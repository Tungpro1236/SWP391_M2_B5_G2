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

@WebServlet("/CartServlet")
public class CartServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        int courseId = Integer.parseInt(request.getParameter("courseId"));

        List<CartItem> cartItems = (List<CartItem>) request.getSession().getAttribute("cartItems");
        if (cartItems == null) cartItems = new ArrayList<>();

        List<CartItem> wishlistItems = (List<CartItem>) request.getSession().getAttribute("wishlistItems");
        if (wishlistItems == null) wishlistItems = new ArrayList<>();

        CourseDAO courseDAO = new CourseDAO();
        Course course = courseDAO.getCourseById(courseId);

        switch (action) {
            case "add":
                boolean existsInCart = cartItems.stream().anyMatch(item -> item.getCourseId() == courseId);
                boolean existsInWishlist = wishlistItems.stream().anyMatch(item -> item.getCourseId() == courseId);

                if (existsInWishlist) {
                    request.getSession().setAttribute("message", "This course was available in the Wishlist.");
                } else if (existsInCart) {
                    request.getSession().setAttribute("message", "This course was available in the Cart.");
                } else {
                    CartItem newItem = new CartItem(course.getId(), course.getTitle(), course.getPrice(), course.getThumbnailUrl());
                    cartItems.add(newItem);
                    request.getSession().setAttribute("cartItems", cartItems);
                    request.getSession().removeAttribute("message");
                }

                request.getSession().setAttribute("totalPrice", calculateTotalPrice(cartItems));
                response.sendRedirect("cart.jsp");
                break;

            case "remove":
                cartItems.removeIf(item -> item.getCourseId() == courseId);
                request.getSession().setAttribute("cartItems", cartItems);
                request.getSession().setAttribute("totalPrice", calculateTotalPrice(cartItems));
                response.sendRedirect("cart.jsp");
                break;

            case "moveToWishlist":
                boolean existsInWishlistForMove = wishlistItems.stream().anyMatch(item -> item.getCourseId() == courseId);
                if (!existsInWishlistForMove) {
                    CartItem moveItem = cartItems.stream()
                        .filter(item -> item.getCourseId() == courseId)
                        .findFirst()
                        .orElse(null);
                    if (moveItem != null) {
                        cartItems.remove(moveItem);
                        wishlistItems.add(moveItem);
                    }
                }

                request.getSession().setAttribute("cartItems", cartItems);
                request.getSession().setAttribute("wishlistItems", wishlistItems);
                request.getSession().setAttribute("totalPrice", calculateTotalPrice(cartItems));
                response.sendRedirect("wishlist.jsp");
                break;

            case "addToWishlistFromCart":
                boolean alreadyInWishlist = wishlistItems.stream()
                        .anyMatch(item -> item.getCourseId() == courseId);

                if (alreadyInWishlist) {
                    request.getSession().setAttribute("wishlistMessage", "This course was available in the Wishlist.");
                } else {
                    CartItem wishlistItem = new CartItem(course.getId(), course.getTitle(), course.getPrice(), course.getThumbnailUrl());
                    wishlistItems.add(wishlistItem);
                    cartItems.removeIf(item -> item.getCourseId() == courseId);

                    request.getSession().setAttribute("cartItems", cartItems);
                    request.getSession().setAttribute("wishlistItems", wishlistItems);
                    request.getSession().removeAttribute("wishlistMessage");
                }

                request.getSession().setAttribute("totalPrice", calculateTotalPrice(cartItems));
                response.sendRedirect("cart.jsp");
                break;

            case "addToWishlist":
                boolean alreadyInWishlistFromList = wishlistItems.stream()
                        .anyMatch(item -> item.getCourseId() == courseId);

                boolean existsInCartFromList = cartItems.stream()
                        .anyMatch(item -> item.getCourseId() == courseId);

                if (alreadyInWishlistFromList) {
                    request.getSession().setAttribute("wishlistMessage", "This course was available in the Wishlist.");
                } else if (existsInCartFromList) {
                    request.getSession().setAttribute("wishlistMessage", "This course was available in the Cart.");
                } else {
                    CartItem wishlistItem = new CartItem(course.getId(), course.getTitle(), course.getPrice(), course.getThumbnailUrl());
                    wishlistItems.add(wishlistItem);
                    request.getSession().setAttribute("wishlistItems", wishlistItems);
                    request.getSession().removeAttribute("wishlistMessage");
                }

                response.sendRedirect("listlesson.jsp");
                break;

            case "addFromWishlist":
                CartItem itemFromWishlist = wishlistItems.stream()
                    .filter(item -> item.getCourseId() == courseId)
                    .findFirst()
                    .orElse(null);

                if (itemFromWishlist != null) {
                    boolean existsInCartFromWishlist = cartItems.stream()
                            .anyMatch(item -> item.getCourseId() == courseId);

                    if (!existsInCartFromWishlist) {
                        cartItems.add(itemFromWishlist);
                        wishlistItems.remove(itemFromWishlist);
                        request.getSession().setAttribute("message", "✅ moved the course to the cart.");
                    } else {
                        request.getSession().setAttribute("message", "⚠️This course was available in the Cart.");
                    }
                } else {
                    request.getSession().setAttribute("message", "❌ Can not found in the course wishlist.");
                }

                request.getSession().setAttribute("cartItems", cartItems);
                request.getSession().setAttribute("wishlistItems", wishlistItems);
                request.getSession().setAttribute("totalPrice", calculateTotalPrice(cartItems));
                response.sendRedirect("wishlist.jsp");
                break;

            case "removeFromWishlist":
                wishlistItems.removeIf(item -> item.getCourseId() == courseId);
                request.getSession().setAttribute("wishlistItems", wishlistItems);
                response.sendRedirect("wishlist.jsp");
                break;

            default:
                response.sendRedirect("error.jsp");
                break;
        }
    }

    private double calculateTotalPrice(List<CartItem> cartItems) {
        return cartItems.stream().mapToDouble(CartItem::getPrice).sum();
    }
}