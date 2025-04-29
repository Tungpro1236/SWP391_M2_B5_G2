/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package vn.edu.fpt.dao;
import java.sql.Timestamp;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import vn.edu.fpt.dao.DBContext;
import vn.edu.fpt.model.RefundRequest;
import java.util.ArrayList;
import java.util.List;
/**
 *
 * @author regio
 */
public class RefundRequestDAO extends DBContext {
    // Lấy danh sách yêu cầu hoàn tiền
    public List<RefundRequest> getRefundRequestsByStudent(int studentId) throws SQLException {
        List<RefundRequest> requests = new ArrayList<>();
        String sql = "SELECT * FROM refund_requests WHERE student_id = ?";
        try (
             PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, studentId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    RefundRequest request = new RefundRequest();
                    request.setId(rs.getInt("id"));
                    request.setEnrollmentId(rs.getInt("enrollment_id"));
                    request.setStudentId(rs.getInt("student_id"));
                    request.setCourseId(rs.getInt("course_id"));
                    request.setRequestDate(rs.getTimestamp("request_date")); // Sử dụng getTimestamp cho DATETIME
                    request.setReason(rs.getString("reason"));
                    request.setStatus(rs.getString("status"));
                    request.setProcessedDate(rs.getTimestamp("processed_date")); // Sử dụng getTimestamp
                    request.setProcessedBy(rs.getInt("processed_by"));
                    requests.add(request);
                }
            }
        }
        return requests;
    }

    public List<RefundRequest> getAllRefundRequests() throws SQLException {
        List<RefundRequest> requests = new ArrayList<>();
        String sql = "SELECT * FROM refund_requests ORDER BY request_date DESC";
        try (
             PreparedStatement stmt = connection.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                RefundRequest request = new RefundRequest();
                request.setId(rs.getInt("id"));
                request.setEnrollmentId(rs.getInt("enrollment_id"));
                request.setStudentId(rs.getInt("student_id"));
                request.setCourseId(rs.getInt("course_id"));
                request.setRequestDate(rs.getTimestamp("request_date")); // Sử dụng getTimestamp
                request.setReason(rs.getString("reason"));
                request.setStatus(rs.getString("status"));
                request.setProcessedDate(rs.getTimestamp("processed_date")); // Sử dụng getTimestamp
                request.setProcessedBy(rs.getInt("processed_by"));
                requests.add(request);
            }
        }
        return requests;
    }

    public void createRefundRequest(RefundRequest request) throws SQLException {
        String sql = "INSERT INTO refund_requests (enrollment_id, student_id, course_id, request_date, reason, status) VALUES (?, ?, ?, ?, ?, ?)";
        try (
             PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, request.getEnrollmentId());
            stmt.setInt(2, request.getStudentId());
            stmt.setInt(3, request.getCourseId());
            stmt.setTimestamp(4, request.getRequestDate()); // Sử dụng setTimestamp cho DATETIME
            stmt.setString(5, request.getReason());
            stmt.setString(6, request.getStatus());
            stmt.executeUpdate();
        }
    }

    public void updateRefundRequestStatus(int requestId, String status, int adminId) throws SQLException {
         String sql = "UPDATE refund_requests SET status = ?, processed_date = ?, processed_by = ? WHERE id = ?";
    try (
         PreparedStatement stmt = connection.prepareStatement(sql)) {
        stmt.setString(1, status);
        stmt.setTimestamp(2, new Timestamp(System.currentTimeMillis()));
        stmt.setInt(3, adminId);
        stmt.setInt(4, requestId);
        stmt.executeUpdate();

        if ("approved".equals(status)) {
            String updateEnrollmentSql = "UPDATE course_enrollments SET refund_status = 'refunded' WHERE id = (SELECT enrollment_id FROM refund_requests WHERE id = ?)";
            try (PreparedStatement updateStmt = connection.prepareStatement(updateEnrollmentSql)) {
                updateStmt.setInt(1, requestId);
                updateStmt.executeUpdate();
            }
        } else if ("rejected".equals(status)) {
            String updateEnrollmentSql = "UPDATE course_enrollment SET refund_status = 'rejected' WHERE id = (SELECT enrollment_id FROM refund_requests WHERE id = ?)";
            try (PreparedStatement updateStmt = connection.prepareStatement(updateEnrollmentSql)) {
                updateStmt.setInt(1, requestId);
                updateStmt.executeUpdate();
            }
        }
    }
    }
}
