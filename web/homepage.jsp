<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Online Learning Platform</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
        <style>
            /* Sub header styles */
            .sub-header {
                background: #f8f9fa;
                border-bottom: 1px solid #e3e3e3;
            }

            .sub-header .icon-left a {
                color: #6c757d;
                font-size: 13px;
                text-decoration: none;
            }

            .sub-header .vartical {
                border-left: 1px solid #e3e3e3;
                height: 15px;
                margin: 0 10px;
            }

            /* Navbar styles */
            .menu-area {
                box-shadow: 0 0 1px 1px rgba(20,23,28,.1), 0 3px 1px 0 rgba(20,23,28,.1);
            }

            .mobile-header-buttons {
                display: none;
            }

            .search-box .form-control {
                border-radius: 20px 0 0 20px;
                border-right: 0;
                padding-left: 20px;
            }

            .search-box .btn {
                border-radius: 0 20px 20px 0;
                border: 1px solid #ced4da;
                border-left: 0;
                color: #6c757d;
            }

            .menu-icon-box {
                position: relative;
                margin: 0 5px;
            }

            .menu-icon-box .icon a {
                color: #6c757d;
            }

            .menu-icon-box .number {
                position: absolute;
                top: -5px;
                right: -5px;
                background: #ec5252;
                color: #fff;
                border-radius: 50%;
                font-size: 10px;
                padding: 0 5px;
            }

            .user-dropdown {
                min-width: 200px;
                padding: 10px 0;
                box-shadow: 0 4px 16px rgba(20,23,28,.25);
                background: #fff;
                display: none;
            }

            .user-dropdown-menu-item a {
                color: #505763;
                padding: 10px 15px;
                display: block;
                text-decoration: none;
            }

            .user-dropdown-menu-item a:hover {
                background: #f2f3f5;
            }

            @media (max-width: 991px) {
                .mobile-header-buttons {
                    display: block;
                }

                .main-nav-wrap {
                    display: none;
                }
            }

            /* Update these styles in your existing <style> section */
            .menu-icon-box {
                position: relative;
                margin: 0 5px;
                cursor: pointer;
            }

            .menu-icon-box .icon a {
                color: #6c757d;
                font-size: 18px; /* Reduced icon size */
                padding: 5px;
                display: inline-block;
            }

            .menu-icon-box .icon img {
                width: 52px; /* Smaller user avatar */
                height: 35px;
                border-radius: 50%;
            }

            .user-dropdown {
                position: absolute;
                right: 0;
                top: 100%;
                min-width: 260px;
                background: #fff;
                border-radius: 10px;
                box-shadow: 0 4px 16px rgba(20,23,28,.25);
                z-index: 1000;
            }

            .category {
                position: absolute;
                top: 100%;
                left: 0;
                background: #fff;
                border-radius: 5px;
                box-shadow: 0 4px 16px rgba(20,23,28,.25);
                min-width: 220px;
                z-index: 1000;
            }

            .category:not(.is-hidden) {
                display: block;
            }

            .category.is-hidden {
                display: none;
            }

            .user-dropdown-menu-item a {
                padding: 10px 20px;
                display: flex;
                align-items: center;
                color: #505763;
                font-size: 14px;
                text-decoration: none;
            }

            .user-dropdown-menu-item a i {
                margin-right: 10px;
                font-size: 16px;
            }

            .dropdown-user-info {
                padding: 15px 20px;
                border-bottom: 1px solid #dedfe0;
            }

            .user-image img {
                width: 40px;
                height: 40px;
                border-radius: 50%;
                margin-right: 15px;
            }

            .user-details .user-name {
                font-size: 15px;
                font-weight: 500;
                margin-bottom: 5px;
            }

            .user-details .user-name .hi {
                color: #888;
                font-weight: normal;
            }

            .user-details .user-email {
                font-size: 13px;
                color: #686f7a;
            }

            .all-category-devided {
                border-bottom: 1px solid #e3e3e3;
            }

            .all-category-devided a {
                padding: 12px 20px;
                display: flex;
                align-items: center;
                color: #505763;
                font-size: 14px;
                text-decoration: none;
            }

            .all-category-devided a:hover {
                background: #f2f3f5;
            }

            .all-category-devided .icon {
                margin-right: 10px;
                font-size: 16px;
            }
        </style>
        <!-- Add this right before the closing </body> tag -->
        <script>
            // Dropdown functionality
            document.addEventListener('DOMContentLoaded', function () {
                // User dropdown
                const userBox = document.querySelector('.user-box');
                const userDropdown = document.querySelector('.user-dropdown');

                userBox.addEventListener('click', function (e) {
                    userDropdown.style.display = userDropdown.style.display === 'block' ? 'none' : 'block';
                    e.stopPropagation();
                });

                // Category dropdown
                const categoryMenu = document.querySelector('.has-children');
                const categoryDropdown = document.querySelector('.category');

                categoryMenu.addEventListener('click', function (e) {
                    categoryDropdown.classList.toggle('is-hidden');
                    e.stopPropagation();
                });

                // Close dropdowns when clicking outside
                document.addEventListener('click', function () {
                    userDropdown.style.display = 'none';
                    categoryDropdown.classList.add('is-hidden');
                });
            });
        </script>
    </head>
    <body>
        <!-- Sub Header -->
        <div class="sub-header py-0">
            <div class="container-xl">
                <div class="row">
                    <div class="col-xl-6 col-lg-6 col-md-10 col-sm-12">
                        <div class="icon icon-left">
                            <ul class="nav">
                                <li class="nav-item px-2">
                                    <a href="tel:+84123456789"><i class="fas fa-headphones"></i> +84 123 456 789</a>
                                </li>
                                <div class="vartical"></div>
                                <li class="nav-item px-2">
                                    <a href="mailto:support@example.com"><i class="fas fa-envelope"></i> support@example.com</a>
                                </li>
                            </ul>
                        </div>
                    </div>

                    <div class="col-xl-6 col-lg-6 col-md-2 d-none d-lg-block col-sm-12">
                        <div class="icon right-icon">
                            <ul class="nav justify-content-end">
                                <li class="nav-item align-items-center d-flex">
                                    <select class="select-control form-select" onchange="switch_language(this.value)">
                                        <option value="english">English</option>
                                        <option value="vietnamese" selected>Vietnamese</option>
                                    </select>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Main Navbar -->
        <section class="menu-area bg-white box-shadow">
            <div class="container-xl">
                <nav class="navbar navbar-expand-lg navbar-light">
                    <ul class="mobile-header-buttons">
                        <li><a class="mobile-nav-trigger" href="#mobile-primary-nav">Menu<span></span></a></li>
                        <li><a class="mobile-search-trigger" href="#mobile-search">Search<span></span></a></li>
                    </ul>

                    <a href="${pageContext.request.contextPath}/" class="navbar-brand pt-2 mt-1">
                        <img src="assets/logo.png" alt="" height="60">
                    </a>

                    <div class="main-nav-wrap">
                        <div class="mobile-overlay"></div>
                        <ul class="mobile-main-nav">
                            <div class="mobile-menu-helper-top"></div>
                            <li class="has-children text-nowrap fw-bold">
                                <a href="#" class="nav-link header-dropdown px-3 text-nowrap" id="navbarDropdown1">
                                    <i class="fas fa-bars text-16px"></i>
                                    <span class="fw-500">Danh mục</span>
                                    <span class="has-sub-category"><i class="fas fa-angle-right"></i></span>
                                </a>
                                <ul class="category corner-triangle top-left is-hidden pb-0">
                                    <li class="all-category-devided mb-0 p-0">
                                        <a href="#" class="py-3">
                                            <span class="icon"><i class="fas fa-book"></i></span>
                                            <span>Khóa học</span>
                                        </a>
                                    </li>
                                    <li class="all-category-devided mb-0 p-0">
                                        <a href="#" class="py-3">
                                            <span class="icon"><i class="fas fa-blog"></i></span>
                                            <span>Blog</span>
                                        </a>
                                    </li>
                                </ul>
                            </li>
                            <div class="mobile-menu-helper-bottom"></div>
                        </ul>
                    </div>

                    <!-- Search Box -->
                    <form class="inline-form me-2" action="${pageContext.request.contextPath}/search" method="get" style="width: 100%;">
                        <div class="input-group search-box mobile-search">
                            <input type="text" name="query" class="form-control" placeholder="Tìm kiếm các khóa học">
                            <div class="input-group-append">
                                <button class="btn" type="submit"><i class="fas fa-search"></i></button>
                            </div>
                        </div>
                    </form>

                    <!-- User Menu -->
                    <div class="instructor-box menu-icon-box d-none d-lg-block">
                        <div class="icon">
                            <a href="${pageContext.request.contextPath}/my-courses" style="border: 1px solid transparent; margin: 0px; padding: 0px 10px; font-size: 14px; width: max-content; border-radius: 5px; height: 40px; line-height: 40px;">Khóa học của tôi</a>
                        </div>
                    </div>

                    <!-- Wishlist -->
                    <div class="wishlist-box menu-icon-box">
                        <div class="icon">
                            <a href="${pageContext.request.contextPath}/wishlist"><i class="far fa-heart"></i></a>
                            <span class="number">0</span>
                        </div>
                    </div>

                    <!-- Cart -->
                    <div class="cart-box menu-icon-box">
                        <div class="icon">
                            <a href="${pageContext.request.contextPath}/cart"><i class="fas fa-shopping-cart"></i></a>
                            <span class="number">0</span>
                        </div>
                    </div>

                    <!-- User Profile -->
                    <div class="user-box menu-icon-box">
                        <div class="icon">
                            <a href="javascript:;">
                                <img src="https://static.vecteezy.com/system/resources/previews/000/574/512/original/vector-sign-of-user-icon.jpg" alt="" class="img-fluid">
                            </a>
                        </div>
                        <div class="dropdown user-dropdown corner-triangle top-right radius-10">
                            <ul class="user-dropdown-menu radius-10">
                                <li class="dropdown-user-info">
                                    <a href="javascript:;" class="radius-top-10">
                                        <div class="clearfix">
                                            <div class="user-image float-start">
                                                <img src="${user.avatarUrl != null ? user.avatarUrl : 'assets/images/default-avatar.png'}" 
                     alt="Profile" class="profile-pic">
                                            </div>
                                            <div class="user-details">
                                                <div class="user-name">
                                                    <span class="hi">Xin chào,</span>
                                                    ${user.email}
                                                </div>
                                                <div class="user-email">
                                                    <span class="email">${user.firstName} ${user.lastName}</span>
                                                    <span class="welcome">chào mừng trở lại</span>
                                                </div>
                                            </div>
                                        </div>
                                    </a>
                                </li>
                                <li class="user-dropdown-menu-item"><a href="${pageContext.request.contextPath}/my-courses"><i class="far fa-gem"></i>Khóa học của tôi</a></li>
                                <li class="user-dropdown-menu-item"><a href="${pageContext.request.contextPath}/wishlist"><i class="far fa-heart"></i>Khóa học yêu thích</a></li>
                                <li class="user-dropdown-menu-item"><a href="${pageContext.request.contextPath}/messages"><i class="far fa-envelope"></i>Tin nhắn của tôi</a></li>
                                <li class="user-dropdown-menu-item"><a href="${pageContext.request.contextPath}/purchase-history"><i class="fas fa-shopping-cart"></i>Lịch sử mua hàng</a></li>
                                <li class="user-dropdown-menu-item"><a href="${pageContext.request.contextPath}/profile"><i class="fas fa-user"></i>Hồ sơ người dùng</a></li>
                                <li class="dropdown-user-logout user-dropdown-menu-item radius-bottom-10"><a href="${pageContext.request.contextPath}/logout" class="radius-bottom-10 py-3"><i class="fas fa-sign-out-alt"></i> Đăng xuất</a></li>
                            </ul>
                        </div>
                    </div>
                </nav>
            </div>
        </section>

        <!-- Banner Section -->
        <section class="home-banner-area py-5">
            <div class="container">
                <div class="row align-items-center">
                    <div class="col-md-6">
                        <h1>Learn From The Best</h1>
                        <p>Explore thousands of courses with the best instructors</p>
                    </div>
                    <div class="col-md-6">
                        <img src="assets/banner-image.jpg" class="img-fluid" alt="Banner">
                    </div>
                </div>
            </div>
        </section>

        <!-- Latest Courses Section -->
        <section class="py-5">
            <div class="container">
                <h2 class="mb-4">Latest Courses</h2>
                <div class="row">
                    <c:forEach items="${latestCourses}" var="course">
                        <div class="col-md-3 mb-4">
                            <div class="card">
                                <img src="${course.thumbnailUrl}" class="card-img-top" alt="${course.title}">
                                <div class="card-body">
                                    <h5 class="card-title">${course.title}</h5>
                                    <p class="card-text">${course.description}</p>
                                    <div class="d-flex justify-content-between align-items-center">
                                        <span class="price">$${course.price}</span>
                                    </div>
                                    <!-- Inside the course card -->
                                    <div class="w-100 d-flex text-dark border-top py-1">
                                        <div class="">
                                            <i class="fas fa-book text-14px"></i>
                                            <span class="text-muted text-12px">${course.lessonCount} Bài học</span>
                                        </div>
                                        <div class="ms-auto">
                                            <i class="fas fa-user-graduate text-14px"></i>
                                            <span class="text-muted text-12px">${course.enrollmentCount} Học viên</span>
                                        </div>
                                        <button class="btn btn-primary btn-sm add-to-cart" data-course-id="${course.id}">
                                            <i class="fas fa-cart-plus"></i> Add to Cart
                                        </button>
                                    </div>

                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </section>

        <!-- Hot Courses Section -->
        <section class="py-5 bg-light">
            <div class="container">
                <h2 class="mb-4">Most Popular Courses</h2>
                <div class="row">
                    <c:forEach items="${hotCourses}" var="course">
                        <div class="col-md-3 mb-4">
                            <div class="card">
                                <img src="${course.thumbnailUrl}" class="card-img-top" alt="${course.title}">
                                <div class="card-body">
                                    <h5 class="card-title">${course.title}</h5>
                                    <p class="card-text">${course.description}</p>
                                    <div class="d-flex justify-content-between align-items-center">
                                        <span class="price">$${course.price}</span>
                                    </div>
                                    <!-- Inside the course card -->
                                    <div class="w-100 d-flex text-dark border-top py-1">
                                        <div class="">
                                            <i class="fas fa-book text-14px"></i>
                                            <span class="text-muted text-12px">${course.lessonCount} Bài học</span>
                                        </div>
                                        <div class="ms-auto">
                                            <i class="fas fa-user-graduate text-14px"></i>
                                            <span class="text-muted text-12px">${course.enrollmentCount} Học viên</span>
                                        </div>
                                    </div>
                                    <button class="btn btn-primary btn-sm add-to-cart" data-course-id="${course.id}">
                                        <i class="fas fa-cart-plus"></i> Add to Cart
                                    </button>    
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </section>

        <!-- After Hot Courses Section -->
        <section class="py-5">
            <div class="container">
                <h2 class="mb-4">Latest Blogs</h2>
                <div class="row">
                    <c:forEach items="${latestBlogs}" var="blog">
                        <div class="col-md-4 mb-4">
                            <div class="card">
                                <div class="card-body">
                                    <h5 class="card-title">${blog.title}</h5>
                                    <p class="card-text">${blog.content}</p>
                                    <div class="d-flex justify-content-between align-items-center">
                                        <small class="text-muted">Posted on ${blog.createdAt}</small>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </section>

        <!-- Footer -->
        <footer class="bg-dark text-light py-4">
            <div class="container">
                <!-- Add footer content -->
            </div>
        </footer>

        <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
    </body>
</html>



