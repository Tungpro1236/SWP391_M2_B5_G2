package vn.edu.fpt.controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import vn.edu.fpt.dao.TeacherRequestDAO;
import vn.edu.fpt.dao.UserDAO;
import vn.edu.fpt.enums.Role;
import vn.edu.fpt.model.TeacherRequest;
import vn.fpt.edu.model.UserModel;

@WebServlet(name = "TeacherController", urlPatterns = {"/teacher/*"})
public class TeacherController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String path = request.getPathInfo();
        if (path == null) path = "/";
        
        HttpSession session = request.getSession();
        UserModel user = (UserModel) session.getAttribute("user");
        
        if (user == null || user.getRoleId() != Role.INSTRUCTOR.getRoleId()) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        TeacherRequestDAO requestDAO = new TeacherRequestDAO();
        
        switch (path) {
            case "/profile":
                // Get teacher's requests
                List<TeacherRequest> requests = requestDAO.getRequestsByTeacher(user.getId());
                boolean hasActiveRequest = requestDAO.hasActiveRequest(user.getId());
                
                request.setAttribute("teacherRequests", requests);
                request.setAttribute("hasActiveRequest", hasActiveRequest);
                request.getRequestDispatcher("/teacher-profile.jsp").forward(request, response);
                break;
                
            default:
                response.sendRedirect(request.getContextPath() + "/teacher/profile");
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String path = request.getPathInfo();
        if (path == null) path = "/";
        
        HttpSession session = request.getSession();
        UserModel user = (UserModel) session.getAttribute("user");
        
        if (user == null || user.getRoleId() != 2) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        TeacherRequestDAO requestDAO = new TeacherRequestDAO();
        UserDAO userDAO = new UserDAO();
        
        switch (path) {
            case "/profile":
                // Handle profile update
                String firstName = request.getParameter("firstName");
                String lastName = request.getParameter("lastName");
                String email = request.getParameter("email");
                String avatarUrl = request.getParameter("avatarUrl");
                int genderId = Integer.parseInt(request.getParameter("genderId"));
                
                user.setFirstName(firstName);
                user.setLastName(lastName);
                user.setEmail(email);
                user.setAvatarUrl(avatarUrl);
                user.setGenderId(genderId);
                
                if (userDAO.updateProfile(user)) {
                    // If this is first time setting avatar, create teacher request
                    if (avatarUrl != null && !avatarUrl.isEmpty() && !requestDAO.hasActiveRequest(user.getId())) {
                        requestDAO.createRequest(user.getId());
                    }
                    
                    session.setAttribute("user", user);
                    request.setAttribute("success", "Profile updated successfully!");
                } else {
                    request.setAttribute("error", "Failed to update profile!");
                }
                
                // Refresh teacher's requests
                List<TeacherRequest> requests = requestDAO.getRequestsByTeacher(user.getId());
                boolean hasActiveRequest = requestDAO.hasActiveRequest(user.getId());
                
                request.setAttribute("teacherRequests", requests);
                request.setAttribute("hasActiveRequest", hasActiveRequest);
                request.getRequestDispatcher("/teacher-profile.jsp").forward(request, response);
                break;
                
            case "/request":
                // Handle new request creation
                if (!requestDAO.hasActiveRequest(user.getId())) {
                    if (requestDAO.createRequest(user.getId())) {
                        request.setAttribute("success", "Request sent successfully!");
                    } else {
                        request.setAttribute("error", "Failed to send request!");
                    }
                }
                response.sendRedirect(request.getContextPath() + "/teacher/profile");
                break;
                
            default:
                response.sendRedirect(request.getContextPath() + "/teacher/profile");
                break;
        }
    }
}