/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package vn.edu.fpt.model;

/**
 *
 * @author Admin
 */
import java.util.Date;

public class Course {
    
    private int id;
    private int teacherId;
    private String title;
    private String thumbnailUrl;
    private String description;
    private int categoryId;
    private String status;
    private Date createdAt;
    private int price;

    public Course() {
    }

    public Course(int id, int teacherId, String title, String thumbnailUrl, String description, int categoryId, String status, Date createdAt, int price) {
        this.id = id;
        this.teacherId = teacherId;
        this.title = title;
        this.thumbnailUrl = thumbnailUrl;
        this.description = description;
        this.categoryId = categoryId;
        this.status = status;
        this.createdAt = createdAt;
        this.price = price;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getTeacherId() {
        return teacherId;
    }

    public void setTeacherId(int teacherId) {
        this.teacherId = teacherId;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getThumbnailUrl() {
        return thumbnailUrl;
    }

    public void setThumbnailUrl(String thumbnailUrl) {
        this.thumbnailUrl = thumbnailUrl;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public int getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(int categoryId) {
        this.categoryId = categoryId;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }

    public int getPrice() {
        return price;
    }

    public void setPrice(int price) {
        this.price = price;
    }

    @Override
    public String toString() {
        return "Course{" + "id=" + id + ", teacherId=" + teacherId + ", title=" + title + ", thumbnailUrl=" + thumbnailUrl + ", description=" + description + ", categoryId=" + categoryId + ", status=" + status + ", createdAt=" + createdAt + ", price=" + price + '}';
    }
}
