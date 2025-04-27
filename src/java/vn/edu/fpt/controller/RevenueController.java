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
import vn.edu.fpt.dao.RevenueDAO;
import vn.edu.fpt.model.Revenue;

/**
 *
 * @author regio
 */
@WebServlet(name="RevenueController", urlPatterns={"/revenue"})
public class RevenueController extends HttpServlet {
   private RevenueDAO revenueDAO;

    @Override
    public void init() throws ServletException {
        revenueDAO = new RevenueDAO();
    }
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
            out.println("<title>Servlet RevenueController</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet RevenueController at " + request.getContextPath () + "</h1>");
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
        List<Revenue> revenues = revenueDAO.getAllRevenues();
        request.setAttribute("revenues", revenues);
        request.getRequestDispatcher("/revenue.jsp").forward(request, response);
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
       String action = request.getParameter("action");
        if ("generate".equals(action)) {
            String monthStr = request.getParameter("month");
            String yearStr = request.getParameter("year");

            try {
                int month = Integer.parseInt(monthStr);
                int year = Integer.parseInt(yearStr);
                revenueDAO.generateRevenue(month, year);
                request.setAttribute("success", "Revenue generated successfully for " + month + "/" + year);
            } catch (NumberFormatException e) {
                request.setAttribute("error", "Invalid month or year format.");
            } catch (IllegalArgumentException e) {
                request.setAttribute("error", e.getMessage());
            } catch (Exception e) {
                request.setAttribute("error", "Failed to generate revenue: " + e.getMessage());
            }
        }

        doGet(request, response);
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
