package cn.pet.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import cn.pet.entity.Apply;
import cn.pet.entity.Pet;
import cn.pet.entity.User;
import cn.pet.util.DBUtil;

public class ApplyDao {

    /**
     * 1. 保存领养申请
     */
    public boolean saveApply(Apply apply) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        boolean flag = false;
        try {
            conn = DBUtil.getConn();
            String sql = "INSERT INTO t_apply (user_id, pet_id, reason, apply_status, apply_time) VALUES (?, ?, ?, 0, NOW())";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, apply.getUserId());
            pstmt.setInt(2, apply.getPetId());
            pstmt.setString(3, apply.getReason());
            
            int row = pstmt.executeUpdate();
            if (row > 0) flag = true;
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBUtil.closeAll(pstmt, conn);
        }
        return flag;
    }

    /**
     * 2. 查询某用户的申请记录 (关联查询宠物信息)
     * 这里的 SQL 使用了 JOIN，把 pet 表的信息一起查出来，方便页面显示宠物名字
     */
    public List<Apply> findAppliesByUserId(int userId) {
        List<Apply> list = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            conn = DBUtil.getConn();
            // 关联查询：t_apply 和 t_pet
            String sql = "SELECT a.*, p.pet_name, p.image FROM t_apply a " +
                         "JOIN t_pet p ON a.pet_id = p.id " +
                         "WHERE a.user_id = ? ORDER BY a.apply_time DESC";
            
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, userId);
            rs = pstmt.executeQuery();
            
            while (rs.next()) {
                Apply apply = new Apply();
                apply.setId(rs.getInt("id"));
                apply.setUserId(rs.getInt("user_id"));
                apply.setPetId(rs.getInt("pet_id"));
                apply.setReason(rs.getString("reason"));
                apply.setApplyStatus(rs.getInt("apply_status"));
                apply.setApplyTime(rs.getTimestamp("apply_time"));
                
                // 封装关联的 Pet 对象
                Pet p = new Pet();
                p.setPetName(rs.getString("pet_name"));
                p.setImage(rs.getString("image"));
                apply.setPet(p);
                
                list.add(apply);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBUtil.closeAll(rs, pstmt, conn);
        }
        return list;
    }
    /**
     * 3. 【管理员】查询所有申请记录
     */
    public List<Apply> findAllApplies() {
        List<Apply> list = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            conn = DBUtil.getConn();
            // 关联三张表：申请表 + 用户表 + 宠物表
            String sql = "SELECT a.*, u.username, u.real_name, p.pet_name " +
                         "FROM t_apply a " +
                         "JOIN t_user u ON a.user_id = u.id " +
                         "JOIN t_pet p ON a.pet_id = p.id " +
                         "ORDER BY a.apply_status ASC, a.apply_time DESC";

            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                Apply apply = new Apply();
                apply.setId(rs.getInt("id"));
                apply.setUserId(rs.getInt("user_id"));
                apply.setPetId(rs.getInt("pet_id"));
                apply.setReason(rs.getString("reason"));
                apply.setApplyStatus(rs.getInt("apply_status"));
                apply.setApplyTime(rs.getTimestamp("apply_time"));

                // 封装关联的用户信息
                User u = new User();
                u.setUsername(rs.getString("username"));
                u.setRealName(rs.getString("real_name"));
                apply.setUser(u);

                // 封装关联的宠物信息
                Pet p = new Pet();
                p.setPetName(rs.getString("pet_name"));
                apply.setPet(p);

                list.add(apply);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBUtil.closeAll(rs, pstmt, conn);
        }
        return list;
    }

    /**
     * 4. 审核处理
     * @param applyId 申请记录ID
     * @param petId 关联的宠物ID
     * @param status 目标状态 (1:通过, 2:驳回)
     */
    public boolean auditApply(int applyId, int petId, int status) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        boolean success = false;

        try {
            conn = DBUtil.getConn();

            // A. 开启事务
            conn.setAutoCommit(false);

            // 1. 更新申请表的状态
            String sql1 = "UPDATE t_apply SET apply_status = ? WHERE id = ?";
            pstmt = conn.prepareStatement(sql1);
            pstmt.setInt(1, status);
            pstmt.setInt(2, applyId);
            pstmt.executeUpdate();

            // 2. 如果是“通过”(status=1)，还需要把宠物状态改为“已领养”(status=2)
            if (status == 1) {
                pstmt.close();

                String sql2 = "UPDATE t_pet SET status = 2 WHERE id = ?";
                pstmt = conn.prepareStatement(sql2);
                pstmt.setInt(1, petId);
                pstmt.executeUpdate();
            }

            // B. 提交事务
            conn.commit();
            success = true;

        } catch (SQLException e) {
            // C. 出现异常，回滚
            try {
                if (conn != null) conn.rollback();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
            e.printStackTrace();
        } finally {
            DBUtil.closeAll(pstmt, conn);
        }
        return success;
    }
}