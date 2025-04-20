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
import vn.edu.fpt.utils.SendMailHelper;
import java.util.Random;

@WebServlet(name = "PasswordController", urlPatterns = {"/password"})
public class PasswordController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("text/html;charset=UTF-8");
        String action = request.getParameter("action");

        if (action == null) {
            response.sendRedirect("change-password.jsp");
            return;
        }

        switch (action) {
            case "change":
                changePassword(request, response);
                break;
            case "forgot":
                forgotPassword(request, response);
                break;
            default:
                response.sendRedirect("change-password.jsp");
        }
    }

    private void changePassword(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        UserModel user = (UserModel) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String newPassword = request.getParameter("newPassword");

        UserDAO userDao = new UserDAO();
        if (userDao.resetPassword(user.getEmail(), newPassword)) {
            request.setAttribute("success", "Password changed successfully!");
        } else {
            request.setAttribute("error", "Failed to change password. Please try again!");
        }

        request.getRequestDispatcher("change-password.jsp").forward(request, response);
    }

    private void forgotPassword(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email");
        UserDAO userDao = new UserDAO();
        
        if (!userDao.checkEmailExists(email)) {
            request.setAttribute("error", "Email address not found!");
            request.getRequestDispatcher("forgot-password.jsp").forward(request, response);
            return;
        }
        
        String resetLink = request.getScheme() + "://" + request.getServerName() + ":" 
                + request.getServerPort() + request.getContextPath() 
                + "/reset-password?email="+email;
        
        String subject = "Password Reset";
        String message = "Hello,\n\n"
                + "You have requested to reset your password. Please click the link below:\n\n"
                + resetLink + "\n\n"
                + "If you did not request this, please ignore this email.\n\n"
                + "Best regards,\n"
                + "Boost Your Style Team";
        
        SendMailHelper.sendEmailTo(email, subject, message);
        request.setAttribute("success", "Password reset link has been sent to your email!");
        request.getRequestDispatcher("forgot-password.jsp").forward(request, response);
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
