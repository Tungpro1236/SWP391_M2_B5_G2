package vn.edu.fpt.model;

import java.sql.Timestamp;

public class TeacherRequest {
    private int id;
    private int requesterId;
    private int approverId;
    private Timestamp requestDate;
    private Timestamp approveDate;
    private int status;
    private String rejectReason;
    private String approverName;
    private String teacherName;
    private String teacherEmail;
    private String approverEmail;
    
    // Add getters and setters
    public String getTeacherEmail() {
        return teacherEmail;
    }
    
    public void setTeacherEmail(String teacherEmail) {
        this.teacherEmail = teacherEmail;
    }
    
    public String getApproverEmail() {
        return approverEmail;
    }
    
    public void setApproverEmail(String approverEmail) {
        this.approverEmail = approverEmail;
    }
    
    // Add getters and setters for all fields

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getRequesterId() {
        return requesterId;
    }

    public void setRequesterId(int requesterId) {
        this.requesterId = requesterId;
    }

    public int getApproverId() {
        return approverId;
    }

    public void setApproverId(int approverId) {
        this.approverId = approverId;
    }

    public Timestamp getRequestDate() {
        return requestDate;
    }

    public void setRequestDate(Timestamp requestDate) {
        this.requestDate = requestDate;
    }

    public Timestamp getApproveDate() {
        return approveDate;
    }

    public void setApproveDate(Timestamp approveDate) {
        this.approveDate = approveDate;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public String getRejectReason() {
        return rejectReason;
    }

    public void setRejectReason(String rejectReason) {
        this.rejectReason = rejectReason;
    }

    public String getApproverName() {
        return approverName;
    }

    public void setApproverName(String approverName) {
        this.approverName = approverName;
    }

    public String getTeacherName() {
        return teacherName;
    }

    public void setTeacherName(String teacherName) {
        this.teacherName = teacherName;
    }
    
    
}