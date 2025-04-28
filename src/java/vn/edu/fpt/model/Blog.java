/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package vn.edu.fpt.model;


import java.util.Date;

public class Blog {
    private int id;
    private String title;
    private String content;
    private int authorId;
    private Date createdAt;
    private String thumbnailUrl;
    private Date publishedAt;
    
    // Constructors
    public Blog() {}
    
    public Blog(int id, String title, String content, int authorId, Date createdAt, 
                String thumbnailUrl, Date publishedAt) {
        this.id = id;
        this.title = title;
        this.content = content;
        this.authorId = authorId;
        this.createdAt = createdAt;
        this.thumbnailUrl = thumbnailUrl;
        this.publishedAt = publishedAt;
    }
    
    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    
    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }
    
    public String getContent() { return content; }
    public void setContent(String content) { this.content = content; }
    
    public int getAuthorId() { return authorId; }
    public void setAuthorId(int authorId) { this.authorId = authorId; }
    
    public Date getCreatedAt() { return createdAt; }
    public void setCreatedAt(Date createdAt) { this.createdAt = createdAt; }
    
    public String getThumbnailUrl() { return thumbnailUrl; }
    public void setThumbnailUrl(String thumbnailUrl) { this.thumbnailUrl = thumbnailUrl; }
    
    public Date getPublishedAt() { return publishedAt; }
    public void setPublishedAt(Date publishedAt) { this.publishedAt = publishedAt; }
    
    // Helper method to get short description
    public String getShortDescription() {
        if (content.length() > 150) {
            return content.substring(0, 150) + "...";
        }
        return content;
    }
    
    // Helper method to format date
    public String getFormattedPublishDate() {
        // Implement date formatting as needed
        return new java.text.SimpleDateFormat("EEE, dd MMM yyyy").format(publishedAt);
    }
}
