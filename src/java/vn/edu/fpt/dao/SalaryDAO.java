/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nb://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package vn.edu.fpt.dao;

import vn.edu.fpt.model.Salary;
import java.sql.*;
import java.util.*;

/**
 *
 * @author regio
 */
public class SalaryDAO extends DBContext {
    /**
     * Lấy danh sách các lương giáo viên theo trang với phân trang
     * @param keyword Từ khóa tìm kiếm theo tên giáo viên
     * @param page Số trang hiện tại
     * @param pageSize Số lượng bản ghi trên mỗi trang
     * @return Danh sách các lương giáo viên
     */
    public List<Salary> getAllSalaries(String keyword, int page, int pageSize) {
        List<Salary> list = new ArrayList<>();
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            StringBuilder sql = new StringBuilder(
                "SELECT ts.id, ts.teacher_id, u.first_name + ' ' + u.last_name AS teacher_name, " +
                "ts.month, ts.year, ts.paid, ts.total_amount " +
                "FROM teacher_salary ts " +
                "JOIN users u ON ts.teacher_id = u.id"
            );

            // Add WHERE clause only if keyword is not empty
            if (keyword != null && !keyword.trim().isEmpty()) {
                sql.append(" WHERE (u.first_name + ' ' + u.last_name) LIKE ?");
            }

            // Add ORDER BY and pagination for SQL Server
            sql.append(" ORDER BY ts.id OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");

            ps = connection.prepareStatement(sql.toString());
            int paramIndex = 1;
            if (keyword != null && !keyword.trim().isEmpty()) {
                ps.setString(paramIndex++, "%" + keyword + "%");
            }
            ps.setInt(paramIndex++, (page - 1) * pageSize); // OFFSET
            ps.setInt(paramIndex, pageSize); // FETCH NEXT

            rs = ps.executeQuery();
            while (rs.next()) {
                Salary s = new Salary();
                s.setId(rs.getInt("id"));
                s.setTeacherId(rs.getInt("teacher_id"));
                s.setTeacherName(rs.getString("teacher_name"));
                s.setMonth(rs.getString("month"));
                s.setYear(rs.getInt("year"));
                s.setPaid(rs.getDouble("paid"));
                s.setTotalAmount(rs.getDouble("total_amount"));
                list.add(s);
            }
        } catch (SQLException e) {
            System.err.println("Error retrieving paginated salaries with keyword: " + keyword + " - " + e.getMessage());
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
            } catch (SQLException e) {
                System.err.println("Error closing database resources: " + e.getMessage());
            }
        }
        return list;
    }

    /**
     * Đếm tổng số bản ghi lương giáo viên dựa trên từ khóa
     * @param keyword Từ khóa tìm kiếm theo tên giáo viên
     * @return Tổng số bản ghi
     */
    public int getTotalRecords(String keyword) {
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            StringBuilder sql = new StringBuilder(
                "SELECT COUNT(*) " +
                "FROM teacher_salary ts " +
                "JOIN users u ON ts.teacher_id = u.id"
            );

            if (keyword != null && !keyword.trim().isEmpty()) {
                sql.append(" WHERE (u.first_name + ' ' + u.last_name) LIKE ?");
            }

            ps = connection.prepareStatement(sql.toString());
            if (keyword != null && !keyword.trim().isEmpty()) {
                ps.setString(1, "%" + keyword + "%");
            }

            rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            System.err.println("Error counting total records with keyword: " + keyword + " - " + e.getMessage());
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
            } catch (SQLException e) {
                System.err.println("Error closing database resources: " + e.getMessage());
            }
        }
        return 0;
    }

    /**
     * Lấy thông tin giáo viên và số tiền lương theo id
     * @param id ID của giáo viên
     * @return Thông tin lương của giáo viên
     */
    public Salary getSalaryByTeacherId(int id) {
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            String sql = "SELECT ts.id, ts.teacher_id, u.first_name + ' ' + u.last_name AS teacher_name, " +
                         "ts.month, ts.year, ts.paid, ts.total_amount " +
                         "FROM teacher_salary ts " +
                         "JOIN users u ON ts.teacher_id = u.id " +
                         "WHERE ts.teacher_id = ?";
            ps = connection.prepareStatement(sql);
            ps.setInt(1, id);
            rs = ps.executeQuery();
            if (rs.next()) {
                Salary s = new Salary();
                s.setId(rs.getInt("id"));
                s.setTeacherId(rs.getInt("teacher_id"));
                s.setTeacherName(rs.getString("teacher_name"));
                s.setMonth(rs.getString("month"));
                s.setYear(rs.getInt("year"));
                s.setPaid(rs.getDouble("paid"));
                s.setTotalAmount(rs.getDouble("total_amount"));
                return s;
            }
        } catch (SQLException e) {
            System.err.println("Error retrieving salary for teacherId: " + id + " - " + e.getMessage());
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
            } catch (SQLException e) {
                System.err.println("Error closing database resources: " + e.getMessage());
            }
        }
        return null;
    }

    public static void main(String[] args) {
        SalaryDAO dao = new SalaryDAO();
        String keyword = "John";  // Từ khóa mẫu để tìm kiếm
        int page = 1;
        int pageSize = 5;
        List<Salary> salaries = dao.getAllSalaries(keyword, page, pageSize);
        for (Salary s : salaries) {
            System.out.println("ID: " + s.getId() + ", Teacher ID: " + s.getTeacherId() + ", Name: " + s.getTeacherName() + 
                               ", Month: " + s.getMonth() + ", Year: " + s.getYear() + ", Paid: " + s.getPaid() + 
                               ", Total Amount: " + String.format("%.2f", s.getTotalAmount()));
        }
    }
}