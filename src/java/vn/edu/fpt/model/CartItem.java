package vn.edu.fpt.model;

public class CartItem {
    private int courseId;
    private String title;
    private double price;
    private String thumbnailUrl;
    
    public CartItem(int courseId, String title, double price, String thumbnailUrl) {
        this.courseId = courseId;
        this.title = title;
        this.price = price;
        this.thumbnailUrl = thumbnailUrl;
    }
    
    // Getters
    public int getCourseId() { return courseId; }
    public String getTitle() { return title; }
    public double getPrice() { return price; }
    public String getThumbnailUrl() { return thumbnailUrl; }
}