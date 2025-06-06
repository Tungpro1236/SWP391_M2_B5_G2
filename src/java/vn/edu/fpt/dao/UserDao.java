package vn.edu.fpt.dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import vn.edu.fpt.model.UserModel;
import java.util.ArrayList;
import java.util.List;
import vn.edu.fpt.model.UserModel;

public class UserDAO extends DBContext {

    public UserModel login(String email, String password) {
        String query = "SELECT * FROM users WHERE email = ? AND password = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(query);
            ps.setString(1, email);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return new UserModel(
                        rs.getInt("id"),
                        rs.getString("first_name"),
                        rs.getString("middle_name"),
                        rs.getString("last_name"),
                        rs.getString("email"),
                        rs.getInt("gender_id"),
                        rs.getString("password"),
                        rs.getInt("role_id"),
                        rs.getString("avatar_url"),
                        rs.getTimestamp("created_at"),
                        rs.getBoolean("status"),
                        rs.getString("education_level"),
                        rs.getString("graduated_school"),
                        rs.getInt("graduated_year"),
                        rs.getString("major"),
                        rs.getString("certifications"),
                        rs.getInt("teaching_experience_years"),
                        rs.getString("subjects"),
                        rs.getString("teaching_levels"),
                        rs.getString("skills"),
                        rs.getString("teaching_philosophy"),
                        rs.getString("career_goals")
                );
            }
        } catch (SQLException e) {
            System.out.println("Error in login: " + e.getMessage());
        }
        return null;
    }

    public boolean register(UserModel user) {
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

    public boolean changePassword(String email, String currentPassword, String newPassword) {
        try {
            // Verify current password first
            String verifyQuery = "SELECT id FROM users WHERE email = ? AND password = ?";
            PreparedStatement verifyPs = connection.prepareStatement(verifyQuery);
            verifyPs.setString(1, email);
            verifyPs.setString(2, currentPassword);
            ResultSet rs = verifyPs.executeQuery();

            if (!rs.next()) {
                return false; // Current password is incorrect
            }

            // Update to new password
            String updateQuery = "UPDATE users SET password = ? WHERE email = ?";
            PreparedStatement updatePs = connection.prepareStatement(updateQuery);
            updatePs.setString(1, newPassword);
            updatePs.setString(2, email);

            return updatePs.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println("Error in changePassword: " + e.getMessage());
            return false;
        }
    }

    public boolean resetPassword(String email, String newPassword) {
        try {
            String query = "UPDATE users SET password = ? WHERE email = ?";
            PreparedStatement ps = connection.prepareStatement(query);
            ps.setString(1, newPassword);
            ps.setString(2, email);

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println("Error in resetPassword: " + e.getMessage());
            return false;
        }
    }

    public boolean updatePassword(String email, String newPassword) {
        try {
            String query = "UPDATE users SET password = ? WHERE email = ?";
            PreparedStatement ps = connection.prepareStatement(query);
            ps.setString(1, newPassword);
            ps.setString(2, email);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println("Error in updatePassword: " + e.getMessage());
            return false;
        }
    }

    public boolean updateProfile(UserModel user) {
        try {
            String baseQuery = "UPDATE users SET first_name=?, last_name=?, gender_id=?, avatar_url=?";

            // Add teacher-specific fields if user is a teacher (roleId = 2)
            if (user.getRoleId() == 2) {
                baseQuery += ", education_level=?, graduated_school=?, graduated_year=?, major=?, "
                        + "certifications=?, teaching_experience_years=?, subjects=?, "
                        + "teaching_levels=?, skills=?, teaching_philosophy=?, career_goals=?";
            }
            baseQuery += " WHERE id=?";

            PreparedStatement ps = connection.prepareStatement(baseQuery);

            // Set basic user information
            int paramIndex = 1;
            ps.setString(paramIndex++, user.getFirstName());
            ps.setString(paramIndex++, user.getLastName());
            ps.setInt(paramIndex++, user.getGenderId());
            ps.setString(paramIndex++, user.getAvatarUrl());

            // Set teacher-specific information if user is a teacher
            if (user.getRoleId() == 2) {
                ps.setString(paramIndex++, user.getEducationLevel());
                ps.setString(paramIndex++, user.getGraduatedSchool());
                ps.setObject(paramIndex++, user.getGraduatedYear());
                ps.setString(paramIndex++, user.getMajor());
                ps.setString(paramIndex++, user.getCertifications());
                ps.setObject(paramIndex++, user.getTeachingExperienceYears());
                ps.setString(paramIndex++, user.getSubjects());
                ps.setString(paramIndex++, user.getTeachingLevels());
                ps.setString(paramIndex++, user.getSkills());
                ps.setString(paramIndex++, user.getTeachingPhilosophy());
                ps.setString(paramIndex++, user.getCareerGoals());
            }

            // Set the user ID as the last parameter
            ps.setInt(paramIndex, user.getId());

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println("Error in updateProfile: " + e.getMessage());
            return false;
        }
    }

    public List<UserModel> getUserList(int page, int pageSize, String search, String role, String status) {
        List<UserModel> users = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT * FROM users WHERE 1=1");
        List<Object> params = new ArrayList<>();

        // Add search condition
        if (search != null && !search.trim().isEmpty()) {
            sql.append(" AND (LOWER(first_name) LIKE ? OR LOWER(last_name) LIKE ? OR LOWER(email) LIKE ?)");
            String searchParam = "%" + search.toLowerCase() + "%";
            params.add(searchParam);
            params.add(searchParam);
            params.add(searchParam);
        }

        // Add role filter
        if (role != null && !role.trim().isEmpty()) {
            sql.append(" AND role_id = ?");
            params.add(Integer.parseInt(role));
        }

        // Add status filter
        if (status != null && !status.trim().isEmpty()) {
            sql.append(" AND status = ?");
            params.add(Boolean.parseBoolean(status));
        }

        // Add pagination
        sql.append(" ORDER BY id OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");
        params.add((page - 1) * pageSize);
        params.add(pageSize);

        try {
            PreparedStatement ps = connection.prepareStatement(sql.toString());
            // Set parameters
            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                UserModel user = new UserModel(
                        rs.getInt("id"),
                        rs.getString("first_name"),
                        rs.getString("middle_name"),
                        rs.getString("last_name"),
                        rs.getString("email"),
                        rs.getInt("gender_id"),
                        rs.getString("password"),
                        rs.getInt("role_id"),
                        rs.getString("avatar_url"),
                        rs.getTimestamp("created_at"),
                        rs.getBoolean("status"),
                        rs.getString("education_level"),
                        rs.getString("graduated_school"),
                        rs.getInt("graduated_year"),
                        rs.getString("major"),
                        rs.getString("certifications"),
                        rs.getInt("teaching_experience_years"),
                        rs.getString("subjects"),
                        rs.getString("teaching_levels"),
                        rs.getString("skills"),
                        rs.getString("teaching_philosophy"),
                        rs.getString("career_goals")
                );
                user.setStatus(rs.getBoolean("status"));
                users.add(user);
            }
        } catch (SQLException e) {
            System.out.println("Error in getUserList: " + e.getMessage());
        }
        return users;
    }

    public int getTotalUsers(String search, String role, String status) {
        StringBuilder sql = new StringBuilder("SELECT COUNT(*) FROM users WHERE 1=1");
        List<Object> params = new ArrayList<>();

        // Add search condition
        if (search != null && !search.trim().isEmpty()) {
            sql.append(" AND (LOWER(first_name) LIKE ? OR LOWER(last_name) LIKE ? OR LOWER(email) LIKE ?)");
            String searchParam = "%" + search.toLowerCase() + "%";
            params.add(searchParam);
            params.add(searchParam);
            params.add(searchParam);
        }

        // Add role filter
        if (role != null && !role.trim().isEmpty()) {
            sql.append(" AND role_id = ?");
            params.add(Integer.parseInt(role));
        }

        // Add status filter
        if (status != null && !status.trim().isEmpty()) {
            sql.append(" AND status = ?");
            params.add(Boolean.parseBoolean(status));
        }

        try {
            PreparedStatement ps = connection.prepareStatement(sql.toString());
            // Set parameters
            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            System.out.println("Error in getTotalUsers: " + e.getMessage());
        }
        return 0;
    }

    public boolean updateUserStatus(int userId, boolean status) {
        String query = "UPDATE users SET status = ? WHERE id = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(query);
            ps.setBoolean(1, status);
            ps.setInt(2, userId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println("Error in updateUserStatus: " + e.getMessage());
            return false;
        }
    }

    public int getUserIdByEmail(String email) {
        String query = "SELECT id FROM users WHERE email = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(query);
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return rs.getInt("id");  // Trả về userId nếu tìm thấy người dùng
            }
        } catch (SQLException e) {
            System.out.println("Error in getUserIdByEmail: " + e.getMessage());
        }
        return -1;  // Trả về -1 nếu không tìm thấy người dùng
    }

    public List<UserModel> getAllUser() {
        List<UserModel> list = new ArrayList<>();
        String query = "SELECT * "
                + "FROM [Onlinelearning].[dbo].[users]";
        try (PreparedStatement ps = connection.prepareStatement(query); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                UserModel f = new UserModel(
                        rs.getInt("id"),
                        rs.getString("first_name"),
                        rs.getString("middle_name"),
                        rs.getString("last_name"),
                        rs.getString("email"),
                        rs.getInt("gender_id"),
                        rs.getString("password"),
                        rs.getInt("role_id"),
                        rs.getString("avatar_url"),
                        rs.getTimestamp("created_at"),
                        rs.getBoolean("status")
                );
                list.add(f);
            }
        } catch (SQLException ex) {
            Logger.getLogger(CourseDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return list;
    }

    public UserModel getTeacherById(int teacherId) {
        String query = "SELECT * FROM users WHERE id = ? AND role_id = 2";
        try {
            PreparedStatement ps = connection.prepareStatement(query);
            ps.setInt(1, teacherId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return new UserModel(
                        rs.getInt("id"),
                        rs.getString("first_name"),
                        rs.getString("middle_name"),
                        rs.getString("last_name"),
                        rs.getString("email"),
                        rs.getInt("gender_id"),
                        rs.getString("password"),
                        rs.getInt("role_id"),
                        rs.getString("avatar_url"),
                        rs.getTimestamp("created_at"),
                        rs.getBoolean("status"),
                        rs.getString("education_level"),
                        rs.getString("graduated_school"),
                        rs.getInt("graduated_year"),
                        rs.getString("major"),
                        rs.getString("certifications"),
                        rs.getInt("teaching_experience_years"),
                        rs.getString("subjects"),
                        rs.getString("teaching_levels"),
                        rs.getString("skills"),
                        rs.getString("teaching_philosophy"),
                        rs.getString("career_goals")
                );
            }
        } catch (SQLException e) {
            System.out.println("Error in getTeacherById: " + e.getMessage());
        }
        return null;
    }

}
