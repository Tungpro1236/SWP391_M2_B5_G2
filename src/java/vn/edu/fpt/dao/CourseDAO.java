/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package vn.edu.fpt.dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import vn.edu.fpt.model.Blog;
import vn.edu.fpt.model.Category;
import vn.edu.fpt.model.Course;

public class CourseDAO extends DBContext {
    
    private static final int PAGE_SIZE = 6; // Số lượng khóa học trên mỗi trang

    /**
     * Lấy tổng số lượng khóa học
     * @return Tổng số lượng khóa học
     */
    public int getTotalCourses() {
        String query = "SELECT COUNT(*) FROM [Onlinelearning].[dbo].[courses] WHERE [status] = 'active'";
        try (PreparedStatement ps = connection.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {
            
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException ex) {
            Logger.getLogger(CourseDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return 0;
    }
    
    /**
     * Lấy danh sách các khóa học theo trang
     * @param page Trang hiện tại
     * @return Danh sách các khóa học
     */
    public List<Course> getAllCourses(int page) {
        List<Course> list = new ArrayList<>();
        String query = "SELECT [id], [teacher_id], [title], [thumbnail_url], "
                + "[description], [category_id], [status], [created_at], [price] "
                + "FROM [Onlinelearning].[dbo].[courses] "
                + "WHERE [status] = 'active' "
                + "ORDER BY [id] "
                + "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, (page - 1) * PAGE_SIZE);
            ps.setInt(2, PAGE_SIZE);
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Course course = new Course(
                            rs.getInt("id"),
                            rs.getInt("teacher_id"),
                            rs.getString("title"),
                            rs.getString("thumbnail_url"),
                            rs.getString("description"),
                            rs.getInt("category_id"),
                            rs.getString("status"),
                            rs.getTimestamp("created_at"),
                            rs.getInt("price")
                    );
                    list.add(course);
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(CourseDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        return list;
    }
    
    /**
     * Lấy tổng số lượng khóa học theo danh mục
     * @param categoryId ID của danh mục
     * @return Tổng số lượng khóa học theo danh mục
     */
    public int getTotalCoursesByCategory(int categoryId) {
        String query = "SELECT COUNT(*) FROM [Onlinelearning].[dbo].[courses] "
                + "WHERE [category_id] = ? AND [status] = 'active'";
        
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, categoryId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(CourseDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return 0;
    }
    
    /**
     * Lấy danh sách các khóa học theo danh mục và trang
     * @param categoryId ID của danh mục
     * @param page Trang hiện tại
     * @return Danh sách các khóa học thuộc danh mục
     */
    public List<Course> getCoursesByCategory(int categoryId, int page) {
        List<Course> list = new ArrayList<>();
        String query = "SELECT [id], [teacher_id], [title], [thumbnail_url], "
                + "[description], [category_id], [status], [created_at], [price] "
                + "FROM [Onlinelearning].[dbo].[courses] "
                + "WHERE [category_id] = ? AND [status] = 'active' "
                + "ORDER BY [id] "
                + "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, categoryId);
            ps.setInt(2, (page - 1) * PAGE_SIZE);
            ps.setInt(3, PAGE_SIZE);
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Course course = new Course(
                            rs.getInt("id"),
                            rs.getInt("teacher_id"),
                            rs.getString("title"),
                            rs.getString("thumbnail_url"),
                            rs.getString("description"),
                            rs.getInt("category_id"),
                            rs.getString("status"),
                            rs.getTimestamp("created_at"),
                            rs.getInt("price")
                    );
                    list.add(course);
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(CourseDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        return list;
    }
    
    /**
     * Lấy tất cả các danh mục
     * @return Danh sách các danh mục
     */
    public List<Category> getAllCategories() {
        List<Category> list = new ArrayList<>();
        String query = "SELECT [id], [semester] "
                + "FROM [Onlinelearning].[dbo].[category]";
        
        try (PreparedStatement ps = connection.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                Category category = new Category(
                        rs.getInt("id"),
                        rs.getString("semester")
                );
                list.add(category);
            }
        } catch (SQLException ex) {
            Logger.getLogger(CourseDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        return list;
    }
    
    public List<Course> getLatestCourses() {
        List<Course> courses = new ArrayList<>();
        String sql = "SELECT TOP 10 c.*, " +
                    "(SELECT COUNT(*) FROM course_enrollments ce WHERE ce.course_id = c.id) as enrollment_count, " +
                    "(SELECT COUNT(*) FROM Lesson l WHERE l.CourseID = c.id) as lesson_count " +
                    "FROM courses c " +
                    "WHERE c.status = 'active' " +
                    "ORDER BY c.created_at DESC";
        
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Course course = new Course();
                course.setId(rs.getInt("id"));
                course.setTitle(rs.getString("title"));
                course.setThumbnailUrl(rs.getString("thumbnail_url"));
                course.setDescription(rs.getString("description"));
                course.setPrice(rs.getInt("price"));
                course.setCreatedAt(rs.getDate("created_at"));
                course.setEnrollmentCount(rs.getInt("enrollment_count"));
                course.setLessonCount(rs.getInt("lesson_count"));
                courses.add(course);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return courses;
    }
    
    public List<Course> getHotCourses() {
        List<Course> courses = new ArrayList<>();
        String sql = "SELECT TOP 10 c.id, c.teacher_id, c.title, c.thumbnail_url, " +
                "c.category_id, c.status, c.created_at, c.price, " +
                "COUNT(ce.id) as enrollment_count, " +
                "(SELECT COUNT(*) FROM Lesson l WHERE l.CourseID = c.id) as lesson_count " +
                "FROM courses c " +
                "LEFT JOIN course_enrollments ce ON c.id = ce.course_id " +
                "WHERE c.status = 'active' " +
                "GROUP BY c.id, c.teacher_id, c.title, c.thumbnail_url, " +
                " c.category_id, c.status, c.created_at, c.price " +
                "ORDER BY COUNT(ce.id) DESC";
        
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Course course = new Course();
                course.setId(rs.getInt("id"));
                course.setTitle(rs.getString("title"));
                course.setThumbnailUrl(rs.getString("thumbnail_url"));
                course.setPrice(rs.getInt("price"));
                course.setCreatedAt(rs.getDate("created_at"));
                course.setEnrollmentCount(rs.getInt("enrollment_count"));
                course.setLessonCount(rs.getInt("lesson_count"));
                courses.add(course);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return courses;
    }
    
    public List<Blog> getLatestBlogs() {
        List<Blog> blogs = new ArrayList<>();
        String sql = "SELECT TOP 10 b.* FROM blogs b ORDER BY b.created_at DESC";
        
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Blog blog = new Blog();
                blog.setId(rs.getInt("id"));
                blog.setTitle(rs.getString("title"));
                blog.setContent(rs.getString("content"));
                blog.setAuthorId(rs.getInt("author_id"));
                blog.setCreatedAt(rs.getDate("created_at"));
                blogs.add(blog);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return blogs;
    }
    

//    public static void main(String[] args) {
//        CourseDAO dao = new CourseDAO();
//        List<Course> courses= dao.getAllCourses();
//
//        if (courses.isEmpty()) {
//            System.out.println("Không có dữ liệu trong bảng courses.");
//        } else {
//            for (Course c : courses) {
//                System.out.println("ID: " + c.getId() + " | Title: " + c.getTitle() + " | Created at: " + c.getCreatedAt());
//            }
//        }
//    }
}
