package cn.pet.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import cn.pet.entity.Pet;
import cn.pet.util.DBUtil;

public class PetDao {

    // 1. 获取【待领养】宠物的总记录数 (用于计算总页数)
    public int getPetCount() {
        int count = 0;
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            conn = DBUtil.getConn();
            // 只统计状态为 1 (待领养) 的
            String sql = "select count(*) from t_pet where status = 1";
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBUtil.closeAll(rs, pstmt, conn);
        }
        return count;
    }

    // 2. 获取【指定页码】的数据
    public List<Pet> getPetListByPage(int currPage, int pageSize) {
        List<Pet> list = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            conn = DBUtil.getConn();
            String sql = "select * from t_pet where status = 1 order by create_time desc limit ?, ?";
            pstmt = conn.prepareStatement(sql);

            // 计算起始行号：(当前页 - 1) * 每页条数
            int startRow = (currPage - 1) * pageSize;

            pstmt.setInt(1, startRow);
            pstmt.setInt(2, pageSize);

            rs = pstmt.executeQuery();
            while (rs.next()) {
                Pet pet = new Pet();
                pet.setId(rs.getInt("id"));
                pet.setPetName(rs.getString("pet_name"));
                pet.setType(rs.getString("type"));
                pet.setSex(rs.getString("sex"));
                pet.setImage(rs.getString("image"));
                pet.setDescription(rs.getString("description"));
                pet.setStatus(rs.getInt("status"));
                list.add(pet);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBUtil.closeAll(rs, pstmt, conn);
        }
        return list;
    }


    /**
     * 发布新宠物
     */
    public boolean addPet(Pet pet) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        boolean flag = false;
        try {
            conn = DBUtil.getConn();
            String sql = "INSERT INTO t_pet (pet_name, type, sex, age, description, image, status, publisher_id, create_time) " +
                         "VALUES (?, ?, ?, ?, ?, ?, ?, ?, NOW())";

            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, pet.getPetName());
            pstmt.setString(2, pet.getType());
            pstmt.setString(3, pet.getSex());
            pstmt.setString(4, pet.getAge());
            pstmt.setString(5, pet.getDescription());
            pstmt.setString(6, pet.getImage());
            pstmt.setInt(7, pet.getStatus());
            pstmt.setInt(8, pet.getPublisherId());

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
     * 1. 【管理员】查询所有待审核的宠物 (status = 0)
     */
    public List<Pet> findPendingPets() {
        List<Pet> list = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            conn = DBUtil.getConn();
            // 只查 status = 0 (待审核)
            String sql = "SELECT * FROM t_pet WHERE status = 0 ORDER BY create_time DESC";
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                Pet p = new Pet();
                p.setId(rs.getInt("id"));
                p.setPetName(rs.getString("pet_name"));
                p.setType(rs.getString("type"));
                p.setSex(rs.getString("sex"));
                p.setAge(rs.getString("age"));
                p.setDescription(rs.getString("description"));
                p.setImage(rs.getString("image"));
                p.setStatus(rs.getInt("status"));
                p.setCreateTime(rs.getTimestamp("create_time"));
                p.setPublisherId(rs.getInt("publisher_id"));

                list.add(p);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBUtil.closeAll(rs, pstmt, conn);
        }
        return list;
    }

    /**
     * 2. 【管理员】审核宠物发布 (通过或驳回)
     * @param petId 宠物ID
     * @param pass 1:通过(待领养)，
     * 这里我们演示：通过->1, 驳回->直接删除记录
     */
    public boolean auditPet(int petId, boolean pass) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        boolean flag = false;
        try {
            conn = DBUtil.getConn();
            String sql;
            if (pass) {
                // 通过 -> 状态变为 1 (待领养)
                sql = "UPDATE t_pet SET status = 1 WHERE id = ?";
            } else {
                // 驳回 -> 直接删除该条数据
                sql = "DELETE FROM t_pet WHERE id = ?";
            }

            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, petId);

            int row = pstmt.executeUpdate();
            if (row > 0) flag = true;
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBUtil.closeAll(pstmt, conn);
        }
        return flag;
    }
}