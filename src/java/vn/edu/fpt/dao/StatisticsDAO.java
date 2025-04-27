/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package vn.edu.fpt.dao;
import vn.edu.fpt.model.Statistics;
import vn.edu.fpt.model.TopTeacher;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
/**
 *
 * @author regio
 */
public class StatisticsDAO extends DBContext {

    public List<Statistics> getStatistics(int year) throws SQLException {
        List<Statistics> statisticsList = new ArrayList<>();
        String sql = "SELECT Year, Month, TotalRevenue, TotalTeachers, TotalStudents, TotalCourses, TotalSuccessfulTransactions " +
                     "FROM [dbo].[StatisticsView] WHERE Year = ? ORDER BY Month";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, year);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Statistics stats = new Statistics();
                    stats.setYear(rs.getInt("Year"));
                    stats.setMonth(rs.getInt("Month"));
                    stats.setTotalRevenue(rs.getDouble("TotalRevenue"));
                    stats.setTotalTeachers(rs.getInt("TotalTeachers"));
                    stats.setTotalStudents(rs.getInt("TotalStudents"));
                    stats.setTotalCourses(rs.getInt("TotalCourses"));
                    stats.setTotalSuccessfulTransactions(rs.getInt("TotalSuccessfulTransactions"));
                    statisticsList.add(stats);
                }
            }
        }
        return statisticsList;
    }

    public List<TopTeacher> getTopTeachers(int year) throws SQLException {
        List<TopTeacher> topTeachers = new ArrayList<>();
        String sql = "SELECT TeacherID, TeacherName, TotalSalary, Year FROM [dbo].[TopTeachersView] WHERE Year = ?";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, year);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    TopTeacher teacher = new TopTeacher();
                    teacher.setTeacherId(rs.getInt("TeacherID"));
                    teacher.setTeacherName(rs.getString("TeacherName"));
                    teacher.setTotalSalary(rs.getDouble("TotalSalary"));
                    teacher.setYear(rs.getInt("Year"));
                    topTeachers.add(teacher);
                }
            }
        }
        return topTeachers;
    }
}
