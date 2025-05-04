/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package vn.edu.fpt.dao;

import java.sql.Timestamp;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import vn.edu.fpt.model.RefundRequest;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author regio
 */
public class RefundRequestDAO extends DBContext {
     // Get refund requests with pagination and search by full name (for admin)
    public List<RefundRequest> getRefundRequests(int page, int pageSize, String keyword) throws SQLException {
        List<RefundRequest> requests = new ArrayList<>();
        String sql = "SELECT r.*, u.first_name, u.middle_name, u.last_name, c.title AS course_title " +
                     "FROM refund_requests r " +
                     "JOIN users u ON r.student_id = u.id " +
                     "JOIN courses c ON r.course_id = c.id " +
                     "WHERE (u.last_name + ' ' + u.middle_name + ' ' + u.first_name LIKE ? OR c.title LIKE ? OR r.reason LIKE ?) " +
                     "ORDER BY r.request_date DESC " +
                     "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            String searchTerm = "%" + (keyword != null ? keyword : "") + "%";
            stmt.setString(1, searchTerm); // Full name search
            stmt.setString(2, searchTerm); // Course title search
            stmt.setString(3, searchTerm); // Reason search
            stmt.setInt(4, (page - 1) * pageSize); // OFFSET
            stmt.setInt(5, pageSize); // FETCH NEXT
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    RefundRequest request = new RefundRequest();
                    request.setId(rs.getInt("id"));
                    request.setEnrollmentId(rs.getInt("enrollment_id"));
                    request.setStudentId(rs.getInt("student_id"));
                    request.setCourseId(rs.getInt("course_id"));
                    request.setRequestDate(rs.getTimestamp("request_date"));
                    request.setReason(rs.getString("reason"));
                    request.setStatus(rs.getString("status"));
                    request.setProcessedDate(rs.getTimestamp("processed_date"));
                    request.setProcessedBy(rs.getInt("processed_by"));
                    request.setFirstName(rs.getString("first_name"));
                    request.setMiddleName(rs.getString("middle_name"));
                    request.setLastName(rs.getString("last_name"));
                    request.setCourseTitle(rs.getString("course_title"));
                    requests.add(request);
                }
            }
        }
        return requests;
    }

    // Count total refund requests for pagination (for admin)
    public int getTotalRefundRequests(String keyword) throws SQLException {
        String sql = "SELECT COUNT(*) FROM refund_requests r " +
                     "JOIN users u ON r.student_id = u.id " +
                     "JOIN courses c ON r.course_id = c.id " +
                     "WHERE (u.last_name + ' ' + u.middle_name + ' ' + u.first_name LIKE ? OR c.title LIKE ? OR r.reason LIKE ?)";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            String searchTerm = "%" + (keyword != null ? keyword : "") + "%";
            stmt.setString(1, searchTerm);
            stmt.setString(2, searchTerm);
            stmt.setString(3, searchTerm);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        }
        return 0;
    }

    // Get refund requests for a specific student with pagination and search
    public List<RefundRequest> getRefundRequestsByStudentWithPagination(int studentId, int page, int pageSize, String keyword) throws SQLException {
        List<RefundRequest> requests = new ArrayList<>();
        String sql = "SELECT r.*, u.first_name, u.middle_name, u.last_name, c.title AS course_title " +
                     "FROM refund_requests r " +
                     "JOIN users u ON r.student_id = u.id " +
                     "JOIN courses c ON r.course_id = c.id " +
                     "WHERE r.student_id = ? AND (c.title LIKE ? OR r.status LIKE ?) " +
                     "ORDER BY r.request_date DESC " +
                     "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            String searchTerm = "%" + (keyword != null ? keyword : "") + "%";
            stmt.setInt(1, studentId);
            stmt.setString(2, searchTerm); // Course title search
            stmt.setString(3, searchTerm); // Status search
            stmt.setInt(4, (page - 1) * pageSize); // OFFSET
            stmt.setInt(5, pageSize); // FETCH NEXT
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    RefundRequest request = new RefundRequest();
                    request.setId(rs.getInt("id"));
                    request.setEnrollmentId(rs.getInt("enrollment_id"));
                    request.setStudentId(rs.getInt("student_id"));
                    request.setCourseId(rs.getInt("course_id"));
                    request.setRequestDate(rs.getTimestamp("request_date"));
                    request.setReason(rs.getString("reason"));
                    request.setStatus(rs.getString("status"));
                    request.setProcessedDate(rs.getTimestamp("processed_date"));
                    request.setProcessedBy(rs.getInt("processed_by"));
                    request.setFirstName(rs.getString("first_name"));
                    request.setMiddleName(rs.getString("middle_name"));
                    request.setLastName(rs.getString("last_name"));
                    request.setCourseTitle(rs.getString("course_title"));
                    requests.add(request);
                }
            }
        }
        return requests;
    }

    // Count total refund requests for a specific student
    public int getTotalRefundRequestsByStudent(int studentId, String keyword) throws SQLException {
        String sql = "SELECT COUNT(*) FROM refund_requests r " +
                     "JOIN users u ON r.student_id = u.id " +
                     "JOIN courses c ON r.course_id = c.id " +
                     "WHERE r.student_id = ? AND (c.title LIKE ? OR r.status LIKE ?)";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            String searchTerm = "%" + (keyword != null ? keyword : "") + "%";
            stmt.setInt(1, studentId);
            stmt.setString(2, searchTerm);
            stmt.setString(3, searchTerm);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        }
        return 0;
    }

    // Check if enrollment_id is valid for the student and course
    public boolean isValidEnrollment(int enrollmentId, int studentId, int courseId) throws SQLException {
        String sql = "SELECT COUNT(*) FROM course_enrollments WHERE id = ? AND student_id = ? AND course_id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, enrollmentId);
            stmt.setInt(2, studentId);
            stmt.setInt(3, courseId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        }
        return false;
    }

    // Existing methods remain unchanged
    public List<RefundRequest> getRefundRequestsByStudent(int studentId) throws SQLException {
        List<RefundRequest> requests = new ArrayList<>();
        String sql = "SELECT r.*, u.first_name, u.middle_name, u.last_name, c.title AS course_title " +
                     "FROM refund_requests r " +
                     "JOIN users u ON r.student_id = u.id " +
                     "JOIN courses c ON r.course_id = c.id " +
                     "WHERE r.student_id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, studentId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    RefundRequest request = new RefundRequest();
                    request.setId(rs.getInt("id"));
                    request.setEnrollmentId(rs.getInt("enrollment_id"));
                    request.setStudentId(rs.getInt("student_id"));
                    request.setCourseId(rs.getInt("course_id"));
                    request.setRequestDate(rs.getTimestamp("request_date"));
                    request.setReason(rs.getString("reason"));
                    request.setStatus(rs.getString("status"));
                    request.setProcessedDate(rs.getTimestamp("processed_date"));
                    request.setProcessedBy(rs.getInt("processed_by"));
                    request.setFirstName(rs.getString("first_name"));
                    request.setMiddleName(rs.getString("middle_name"));
                    request.setLastName(rs.getString("last_name"));
                    request.setCourseTitle(rs.getString("course_title"));
                    requests.add(request);
                }
            }
        }
        return requests;
    }

    public void createRefundRequest(RefundRequest request) throws SQLException {
        String sql = "INSERT INTO refund_requests (enrollment_id, student_id, course_id, request_date, reason, status) VALUES (?, ?, ?, ?, ?, ?)";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, request.getEnrollmentId());
            stmt.setInt(2, request.getStudentId());
            stmt.setInt(3, request.getCourseId());
            stmt.setTimestamp(4, request.getRequestDate());
            stmt.setString(5, request.getReason());
            stmt.setString(6, request.getStatus());
            stmt.executeUpdate();
        }
    }

    public void updateRefundRequestStatus(int requestId, String status, int adminId) throws SQLException {
        String sql = "UPDATE refund_requests SET status = ?, processed_date = ?, processed_by = ? WHERE id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, status);
            stmt.setTimestamp(2, new Timestamp(System.currentTimeMillis()));
            stmt.setInt(3, adminId);
            stmt.setInt(4, requestId);
            stmt.executeUpdate();

            if ("approved".equals(status)) {
                String updateEnrollmentSql = "UPDATE course_enrollments SET status = 'quit', "
                        + "refund_status = 'refunded' WHERE id = (SELECT enrollment_id FROM refund_requests WHERE id = ?)";
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
    
    // Thêm phương thức xóa yêu cầu (đổi status về 'studying')
     public void deleteRefundRequest(int requestId) throws SQLException {
        // Kiểm tra status trước khi xóa
        String checkSql = "SELECT status FROM refund_requests WHERE id = ?";
        String currentStatus = null;
        try (PreparedStatement checkStmt = connection.prepareStatement(checkSql)) {
            checkStmt.setInt(1, requestId);
            try (ResultSet rs = checkStmt.executeQuery()) {
                if (rs.next()) {
                    currentStatus = rs.getString("status");
                }
            }
        }

        if ("pending".equals(currentStatus)) {
            String updateEnrollmentSql = "UPDATE course_enrollments SET status = 'studying' WHERE id = (SELECT enrollment_id FROM refund_requests WHERE id = ?)";
            try (PreparedStatement updateStmt = connection.prepareStatement(updateEnrollmentSql)) {
                updateStmt.setInt(1, requestId);
                updateStmt.executeUpdate();
            }

            String deleteSql = "DELETE FROM refund_requests WHERE id = ?";
            try (PreparedStatement deleteStmt = connection.prepareStatement(deleteSql)) {
                deleteStmt.setInt(1, requestId);
                deleteStmt.executeUpdate();
            }
        } else {
            throw new SQLException("Only pending refund requests can be deleted.");
        }
    }
}