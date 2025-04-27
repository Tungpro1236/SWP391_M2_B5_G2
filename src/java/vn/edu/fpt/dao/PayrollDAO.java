/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package vn.edu.fpt.dao;
import vn.edu.fpt.model.Payroll;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
/**
 *
 * @author regio
 */
public class PayrollDAO extends DBContext {
    public List<Payroll> getAllPayrolls() throws SQLException {
        List<Payroll> payrolls = new ArrayList<>();
        String sql = "SELECT SalaryID, TeacherID, TeacherName, GrossAmount,"
                + " CommissionRate, CommissionAmount, SalaryAmount, SalaryMonth, "
                + "SalaryYear, PaymentStatus, TransactionCount, TotalCourseRevenue, "
                + "Status FROM [dbo].[TeacherPayrollView]";

        try (
             Statement stmt = connection.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                Payroll payroll = new Payroll();
                payroll.setSalaryId(rs.getInt("SalaryID"));
                payroll.setTeacherId(rs.getInt("TeacherID"));
                payroll.setTeacherName(rs.getString("TeacherName"));
                payroll.setGrossAmount(rs.getDouble("GrossAmount"));
                payroll.setCommissionRate(rs.getDouble("CommissionRate"));
                payroll.setCommissionAmount(rs.getDouble("CommissionAmount"));
                payroll.setSalaryAmount(rs.getDouble("SalaryAmount"));
                payroll.setSalaryMonth(rs.getInt("SalaryMonth"));
                payroll.setSalaryYear(rs.getInt("SalaryYear"));
                payroll.setPaymentStatus(rs.getString("PaymentStatus"));
                payroll.setTransactionCount(rs.getInt("TransactionCount"));
                payroll.setTotalCourseRevenue(rs.getDouble("TotalCourseRevenue"));
                payroll.setStatus(rs.getString("Status"));
                payrolls.add(payroll);
            }
        }
        return payrolls;
    }
    
    public void generatePayroll(int month, int year, Integer adminId) throws SQLException {
        String sql = "{call [dbo].[GenerateTeacherPayroll](?, ?, ?)}";

        try (
             CallableStatement stmt = connection.prepareCall(sql)) {
            stmt.setInt(1, month);
            stmt.setInt(2, year);
            if (adminId != null) {
                stmt.setInt(3, adminId);
            } else {
                stmt.setNull(3, Types.INTEGER);
            }
            stmt.execute();
        }
    }
    
    // Mark salary as paid
    public void markSalaryPaid(int salaryId, Integer adminId) throws SQLException {
        String sql = "{call [dbo].[MarkTeacherSalaryPaid](?, ?)}";

        try (
             CallableStatement stmt = connection.prepareCall(sql)) {
            stmt.setInt(1, salaryId);
            if (adminId != null) {
                stmt.setInt(2, adminId);
            } else {
                stmt.setNull(2, Types.INTEGER);
            }
            stmt.execute();
        }
    }
}
