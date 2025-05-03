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
import java.util.List;
import vn.edu.fpt.dao.RefundRequestDAO;
import vn.edu.fpt.model.RefundRequest;
import vn.edu.fpt.model.UserModel;
import java.sql.SQLException;

/**
 *
 * @author regio
 */
@WebServlet(name = "AdminRefundServlet", urlPatterns = {"/admin/refund"})
public class AdminRefundServlet extends HttpServlet {

    private RefundRequestDAO refundRequestDAO;
    private static final int PAGE_SIZE = 5; // Number of records per page

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
            out.println("<title>Servlet AdminRefundServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AdminRefundServlet at " + request.getContextPath() + "</h1>");
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
        UserModel admin = (UserModel) session.getAttribute("user");
        if (admin == null || admin.getRoleId() != 1) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        try {
            // Get parameters
            String keyword = request.getParameter("keyword");
            String pageParam = request.getParameter("page");
            int currentPage = pageParam != null ? Integer.parseInt(pageParam) : 1;

            // Fetch paginated and filtered refund requests
            List<RefundRequest> refundRequests = refundRequestDAO.getRefundRequests(currentPage, PAGE_SIZE, keyword);

            // Calculate total pages
            int totalRecords = refundRequestDAO.getTotalRefundRequests(keyword);
            int totalPages = (int) Math.ceil((double) totalRecords / PAGE_SIZE);

            // Set attributes
            request.setAttribute("refundRequests", refundRequests);
            request.setAttribute("currentPage", currentPage);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("activePage", "refund"); // For sidebar highlighting

            request.getRequestDispatcher("/admin/adminRefund.jsp").forward(request, response);
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
    UserModel admin = (UserModel) session.getAttribute("user");
    if (admin == null || admin.getRoleId() != 1) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }

    try {
        int requestId = Integer.parseInt(request.getParameter("requestId"));
        String action = request.getParameter("action");
        String status = "approve".equals(action) ? "approved" : "rejected";

        refundRequestDAO.updateRefundRequestStatus(requestId, status, admin.getId());

        // Get the keyword parameter
        String keyword = request.getParameter("keyword");
        // Construct the redirect URL
        String redirectUrl = request.getContextPath() + "/admin/refund?page=1";
        if (keyword != null && !keyword.trim().isEmpty()) {
            // Encode the keyword to handle special characters
            String encodedKeyword = java.net.URLEncoder.encode(keyword, "UTF-8");
            redirectUrl += "&keyword=" + encodedKeyword;
        }

        response.sendRedirect(redirectUrl);
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
