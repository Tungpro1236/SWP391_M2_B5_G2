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

    public List<Payroll> getAllPayrolls(int page, int pageSize, String paymentStatus) throws SQLException {
        List<Payroll> payrolls = new ArrayList<>();
        String sql = "SELECT SalaryID, TeacherID, TeacherName, GrossAmount,"
                + " CommissionRate, CommissionAmount, SalaryAmount, SalaryMonth, "
                + "SalaryYear, PaymentStatus, TransactionCount, TotalCourseRevenue, "
                + "Status FROM [dbo].[TeacherPayrollView] "
                + (paymentStatus != null && !paymentStatus.isEmpty() ? "WHERE PaymentStatus = ? " : "")
                + "ORDER BY SalaryID DESC "
                + "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            int paramIndex = 1;
            if (paymentStatus != null && !paymentStatus.isEmpty()) {
                stmt.setString(paramIndex++, paymentStatus);
            }
            stmt.setInt(paramIndex++, (page - 1) * pageSize);
            stmt.setInt(paramIndex, pageSize);
            try (ResultSet rs = stmt.executeQuery()) {
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
        }
        return payrolls;
    }

    public int getPayrollCount(String paymentStatus) throws SQLException {
        String sql = "SELECT COUNT(*) FROM [dbo].[TeacherPayrollView]"
                + (paymentStatus != null && !paymentStatus.isEmpty() ? " WHERE PaymentStatus = ?" : "");
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            if (paymentStatus != null && !paymentStatus.isEmpty()) {
                stmt.setString(1, paymentStatus);
            }
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
                return 0;
            }
        }
    }

    public String[] generatePayroll(int month, int year, Integer adminId, String teacherName) throws SQLException {
        String sql = "{call [dbo].[GenerateTeacherPayroll](?, ?, ?, ?)}";
        String[] result = new String[2];

        try (CallableStatement stmt = connection.prepareCall(sql)) {
            stmt.setInt(1, month);
            stmt.setInt(2, year);
            if (adminId != null) {
                stmt.setInt(3, adminId);
            } else {
                stmt.setNull(3, Types.INTEGER);
            }
            stmt.setString(4, teacherName);

            boolean hasResults = stmt.execute();
            if (hasResults) {
                try (ResultSet rs = stmt.getResultSet()) {
                    if (rs.next()) {
                        result[0] = rs.getString("Status");
                        result[1] = rs.getString("Message");
                    }
                }
            }
            return result;
        }
    }

    public boolean isSalaryPaid(int salaryId) throws SQLException {
        String sql = "SELECT paid FROM teacher_salary WHERE id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, salaryId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getBoolean("paid");
            }
            return false;
        }
    }

    public void markSalaryPaid(int salaryId, Integer adminId) throws SQLException {
        String sql = "{call [dbo].[MarkTeacherSalaryPaid](?, ?)}";

        try (CallableStatement stmt = connection.prepareCall(sql)) {
            stmt.setInt(1, salaryId);
            if (adminId != null) {
                stmt.setInt(2, adminId);
            } else {
                stmt.setNull(2, Types.INTEGER);
            }
            stmt.execute();
        }
    }

    public boolean updateCommission(int salaryId, double commissionRate, int adminId) throws SQLException {
        String checkSql = "SELECT gross_amount FROM [dbo].[teacher_salary] WHERE id = ? AND status = 'Pending'";
        try (PreparedStatement checkStmt = connection.prepareStatement(checkSql)) {
            checkStmt.setInt(1, salaryId);
            ResultSet rs = checkStmt.executeQuery();
            if (!rs.next() || rs.getObject("gross_amount") == null) {
                System.out.println("PayrollDAO: Không tìm thấy bản ghi hoặc gross_amount là NULL cho lương ID " + salaryId);
                return false;
            }
        }

        String sql = "UPDATE [dbo].[teacher_salary] "
                + "SET commission_rate = ?, "
                + "    commission_amount = gross_amount * ?, "
                + "    total_amount = gross_amount - (gross_amount * ?), "
                + "    last_modified_by = ? "
                + "WHERE id = ? AND status = 'Pending'";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setDouble(1, commissionRate);
            stmt.setDouble(2, commissionRate);
            stmt.setDouble(3, commissionRate);
            stmt.setInt(4, adminId);
            stmt.setInt(5, salaryId);
            int rowsAffected = stmt.executeUpdate();
            System.out.println("PayrollDAO: Cập nhật commission cho lương ID " + salaryId + ", commissionRate=" + commissionRate + ", rowsAffected=" + rowsAffected);
            return rowsAffected > 0;
        } catch (SQLException e) {
            String errorMessage = e.getMessage() != null ? e.getMessage() : "Không có thông tin lỗi SQL";
            System.err.println("PayrollDAO: Lỗi cập nhật commission cho lương ID " + salaryId + ": " + errorMessage + ", SQLState=" + e.getSQLState() + ", ErrorCode=" + e.getErrorCode());
            throw e;
        }
    }

    public Payroll getPayrollById(int salaryId) throws SQLException {
        String sql = "SELECT id, teacher_id, teacher_name, gross_amount, commission_rate, "
                + "commission_amount, total_amount, month, year, "
                + "paid, transaction_count, total_course_revenue, status "
                + "FROM teacher_salary WHERE id = ?";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, salaryId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                Payroll payroll = new Payroll();
                payroll.setSalaryId(rs.getInt("id"));
                payroll.setTeacherId(rs.getInt("teacher_id"));
                payroll.setTeacherName(rs.getString("teacher_name"));
                payroll.setGrossAmount(rs.getDouble("gross_amount"));
                payroll.setCommissionRate(rs.getDouble("commission_rate"));
                payroll.setCommissionAmount(rs.getDouble("commission_amount"));
                payroll.setSalaryAmount(rs.getDouble("total_amount"));
                payroll.setSalaryMonth(rs.getInt("month"));
                payroll.setSalaryYear(rs.getInt("year"));
                payroll.setPaymentStatus(rs.getBoolean("paid") ? "Paid" : "Unpaid");
                payroll.setTransactionCount(rs.getInt("transaction_count"));
                payroll.setTotalCourseRevenue(rs.getDouble("total_course_revenue"));
                payroll.setStatus(rs.getString("status"));
                return payroll;
            }
            return null;
        }
    }
}
