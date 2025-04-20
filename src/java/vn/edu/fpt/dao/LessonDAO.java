package vn.edu.fpt.dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import vn.edu.fpt.model.Lesson;

public class LessonDAO extends DBContext {

    public List<Lesson> getLessonsByCourseId(int courseId) {
        List<Lesson> lessons = new ArrayList<>();
        String sql = "SELECT LessonID, CourseID, Title, Content, VideoURL, CreatedAt FROM Lesson WHERE CourseID = ?";
        try {
            PreparedStatement pstmt = connection.prepareStatement(sql);
            pstmt.setInt(1, courseId);
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                Lesson lesson = new Lesson();
                lesson.setLessonId(rs.getInt("LessonID"));
                lesson.setCourseId(rs.getInt("CourseID"));
                lesson.setTitle(rs.getString("Title"));
                lesson.setContent(rs.getString("Content"));
                lesson.setVidURL(rs.getString("VideoURL"));
                lesson.setCreatedAt(rs.getDate("CreatedAt"));
                lessons.add(lesson);
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Xử lý ngoại lệ thích hợp, có thể ghi log
        }
        return lessons;
    }

    public Lesson getLessonDetails(int lessonId, int courseId) {
        Lesson lesson = null;
        String sql = "SELECT title, Content, VideoURL, CreatedAt FROM Lesson WHERE lessonId = ? AND courseId = ?";

        try {
            PreparedStatement pstmt = connection.prepareStatement(sql);
            pstmt.setInt(1, lessonId);
            pstmt.setInt(2, courseId);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                lesson = new Lesson();
                lesson.setLessonId(lessonId);
                lesson.setCourseId(courseId);
                lesson.setTitle(rs.getString("title"));
                lesson.setContent(rs.getString("Content"));
                lesson.setVidURL(rs.getString("VideoURL"));
                lesson.setCreatedAt(rs.getDate("CreatedAt"));
            }

        } catch (SQLException e) {
            e.printStackTrace(); 
        }

        return lesson;
    }

    public boolean isUserEnrolled(int userId, int courseId) {
        String sql = "SELECT 1 FROM course_enrollments WHERE student_id = ? AND course_id = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, userId);
            ps.setInt(2, courseId);
            ResultSet rs = ps.executeQuery();
            return rs.next();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public static void main(String[] args) {
//        LessonDAO lessonDAO = new LessonDAO();
//        int courseId = 12; // Thay thế bằng courseId thực tế bạn muốn truy vấn
//        List<String> lessonTitles = lessonDAO.getLessonTitlesByCourseId(courseId);
//
//        if (lessonTitles.isEmpty()) {
//            System.out.println("Không tìm thấy bài học nào cho Course ID: " + courseId);
//        } else {
//            System.out.println("Danh sách tiêu đề bài học cho Course ID: " + courseId);
//            for (String title : lessonTitles) {
//                System.out.println("- " + title);
//            }
//        }
        LessonDAO lessonDAO = new LessonDAO();
        int lessonId = 2; // Thay thế bằng lessonId thực tế bạn muốn truy vấn
        int courseId = 12; // Thay thế bằng courseId thực tế bạn muốn truy vấn

        Lesson lesson = lessonDAO.getLessonDetails(lessonId, courseId);

        if (lesson == null) {
            System.out.println("Không tìm thấy bài học nào với Lesson ID: " + lessonId + " và Course ID: " + courseId);
        } else {
            System.out.println("Thông tin chi tiết bài học:");
            System.out.println("Title: " + lesson.getTitle());
            System.out.println("Content: " + lesson.getContent());
            System.out.println("Video URL: " + lesson.getVidURL());
            System.out.println("Created At: " + lesson.getCreatedAt());
        }
    }
}
