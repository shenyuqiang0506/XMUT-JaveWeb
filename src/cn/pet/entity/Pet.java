package cn.pet.entity;

import java.util.Date;

public class Pet {
    private Integer id;
    private String petName;
    private String type;        // 猫/狗
    private String sex;
    private String age;
    private String description;
    private String image;       // 图片文件名
    private Integer status;     // 0:待审核 1:待领养 2:已领养
    private Integer publisherId;// 发布人ID
    private Date createTime;

    public Pet() {}


    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }

    public String getPetName() { return petName; }
    public void setPetName(String petName) { this.petName = petName; }

    public String getType() { return type; }
    public void setType(String type) { this.type = type; }

    public String getSex() { return sex; }
    public void setSex(String sex) { this.sex = sex; }

    public String getAge() { return age; }
    public void setAge(String age) { this.age = age; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public String getImage() { return image; }
    public void setImage(String image) { this.image = image; }

    public Integer getStatus() { return status; }
    public void setStatus(Integer status) { this.status = status; }

    public Integer getPublisherId() { return publisherId; }
    public void setPublisherId(Integer publisherId) { this.publisherId = publisherId; }

    public Date getCreateTime() { return createTime; }
    public void setCreateTime(Date createTime) { this.createTime = createTime; }


}