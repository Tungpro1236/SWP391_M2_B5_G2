/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package vn.edu.fpt.model;

import java.sql.Timestamp;

/**
 *
 * @author regio
 */
public class UserModel {
    private int id;
    private String firstName;
    private String middleName;
    private String lastName;
    private String email;
    private int genderId;
    private String password;
    private int roleId;
    private String avatarUrl;
    private Timestamp createdAt;
    private boolean status;
    private String educationLevel;
    private String graduatedSchool;
    private Integer graduatedYear;
    private String major;
    private String certifications;
    private Integer teachingExperienceYears;
    private String subjects;
    private String teachingLevels;
    private String skills;
    private String teachingPhilosophy;
    private String careerGoals;

    // Default constructor
    public UserModel() {
    }
    
    // Constructor with fields
    public UserModel(int id, String firstName, String middleName, String lastName, 
            String email, int genderId, String password, int roleId, 
            String avatarUrl, Timestamp createdAt , boolean status) {
        this.id = id;
        this.firstName = firstName;
        this.middleName = middleName;
        this.lastName = lastName;
        this.email = email;
        this.genderId = genderId;
        this.password = password;
        this.roleId = roleId;
        this.avatarUrl = avatarUrl;
        this.createdAt = createdAt;
        this.status = status;
    }

    public UserModel(int id, String firstName, String middleName, String lastName, String email, int genderId, String password, int roleId, String avatarUrl, Timestamp createdAt, boolean status, String educationLevel, String graduatedSchool, Integer graduatedYear, String major, String certifications, Integer teachingExperienceYears, String subjects, String teachingLevels, String skills, String teachingPhilosophy, String careerGoals) {
        this.id = id;
        this.firstName = firstName;
        this.middleName = middleName;
        this.lastName = lastName;
        this.email = email;
        this.genderId = genderId;
        this.password = password;
        this.roleId = roleId;
        this.avatarUrl = avatarUrl;
        this.createdAt = createdAt;
        this.status = status;
        this.educationLevel = educationLevel;
        this.graduatedSchool = graduatedSchool;
        this.graduatedYear = graduatedYear;
        this.major = major;
        this.certifications = certifications;
        this.teachingExperienceYears = teachingExperienceYears;
        this.subjects = subjects;
        this.teachingLevels = teachingLevels;
        this.skills = skills;
        this.teachingPhilosophy = teachingPhilosophy;
        this.careerGoals = careerGoals;
    }
    
    
    
    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
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

    public int getGenderId() {
        return genderId;
    }

    public void setGenderId(int genderId) {
        this.genderId = genderId;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public int getRoleId() {
        return roleId;
    }

    public void setRoleId(int roleId) {
        this.roleId = roleId;
    }

    public String getAvatarUrl() {
        return avatarUrl;
    }

    public void setAvatarUrl(String avatarUrl) {
        this.avatarUrl = avatarUrl;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

    public String getEducationLevel() {
        return educationLevel;
    }

    public void setEducationLevel(String educationLevel) {
        this.educationLevel = educationLevel;
    }

    public String getGraduatedSchool() {
        return graduatedSchool;
    }

    public void setGraduatedSchool(String graduatedSchool) {
        this.graduatedSchool = graduatedSchool;
    }

    public Integer getGraduatedYear() {
        return graduatedYear;
    }

    public void setGraduatedYear(Integer graduatedYear) {
        this.graduatedYear = graduatedYear;
    }

    public String getMajor() {
        return major;
    }

    public void setMajor(String major) {
        this.major = major;
    }

    public String getCertifications() {
        return certifications;
    }

    public void setCertifications(String certifications) {
        this.certifications = certifications;
    }

    public Integer getTeachingExperienceYears() {
        return teachingExperienceYears;
    }

    public void setTeachingExperienceYears(Integer teachingExperienceYears) {
        this.teachingExperienceYears = teachingExperienceYears;
    }

    public String getSubjects() {
        return subjects;
    }

    public void setSubjects(String subjects) {
        this.subjects = subjects;
    }

    public String getTeachingLevels() {
        return teachingLevels;
    }

    public void setTeachingLevels(String teachingLevels) {
        this.teachingLevels = teachingLevels;
    }

    public String getSkills() {
        return skills;
    }

    public void setSkills(String skills) {
        this.skills = skills;
    }

    public String getTeachingPhilosophy() {
        return teachingPhilosophy;
    }

    public void setTeachingPhilosophy(String teachingPhilosophy) {
        this.teachingPhilosophy = teachingPhilosophy;
    }

    public String getCareerGoals() {
        return careerGoals;
    }

    public void setCareerGoals(String careerGoals) {
        this.careerGoals = careerGoals;
    }
    
    
    
}
