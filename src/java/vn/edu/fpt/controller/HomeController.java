package vn.edu.fpt.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import vn.edu.fpt.dao.CourseDAO;
import vn.edu.fpt.model.Blog;
import vn.edu.fpt.model.Course;

@WebServlet(name = "HomeController", urlPatterns = {"/home"})
public class HomeController extends HttpServlet {
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
//        if (session == null || session.getAttribute("user") == null) {
//            response.sendRedirect("login.jsp");
//            return;
//        }
        
        CourseDAO courseDAO = new CourseDAO();
        
        List<Course> latestCourses = courseDAO.getLatestCourses();
        List<Course> hotCourses = courseDAO.getHotCourses();
        List<Blog> latestBlogs = courseDAO.getLatestBlogs();
        
        request.setAttribute("latestCourses", latestCourses);
        request.setAttribute("hotCourses", hotCourses);
        request.setAttribute("latestBlogs", latestBlogs);
        
        request.getRequestDispatcher("homepage.jsp").forward(request, response);
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