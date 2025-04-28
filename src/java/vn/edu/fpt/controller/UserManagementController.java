package vn.edu.fpt.controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import vn.edu.fpt.dao.UserDAO;
import java.util.List;
import vn.edu.fpt.enums.Role;
import vn.edu.fpt.model.UserModel;

@WebServlet(name = "UserManagementController", urlPatterns = {"/admin/users"})
public class UserManagementController extends HttpServlet {
    private static final int PAGE_SIZE = 5;
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        UserModel user = (UserModel) session.getAttribute("user");
        if(user == null || user.getRoleId() != Role.ADMIN.getRoleId()){
            response.sendRedirect("../login");
            return;
        }
        
        UserDAO userDAO = new UserDAO();
        
        // Get parameters
        String search = request.getParameter("search");
        String role = request.getParameter("role");
        String status = request.getParameter("status");
        
        int page = 1;
        try {
            page = Integer.parseInt(request.getParameter("page"));
        } catch (NumberFormatException e) {
            // Keep default page = 1
        }
        
        // Get filtered user list
        List<UserModel> users = userDAO.getUserList(page, PAGE_SIZE, search, role, status);
        int totalUsers = userDAO.getTotalUsers(search, role, status);
        int totalPages = (int) Math.ceil((double) totalUsers / PAGE_SIZE);
        
        // Set attributes
        request.setAttribute("users", users);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("search", search);
        request.setAttribute("role", role);
        request.setAttribute("status", status);
        
        // Forward to JSP
        request.getRequestDispatcher("/admin/user-list.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("updateStatus".equals(action)) {
            int userId = Integer.parseInt(request.getParameter("userId"));
            boolean status = Boolean.parseBoolean(request.getParameter("status"));
            
            
            UserDAO userDAO = new UserDAO();
            boolean success = userDAO.updateUserStatus(userId, status);
            
            response.setContentType("application/json");
            response.getWriter().write("{\"success\":" + success + "}");
        }
    }
}