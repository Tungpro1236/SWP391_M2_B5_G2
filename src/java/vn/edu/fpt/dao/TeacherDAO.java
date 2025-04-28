/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package vn.edu.fpt.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import vn.edu.fpt.model.UserModel;

/**
 *
 * @author regio
 */
public class TeacherDAO extends DBContext {

    // Lấy danh sách tất cả giáo viên (role_id = 2)
    public List<UserModel> getAllTeachers() throws SQLException {
        List<UserModel> teachers = new ArrayList<>();
        String sql = "SELECT id, first_name, middle_name, last_name FROM users WHERE role_id = 2 ORDER BY id";
        try (
                PreparedStatement stmt = connection.prepareStatement(sql); ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                UserModel teacher = new UserModel();
                teacher.setId(rs.getInt("id"));
                teacher.setFirstName(rs.getString("first_name"));
                teacher.setMiddleName(rs.getString("middle_name"));
                teacher.setLastName(rs.getString("last_name"));
                teachers.add(teacher);
            }
        }
        return teachers;
    }

    public UserModel getFirstTeacher() throws SQLException {
        String sql = "SELECT TOP 1 id, first_name, middle_name, last_name FROM users WHERE role_id = 2 ORDER BY id";
        try (
                PreparedStatement stmt = connection.prepareStatement(sql); ResultSet rs = stmt.executeQuery()) {
            if (rs.next()) {
                UserModel teacher = new UserModel();
                teacher.setId(rs.getInt("id"));
                teacher.setFirstName(rs.getString("first_name"));
                teacher.setMiddleName(rs.getString("middle_name"));
                teacher.setLastName(rs.getString("last_name"));
                return teacher;
            }
        }
        return null;
    }
}
