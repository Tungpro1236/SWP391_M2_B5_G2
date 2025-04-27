/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package vn.edu.fpt.controller;

import vn.edu.fpt.dao.UserDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import vn.edu.fpt.enums.Role;
import vn.fpt.edu.model.UserModel;

@WebServlet(name = "UserController", urlPatterns = {"/user"})
public class UserController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String action = request.getParameter("action");

        if (action == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        switch (action) {
            case "register":
                register(request, response);
                break;
            default:
                response.sendRedirect("login.jsp");
        }
    }

    private void register(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email");
        UserDAO userDao = new UserDAO();

        if (userDao.checkEmailExists(email)) {
            request.setAttribute("error", "Email already exists");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }
        // In your doPost method
        String roleId = request.getParameter("roleId");
        

        UserModel user = new UserModel();
        user.setFirstName(request.getParameter("firstName"));
        user.setMiddleName(request.getParameter("middleName"));
        user.setLastName(request.getParameter("lastName"));
        user.setEmail(email);
        user.setGenderId(Integer.parseInt(request.getParameter("genderId")));
        user.setPassword(request.getParameter("password"));
        // When creating new user
        user.setRoleId(Integer.parseInt(roleId));
        user.setAvatarUrl(request.getParameter("avatarUrl"));

        if (userDao.register(user)) {
            response.sendRedirect("login.jsp");
        } else {
            request.setAttribute("error", "Registration failed");
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }
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
