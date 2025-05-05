<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Wishlist</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
</head>
<body>
    <%@ include file="/layout/header.jsp" %>

    <div class="container py-5">
        <h1 class="text-center mb-5">Wishlist</h1>

        <c:choose>
            <c:when test="${not empty wishlistItems}">
                <div class="table-responsive">
                    <table class="table table-bordered table-hover align-middle">
                        <thead class="table-dark text-center">
                            <tr>
                                <th>#</th>
                                <th>Course Name</th>
                                <th>Price</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${wishlistItems}" var="item" varStatus="status">
                                <tr>
                                    <td class="text-center">${status.index + 1}</td>
                                    <td>${item.title}</td>
                                    <td class="text-success fw-bold">$${item.price}</td>
                                    <td class="text-center">
                                        <div class="d-flex justify-content-center gap-2">
                                            <!-- Remove button -->
                                            <form action="CartServlet" method="post">
                                                <input type="hidden" name="action" value="removeFromWishlist"/>
                                                <input type="hidden" name="courseId" value="${item.courseId}"/>
                                                <button type="submit" class="btn btn-sm btn-danger">
                                                    <i class="bi bi-trash"></i> Remove
                                                </button>
                                            </form>
                                            <!-- Add to cart button -->
                                            <form action="CartServlet" method="post">
                                                <input type="hidden" name="action" value="addFromWishlist"/>
                                                <input type="hidden" name="courseId" value="${item.courseId}"/>
                                                <button type="submit" class="btn btn-sm btn-success">
                                                    <i class="bi bi-cart-plus"></i> Add to Cart
                                                </button>
                                            </form>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </c:when>
            <c:otherwise>
                <div class="alert alert-info text-center">
                    <i class="bi bi-heart-x empty-wishlist-icon" style="font-size: 5rem; color: #6c757d;"></i>
                    <h4 class="mt-3">Your Wishlist is Empty</h4>
                    <p>Please add some favorite courses to your wishlist!</p>
                    <a href="CourseController" class="btn btn-primary mt-2">
                        <i class="bi bi-book"></i> Browse Courses
                    </a>
                </div>
            </c:otherwise>
        </c:choose>

        <a href="CourseController" class="btn btn-secondary mt-3">
            <i class="bi bi-arrow-left"></i> Back to Course List
        </a>
    </div>

    <%@ include file="/layout/footer.jsp" %>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>