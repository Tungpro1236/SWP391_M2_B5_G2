<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <title>List Lessons</title>
        
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    </head>
    <body>
        
        <!-- Header -->
        <%@ include file="/layout/header.jsp" %>
        <div class="container">
            <h2 class="mt-4">List of Lessons</h2>

            <!-- Display message if already in wishlist -->
            <c:if test="${not empty sessionScope.wishlistMessage}">
                <div class="alert alert-warning">${wishlistMessage}</div>
                <c:remove var="wishlistMessage" scope="session" />
            </c:if>

            <table class="table table-bordered">
                <thead class="thead-light">
                    <tr>
                        <th>Title</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="lesson" items="${lessons}">
                        <tr>
                            <td>${lesson.title}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${enrolled}">
                                        <!-- If enrolled, show "View Details" button -->
                                        <a href="LessonController?action=detail&courseId=${lesson.courseId}&lessonId=${lesson.lessonId}" 
                                           class="btn btn-primary">View Details</a>
                                    </c:when>
                                    <c:otherwise>
                                        <!-- Check if course is in cart -->
                                        <c:set var="alreadyInCart" value="false"/>
                                        <c:forEach var="cart" items="${sessionScope.cartItems}">
                                            <c:if test="${cart.courseId == lesson.courseId}">
                                                <c:set var="alreadyInCart" value="true"/>
                                            </c:if>
                                        </c:forEach>

                                        <!-- Check if course is in wishlist -->
                                        <c:set var="alreadyInWishlist" value="false"/>
                                        <c:forEach var="w" items="${sessionScope.wishlistItems}">
                                            <c:if test="${w.courseId == lesson.courseId}">
                                                <c:set var="alreadyInWishlist" value="true"/>
                                            </c:if>
                                        </c:forEach>

                                        <!-- If course is not in cart or wishlist -->
                                        <c:if test="${!alreadyInCart && !alreadyInWishlist}">
                                            <form action="CartServlet" method="post" class="d-inline ml-2">
                                                <input type="hidden" name="action" value="add" />
                                                <input type="hidden" name="courseId" value="${lesson.courseId}" />
                                                <button type="submit" class="btn btn-outline-success">
                                                    Add to Cart
                                                </button>
                                            </form>

                                            <form action="WishlistServlet" method="post" class="d-inline ml-2">
                                                <input type="hidden" name="action" value="add" />
                                                <input type="hidden" name="courseId" value="${lesson.courseId}" />
                                                <button type="submit" class="btn btn-outline-danger">
                                                    Add to Wishlist
                                                </button>
                                            </form>
                                        </c:if>

                                        <!-- If course is already in cart, hide "Add to Wishlist" button -->
                                        <c:if test="${alreadyInCart}">
                                            <form action="WishlistServlet" method="post" class="d-inline ml-2">
                                                <input type="hidden" name="action" value="add" />
                                                <input type="hidden" name="courseId" value="${lesson.courseId}" />
                                                <button type="submit" class="btn btn-outline-danger" style="display:none;">
                                                    Add to Wishlist
                                                </button>
                                            </form>
                                        </c:if>

                                        <!-- If course is already in wishlist -->
                                        <c:if test="${alreadyInWishlist && !alreadyInCart}">
                                            <form action="CartServlet" method="post" class="d-inline ml-2">
                                                <input type="hidden" name="action" value="add" />
                                                <input type="hidden" name="courseId" value="${lesson.courseId}" />
                                                <button type="submit" class="btn btn-outline-success">
                                                    Add to Cart
                                                </button>
                                            </form>
                                        </c:if>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>

            <a href="CourseController" class="btn btn-link">Back to Course List</a>
        </div>

        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.3/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    </body>

</html>
