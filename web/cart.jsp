<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Giỏ hàng</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
        <style>
            .course-card {
                transition: transform 0.3s;
                border: none;
                box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
                border-radius: 0.5rem;
            }
            .course-card:hover {
                transform: translateY(-5px);
                box-shadow: 0 10px 20px rgba(0,0,0,0.1);
            }
            .empty-cart-icon {
                font-size: 5rem;
                color: #6c757d;
                margin-bottom: 1rem;
            }
        </style>
    </head>
    <body>
        <%@ include file="/layout/header.jsp" %>

        <div class="container py-5">
            <!-- Hiển thị thông báo nếu có thông báo trong session -->
            <c:if test="${not empty message}">
                <div class="alert alert-warning alert-dismissible fade show" role="alert">
                    ${message}
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            </c:if>
            
            <h1 class="text-center mb-5">Lựa chọn các khoản nộp</h1>

            <c:choose>
    <c:when test="${not empty cartItems}">
        <div class="table-responsive">
            <table class="table table-bordered table-striped table-hover align-middle">
                <thead class="table-dark text-center">
                    <tr>
                        <th scope="col">#</th>
                        <th scope="col">Tên khóa học</th>
                        <th scope="col">Giá</th>
                        <th scope="col">Hành động</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${cartItems}" var="item" varStatus="status">
                        <tr>
                            <td class="text-center">${status.index + 1}</td>
                            <td>${item.title}</td>
                            <td class="text-success fw-bold">$${item.price}</td>
                            <td class="text-center">
                                <div class="d-flex justify-content-center gap-2">
                                    <!-- Xóa -->
                                    <form action="CartServlet" method="post">
                                        <input type="hidden" name="action" value="remove"/>
                                        <input type="hidden" name="courseId" value="${item.courseId}"/>
                                        <button type="submit" class="btn btn-sm btn-danger">
                                            <i class="bi bi-trash"></i> Xóa
                                        </button>
                                    </form>
                                    
                                    <!-- Chuyển sang Wishlist -->
                                    <form action="CartServlet" method="post">
                                        <input type="hidden" name="action" value="moveToWishlist"/>
                                        <input type="hidden" name="courseId" value="${item.courseId}"/>
                                        <button type="submit" class="btn btn-sm btn-warning">
                                            <i class="bi bi-heart"></i> Wishlist
                                        </button>
                                    </form>
                                </div>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>

        <!-- Hiển thị tổng cộng + nút thanh toán -->
        <div class="d-flex justify-content-between align-items-center mt-3">
            <h5 class="fw-bold">Tổng cộng: $${sessionScope.totalPrice}</h5>
            <a href="CheckoutServlet" class="btn btn-success btn-lg">
                <i class="bi bi-cart-check"></i> Thanh toán
            </a>
        </div>
    </c:when>
    
    <c:otherwise>
        <div class="alert alert-info text-center">
            <i class="bi bi-cart-x empty-cart-icon"></i>
            <h4 class="mt-3">Giỏ hàng trống</h4>
            <p>Hãy thêm khóa học vào giỏ hàng!</p>
            <a href="CourseController" class="btn btn-primary mt-2">
                <i class="bi bi-book"></i> Xem khóa học
            </a>
        </div>
    </c:otherwise>
</c:choose>

            <!-- Nút quay lại danh sách khóa học -->
            <a href="CourseController" class="btn btn-secondary mt-3">
                <i class="bi bi-arrow-left"></i> Quay lại danh sách khóa học
            </a>
        </div>

        <%@ include file="/layout/footer.jsp" %>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
