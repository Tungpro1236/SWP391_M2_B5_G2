/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package vn.edu.fpt.dao;

import java.text.SimpleDateFormat;
import vn.edu.fpt.model.Blog;
import java.sql.*;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

public class BlogDAO {
    private Connection connection;

    public BlogDAO(Connection connection) {
        this.connection = connection;
    }

    // Lấy tất cả blog đã publish
    public List<Blog> getAllPublishedBlogs() throws SQLException {
        List<Blog> blogs = new ArrayList<>();
        String query = "SELECT id, title, content, author_id, created_at, thumbnail_url, published_at " +
                       "FROM blogs WHERE published_at IS NOT NULL ORDER BY published_at DESC";
        
        try (Statement stmt = connection.createStatement();
             ResultSet rs = stmt.executeQuery(query)) {
            
            while (rs.next()) {
                Blog blog = new Blog(
                    rs.getInt("id"),
                    rs.getString("title"),
                    rs.getString("content"),
                    rs.getInt("author_id"),
                    rs.getDate("created_at"),
                    rs.getString("thumbnail_url"),
                    rs.getDate("published_at")
                );
                blogs.add(blog);
            }
        }
        return blogs;
    }

    // Tìm kiếm blog theo từ khóa
    public List<Blog> searchBlogs(String keyword) throws SQLException {
        List<Blog> blogs = new ArrayList<>();
        String query = "SELECT id, title, content, author_id, created_at, thumbnail_url, published_at " +
                       "FROM blogs WHERE published_at IS NOT NULL AND " +
                       "(title LIKE ? OR content LIKE ?) ORDER BY published_at DESC";
        
        try (PreparedStatement pstmt = connection.prepareStatement(query)) {
            pstmt.setString(1, "%" + keyword + "%");
            pstmt.setString(2, "%" + keyword + "%");
            
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                Blog blog = new Blog(
                    rs.getInt("id"),
                    rs.getString("title"),
                    rs.getString("content"),
                    rs.getInt("author_id"),
                    rs.getDate("created_at"),
                    rs.getString("thumbnail_url"),
                    rs.getDate("published_at")
                );
                blogs.add(blog);
            }
        }
        return blogs;
    }
    
    // Lấy blog theo ID
    public Blog getBlogById(int id) throws SQLException {
        String query = "SELECT id, title, content, author_id, created_at, thumbnail_url, published_at " +
                       "FROM blogs WHERE id = ?";
        
        try (PreparedStatement pstmt = connection.prepareStatement(query)) {
            pstmt.setInt(1, id);
            
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                return new Blog(
                    rs.getInt("id"),
                    rs.getString("title"),
                    rs.getString("content"),
                    rs.getInt("author_id"),
                    rs.getDate("created_at"),
                    rs.getString("thumbnail_url"),
                    rs.getDate("published_at")
                );
            }
        }
        return null;
    }
    public Map<String, Integer> getCategoriesWithCount() throws SQLException {
    Map<String, Integer> categories = new LinkedHashMap<>();
    String query = "SELECT c.name, COUNT(b.id) as count " +
                   "FROM categories c " +
                   "LEFT JOIN blog_categories bc ON c.id = bc.category_id " +
                   "LEFT JOIN blogs b ON bc.blog_id = b.id AND b.published_at IS NOT NULL " +
                   "GROUP BY c.name " +
                   "ORDER BY count DESC";
    
    try (Statement stmt = connection.createStatement();
         ResultSet rs = stmt.executeQuery(query)) {
        
        while (rs.next()) {
            categories.put(rs.getString("name"), rs.getInt("count"));
        }
    }
    return categories;
}
    public List<Blog> getBlogsByCategory(String categoryName) throws SQLException {
    List<Blog> blogs = new ArrayList<>();
    String query = "SELECT b.id, b.title, b.content, b.author_id, b.created_at, b.thumbnail_url, b.published_at " +
                   "FROM blogs b " +
                   "JOIN blog_categories bc ON b.id = bc.blog_id " +
                   "JOIN categories c ON bc.category_id = c.id " +
                   "WHERE b.published_at IS NOT NULL AND c.name = ? " +
                   "ORDER BY b.published_at DESC";
    
    try (PreparedStatement pstmt = connection.prepareStatement(query)) {
        pstmt.setString(1, categoryName);
        ResultSet rs = pstmt.executeQuery();
        
        while (rs.next()) {
            Blog blog = new Blog(
                rs.getInt("id"),
                rs.getString("title"),
                rs.getString("content"),
                rs.getInt("author_id"),
                rs.getDate("created_at"),
                rs.getString("thumbnail_url"),
                rs.getDate("published_at")
            );
            blogs.add(blog);
        }
    }
    return blogs;
}
}