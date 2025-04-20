/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
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

    public List<Salary> getAllSalaries(String keyword) {
        List<Salary> list = new ArrayList<>();
        String sql = "SELECT ts.id, ts.teacher_id, u.first_name +"
                + " ' ' + u.last_name AS teacher_name, ts.month, ts.year, ts.paid "
                + "FROM teacher_salary ts "
                + "JOIN users u ON ts.teacher_id = u.id "
                + "WHERE (u.first_name + ' ' + u.last_name) LIKE ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, "%" + keyword + "%");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Salary s = new Salary();
                s.setId(rs.getInt("id"));
                s.setTeacherId(rs.getInt("teacher_id"));
                s.setTeacherName(rs.getString("teacher_name"));
                s.setMonth(rs.getString("month"));
                s.setYear(rs.getInt("year"));
                s.setPaid(rs.getDouble("paid"));
                list.add(s);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public Salary getSalaryByTeacherId(int id) {
        String sql = "SELECT ts.id, ts.teacher_id, u.first_name + ' ' + u.last_name AS teacher_name, " +
                     "ts.month, ts.year, ts.paid, ts.total_amount " +
                     "FROM teacher_salary ts " +
                     "JOIN users u ON ts.teacher_id = u.id " +
                     "WHERE ts.teacher_id = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
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
            e.printStackTrace();
        }
        return null;
    }

    public static void main(String[] args) {
        SalaryDAO dao = new SalaryDAO();
        String keyword = "John";  // Từ khóa mẫu để tìm kiếm
        List<Salary> salaries = dao.getAllSalaries(keyword);
        for (Salary s : salaries) {
            System.out.println("ID: " + s.getId() + ", Teacher ID: " + s.getTeacherId() + ", Name: " + s.getTeacherName() + ", Month: " + s.getMonth() + ", Year: " + s.getYear() + ", Paid: " + s.getPaid());
        }
    }
}
