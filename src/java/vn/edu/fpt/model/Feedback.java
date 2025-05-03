/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package vn.edu.fpt.model;

import java.sql.Timestamp;
import java.util.Date;

/**
 *
 * @author Admin
 */
public class Feedback {
    private int id;
    private int student_id;
    private int course_id;
    private String content;
    private int rating;
    private String status;
    private String create_at;

    public Feedback() {
    }

    public Feedback(int id, int student_id, int course_id, String content, int rating, String status, String create_at) {
        this.id = id;
        this.student_id = student_id;
        this.course_id = course_id;
        this.content = content;
        this.rating = rating;
        this.status = status;
        this.create_at = create_at;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getStudent_id() {
        return student_id;
    }

    public void setStudent_id(int student_id) {
        this.student_id = student_id;
    }

    public int getCourse_id() {
        return course_id;
    }

    public void setCourse_id(int course_id) {
        this.course_id = course_id;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public int getRating() {
        return rating;
    }

    public void setRating(int rating) {
        this.rating = rating;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getCreate_at() {
        return create_at;
    }

    public void setCreate_at(String create_at) {
        this.create_at = create_at;
    }

    @Override
    public String toString() {
        return "Feedback{" + "id=" + id + ", student_id=" + student_id + ", course_id=" + course_id + ", content=" + content + ", rating=" + rating + ", status=" + status + ", create_at=" + create_at + '}';
    }
    
    
}
