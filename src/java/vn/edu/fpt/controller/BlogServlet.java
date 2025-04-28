package vn.edu.fpt.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import vn.edu.fpt.dao.BlogDAO;
import vn.edu.fpt.dao.DBContext;
import vn.edu.fpt.model.Blog;

@WebServlet(name = "BlogServlet", urlPatterns = {"/blogs"})
public class BlogServlet extends HttpServlet {
    private BlogDAO blogDAO;

    // Khởi tạo BlogDAO trong phương thức init
 

    // Xử lý phương thức POST thay vì GET
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            String action = request.getParameter("action");
            String searchQuery = request.getParameter("search");
            
            if ("view".equals(action) && request.getParameter("id") != null) {
                handleViewBlog(request, response);
                return;
            }

            handleBlogList(request, response, searchQuery);

        } catch (Exception e) {
            throw new ServletException("Lỗi xử lý yêu cầu", e);
        }
    }

    // Xử lý chi tiết blog
    private void handleViewBlog(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException, NumberFormatException {
        int blogId = Integer.parseInt(request.getParameter("id"));
        Blog blog = blogDAO.getBlogById(blogId);
        request.setAttribute("blog", blog);
        request.getRequestDispatcher("/blog-details.jsp").forward(request, response);
    }

    // Xử lý danh sách blog
    private void handleBlogList(HttpServletRequest request, HttpServletResponse response, String searchQuery)
            throws ServletException, IOException, SQLException {
        List<Blog> blogList;
        
        // Nếu có từ khóa tìm kiếm, sử dụng tìm kiếm
        if (searchQuery != null && !searchQuery.trim().isEmpty()) {
            blogList = blogDAO.searchBlogs(searchQuery);
            request.setAttribute("searchQuery", searchQuery); // Truyền lại từ khóa tìm kiếm cho JSP
        } else {
            blogList = blogDAO.getAllPublishedBlogs(); // Lấy tất cả các blog đã xuất bản
        }
        
        request.setAttribute("blogList", blogList); // Truyền danh sách blog vào request
        request.getRequestDispatcher("/blogs.jsp").forward(request, response); // Chuyển tiếp đến JSP
    }
}
