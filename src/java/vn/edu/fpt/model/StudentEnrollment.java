/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package vn.edu.fpt.model;

//lớp này để show ra danh sách cho join vào couse hôm nay( sử dụng cho TeacherDashboard)
public class StudentEnrollment {

    private String firstName;
    private String middleName;
    private String lastName;
    private String email;
    private String genderName;
    private String courseTitle;
    private String enrollmentStatus;

    public StudentEnrollment() {
    }

    public StudentEnrollment(String firstName, String middleName, String lastName, String email, String genderName, String courseTitle, String enrollmentStatus) {
        this.firstName = firstName;
        this.middleName = middleName;
        this.lastName = lastName;
        this.email = email;
        this.genderName = genderName;
        this.courseTitle = courseTitle;
        this.enrollmentStatus = enrollmentStatus;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getMiddleName() {
        return middleName;
    }

    public void setMiddleName(String middleName) {
        this.middleName = middleName;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getGenderName() {
        return genderName;
    }

    public void setGenderName(String genderName) {
        this.genderName = genderName;
    }

    public String getCourseTitle() {
        return courseTitle;
    }

    public void setCourseTitle(String courseTitle) {
        this.courseTitle = courseTitle;
    }

    public String getEnrollmentStatus() {
        return enrollmentStatus;
    }

    public void setEnrollmentStatus(String enrollmentStatus) {
        this.enrollmentStatus = enrollmentStatus;
    }
    
    public String getFullName() {
        StringBuilder fullName = new StringBuilder();
        if (firstName != null) fullName.append(firstName).append(" ");
        if (middleName != null) fullName.append(middleName).append(" ");
        if (lastName != null) fullName.append(lastName);
        return fullName.toString().trim();
    }

    @Override
    public String toString() {
        return "StudentEnrollment{" + "firstName=" + firstName + ", middleName=" + middleName + ", lastName=" + lastName + ", email=" + email + ", genderName=" + genderName + ", courseTitle=" + courseTitle + ", enrollmentStatus=" + enrollmentStatus + '}';
    }
    
    
}
