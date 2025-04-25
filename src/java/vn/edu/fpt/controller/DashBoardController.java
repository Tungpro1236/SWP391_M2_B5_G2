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
import vn.edu.fpt.model.Chartdata;
import vn.edu.fpt.dao.ChartDataDAO;

/**
 *
 * @author regio
 */
@WebServlet(name="DashBoardController", urlPatterns={"/dashBoard"})
public class DashBoardController extends HttpServlet {
    private ChartDataDAO chartdataDAO;

    @Override
    public void init() {
        chartdataDAO = new ChartDataDAO();
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
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet DashBoardController</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet DashBoardController at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    } 

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
        try {
            // Default to current year
            int year = java.time.Year.now().getValue();
            String yearParam = request.getParameter("year");
            if (yearParam != null && !yearParam.isEmpty()) {
                year = Integer.parseInt(yearParam);
            }

            // Fetch chart data for the selected year
            List<Chartdata> chartData = chartdataDAO.getChartData(year);
            request.setAttribute("chartData", chartData);
            request.setAttribute("selectedYear", year);
            request.getRequestDispatcher("/dashBoard.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid year format: " + e.getMessage());
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("error", "Error fetching dashboard data: " + e.getMessage());
            request.getRequestDispatcher("/error.jsp").forward(request, response);
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
        return "Handles dashboard data for admin";
    }
}