/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package vn.edu.fpt.controller;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import vn.edu.fpt.dao.PayrollDAO;
import java.sql.SQLException;
import vn.edu.fpt.enums.Role;
import vn.edu.fpt.model.Payroll;
import vn.edu.fpt.model.UserModel;

/**
 *
 * @author regio
 */
@WebServlet(name = "EditCommissionController", urlPatterns = {"/editCommission"})
public class EditCommissionController extends HttpServlet {

    private PayrollDAO payrollDAO;

    @Override
    public void init() {
        payrollDAO = new PayrollDAO();
    }

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.getRequestDispatcher("/error.jsp").forward(request, response);
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet EditCommissionController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet EditCommissionController at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/plain;charset=UTF-8");
        try {
            int salaryId = Integer.parseInt(request.getParameter("salaryId"));
            Payroll payroll = payrollDAO.getPayrollById(salaryId);
            if (payroll == null) {
                response.getWriter().write("error:PayrollNotFound");
                return;
            }
            // Trả về dữ liệu dạng text (hoặc JSON nếu cần)
            response.getWriter().write("salaryId:" + payroll.getSalaryId() + 
                                     ",commissionRate:" + payroll.getCommissionRate());
        } catch (NumberFormatException e) {
            response.getWriter().write("error:InvalidSalaryId");
        } catch (SQLException e) {
            e.printStackTrace();
            response.getWriter().write("error:DatabaseError");
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("error:UnexpectedError: " + e.getMessage());
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/plain;charset=UTF-8");
        // Check if user is admin
       try {
            UserModel user = (UserModel) request.getSession().getAttribute("user");
            if (user == null || user.getRoleId() != Role.ADMIN.getRoleId()) {
                response.getWriter().write("error:Unauthorized");
                return;
            }

            String salaryIdParam = request.getParameter("salaryId");
            String commissionRateParam = request.getParameter("commissionRate");

            if (salaryIdParam == null || salaryIdParam.trim().isEmpty() || 
                commissionRateParam == null || commissionRateParam.trim().isEmpty()) {
                response.getWriter().write("error:MissingParameters");
                return;
            }

            int salaryId = Integer.parseInt(salaryIdParam);
            double commissionRate = Double.parseDouble(commissionRateParam);

            // Chuyển đổi nếu nhập dạng phần trăm
            if (commissionRate > 1) {
                commissionRate = commissionRate / 100.0; // Ví dụ: 24 -> 0.24, 23.99 -> 0.2399
            }

            // Kiểm tra giá trị
            if (commissionRate < 0 || commissionRate > 1) {
                response.getWriter().write("error:InvalidCommissionRate");
                return;
            }

            boolean success = payrollDAO.updateCommission(salaryId, commissionRate, user.getId());
            if (success) {
                response.getWriter().write("success");
            } else {
                response.getWriter().write("error:UpdateFailed");
            }
        } catch (NumberFormatException e) {
            response.getWriter().write("error:InvalidInput");
        } catch (SQLException e) {
            String errorMessage = e.getMessage() != null ? e.getMessage() : "Không có thông tin lỗi SQL";
            response.getWriter().write("error:DatabaseError: " + errorMessage);
        } catch (Exception e) {
            e.printStackTrace();
            String errorMessage = e.getMessage() != null ? e.getMessage() : "Không có thông tin lỗi";
            response.getWriter().write("error:UnexpectedError: " + errorMessage);
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
