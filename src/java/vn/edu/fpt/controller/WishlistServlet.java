package vn.edu.fpt.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import vn.edu.fpt.dao.CourseDAO;
import vn.edu.fpt.model.CartItem;
import vn.edu.fpt.model.Course;

@WebServlet("/WishlistServlet")
public class WishlistServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        
        // Lấy danh sách wishlist từ session
        List<CartItem> wishlistItems = (List<CartItem>) request.getSession().getAttribute("wishlistItems");
        if (wishlistItems == null) {
            wishlistItems = new ArrayList<>();
        }

        // Lấy giỏ hàng từ session
        List<CartItem> cartItems = (List<CartItem>) request.getSession().getAttribute("cartItems");
        if (cartItems == null) {
            cartItems = new ArrayList<>();
        }

        // Thêm khóa học vào wishlist
        if ("add".equals(action)) {
            int courseId = Integer.parseInt(request.getParameter("courseId"));
            CourseDAO courseDAO = new CourseDAO();
            Course course = courseDAO.getCourseById(courseId);
            CartItem cartItem = new CartItem(course.getId(), course.getTitle(), course.getPrice(), course.getThumbnailUrl());

            // Kiểm tra xem khóa học đã có trong wishlist chưa
            boolean alreadyInWishlist = wishlistItems.stream().anyMatch(item -> item.getCourseId() == courseId);
            if (!alreadyInWishlist) {
                wishlistItems.add(cartItem);  // Thêm khóa học vào wishlist
                request.getSession().setAttribute("wishlistItems", wishlistItems);
            }
            response.sendRedirect("wishlist.jsp");
        }

        // Xóa khóa học khỏi wishlist
        if ("remove".equals(action)) {
            int courseId = Integer.parseInt(request.getParameter("courseId"));
            wishlistItems.removeIf(item -> item.getCourseId() == courseId);
            request.getSession().setAttribute("wishlistItems", wishlistItems);
            response.sendRedirect("wishlist.jsp");
        }

        // Chuyển khóa học từ wishlist sang giỏ hàng
        if ("moveToCart".equals(action)) {
            int courseId = Integer.parseInt(request.getParameter("courseId"));
            CourseDAO courseDAO = new CourseDAO();
            Course course = courseDAO.getCourseById(courseId);
            CartItem cartItem = new CartItem(course.getId(), course.getTitle(), course.getPrice(), course.getThumbnailUrl());

            // Kiểm tra xem khóa học đã có trong giỏ hàng chưa
            boolean alreadyInCart = cartItems.stream().anyMatch(item -> item.getCourseId() == courseId);

            if (!alreadyInCart) {
                cartItems.add(cartItem);  // Thêm khóa học vào giỏ hàng
                wishlistItems.removeIf(item -> item.getCourseId() == courseId);  // Xóa khỏi wishlist
                request.getSession().setAttribute("cartItems", cartItems);
                request.getSession().setAttribute("wishlistItems", wishlistItems);
            }

            response.sendRedirect("wishlist.jsp");
        }
    }
}
