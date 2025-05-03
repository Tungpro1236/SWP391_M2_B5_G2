/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package vn.edu.fpt.dao;
import vn.edu.fpt.model.Enrollment;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
/**
 *
 * @author regio
 */
public class EnrollmentDAO extends DBContext {
    public List<Enrollment> getEnrolledCourses(int studentId) throws SQLException {
        List<Enrollment> enrollments = new ArrayList<>();
        String sql = "SELECT ce.id, ce.course_id, c.title " +
                     "FROM course_enrollments ce " +
                     "JOIN courses c ON ce.course_id = c.id " +
                     "WHERE ce.student_id = ? AND ce.refund_status IS NULL";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, studentId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    enrollments.add(new Enrollment(
                        rs.getInt("id"),
                        rs.getInt("course_id"),
                        rs.getString("title")
                    ));
                }
            }
        }
        return enrollments;
    }
    public void updateEnrollmentStatus(int enrollmentId, String status) throws SQLException {
        String sql = "UPDATE course_enrollments SET status = ? WHERE id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, status);
            stmt.setInt(2, enrollmentId);
            stmt.executeUpdate();
        }
    }
}
