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
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import vn.edu.fpt.dao.CourseDAO;
import vn.edu.fpt.dao.FeedbackDAO;
import vn.edu.fpt.dao.LessonDAO;
import vn.edu.fpt.dao.UserDAO;
import vn.edu.fpt.model.Course;
import vn.edu.fpt.model.Feedback;
import vn.edu.fpt.model.Lesson;
import vn.fpt.edu.model.UserModel;

/**
 *
 * @author Admin
 */
@WebServlet(name = "FeedbackServlet", urlPatterns = {"/feedback"})
public class FeedbackController extends HttpServlet {

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
            out.println("<title>Servlet FeedbackServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet FeedbackServlet at " + request.getContextPath() + "</h1>");
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
        FeedbackDAO feedbackDAO = new FeedbackDAO();
        CourseDAO courseDAO = new CourseDAO();
        UserDAO userDAO = new UserDAO();
        int courseId = Integer.parseInt(request.getParameter("courseId"));
        HttpSession session = request.getSession();
        UserModel user = (UserModel) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        } else {
            List<Feedback> feedback = feedbackDAO.getFeedbackByCourseID(courseId);
            List<Course> courseList = courseDAO.getAllCourses();
            List<UserModel> userList = userDAO.getAllUser();
            Course courseD = courseDAO.getCourseById(courseId);
            request.setAttribute("feedback", feedback);
            request.setAttribute("courseD", courseD);
            request.setAttribute("courseList", courseList);
            request.setAttribute("userList", userList);
            request.getRequestDispatcher("feedback.jsp").forward(request, response);
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
        String action = request.getParameter("action");
        FeedbackDAO fdao = new FeedbackDAO();
        HttpSession session = request.getSession();
        int courseid;
        String commentId;
        switch (action) {
            
            case "delete":
                courseid = Integer.parseInt(request.getParameter("courseid"));
                commentId = request.getParameter("commentId");
                if (commentId != null && commentId.startsWith("comment")) {
                    commentId = commentId.substring(7);  
                }
                fdao.deleteComment(Integer.parseInt(commentId));
                session.setAttribute("feedbackMessage", "Xóa đánh giá thành công");
                response.sendRedirect("feedback?courseId=" + courseid);
                break;
            default:
                throw new AssertionError();
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
