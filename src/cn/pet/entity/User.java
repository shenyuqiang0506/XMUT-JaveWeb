package cn.pet.entity;

import java.util.Date;

public class User {
    private Integer id;
    private String username;  // 账号
    private String password;  // 密码
    private String realName;  // 真实姓名 (对应数据库 real_name)
    private String phone;     // 电话
    private Integer role;     // 角色：0-普通用户，1-管理员
    private Date createTime;  // 注册时间

    // 无参构造方法 (必须有，反射和框架需要)
    public User() {
    }

    // 全参构造方法 (方便直接 new 对象)
    public User(Integer id, String username, String password, String realName, String phone, Integer role, Date createTime) {
        this.id = id;
        this.username = username;
        this.password = password;
        this.realName = realName;
        this.phone = phone;
        this.role = role;
        this.createTime = createTime;
    }
    
    // 用于登录或注册时的简化构造方法
    public User(String username, String password, String realName, String phone, Integer role) {
        this.username = username;
        this.password = password;
        this.realName = realName;
        this.phone = phone;
        this.role = role;
    }

    // --- Getters and Setters ---

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getRealName() {
        return realName;
    }

    public void setRealName(String realName) {
        this.realName = realName;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public Integer getRole() {
        return role;
    }

    public void setRole(Integer role) {
        this.role = role;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    // 重写 toString，方便打印调试
    @Override
    public String toString() {
        return "User [id=" + id + ", username=" + username + ", role=" + role + "]";
    }
}