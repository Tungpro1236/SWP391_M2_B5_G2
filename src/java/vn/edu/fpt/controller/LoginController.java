package vn.edu.fpt.controller;

import vn.edu.fpt.dao.UserDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import vn.fpt.edu.model.UserModel;

@WebServlet(name = "LoginController", urlPatterns = {"/login"})
public class LoginController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if (action == null) {
            HttpSession session = request.getSession(false);
            if (session != null && session.getAttribute("user") != null) {
                response.sendRedirect("profile");
                return;
            }
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

        switch (action) {
            case "login":
                login(request, response);
                break;
            case "logout":
                logout(request, response);
                break;
            default:
                request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }

    private void login(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        UserDAO userDao = new UserDAO();
        UserModel user = userDao.login(email, password);

        if (user != null && user.isStatus()) {
            session = request.getSession();
            // After successful login, where you set the user in session
            session.setAttribute("user", user);
            
            // Add role-based redirect logic
            String redirectPath = "";
            switch (user.getRoleId()) {
                case 1: // Admin
                    redirectPath = "/admin/users";
                    break;
                case 2: // Teacher
                    if (user.getAvatarUrl() == null || user.getAvatarUrl().isEmpty()) {
                        redirectPath = "/teacher/profile";
                    } else {
                        redirectPath = "/home";
                    }
                    break;
                case 3: // Student
                    redirectPath = "/home";
                    break;
                default:
                    redirectPath = "/home";
            }
            
            response.sendRedirect(request.getContextPath() + redirectPath);
        } else if (user != null && !user.isStatus()) {
            request.setAttribute("error", "Account is inactive");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        } else {
            request.setAttribute("error", "Invalid email or password");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }

    private void logout(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        session.invalidate();
        response.sendRedirect("login");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
}
