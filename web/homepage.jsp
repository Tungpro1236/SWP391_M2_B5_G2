<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Online Learning Platform</title>
        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@10/swiper-bundle.min.css" />
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

            .swiper {
                padding: 20px 0;
            }
            .swiper-button-next, .swiper-button-prev {
                color: #0d6efd;
            }
            .swiper-pagination-bullet-active {
                background: #0d6efd;
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
        <jsp:include page="/layout/header.jsp" />

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
                <div class="swiper latestCoursesSwiper">
                    <div class="swiper-wrapper">
                        <c:forEach items="${latestCourses}" var="course">
                            <div class="swiper-slide">
                                <div class="card h-100">
                                    <img src="${course.thumbnailUrl}" class="card-img-top" alt="${course.title}">
                                    <div class="card-body">
                                        <h5 class="card-title">${course.title}</h5>
                                        <p class="card-text">${course.description}</p>
                                        <div class="d-flex justify-content-between align-items-center">
                                            <span class="price">$${course.price}</span>
                                        </div>
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
                                        <div class="card-footer">
                                            <a href="LessonController?courseId=${course.id}" class="btn btn-primary w-100">Xem chi tiết</a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                    <div class="swiper-pagination"></div>
                    <div class="swiper-button-next"></div>
                    <div class="swiper-button-prev"></div>
                </div>
        </section>

        <!-- Hot Courses Section -->
        <section class="py-5 bg-light">
            <div class="container">
                <h2 class="mb-4">Most Popular Courses</h2>
                <div class="swiper hotCoursesSwiper">
                    <div class="swiper-wrapper">
                        <c:forEach items="${hotCourses}" var="course">
                            <div class="swiper-slide">
                                <div class="card h-100">
                                    <!-- Same card content as Latest Courses -->
                                    <img src="${course.thumbnailUrl}" class="card-img-top" alt="${course.title}">
                                    <div class="card-body">
                                        <h5 class="card-title">${course.title}</h5>
                                        <p class="card-text">${course.description}</p>
                                        <div class="d-flex justify-content-between align-items-center">
                                            <span class="price">$${course.price}</span>
                                        </div>
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
                                        <div class="card-footer">
                                            <a href="LessonController?courseId=${course.id}" class="btn btn-primary w-100">Xem chi tiết</a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                    <div class="swiper-pagination"></div>
                    <div class="swiper-button-next"></div>
                    <div class="swiper-button-prev"></div>
                </div>
            </div>
        </section>

        <!-- Latest Blogs Section -->
        <section class="py-5">
            <div class="container">
                <h2 class="mb-4">Latest Blogs</h2>
                <div class="swiper blogsSwiper">
                    <div class="swiper-wrapper">
                        <c:forEach items="${latestBlogs}" var="blog">
                            <div class="swiper-slide">
                                <div class="card h-100">
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
                    <div class="swiper-pagination"></div>
                    <div class="swiper-button-next"></div>
                    <div class="swiper-button-prev"></div>
                </div>
            </div>
        </section>

        <jsp:include page="layout/footer.jsp" />

        <!-- Add before closing body tag -->
        <script src="https://cdn.jsdelivr.net/npm/swiper@10/swiper-bundle.min.js"></script>
        <script>
            const swiperConfig = {
                slidesPerView: 1,
                spaceBetween: 20,
                pagination: {
                    el: '.swiper-pagination',
                    clickable: true
                },
                navigation: {
                    nextEl: '.swiper-button-next',
                    prevEl: '.swiper-button-prev',
                },
                breakpoints: {
                    640: {
                        slidesPerView: 2,
                    },
                    768: {
                        slidesPerView: 3,
                    },
                    1024: {
                        slidesPerView: 5,
                    },
                }
            };

            new Swiper('.latestCoursesSwiper', swiperConfig);
            new Swiper('.hotCoursesSwiper', swiperConfig);
            new Swiper('.blogsSwiper', swiperConfig);
        </script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>



