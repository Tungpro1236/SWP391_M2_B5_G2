package vn.edu.fpt.dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import model.User;

public class UserDAO extends DBContext {
    
    public User login(String email, String password) {
        String query = "SELECT * FROM users WHERE email = ? AND password = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(query);
            ps.setString(1, email);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                return new User(
                    rs.getInt("id"),
                    rs.getString("first_name"),
                    rs.getString("middle_name"),
                    rs.getString("last_name"),
                    rs.getString("email"),
                    rs.getInt("gender_id"),
                    rs.getString("password"),
                    rs.getInt("role_id"),
                    rs.getString("avatar_url"),
                    rs.getTimestamp("created_at")
                );
            }
        } catch (SQLException e) {
            System.out.println("Error in login: " + e.getMessage());
        }
        return null;
    }
    
    public boolean register(User user) {
        String query = "INSERT INTO users (first_name, middle_name, last_name, email, gender_id, password, role_id, avatar_url) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try {
            PreparedStatement ps = connection.prepareStatement(query);
            ps.setString(1, user.getFirstName());
            ps.setString(2, user.getMiddleName());
            ps.setString(3, user.getLastName());
            ps.setString(4, user.getEmail());
            ps.setInt(5, user.getGenderId());
            ps.setString(6, user.getPassword());
            ps.setInt(7, user.getRoleId());
            ps.setString(8, user.getAvatarUrl());
            
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println("Error in register: " + e.getMessage());
            return false;
        }
    }
    
    public boolean checkEmailExists(String email) {
        String query = "SELECT COUNT(*) FROM users WHERE email = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(query);
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            System.out.println("Error in checkEmailExists: " + e.getMessage());
        }
        return false;
    }
}
