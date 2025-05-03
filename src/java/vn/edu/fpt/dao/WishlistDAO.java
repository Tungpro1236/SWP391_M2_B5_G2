package vn.edu.fpt.dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import vn.edu.fpt.model.WishlistItem;  // Import WishlistItem class

public class WishlistDAO extends DBContext {

    // Lấy danh sách lịch sử wishlist của người dùng
    public List<WishlistItem> getHistoryWishlistItems(int userId) {
        List<WishlistItem> historyWishlistItems = new ArrayList<>();
        String query = "SELECT course_id, status FROM wishlist WHERE user_id = ?";

        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, userId);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    WishlistItem item = new WishlistItem();
                    item.setCourseId(rs.getInt("course_id"));
                    item.setStatus(rs.getString("status"));
                    historyWishlistItems.add(item);
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(WishlistDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return historyWishlistItems;
    }
}
