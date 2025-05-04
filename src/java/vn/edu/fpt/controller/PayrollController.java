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
import java.util.List;
import java.sql.SQLException;
import vn.edu.fpt.dao.PayrollDAO;
import vn.edu.fpt.model.Payroll;

/**
 *
 * @author regio
 */
@WebServlet(name = "PayrollController", urlPatterns = {"/payRoll"})
public class PayrollController extends HttpServlet {

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
    }

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
        try {
            // Pagination parameters
            int page = 1;
            int pageSize = 10;
            String pageParam = request.getParameter("page");
            if (pageParam != null && !pageParam.isEmpty()) {
                try {
                    page = Integer.parseInt(pageParam);
                    if (page < 1) {
                        page = 1;
                    }
                } catch (NumberFormatException e) {
                    page = 1;
                }
            }

            // Filter parameter
            String paymentStatus = request.getParameter("paymentStatus");

            // Fetch payroll data and count
            List<Payroll> payrolls = payrollDAO.getAllPayrolls(page, pageSize, paymentStatus);
            int totalRecords = payrollDAO.getPayrollCount(paymentStatus);
            int totalPages = (int) Math.ceil((double) totalRecords / pageSize);

            // Set attributes
            request.setAttribute("payrolls", payrolls);
            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("pageSize", pageSize);
            request.setAttribute("paymentStatus", paymentStatus);

            // Forward to JSP
            request.getRequestDispatcher("/payroll.jsp").forward(request, response);
        } catch (SQLException e) {
            request.setAttribute("error", "Error fetching payroll data: " + e.getMessage());
            request.getRequestDispatcher("/error.jsp").forward(request, response);
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
        try {
            int month = Integer.parseInt(request.getParameter("month"));
            int year = Integer.parseInt(request.getParameter("year"));
            String teacherName = request.getParameter("teacherName");
            if (teacherName == null || teacherName.trim().isEmpty()) {
                request.setAttribute("message", "Error: Teacher name is required.");
                request.setAttribute("messageType", "danger");
                request.getRequestDispatcher("/payroll.jsp").forward(request, response);
                return;
            }

            // Replace with actual admin ID from session in production
            Integer adminId = null; // Example: 1 for admin user
            String[] result = payrollDAO.generatePayroll(month, year, adminId, teacherName);

            request.setAttribute("message", result[1]);
            request.setAttribute("messageType", result[0].equals("Success") ? "success" : result[0].equals("Warning") ? "warning" : "danger");

            // Refresh payroll data
            List<Payroll> payrolls = payrollDAO.getAllPayrolls(1, 10, null);
            int totalRecords = payrollDAO.getPayrollCount(null);
            int totalPages = (int) Math.ceil((double) totalRecords / 10);

            request.setAttribute("payrolls", payrolls);
            request.setAttribute("currentPage", 1);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("pageSize", 10);

            request.getRequestDispatcher("/payroll.jsp").forward(request, response);
        } catch (SQLException e) {
            request.setAttribute("message", "Error generating payroll: " + e.getMessage());
            request.setAttribute("messageType", "danger");
            request.getRequestDispatcher("/payroll.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            request.setAttribute("message", "Invalid month or year input.");
            request.setAttribute("messageType", "danger");
            request.getRequestDispatcher("/payroll.jsp").forward(request, response);
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
    }
}
