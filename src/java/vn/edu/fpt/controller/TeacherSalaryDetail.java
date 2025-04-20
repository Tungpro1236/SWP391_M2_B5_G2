/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package vn.edu.fpt.controller;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import vn.edu.fpt.dao.SalaryDAO;
import vn.edu.fpt.model.Salary;

/**
 *
 * @author regio
 */
public class TeacherSalaryDetail extends HttpServlet {
   
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
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
            out.println("<title>Servlet TeacherSalaryDetail</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet TeacherSalaryDetail at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    } 

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        String teacherIdStr = request.getParameter("teacherId");
        if (teacherIdStr == null || teacherIdStr.trim().isEmpty()) {
            response.sendRedirect("error.jsp?message=Invalid Teacher ID");
            return;
        }
        try {
            int teacherId = Integer.parseInt(teacherIdStr);
            if (teacherId <= 0) {
                response.sendRedirect("error.jsp?message=Invalid Teacher ID");
                return;
            }
            SalaryDAO dao = new SalaryDAO();
            Salary salary = dao.getSalaryByTeacherId(teacherId); // Assume this method exists
            if (salary == null) {
                response.sendRedirect("error.jsp?message=Salary Not Found");
                return;
            }
            request.setAttribute("salary", salary);
            request.getRequestDispatcher("teacherSalaryDetail.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            response.sendRedirect("error.jsp?message=Invalid Teacher ID Format: " + e.getMessage());
        }
    } 

    /** 
     * Handles the HTTP <code>POST</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        processRequest(request, response);
    }

    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
