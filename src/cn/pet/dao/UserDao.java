package cn.pet.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import cn.pet.entity.User;
import cn.pet.util.DBUtil;

public class UserDao {

    /**
     * 登录验证方法
     *
     * @param username 用户名
     * @param password 密码
     * @return 成功返回 User 对象，失败返回 null
     */
    public User login(String username, String password) {
        User user = null;
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = DBUtil.getConn();
            String sql = "SELECT * FROM t_user WHERE username = ? AND password = ?";

            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, username);
            pstmt.setString(2, password);

            rs = pstmt.executeQuery();

            // 封装成 User 对象
            if (rs.next()) {
                user = new User();
                user.setId(rs.getInt("id"));
                user.setUsername(rs.getString("username"));
                user.setPassword(rs.getString("password"));
                user.setRealName(rs.getString("real_name"));
                user.setPhone(rs.getString("phone"));
                user.setRole(rs.getInt("role"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBUtil.closeAll(rs, pstmt, conn);
        }
        return user;
    }

    /**
     * 检查用户名是否已存在
     */
    public boolean isUsernameExist(String username) {
        boolean exist = false;
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            conn = DBUtil.getConn();
            String sql = "SELECT id FROM t_user WHERE username = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, username);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                exist = true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBUtil.closeAll(rs, pstmt, conn);
        }
        return exist;
    }

    /**
     * 注册新用户
     */
    public boolean register(User user) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        boolean flag = false;
        try {
            conn = DBUtil.getConn();
            String sql = "INSERT INTO t_user (username, password, real_name, phone, role, create_time) VALUES (?, ?, ?, ?, 0, NOW())";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, user.getUsername());
            pstmt.setString(2, user.getPassword());
            pstmt.setString(3, user.getRealName());
            pstmt.setString(4, user.getPhone());

            int row = pstmt.executeUpdate();
            if (row > 0) flag = true;
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBUtil.closeAll(pstmt, conn);
        }
        return flag;
    }
    //修改密码
    public boolean updatePassword(int userId, String newPassword) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        boolean flag = false;
        try {
            conn = DBUtil.getConn();
            String sql = "UPDATE t_user SET password = ? WHERE id = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, newPassword);
            pstmt.setInt(2, userId);

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