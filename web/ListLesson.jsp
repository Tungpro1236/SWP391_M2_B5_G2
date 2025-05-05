<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Danh sách bài học</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    </head>
    <body>
        <div class="container">
            <h2 class="mt-4">Danh sách bài học</h2>

            <!-- Hiển thị thông báo nếu đã có trong wishlist -->
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
                                        <!-- Nếu đã đăng ký, hiện nút xem chi tiết -->
                                        <a href="LessonController?action=detail&courseId=${lesson.courseId}&lessonId=${lesson.lessonId}" 
                                           class="btn btn-primary">Xem chi tiết</a>
                                    </c:when>
                                    <c:otherwise>
                                        <!-- Kiểm tra khóa học đã có trong giỏ hàng chưa -->
                                        <c:set var="alreadyInCart" value="false"/>
                                        <c:forEach var="cart" items="${sessionScope.cartItems}">
                                            <c:if test="${cart.courseId == lesson.courseId}">
                                                <c:set var="alreadyInCart" value="true"/>
                                            </c:if>
                                        </c:forEach>

                                        <!-- Kiểm tra khóa học đã có trong wishlist chưa -->
                                        <c:set var="alreadyInWishlist" value="false"/>
                                        <c:forEach var="w" items="${sessionScope.wishlistItems}">
                                            <c:if test="${w.courseId == lesson.courseId}">
                                                <c:set var="alreadyInWishlist" value="true"/>
                                            </c:if>
                                        </c:forEach>

                                        <!-- Nếu khóa học chưa có trong giỏ hàng và wishlist -->
                                        <c:if test="${!alreadyInCart && !alreadyInWishlist}">
                                            <form action="CartServlet" method="post" class="d-inline ml-2">
                                                <input type="hidden" name="action" value="add" />
                                                <input type="hidden" name="courseId" value="${lesson.courseId}" />
                                                <button type="submit" class="btn btn-outline-success">
                                                    Thêm vào giỏ hàng
                                                </button>
                                            </form>

                                            <form action="WishlistServlet" method="post" class="d-inline ml-2">
                                                <input type="hidden" name="action" value="add" />
                                                <input type="hidden" name="courseId" value="${lesson.courseId}" />
                                                <button type="submit" class="btn btn-outline-danger">
                                                    Thêm vào Wishlist
                                                </button>
                                            </form>
                                        </c:if>

                                        <!-- Nếu khóa học đã có trong giỏ hàng, ẩn nút thêm vào wishlist -->
                                        <c:if test="${alreadyInCart}">
                                            <form action="WishlistServlet" method="post" class="d-inline ml-2">
                                                <input type="hidden" name="action" value="add" />
                                                <input type="hidden" name="courseId" value="${lesson.courseId}" />
                                                <button type="submit" class="btn btn-outline-danger" style="display:none;">
                                                    Thêm vào Wishlist
                                                </button>
                                            </form>
                                        </c:if>

                                        <!-- Nếu khóa học đã có trong wishlist -->
                                        <c:if test="${alreadyInWishlist && !alreadyInCart}">
                                            <form action="CartServlet" method="post" class="d-inline ml-2">
                                                <input type="hidden" name="action" value="add" />
                                                <input type="hidden" name="courseId" value="${lesson.courseId}" />
                                                <button type="submit" class="btn btn-outline-success">
                                                    Thêm vào giỏ hàng
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

            <a href="CourseController" class="btn btn-link">Quay lại danh sách khóa học</a>
        </div>

        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.3/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    </body>
</html>
