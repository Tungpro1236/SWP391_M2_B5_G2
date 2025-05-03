<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lịch sử Wishlist</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
        }
        .container {
            width: 80%;
            margin: 20px auto;
            background-color: white;
            padding: 20px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        table {
            width: 100%;
            border-collapse: collapse;
        }
        table th, table td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: left;
        }
        table th {
            background-color: #f2f2f2;
        }
        .btn {
            padding: 6px 12px;
            text-decoration: none;
            background-color: #4CAF50;
            color: white;
            border-radius: 5px;
            font-size: 14px;
            transition: background-color 0.3s;
        }
        .btn:hover {
            background-color: #45a049;
        }
        h1 {
            color: #333;
        }
    </style>
</head>
<body>

    <div class="container">
        <h1>Lịch sử Wishlist của bạn</h1>

        <!-- Kiểm tra nếu có dữ liệu wishlist -->
        <c:if test="${not empty historyWishlistItems}">
            <table>
                <thead>
                    <tr>
                        <th>STT</th>
                        <th>Tên khóa học</th>
                        <th>Trạng thái</th>
                    </tr>
                </thead>
                <tbody>
                    <!-- Lặp qua các mục wishlist -->
                    <c:forEach var="item" items="${historyWishlistItems}">
                        <tr>
                            <td>${item.index + 1}</td> <!-- Đếm thứ tự item -->
                            <td>${item.courseName}</td> <!-- Tên khóa học -->
                            <td>${item.status}</td> <!-- Trạng thái (Ví dụ: Đã thêm, Đang chờ...) -->
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </c:if>

        <!-- Nếu không có dữ liệu wishlist -->
        <c:if test="${empty historyWishlistItems}">
            <p>Không có khóa học nào trong lịch sử wishlist của bạn.</p>
        </c:if>
        
    </div>

</body>
</html>
