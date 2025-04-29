/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package vn.edu.fpt.dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import vn.edu.fpt.model.Category;
import vn.edu.fpt.model.Feedback;

/**
 *
 * @author Admin
 */
public class FeedbackDAO extends DBContext {

    public static void main(String[] args) {
        FeedbackDAO dao = new FeedbackDAO();
        Date now = new Date();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.SSS");
        String formattedDate = sdf.format(now);
        System.out.println(dao.getFeedBackByID(4));
    }

    public List<Feedback> getAllFeedback() {
        List<Feedback> list = new ArrayList<>();
        String query = "SELECT * "
                + "FROM [Onlinelearning].[dbo].[feedback]";

        try (PreparedStatement ps = connection.prepareStatement(query); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Feedback f = new Feedback(
                        rs.getInt("id"),
                        rs.getInt("student_id"),
                        rs.getInt("course_id"),
                        rs.getString("content"),
                        rs.getInt("rating"),
                        rs.getString("status"),
                        rs.getString("created_at")
                );
                list.add(f);
            }
        } catch (SQLException ex) {
            Logger.getLogger(CourseDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return list;
    }

    public List<Feedback> getFeedbackByCourseID(int courseId) {
        List<Feedback> list = new ArrayList<>();
        String query = "SELECT * FROM [Onlinelearning].[dbo].[feedback] WHERE course_id = ?";

        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, courseId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Feedback f = new Feedback(
                            rs.getInt("id"),
                            rs.getInt("student_id"),
                            rs.getInt("course_id"),
                            rs.getString("content"),
                            rs.getInt("rating"),
                            rs.getString("status"),
                            rs.getString("created_at")
                    );
                    list.add(f);
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(CourseDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return list;
    }

    public void addNewFeedback(Feedback feedback) {
        String query = "INSERT INTO [Onlinelearning].[dbo].[feedback] (student_id, course_id, content, rating, status, created_at) "
                + "VALUES (?, ?, ?, ?, ?, ?)";

        try (PreparedStatement ps = connection.prepareStatement(query)) {
            // Set values from the Feedback object
            ps.setInt(1, feedback.getStudent_id());
            ps.setInt(2, feedback.getCourse_id());
            ps.setString(3, feedback.getContent());
            ps.setInt(4, feedback.getRating());
            ps.setString(5, feedback.getStatus());
            ps.setString(6, feedback.getCreate_at());

            // Execute the update
            ps.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(CourseDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void updateComment(int commentId, String newContent, String rating) {
        String query = "UPDATE [Onlinelearning].[dbo].[feedback] SET content = ?, rating = ? WHERE id = ?";

        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setString(1, newContent);
            ps.setInt(2, Integer.parseInt(rating));
            ps.setInt(3, commentId); // Chuyển commentId sang int

            ps.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(CourseDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void deleteComment(int commentId) {
        String query = "DELETE FROM feedback WHERE id = ?";

        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, commentId);
            ps.executeUpdate();  // Thực hiện câu lệnh xóa
        } catch (SQLException ex) {
            Logger.getLogger(FeedbackDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public Feedback getFeedBackByID(int id) {
    String query = "SELECT id, student_id, course_id, content, rating, status, created_at "
                 + "FROM [Onlinelearning].[dbo].[feedback] WHERE id = ?";
    try (PreparedStatement ps = connection.prepareStatement(query)) {
        ps.setInt(1, id);
        try (ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                Feedback feedback = new Feedback();
                feedback.setId(rs.getInt("id"));
                feedback.setStudent_id(rs.getInt("student_id"));
                feedback.setCourse_id(rs.getInt("course_id"));
                feedback.setContent(rs.getString("content"));
                feedback.setRating(rs.getInt("rating"));
                feedback.setStatus(rs.getString("status"));
                feedback.setCreate_at(rs.getString("created_at"));
                return feedback;
            }
        }
    } catch (SQLException ex) {
        Logger.getLogger(CourseDAO.class.getName()).log(Level.SEVERE, null, ex);
    }
    return null; // nếu không tìm thấy hoặc có lỗi xảy ra
}

}
