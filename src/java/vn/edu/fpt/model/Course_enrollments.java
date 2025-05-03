/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package vn.edu.fpt.model;

import java.util.Date;

/**
 *
 * @author ASUS
 */
public class Course_enrollments {
    private int id;
    private int student_id;
    private int course_id;
    private Date enrolled_At;

    public Course_enrollments() {
    }

    public Course_enrollments(int id, int student_id, int course_id, Date enrolled_At) {
        this.id = id;
        this.student_id = student_id;
        this.course_id = course_id;
        this.enrolled_At = enrolled_At;
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

    public Date getEnrolled_At() {
        return enrolled_At;
    }

    public void setEnrolled_At(Date enrolled_At) {
        this.enrolled_At = enrolled_At;
    }

    @Override
    public String toString() {
        return "Course_enrollments{" + "id=" + id + ", student_id=" + student_id + ", course_id=" + course_id + ", enrolled_At=" + enrolled_At + '}';
    }
    
    
}
