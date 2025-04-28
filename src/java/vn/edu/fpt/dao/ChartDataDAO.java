/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package vn.edu.fpt.dao;

import vn.edu.fpt.model.Chartdata;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author regio
 */
public class ChartDataDAO extends DBContext {

    public List<Chartdata> getChartData(int year) throws SQLException {
        List<Chartdata> chartData = new ArrayList<>();
        String sql = "SELECT Month, TotalTeacherSalary, TransactionCount, TotalRevenue FROM [dbo].[PayrollChartData] WHERE Year = ? ORDER BY Month";

        try (
                PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, year);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Chartdata data = new Chartdata();
                    data.setMonth(rs.getInt("Month"));
                    data.setTotalTeacherSalary(rs.getDouble("TotalTeacherSalary"));
                    data.setTransactionCount(rs.getInt("TransactionCount"));
                    data.setTotalRevenue(rs.getDouble("TotalRevenue"));
                    chartData.add(data);
                }
            }
        }
        return chartData;
    }
}
