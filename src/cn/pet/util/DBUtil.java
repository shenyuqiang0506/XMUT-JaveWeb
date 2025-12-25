package cn.pet.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class DBUtil {

    // 数据库连接配置
    private static final String URL = "jdbc:mysql://localhost:3306/pet_rescue_db?useUnicode=true&characterEncoding=utf-8&serverTimezone=Asia/Shanghai";

    private static final String USERNAME = "root";
    private static final String PASSWORD = "20030506";

    // 静态代码块，项目启动时加载驱动
    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            System.out.println("数据库驱动加载失败，请检查是否导入了 mysql-connector-java.jar 包！");
        }
    }

    /**
     * 获取数据库连接
     */
    public static Connection getConn() {
        Connection conn = null;
        try {
            conn = DriverManager.getConnection(URL, USERNAME, PASSWORD);
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("连接数据库失败，请检查账号密码或服务是否开启！");
        }
        return conn;
    }


    public static void closeAll(ResultSet rs, Statement stmt, Connection conn) {
        try {
            if (rs != null) {
                rs.close();
            }
            if (stmt != null) {
                stmt.close();
            }
            if (conn != null) {
                conn.close();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    public static void closeAll(Statement stmt, Connection conn) {
        closeAll(null, stmt, conn);
    }

    public static void main(String[] args) {
        System.out.println(getConn());
    }
}