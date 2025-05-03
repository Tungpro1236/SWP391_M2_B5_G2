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
import vn.edu.fpt.dao.EnrollmentDAO;
import vn.edu.fpt.model.UserModel;
import vn.edu.fpt.dao.RefundRequestDAO;
import vn.edu.fpt.model.Enrollment;
import vn.edu.fpt.model.RefundRequest;

/**
 *
 * @author regio
 */
@WebServlet(name = "StudentRefundServlet", urlPatterns = {"/student/refund"})
public class StudentRefundServlet extends HttpServlet {

    private RefundRequestDAO refundRequestDAO;
    private EnrollmentDAO enrollmentDAO;
    private static final int PAGE_SIZE = 5;

    @Override
    public void init() throws ServletException {
        refundRequestDAO = new RefundRequestDAO();
        enrollmentDAO = new EnrollmentDAO();
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
            String keyword = request.getParameter("keyword");
            String pageParam = request.getParameter("page");
            int currentPage = pageParam != null ? Integer.parseInt(pageParam) : 1;

            List<RefundRequest> refundRequests = refundRequestDAO.getRefundRequestsByStudentWithPagination(student.getId(), currentPage, PAGE_SIZE, keyword);
            int totalRecords = refundRequestDAO.getTotalRefundRequestsByStudent(student.getId(), keyword);
            int totalPages = (int) Math.ceil((double) totalRecords / PAGE_SIZE);
            List<Enrollment> enrolledCourses = enrollmentDAO.getEnrolledCourses(student.getId());

            System.out.println("Student ID: " + student.getId());
            System.out.println("Enrolled Courses: " + (enrolledCourses != null ? enrolledCourses.size() : "null"));

            request.setAttribute("refundRequests", refundRequests);
            request.setAttribute("currentPage", currentPage);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("enrolledCourses", enrolledCourses);

            request.getRequestDispatcher("/student/studentRefund.jsp").forward(request, response);
        } catch (SQLException e) {
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
            String action = request.getParameter("action");
            if ("delete".equals(action)) {
                int requestId = Integer.parseInt(request.getParameter("requestId"));
                refundRequestDAO.deleteRefundRequest(requestId);
                response.sendRedirect(request.getContextPath() + "/student/refund");
                return;
            }

            String enrollmentSelection = request.getParameter("enrollmentSelection");
            String reason = request.getParameter("reason");

            if (enrollmentSelection == null || enrollmentSelection.isEmpty()) {
                request.setAttribute("error", "Please select a course to request a refund.");
                doGet(request, response);
                return;
            }

            String[] enrollmentData = enrollmentSelection.split(":");
            int enrollmentId = Integer.parseInt(enrollmentData[0]);
            int courseId = Integer.parseInt(enrollmentData[1]);

            boolean isValid = refundRequestDAO.isValidEnrollment(enrollmentId, student.getId(), courseId);
            if (!isValid) {
                request.setAttribute("error", "Invalid course selection.");
                doGet(request, response);
                return;
            }

            enrollmentDAO.updateEnrollmentStatus(enrollmentId, "pause");

            RefundRequest refundRequest = new RefundRequest();
            refundRequest.setEnrollmentId(enrollmentId);
            refundRequest.setStudentId(student.getId());
            refundRequest.setCourseId(courseId);
            refundRequest.setRequestDate(new Timestamp(System.currentTimeMillis()));
            refundRequest.setReason(reason);
            refundRequest.setStatus("pending");

            refundRequestDAO.createRefundRequest(refundRequest);
            response.sendRedirect(request.getContextPath() + "/student/refund");
        } catch (SQLException e) {
            if (e.getMessage().contains("Only pending refund requests can be deleted.")) {
                request.setAttribute("error", "Only pending refund requests can be deleted.");
            } else {
                request.setAttribute("error", "Database error: " + e.getMessage());
            }
            doGet(request, response);
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
