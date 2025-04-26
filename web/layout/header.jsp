<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Online Learning</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    </head>
    <body>
        <nav class="navbar navbar-expand-lg navbar-light bg-light">
            <div class="container">
                <a class="navbar-brand" href="home">Online Learning</a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>

                <div class="collapse navbar-collapse" id="navbarNav">
                    <ul class="navbar-nav mx-auto">
                        <li class="nav-item">
                            <a class="nav-link" href="home">Home</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="CourseController">Courses</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="blogs.jsp">Blogs</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="introduce.jsp">Introduce</a>
                        </li>
                    </ul>

                    <ul class="navbar-nav">
                        <!-- Wishlist and Cart -->
                        <li class="nav-item">
                            <a class="nav-link" href="wishlist.jsp">
                                <i class="bi bi-heart"></i> Wishlist
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="cart.jsp">
                                <i class="bi bi-cart"></i> Cart
                            </a>
                        </li>

                        <!-- User Session Control -->
                        <c:choose>
                            <c:when test="${not empty sessionScope.user}">
                                <a href="profile">
                                    <img src="https://th.bing.com/th/id/OIP.-Zanaodp4hv0ry2WpuuPfgHaEf?rs=1&pid=ImgDetMain" alt="User Icon" style="width:44px; height:28px;">
                                </a>
                                <li class="nav-item">
                                    <a class="nav-link" href="login?action=logout">Logout</a>
                                </li>
                            </c:when>
                            <c:otherwise>
                                <li class="nav-item">
                                    <a class="nav-link" href="login.jsp">Login</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="register.jsp">Register</a>
                                </li>
                            </c:otherwise>
                        </c:choose>
                    </ul>
                </div>
            </div>
        </nav>

        <!-- Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

        <!-- Bootstrap Icons -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    </body>
</html>
