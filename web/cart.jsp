<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Shopping Cart</title>
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
            <!-- Display message if available -->
            <c:if test="${not empty message}">
                <div class="alert alert-warning alert-dismissible fade show" role="alert">
                    ${message}
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            </c:if>

            <h1 class="text-center mb-4">Select Items to Submit</h1>

            <c:choose>
                <c:when test="${not empty cartItems}">
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
                                <c:forEach items="${cartItems}" var="item" varStatus="status">
                                    <tr>
                                        <td class="text-center">${status.index + 1}</td>
                                        <td>${item.title}</td>
                                        <td class="text-success fw-bold">$${item.price}</td>
                                        <td class="text-center">
                                            <div class="d-flex justify-content-center gap-2">
                                                <!-- Remove button -->
                                                <form action="CartServlet" method="post">
                                                    <input type="hidden" name="action" value="remove"/>
                                                    <input type="hidden" name="courseId" value="${item.courseId}"/>
                                                    <button type="submit" class="btn btn-sm btn-danger">
                                                        <i class="bi bi-trash"></i> Remove
                                                    </button>
                                                </form>
                                                <!-- Move to Wishlist button -->
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

                    <!-- Total price and Checkout button -->
                    <div class="d-flex justify-content-between align-items-center mt-4">
                        <h5 class="fw-bold">
                            Total: 
                            <c:choose>
                                <c:when test="${not empty sessionScope.totalPrice}">
                                    $${sessionScope.totalPrice}
                                </c:when>
                                <c:otherwise>
                                    $0.00
                                </c:otherwise>
                            </c:choose>
                        </h5>
                        <a href="CheckoutServlet" class="btn btn-success btn-lg">
                            <i class="bi bi-cart-check"></i> Checkout
                        </a>
                    </div>
                </c:when>

                <c:otherwise>
                    <!-- Display when cart is empty -->
                    <div class="alert alert-info text-center">
                        <i class="bi bi-cart-x empty-cart-icon"></i>
                        <h4 class="mt-3">Your Cart is Empty</h4>
                        <p>Please add some courses to your cart!</p>
                        <a href="CourseController" class="btn btn-primary mt-2">
                            <i class="bi bi-book"></i> Browse Courses
                        </a>
                    </div>
                </c:otherwise>
            </c:choose>

            <!-- Button to go back to course list -->
            <a href="CourseController" class="btn btn-secondary mt-3">
                <i class="bi bi-arrow-left"></i> Back to Course List
            </a>
        </div>

        <%@ include file="/layout/footer.jsp" %>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>