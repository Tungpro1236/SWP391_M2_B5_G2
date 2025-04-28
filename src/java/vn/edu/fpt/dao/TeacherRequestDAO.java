package vn.edu.fpt.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import vn.edu.fpt.model.TeacherRequest;

public class TeacherRequestDAO extends DBContext {
    
    public boolean createRequest(int teacherId) {
        String sql = "INSERT INTO teacher_requests (requester_id) VALUES (?)";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, teacherId);
            return st.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println("Error creating teacher request: " + e.getMessage());
            return false;
        }
    }
    
    public List<TeacherRequest> getRequestsByTeacher(int teacherId) {
        List<TeacherRequest> requests = new ArrayList<>();
        String sql = "SELECT tr.*, u.email as approver_email " +
                    "FROM teacher_requests tr " +
                    "LEFT JOIN users u ON tr.approver_id = u.id " +
                    "WHERE tr.requester_id = ? " +
                    "ORDER BY tr.request_date DESC";
        
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, teacherId);
            ResultSet rs = st.executeQuery();
            
            while (rs.next()) {
                TeacherRequest request = new TeacherRequest();
                request.setId(rs.getInt("id"));
                request.setRequesterId(teacherId);
                request.setApproverId(rs.getInt("approver_id"));
                request.setRequestDate(rs.getTimestamp("request_date"));
                request.setApproveDate(rs.getTimestamp("approve_date"));
                request.setStatus(rs.getInt("status"));
                request.setRejectReason(rs.getString("reject_reason"));
                request.setApproverEmail(rs.getString("approver_email"));
                requests.add(request);
            }
        } catch (SQLException e) {
            System.out.println("Error getting teacher requests: " + e.getMessage());
        }
        return requests;
    }
    
    public boolean hasActiveRequest(int teacherId) {
        String sql = "SELECT COUNT(*) FROM teacher_requests " +
                    "WHERE requester_id = ? AND (status = 0 OR status = 1)";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, teacherId);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            System.out.println("Error checking active requests: " + e.getMessage());
        }
        return false;
    }
    
    public List<TeacherRequest> getRequestsPaginated(int page, int pageSize, Integer status) {
            List<TeacherRequest> requests = new ArrayList<>();
            String sql = "SELECT tr.*, u.email as teacher_email, " +
                        "a.email as approver_email " +
                        "FROM teacher_requests tr " +
                        "JOIN users u ON tr.requester_id = u.id " +
                        "LEFT JOIN users a ON tr.approver_id = a.id " +
                        (status != null ? "WHERE tr.status = ? " : "") +
                        "ORDER BY tr.request_date DESC " +
                        "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
            
            try {
                PreparedStatement st;
                if (status != null) {
                    st = connection.prepareStatement(sql);
                    st.setInt(1, status);
                    st.setInt(2, (page - 1) * pageSize);
                    st.setInt(3, pageSize);
                } else {
                    st = connection.prepareStatement(sql);
                    st.setInt(1, (page - 1) * pageSize);
                    st.setInt(2, pageSize);
                }
                
                ResultSet rs = st.executeQuery();
                while (rs.next()) {
                    TeacherRequest request = new TeacherRequest();
                    request.setId(rs.getInt("id"));
                    request.setRequesterId(rs.getInt("requester_id"));
                    request.setApproverId(rs.getInt("approver_id"));
                    request.setRequestDate(rs.getTimestamp("request_date"));
                    request.setApproveDate(rs.getTimestamp("approve_date"));
                    request.setStatus(rs.getInt("status"));
                    request.setRejectReason(rs.getString("reject_reason"));
                    // Update ResultSet mapping to use email instead of name
                    request.setTeacherEmail(rs.getString("teacher_email"));
                    request.setApproverEmail(rs.getString("approver_email"));
                    requests.add(request);
                }
            } catch (SQLException e) {
                System.out.println("Error getting paginated requests: " + e.getMessage());
            }
            return requests;
        }
        
        public int getTotalRequests(Integer status) {
            String sql = "SELECT COUNT(*) FROM teacher_requests" +
                        (status != null ? " WHERE status = ?" : "");
            try {
                PreparedStatement st = connection.prepareStatement(sql);
                if (status != null) {
                    st.setInt(1, status);
                }
                ResultSet rs = st.executeQuery();
                if (rs.next()) {
                    return rs.getInt(1);
                }
            } catch (SQLException e) {
                System.out.println("Error counting requests: " + e.getMessage());
            }
            return 0;
        }
        
        public boolean approveRequest(int requestId , int currentUserId) {
            String sql = "UPDATE teacher_requests SET status = 1, approve_date = GETDATE(), " +
                        "approver_id = ? WHERE id = ?";
            try {
                PreparedStatement st = connection.prepareStatement(sql);
                st.setInt(1, currentUserId); // You need to implement this method
                st.setInt(2, requestId);
                return st.executeUpdate() > 0;
            } catch (SQLException e) {
                System.out.println("Error approving request: " + e.getMessage());
                return false;
            }
        }
        
        public boolean rejectRequest(int requestId, String reason , int currentUserId) {
            String sql = "UPDATE teacher_requests SET status = -1, approve_date = GETDATE(), " +
                        "approver_id = ?, reject_reason = ? WHERE id = ?";
            try {
                PreparedStatement st = connection.prepareStatement(sql);
                st.setInt(1, currentUserId); // You need to implement this method
                st.setString(2, reason);
                st.setInt(3, requestId);
                return st.executeUpdate() > 0;
            } catch (SQLException e) {
                System.out.println("Error rejecting request: " + e.getMessage());
                return false;
            }
        }
}