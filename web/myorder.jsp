<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>My Order</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
        <style>
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
            <c:if test="${not empty message}">
                <div class="alert alert-warning alert-dismissible fade show" role="alert">
                    ${message}
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            </c:if>

            <c:choose>
                <c:when test="${not empty orders}">
                    <div class="table-responsive">
                        <table class="table table-bordered table-hover align-middle">
                            <thead class="table-dark text-center">
                                <tr>
                                    <th>#</th>
                                    <th>Total</th>
                                    <th>Date</th>
                                    <th>Status</th>
                                    <th>Detail</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${orders}" var="item" varStatus="status">
                                    <tr>
                                        <td class="text-center">${status.index + 1}</td>
                                        <td  class="text-success fw-bold">$ ${item.totalAmount}</td>
                                        <td>${item.orderDate}</td>
                                        <td class="text-center">
                                            <c:choose>
                                                <c:when test="${item.status == 'Pending'}">
                                                    <span class="text-warning fw-bold">Pending</span>
                                                </c:when>
                                                <c:when test="${item.status == 'Confirmed'}">
                                                    <span class="text-success fw-bold">Confirmed</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="text-secondary">Unknown</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td><a href="orderdetail?id=${item.orderID}">Detail</a></td>
                                        
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>

                </c:when>

                <c:otherwise>
                    <div class="alert alert-info text-center">
                        <i class="bi bi-cart-x empty-cart-icon"></i>
                        <h4 class="mt-3">Your orders empty!</h4>
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