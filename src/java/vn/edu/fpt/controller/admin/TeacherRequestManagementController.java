package vn.edu.fpt.controller.admin;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import vn.edu.fpt.dao.TeacherRequestDAO;
import vn.edu.fpt.enums.Role;
import vn.edu.fpt.model.TeacherRequest;
import vn.fpt.edu.model.UserModel;

@WebServlet(name = "TeacherRequestManagementController", urlPatterns = {"/admin/teacher-requests/*"})
public class TeacherRequestManagementController extends HttpServlet {
    private final TeacherRequestDAO requestDAO = new TeacherRequestDAO();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        UserModel user = (UserModel) session.getAttribute("user");
        if (user == null || user.getRoleId() != Role.ADMIN.getRoleId()) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        // Get page parameters
        int page = 1;
        try {
            page = Integer.parseInt(request.getParameter("page"));
        } catch (NumberFormatException e) {}
        
        // Get status filter
        String statusFilter = request.getParameter("status");
        Integer status = null;
        if (statusFilter != null && !statusFilter.isEmpty()) {
            status = Integer.parseInt(statusFilter);
        }
        
        // Get paginated requests
        int pageSize = 10;
        List<TeacherRequest> requests = requestDAO.getRequestsPaginated(page, pageSize, status);
        int totalRequests = requestDAO.getTotalRequests(status);
        int totalPages = (int) Math.ceil((double) totalRequests / pageSize);
        
        request.setAttribute("requests", requests);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.getRequestDispatcher("/admin/teacher-requests.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String path = request.getPathInfo();
        if (path == null) path = "/";
        HttpSession session = request.getSession();
        UserModel user = (UserModel) session.getAttribute("user");
        
        Map<String, Object> jsonResponse = new HashMap<>();
        response.setContentType("application/json");
        
        try {
            switch (path) {
                case "/approve":
                    int approveId = Integer.parseInt(request.getParameter("requestId"));
                    if (requestDAO.approveRequest(approveId , user.getId())) {
                        request.setAttribute("success", "Request approved successfully!");
                    } else {
                        request.setAttribute("error", "Failed to approve request!");
                    }
                    break;
                    
                case "/reject":
                    int rejectId = Integer.parseInt(request.getParameter("requestId"));
                    String reason = request.getParameter("rejectReason");
                    if (requestDAO.rejectRequest(rejectId, reason , user.getId())) {
                        request.setAttribute("success", "Request rejected successfully!");
                    } else {
                        request.setAttribute("error", "Failed to reject request!");
                    }
                    break;
                    
                default:
                    response.sendError(HttpServletResponse.SC_NOT_FOUND);
                    return;
            }
        } catch (Exception e) {
            request.setAttribute("error", "Error: " + e.getMessage());
        }
        
        response.sendRedirect(request.getContextPath() + "/admin/teacher-requests");
    }
}