package cn.pet.entity;

import java.util.Date;

public class Apply {
    private Integer id;
    private Integer userId;
    private Integer petId;
    private String reason;       // 申请理由
    private Integer applyStatus; // 0:审核中, 1:通过, 2:驳回
    private Date applyTime;
    
    // 辅助字段：为了在前端显示方便，我们通常会把关联的 宠物信息 和 用户信息 也存进来
    // 注意：数据库表里没有这两列，但在做关联查询时很有用
    private Pet pet;   
    private User user; 

    public Apply() {}

    public Apply(Integer userId, Integer petId, String reason) {
        this.userId = userId;
        this.petId = petId;
        this.reason = reason;
        this.applyStatus = 0; // 默认为审核中
    }

    // --- Getters and Setters ---
    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }

    public Integer getUserId() { return userId; }
    public void setUserId(Integer userId) { this.userId = userId; }

    public Integer getPetId() { return petId; }
    public void setPetId(Integer petId) { this.petId = petId; }

    public String getReason() { return reason; }
    public void setReason(String reason) { this.reason = reason; }

    public Integer getApplyStatus() { return applyStatus; }
    public void setApplyStatus(Integer applyStatus) { this.applyStatus = applyStatus; }

    public Date getApplyTime() { return applyTime; }
    public void setApplyTime(Date applyTime) { this.applyTime = applyTime; }

    public Pet getPet() { return pet; }
    public void setPet(Pet pet) { this.pet = pet; }

    public User getUser() { return user; }
    public void setUser(User user) { this.user = user; }
}