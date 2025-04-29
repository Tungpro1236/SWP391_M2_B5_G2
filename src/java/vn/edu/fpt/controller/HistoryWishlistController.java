package vn.edu.fpt.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import vn.edu.fpt.dao.UserDAO;
import vn.edu.fpt.dao.WishlistDAO;
import vn.edu.fpt.model.WishlistItem;

@WebServlet("/HistoryWishlistController")
public class HistoryWishlistController extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Lấy thông tin người dùng từ session
        HttpSession session = request.getSession();
        String email = (String) session.getAttribute("email"); // Giả sử bạn đã lưu email người dùng trong session

        if (email != null) {
            // Lấy userId từ email
            UserDAO userDAO = new UserDAO();
            int userId = userDAO.getUserIdByEmail(email);

            if (userId != -1) {
                // Lấy danh sách các khóa học trong lịch sử wishlist
                WishlistDAO wishlistDAO = new WishlistDAO();
                List<WishlistItem> historyWishlistItems = wishlistDAO.getHistoryWishlistItems(userId);

                // Đưa dữ liệu vào request để hiển thị trong JSP
                request.setAttribute("historyWishlistItems", historyWishlistItems);
                request.getRequestDispatcher("/historywishlist.jsp").forward(request, response);
            } else {
                // Nếu không tìm thấy userId, chuyển hướng đến trang đăng nhập
                response.sendRedirect("login.jsp");
            }
        } else {
            // Nếu email không tồn tại trong session, chuyển hướng đến trang đăng nhập
            response.sendRedirect("login.jsp");
        }
    }
}
