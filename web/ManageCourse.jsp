<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>List of Courses</title>
        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Bootstrap Icons -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
        <style>
            .sidebar {
                min-height: 100vh;
                background-color: #f8f9fa;
                border-right: 1px solid #dee2e6;
            }
            .sidebar .nav-link {
                color: #333;
                font-weight: 500;
                padding: 10px 15px;
                border-radius: 8px;
                transition: background 0.3s, color 0.3s;
            }
            .sidebar .nav-link:hover {
                background-color: #e2e6ea;
                color: #007bff;
            }
            .sidebar .nav-link i {
                margin-right: 8px;
            }
            .card img {
                height: 200px;
                object-fit: cover;
            }
        </style>
    </head>
    <body>

        <div class="container-fluid">
            <div class="row">
                <!-- Navbar -->
                <nav class="navbar navbar-expand-lg navbar-dark bg-primary">
                    <div class="container-fluid">
                        <a class="navbar-brand" href="#">Teacher Dashboard</a>
                        <div class="d-flex">
                            <a class="btn btn-outline-light" href="login?action=logout"><i class='bx bx-log-out bx-rotate-180'></i> Logout</a>
                        </div>
                    </div>
                </nav>

                <!-- Sidebar -->
                <div class="col-md-3 bg-light p-4 shadow-sm rounded-end">
                    <div class="text-center mb-4">
                        <img src="admin/images/user.png" class="rounded-circle mb-2 border border-2" width="100" alt="User Image">
                        <h5 class="mb-0">${sessionScope.user.lastName}</h5>
                        <small class="text-muted">Teacher</small>
                    </div>

                    <div class="list-group">
                        <a href="teacher/profile" class="list-group-item list-group-item-action d-flex align-items-center">
                            <i class="bi bi-person me-2"></i> Teacher Profile
                        </a>
                        <a href="TeacherDashboard" class="list-group-item list-group-item-action d-flex align-items-center">
                            <i class="bi bi-speedometer2 me-2"></i> Dashboard
                        </a>
                        <a href="CourseController?action=manageCourse" class="list-group-item list-group-item-action d-flex align-items-center">
                            <i class="bi bi-journal-bookmark me-2"></i> Manage Courses
                        </a>
                        <a href="LessonController?action=manageLesson" class="list-group-item list-group-item-action d-flex align-items-center">
                            <i class="bi bi-book me-2"></i> Manage Lessons
                        </a>
                    </div>
                </div>



                <!-- Main content -->
                <div class="col-md-9 p-5">
                    <h1 class="text-center mb-5">List of Courses</h1>

                    <!-- Nếu role là Teacher thì hiện nút Add Course -->
                    <c:if test="${sessionScope.user.roleId == 2}">
                        <div class="mb-4 text-end">
                            <a href="AddCourse.jsp" class="btn btn-success">
                                <i class="bi bi-plus-circle"></i> Add New Course
                            </a>
                        </div>
                    </c:if>

                    <!-- Nếu role là Teacher thì hiện nút Add Course 
                    <c:if test="${sessionScope.user.roleId == 2}">
                        <div class="mb-4 text-end">
                            <a href="AddLesson.jsp" class="btn btn-success">
                                <i class="bi bi-plus-circle"></i> Add New Lesson
                            </a>
                        </div>
                    </c:if>
                    -->
                    <!-- Danh sách khóa học -->
                    <div class="row row-cols-1 row-cols-md-2 row-cols-lg-3 g-4">
                        <c:forEach items="${courseList}" var="course">
                            <div class="col">
                                <div class="card h-100 shadow-sm">
                                    <img src="${course.thumbnailUrl}" class="card-img-top" alt="${course.title}">
                                    <div class="card-body">
                                        <h5 class="card-title">${course.title}</h5>

                                        <!-- Giá và trạng thái -->
                                        <div class="d-flex justify-content-between align-items-center mb-2">
                                            <span class="text-muted">Price: ${course.price}$</span>
                                        </div>

                                        <div class="d-flex justify-content-between align-items-center">
                                            <span class="text-muted">
                                                ${course.status}
                                            </span>
                                            <small class="text-muted">
                                                <fmt:formatDate value="${course.createdAt}" pattern="dd/MM/yyyy" />
                                            </small>
                                        </div>
                                    </div>

                                    <div class="card-footer d-flex justify-content-between">
                                        <c:if test="${sessionScope.user.roleId == 2}">
                                            <a href="CourseController?action=editCourse&courseId=${course.id}" class="btn btn-warning w-50">
                                                <i class="bi bi-pencil-square"></i> Edit
                                            </a>
                                        </c:if>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </div>

            </div>
        </div>


        <!-- Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>

    </body>
</html>
