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
import jakarta.servlet.http.HttpSession;
import java.sql.Timestamp;
import vn.edu.fpt.dao.RefundRequestDAO;
import java.sql.SQLException;

import java.util.List;
import vn.edu.fpt.model.UserModel;
import vn.edu.fpt.dao.RefundRequestDAO;
import vn.edu.fpt.model.RefundRequest;

/**
 *
 * @author regio
 */
@WebServlet(name = "StudentRefundServlet", urlPatterns = {"/student/refund"})
public class StudentRefundServlet extends HttpServlet {

    private RefundRequestDAO refundRequestDAO;

    @Override
    public void init() throws ServletException {
        refundRequestDAO = new RefundRequestDAO();
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
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet StudentRefundServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet StudentRefundServlet at " + request.getContextPath() + "</h1>");
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
        HttpSession session = request.getSession();
        UserModel student = (UserModel) session.getAttribute("user");
        if (student == null || student.getRoleId() != 3) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        try {
            List<RefundRequest> refundRequests = refundRequestDAO.getRefundRequestsByStudent(student.getId());
            request.setAttribute("refundRequests", refundRequests);
            request.getRequestDispatcher("/student/studentRefund.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            throw new ServletException("Database error: " + e.getMessage(), e);
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
        HttpSession session = request.getSession();
        UserModel student = (UserModel) session.getAttribute("user");
        if (student == null || student.getRoleId() != 3) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        try {
            int enrollmentId = Integer.parseInt(request.getParameter("enrollmentId"));
            int courseId = Integer.parseInt(request.getParameter("courseId"));
            String reason = request.getParameter("reason");
            
            RefundRequest refundRequest = new RefundRequest();
            refundRequest.setEnrollmentId(enrollmentId);
            refundRequest.setStudentId(student.getId());
            refundRequest.setCourseId(courseId);
            refundRequest.setRequestDate(new Timestamp(System.currentTimeMillis())); // Sử dụng Timestamp
            refundRequest.setReason(reason);
            refundRequest.setStatus("pending");

            refundRequestDAO.createRefundRequest(refundRequest);
            response.sendRedirect(request.getContextPath() + "/student/refund");
        } catch (SQLException e) {
            e.printStackTrace();
            throw new ServletException("Database error: " + e.getMessage(), e);
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
