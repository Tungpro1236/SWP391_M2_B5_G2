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
import vn.edu.fpt.dao.SalaryDAO;
import vn.edu.fpt.model.Salary;

/**
 *
 * @author regio
 */
@WebServlet(name="ViewTeacherSalary", urlPatterns={"/viewTeacherSalary"})
public class ViewTeacherSalary extends HttpServlet {
   private static final int DEFAULT_PAGE_SIZE = 5; // Số lượng bản ghi trên mỗi trang
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
            out.println("<title>Servlet ViewTeacherSalary</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ViewTeacherSalary at " + request.getContextPath () + "</h1>");
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
       String keyword = request.getParameter("keyword");
        if (keyword == null) keyword = "";

        // Retrieve pagination parameters
        int page = 1; // Default to page 1
        int pageSize = DEFAULT_PAGE_SIZE;
        try {
            String pageStr = request.getParameter("page");
            if (pageStr != null && !pageStr.trim().isEmpty()) {
                page = Integer.parseInt(pageStr);
                if (page < 1) page = 1; // Ensure page is at least 1
            }
        } catch (NumberFormatException e) {
            // Log error if needed
        }

        SalaryDAO dao = new SalaryDAO();
        // Fetch total records for pagination
        int totalRecords = dao.getTotalRecords(keyword);
        int totalPages = (int) Math.ceil((double) totalRecords / pageSize);

        // Adjust page number if it exceeds total pages
        if (page > totalPages && totalPages > 0) {
            page = totalPages;
        }

        // Fetch paginated salary list
        List<Salary> list = dao.getAllSalaries(keyword, page, pageSize);
        request.setAttribute("salaryList", list);
        request.setAttribute("keyword", keyword);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("pageSize", pageSize);
        request.getRequestDispatcher("teacherSalary.jsp").forward(request, response);
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
