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
            .hero-banner {
                background: linear-gradient(to right, #1a1a1a, #292929);
                min-height: 580px;
                display: flex;
                align-items: center;
            }

            .hero-banner h1 {
                font-size: 3.2rem;
                line-height: 1.2;
            }

            .banner-stats {
                color: #a1a1a1;
            }

            .banner-stats h3 {
                color: #ffffff;
                font-size: 2.4rem;
            }

            .btn-primary {
                background-color: #2877FA;
                border-color: #2877FA;
                padding: 12px 24px;
                font-weight: 600;
            }

            .btn-primary:hover {
                background-color: #1c5fd4;
                border-color: #1c5fd4;
            }

            @media (max-width: 768px) {
                .hero-banner {
                    min-height: auto;
                    padding: 60px 0;
                }

                .hero-banner h1 {
                    font-size: 2.4rem;
                }

                .banner-stats {
                    flex-direction: column;
                    gap: 20px;
                }
            }
            .hero-banner {
                background: linear-gradient(to right, #1d2b3a, #2d4b6e);
                min-height: 580px;
                display: flex;
                align-items: center;
            }

            .card {
                height: 100%;
                display: flex;
                flex-direction: column;
            }

            .card-img-top {
                width: 100%;
                height: 200px;
                object-fit: cover;
            }

            .card-body {
                flex: 1;
                display: flex;
                flex-direction: column;
            }

            .card-title {
                font-size: 1.1rem;
                font-weight: 600;
                margin-bottom: 0.75rem;
                height: 2.4rem;
                overflow: hidden;
                display: -webkit-box;
                -webkit-line-clamp: 2;
                -webkit-box-orient: vertical;
            }

            .card-text {
                flex: 1;
                margin-bottom: 1rem;
                overflow: hidden;
                display: -webkit-box;
                -webkit-line-clamp: 3;
                -webkit-box-orient: vertical;
            }

            .swiper-slide {
                height: auto;
            }

            /* Adjust card footer spacing */
            .card-footer {
                background: none;
                border-top: none;
                padding-top: 0.5rem;
            }
            .hero-banner {
                background: linear-gradient(to right, #1d2b3a, #2d4b6e);
                min-height: 400px; /* Reduced from 580px */
                display: flex;
                align-items: center;
                padding: 40px 0; /* Added padding */
            }

            .hero-banner h1 {
                font-size: 2.5rem; /* Reduced from 3.2rem */
                line-height: 1.2;
            }

            .banner-stats h3 {
                color: #ffffff;
                font-size: 2rem; /* Reduced from 2.4rem */
            }

            @media (max-width: 768px) {
                .hero-banner {
                    min-height: 300px; /* Reduced for mobile */
                    padding: 30px 0;
                }

                .hero-banner h1 {
                    font-size: 2rem;
                }
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
        <div class="swiper bannerSwiper">
            <div class="swiper-wrapper">
                <!-- Banner 1 -->
                <div class="swiper-slide">
                    <section class="hero-banner py-5" style="background-color: #1d2b3a;">
                        <div class="container">
                            <div class="row align-items-center">
                                <div class="col-lg-6 text-white">
                                    <h1 class="display-4 fw-bold mb-4">Learn Anytime Anywhere</h1>
                                    <p class="lead mb-4">
                                        Explore hundreds of quality courses with experienced instructors.
                                    </p>
                                    <div class="banner-stats d-flex gap-4 mb-4">
                                        <div class="stat-item">
                                            <h3 class="fw-bold mb-0">2.000+</h3>
                                            <p class="mb-0">Student</p>
                                        </div>
                                        <div class="stat-item">
                                            <h3 class="fw-bold mb-0">1.900+</h3>
                                            <p class="mb-0">Employed people</p>
                                        </div>
                                    </div>
                                    <a href="${pageContext.request.contextPath}/CourseController" class="btn btn-primary btn-lg">
                                        Start learning now
                                    </a>
                                </div>
                                <div class="col-lg-6">
                                    <img src="https://files.fullstack.edu.vn/f8-prod/banners/Banner_web_ReactJS.png" 
                                         alt="Learning Programming" class="img-fluid">
                                </div>
                            </div>
                        </div>
                    </section>
                </div>

                <!-- Banner 2 -->
                <div class="swiper-slide">
                    <section class="hero-banner py-5" style="background: linear-gradient(to right, #2d1d3a, #4b2d6e);">
                        <div class="container">
                            <div class="row align-items-center">
                                <div class="col-lg-6 text-white">
                                    <h1 class="display-4 fw-bold mb-4">Discover Knowledge, Station to Dreams</h1>
                                    <p class="lead mb-4">
                                        Join the online learning community and improve your skills today.
                                    </p>
                                    <a href="${pageContext.request.contextPath}/CourseController" class="btn btn-primary btn-lg">
                                        Start learning now
                                    </a>
                                </div>
                                <div class="col-lg-6">
                                    <img src="https://files.fullstack.edu.vn/f8-prod/banners/Banner_01_2.png" 
                                         alt="New Technology" class="img-fluid">
                                </div>
                            </div>
                        </div>
                    </section>
                </div>

                <!-- Banner 3 -->
                <div class="swiper-slide">
                    <section class="hero-banner py-5" style="background: linear-gradient(to right, #1d3a2d, #2d6e4b);">
                        <div class="container">
                            <div class="row align-items-center">
                                <div class="col-lg-6 text-white">
                                    <h1 class="display-4 fw-bold mb-4">Hot Courses Are Waiting For You!</h1>
                                    <p class="lead mb-4">
                                        Top rated courses from top instructors.
                                    </p>
                                    <a href="${pageContext.request.contextPath}/CourseController" class="btn btn-primary btn-lg">
                                        Start learning now
                                    </a>
                                </div>
                                <div class="col-lg-6">
                                    <img src="https://files.fullstack.edu.vn/f8-prod/banners/Banner_03_youtube.png" 
                                         alt="Learning Path" class="img-fluid">
                                </div>
                            </div>
                        </div>
                    </section>
                </div>
            </div>
            <div class="swiper-pagination"></div>
            <div class="swiper-button-next"></div>
            <div class="swiper-button-prev"></div>
        </div>

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
            new Swiper('.bannerSwiper', {
                slidesPerView: 1,
                spaceBetween: 0,
                loop: true,
                autoplay: {
                    delay: 5000,
                    disableOnInteraction: false,
                },
                pagination: {
                    el: '.swiper-pagination',
                    clickable: true
                },
                navigation: {
                    nextEl: '.swiper-button-next',
                    prevEl: '.swiper-button-prev',
                }
            });
        </script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>



