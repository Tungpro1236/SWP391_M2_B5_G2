/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package vn.edu.fpt.dao;

import vn.edu.fpt.model.*;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author ACER
 */
public class OrderDAO extends DBContext {

    public void insertOrder(UserModel user, List<CartItem> cart) throws ClassNotFoundException, SQLException {
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = connection;

            double total = 0;
            for (CartItem item : cart) {
                total += item.getPrice();
            }

            String sqlInsertOrder = "INSERT INTO [dbo].[orders] ([user_id], [total], [date], status) VALUES (?, ?, GETDATE(), 'Pending')";
            ps = conn.prepareStatement(sqlInsertOrder);
            ps.setInt(1, user.getId());
            ps.setDouble(2, total);
            ps.executeUpdate();

            String sqlGetOrderId = "SELECT TOP 1 id FROM [dbo].[orders] ORDER BY id DESC";
            ps = conn.prepareStatement(sqlGetOrderId);
            rs = ps.executeQuery();

            int orderId = 0;
            if (rs.next()) {
                orderId = rs.getInt("id");
            }
            rs.close();
            ps.close();

            String sqlInsertDetail = "INSERT INTO [dbo].[order_detail] ([order_id], [course_id], [quantity], [price]) VALUES (?, ?, ?, ?)";
            ps = conn.prepareStatement(sqlInsertDetail);

            for (CartItem item : cart) {
                ps.setInt(1, orderId);
                ps.setInt(2, item.getCourseId());
                ps.setInt(3, 1);
                ps.setDouble(4, item.getPrice());
                ps.executeUpdate();
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
    }

    public List<Order> getOrdersByUserId(int userId) {
        List<Order> orders = new ArrayList<>();
        String sql = "SELECT * FROM orders WHERE user_id = ?";

        try (Connection conn = connection;
                PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Order order = new Order();
                order.setOrderID(rs.getString("id"));
                order.setUserID(rs.getString("user_id"));
                order.setTotalAmount(rs.getDouble("total"));
                order.setOrderDate(rs.getString("date"));
                order.setStatus(rs.getString("status"));

                orders.add(order);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return orders;
    }

    public List<OrderDetail> getOrderDetailByOrderId(int orderId) {
        List<OrderDetail> details = new ArrayList<>();
        String sql = "SELECT od.order_id, od.course_id, od.quantity, od.price, " +
                "c.title, c.thumbnail_url, c.description, c.status " +
                "FROM order_detail od " +
                "JOIN courses c ON od.course_id = c.id " +
                "WHERE od.order_id = ?";

        try (Connection conn = connection;
                PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, orderId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                OrderDetail detail = new OrderDetail();
                detail.setOrderID(rs.getString("order_id"));
                detail.setProductID(rs.getString("course_id"));
                detail.setQuantity(rs.getInt("quantity"));
                detail.setPrice(rs.getDouble("price"));

                detail.setTitle(rs.getString("title"));
                detail.setImage(rs.getString("thumbnail_url"));
                detail.setDescription(rs.getString("description"));
                detail.setStatus(rs.getString("status"));

                details.add(detail);
            }

            rs.close();

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return details;
    }

    public List<Order> getAllOrders(int page, int pageSize, String status) {
        List<Order> orders = new ArrayList<>();
    
        StringBuilder sql = new StringBuilder(
            "SELECT o.id AS order_id, u.email AS user_name, o.total, o.date, o.status, " +
            "       STRING_AGG(c.title, ', ') AS course_titles " +
            "FROM orders o " +
            "JOIN users u ON o.user_id = u.id " +
            "JOIN order_detail od ON o.id = od.order_id " +
            "JOIN courses c ON od.course_id = c.id "
        );
    
        if (!"1".equals(status)) {
            sql.append("WHERE o.status = ? ");
        }
    
        sql.append("GROUP BY o.id, u.email, o.total, o.date, o.status ");
        sql.append("ORDER BY o.date DESC ");
        sql.append("OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");
    
        try (Connection conn = connection;
             PreparedStatement ps = conn.prepareStatement(sql.toString())) {
    
            int paramIndex = 1;
            if (!"1".equals(status)) {
                ps.setString(paramIndex++, status);
            }
            ps.setInt(paramIndex++, (page - 1) * pageSize);
            ps.setInt(paramIndex, pageSize);
    
            ResultSet rs = ps.executeQuery();
    
            while (rs.next()) {
                Order order = new Order();
                order.setOrderID(rs.getString("order_id"));
                order.setUser(rs.getString("user_name"));
                order.setCourses(rs.getString("course_titles"));
                order.setTotalAmount(rs.getDouble("total"));
                order.setOrderDate(rs.getString("date"));
                order.setStatus(rs.getString("status"));
                orders.add(order);
            }
    
            rs.close();
    
        } catch (SQLException e) {
            e.printStackTrace();
        }
    
        return orders;
    }
    
    public static void main(String[] args) {
        OrderDAO d = new OrderDAO();
        System.out.println(d.getAllOrders(1, 10, "1").get(0).toString());
    }
    
    public int getOrderCount(String status) {
        StringBuilder sql = new StringBuilder("SELECT COUNT(DISTINCT o.id) AS total FROM orders o ");
        if (!"1".equals(status)) {
            sql.append("WHERE o.status = ?");
        }
    
        try (Connection conn = connection;
             PreparedStatement ps = conn.prepareStatement(sql.toString())) {
    
            if (!"1".equals(status)) {
                ps.setString(1, status);
            }
    
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt("total");
            }
    
            rs.close();
    
        } catch (SQLException e) {
            e.printStackTrace();
        }
    
        return 0;
    }
    
    public void confirmOrder(int orderId) {
        String sql = "UPDATE orders SET status = 'Confirmed' WHERE id = ?";
    
        try (Connection conn = connection;
             PreparedStatement ps = conn.prepareStatement(sql)) {
    
            ps.setInt(1, orderId);
            ps.executeUpdate();
    
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    

}
