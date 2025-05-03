/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package vn.edu.fpt.model;

/**
 *
 * @author ACER
 */

public class WishlistItem {
    private int courseId;
    private String status;

    // Constructor
    public WishlistItem() {
    }

    public WishlistItem(int courseId, String status) {
        this.courseId = courseId;
        this.status = status;
    }

    // Getter và Setter
    public int getCourseId() {
        return courseId;
    }

    public void setCourseId(int courseId) {
        this.courseId = courseId;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}
