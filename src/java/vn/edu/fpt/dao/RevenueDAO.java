/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package vn.edu.fpt.dao;

import vn.edu.fpt.model.Revenue;
import java.math.BigDecimal;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
/**
 *
 * @author regio
 */
public class RevenueDAO extends DBContext {

    /**
     * Retrieves all revenue records.
     * @return a List of Revenue objects
     */
    public List<Revenue> getAllRevenues() {
        List<Revenue> revenues = new ArrayList<>();
        String sql = "SELECT r.id, r.total_amount, r.commission_id, r.commission_rate, " +
                     "CAST(CAST(r.commission_amount AS DECIMAL(15,3)) AS VARCHAR(20)) AS commission_amount, " +
                     "r.month, r.year, r.generated_at " +
                     "FROM revenue r " +
                     "ORDER BY r.year DESC, r.month DESC";
        try (PreparedStatement ps = connection.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Revenue revenue = new Revenue();
                revenue.setId(rs.getInt("id"));
                revenue.setTotalAmount(rs.getBigDecimal("total_amount"));
                revenue.setCommissionId(rs.getInt("commission_id"));
                revenue.setCommissionRate(rs.getBigDecimal("commission_rate"));
                // Parse the string commission_amount to BigDecimal, removing trailing zeros
                String commissionAmountStr = rs.getString("commission_amount");
                revenue.setCommissionAmount(new BigDecimal(commissionAmountStr));
                revenue.setMonth(rs.getInt("month"));
                revenue.setYear(rs.getInt("year"));
                revenue.setGeneratedAt(rs.getTimestamp("generated_at"));
                revenues.add(revenue);
            }
        } catch (SQLException e) {
            throw new RuntimeException("Failed to retrieve revenue records: " + e.getMessage(), e);
        }
        return revenues;
    }

    /**
     * Generates a new revenue record for the specified month and year.
     * @param month the month (1-12)
     * @param year the year
     */
    public void generateRevenue(int month, int year) {
        // Validate input
        if (month < 1 || month > 12) {
            throw new IllegalArgumentException("Invalid month. Must be between 1 and 12.");
        }
        if (year < 2000 || year > java.time.Year.now().getValue()) {
            throw new IllegalArgumentException("Invalid year. Must be between 2000 and current year.");
        }

        // Check if revenue record already exists for this month and year
        String checkSql = "SELECT COUNT(*) FROM revenue WHERE month = ? AND year = ?";
        try (PreparedStatement ps = connection.prepareStatement(checkSql)) {
            ps.setInt(1, month);
            ps.setInt(2, year);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next() && rs.getInt(1) > 0) {
                    throw new RuntimeException("Revenue record already exists for " + month + "/" + year);
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("Failed to check existing revenue record: " + e.getMessage(), e);
        }

        // Get total revenue from StatisticsView
        BigDecimal totalAmount = BigDecimal.ZERO;
        String revenueSql = "SELECT TotalRevenue FROM StatisticsView WHERE Month = ? AND Year = ?";
        try (PreparedStatement ps = connection.prepareStatement(revenueSql)) {
            ps.setInt(1, month);
            ps.setInt(2, year);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    totalAmount = rs.getBigDecimal("TotalRevenue");
                    if (totalAmount == null) totalAmount = BigDecimal.ZERO;
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("Failed to calculate total revenue: " + e.getMessage(), e);
        }

        // If no revenue, no need to create record
        if (totalAmount.compareTo(BigDecimal.ZERO) <= 0) {
            throw new RuntimeException("No revenue to generate for " + month + "/" + year);
        }

        // Get latest commission rate and ID
        BigDecimal commissionRate = new BigDecimal("20.00"); // Default if no commission found
        int commissionId = 0; // Nullable in DB
        String commissionSql = "SELECT TOP 1 id, rate FROM commissions WHERE effective_from <= GETDATE() ORDER BY effective_from DESC, id DESC";
        try (PreparedStatement ps = connection.prepareStatement(commissionSql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                commissionId = rs.getInt("id");
                commissionRate = rs.getBigDecimal("rate");
            }
        } catch (SQLException e) {
            throw new RuntimeException("Failed to retrieve latest commission rate: " + e.getMessage(), e);
        }

        // Insert new revenue record
        String insertSql = "INSERT INTO revenue (total_amount, commission_id, commission_rate, month, year, generated_at) " +
                          "VALUES (?, ?, ?, ?, ?, GETDATE())";
        try (PreparedStatement ps = connection.prepareStatement(insertSql)) {
            ps.setBigDecimal(1, totalAmount);
            ps.setInt(2, commissionId);
            ps.setBigDecimal(3, commissionRate);
            ps.setInt(4, month);
            ps.setInt(5, year);
            ps.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException("Failed to generate revenue record: " + e.getMessage(), e);
        }
    }
}