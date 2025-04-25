<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Danh sách yêu thích</title>
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
            .empty-wishlist-icon {
                font-size: 5rem;
                color: #6c757d;
                margin-bottom: 1rem;
            }
        </style>
    </head>
    <body>
        <%@ include file="/layout/header.jsp" %>

        <div class="container py-5">
            <h1 class="text-center mb-5">Danh sách yêu thích</h1>

            <c:choose>
                <c:when test="${not empty wishlistItems}">
                    <div class="wishlist-items">
                        <div class="card p-4">
                            <c:forEach items="${wishlistItems}" var="item">
                                <div class="card mb-3 course-card">
                                    <div class="row g-0">
                                        <div class="col-md-8">
                                            <div class="card-body">
                                                <h5 class="card-title">${item.title}</h5>
                                                <p class="card-text text-success fw-bold">$${item.price}</p>
                                            </div>
                                        </div>
                                        <div class="col-md-4 d-flex align-items-center justify-content-end">
                                            <!-- Nút Xóa khỏi Wishlist -->
                                            <form action="CartServlet" method="post" class="me-2">
                                                <input type="hidden" name="action" value="removeFromWishlist"/>
                                                <input type="hidden" name="courseId" value="${item.courseId}"/>
                                                <button type="submit" class="btn btn-danger">
                                                    <i class="bi bi-trash"></i> Xóa
                                                </button>
                                            </form>

                                            <!-- Nút Thêm vào Giỏ hàng -->
                                            <form action="CartServlet" method="post" class="me-2">
                                                <input type="hidden" name="action" value="addFromWishlist"/>
                                                <input type="hidden" name="courseId" value="${item.courseId}"/>
                                                <button type="submit" class="btn btn-success">
                                                    <i class="bi bi-cart-plus"></i> Thêm vào Giỏ hàng
                                                </button>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="alert alert-info text-center">
                        <i class="bi bi-heart-x empty-wishlist-icon"></i>
                        <h4 class="mt-3">Danh sách yêu thích trống</h4>
                        <p>Hãy thêm khóa học yêu thích vào danh sách!</p>
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
