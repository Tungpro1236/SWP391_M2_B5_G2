<%-- 
    Document   : ListCourse
    Created on : Apr 17, 2025, 11:23:43 PM
    Author     : Admin
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>List of Courses</title>
        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Bootstrap Icons -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
        <style>
            body {
                background-color: #f8f9fa;
            }
            .navbar {
                background-color: #343a40;
            }
            .navbar-brand {
                color: white;
            }
            .navbar-brand:hover {
                color: #ddd;
            }
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
            .course-image {
                height: 200px;
                object-fit: cover;
                border-radius: 0.5rem 0.5rem 0 0;
            }
            .category-section {
                margin-bottom: 30px;
            }
            .pagination .page-link {
                color: #007bff;
            }
            .pagination .page-item.active .page-link {
                background-color: #007bff;
                border-color: #007bff;
                color: white;
            }
        </style>
    </head>
    <body>
        <!-- Header -->
        <%@ include file="/layout/header.jsp" %>

        <div class="container py-5">
            <h1 class="text-center mb-5">List of Courses</h1>

            <!-- Phần lọc theo danh mục -->
            <div class="category-section">
                <h4 class="mb-3">Filter by Semester:</h4>
                <form action="CourseController" method="get">
                    <div class="input-group">
                        <select name="categoryId" class="form-select" onchange="this.form.submit()">
                            <option value="">All Courses</option>
                            <c:forEach items="${categoryList}" var="category">
                                <option value="${category.id}" ${param.categoryId eq category.id ? 'selected' : ''}>
                                    ${category.semester}
                                </option>
                            </c:forEach>
                        </select>
                    </div>
                    <input type="hidden" name="page" value="${currentPage}">
                </form>
            </div>

            <!-- Tiêu đề danh mục đã chọn -->
            <c:if test="${not empty selectedCategory}">
                <h2 class="mb-4">Khóa học ${selectedCategory.semester}</h2>
            </c:if>
            <c:if test="${empty selectedCategory and empty param.categoryId}">
                <h2 class="mb-4">All Courses</h2>
            </c:if>

            <!-- Danh sách khóa học -->
            <div class="row row-cols-1 row-cols-md-2 row-cols-lg-3 g-4">
                <c:forEach items="${courseList}" var="course">
                    <div class="col">
                        <div class="card course-card h-100">
                            <img src="${course.thumbnailUrl}" class="card-img-top course-image" alt="${course.title}">
                            <div class="card-body">
                                <h5 class="card-title">${course.title}</h5>
                                <p class="card-text">${course.description}</p>

                                <!-- Hiển thị thông tin học kỳ -->
                                <c:forEach items="${categoryList}" var="category">
                                    <c:if test="${category.id eq course.categoryId}">
                                        <span class="badge bg-info mb-2">Học kỳ: ${category.semester}</span>
                                    </c:if>
                                </c:forEach>

                                <!-- Hiển thị price -->
                                <div class="d-flex justify-content-between align-items-center mt-3">
                                    <small class="text-muted">Price: ${course.price}$</small>
                                </div>

                                <!-- Hiển thị trạng thái -->
                                <div class="d-flex justify-content-between align-items-center mt-3">
                                    <span class="badge bg-${course.status eq 'active' ? 'success' : 'danger'}">
                                        ${course.status eq 'active' ? 'Đang hoạt động' : 'Không hoạt động'}
                                    </span>
                                    <small class="text-muted">Ngày tạo: <fmt:formatDate value="${course.createdAt}" pattern="dd/MM/yyyy" /> </small>
                                </div>
                            </div>
                            <div class="card-footer">
                                <a href="LessonController?courseId=${course.id}" class="btn btn-primary w-100">Xem chi tiết</a>
                            </div>
                        </div>
                    </div>
                </c:forEach>

                <!-- Hiển thị thông báo nếu không có khóa học nào -->
                <c:if test="${empty courseList}">
                    <div class="col-12 text-center">
                        <div class="alert alert-info">
                            Không có khóa học nào trong danh mục này.
                        </div>
                    </div>
                </c:if>
            </div>

            <!-- Phân trang -->
            <nav aria-label="Page navigation">
                <ul class="pagination justify-content-center">
                    <c:if test="${currentPage > 1}">
                        <li class="page-item">
                            <a class="page-link" href="CourseController?categoryId=${categoryId}&page=${currentPage - 1}" aria-label="Previous">
                                <span aria-hidden="true">&laquo;</span>
                            </a>
                        </li>
                    </c:if>

                    <c:forEach begin="1" end="${totalPages}" var="i">
                        <li class="page-item ${currentPage eq i ? 'active' : ''}">
                            <a class="page-link" href="CourseController?categoryId=${categoryId}&page=${i}">${i}</a>
                        </li>
                    </c:forEach>

                    <c:if test="${currentPage < totalPages}">
                        <li class="page-item">
                            <a class="page-link" href="CourseController?categoryId=${categoryId}&page=${currentPage + 1}" aria-label="Next">
                                <span aria-hidden="true">&raquo;</span>
                            </a>
                        </li>
                    </c:if>
                </ul>
            </nav>
        </div>
        <%@ include file="/layout/footer.jsp" %>
        <!-- Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>

