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
import vn.edu.fpt.dao.CourseDAO;
import vn.edu.fpt.dao.FeedbackDAO;

/**
 *
 * @author Admin
 */
@WebServlet(name = "EditFeedbackController", urlPatterns = {"/editfeedback"})
public class EditFeedbackController extends HttpServlet {

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
            out.println("<title>Servlet EditFeedbackController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet EditFeedbackController at " + request.getContextPath() + "</h1>");
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
        String coID = request.getParameter("coID");
        String commentId = request.getParameter("commentId");
        CourseDAO cdao = new CourseDAO();
        FeedbackDAO fdao = new FeedbackDAO();
        request.setAttribute("feedback", fdao.getFeedBackByID(Integer.parseInt(commentId)));
        request.setAttribute("courseD", cdao.getCourseById(Integer.parseInt(coID)));
        request.getRequestDispatcher("EditFeedback.jsp").forward(request, response);
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
         FeedbackDAO fdao = new FeedbackDAO();
        HttpSession session = request.getSession();  
        int courseid = Integer.parseInt(request.getParameter("courseid"));
        int commentIdInt = Integer.parseInt(request.getParameter("commentId"));
        String newContent = request.getParameter("textinput");
        String rating = request.getParameter("rating");
        fdao.updateComment(commentIdInt, newContent, rating);
        session.setAttribute("feedbackMessage", "Edit Succcesfully");
        response.sendRedirect("feedback?courseId=" + courseid);
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
