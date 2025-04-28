<%@ page import="java.util.*, vn.edu.fpt.model.Course, vn.edu.fpt.model.Lesson, java.text.SimpleDateFormat" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>Manage Lessons</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    <link href="https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css" rel="stylesheet">
    <style>
        .sidebar {
            background-color: #f8f9fa;
            height: 100vh;
            position: fixed;
            width: 220px;
            top: 0;
            left: 0;
            padding-top: 60px;
            overflow-y: auto;
        }
        .sidebar .nav-link {
            color: #495057;
        }
        .sidebar .nav-link:hover {
            background-color: #e9ecef;
        }
        body {
            margin-left: 220px;
            background-color: #f5f5f5;
        }
        main {
            margin-top: 70px;
        }
    </style>
</head>
<body>

<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-dark bg-primary fixed-top">
    <div class="container-fluid">
        <a class="navbar-brand" href="#">Teacher Dashboard</a>
        <div class="d-flex">
            <a class="btn btn-outline-light" href="login?action=logout">
                <i class='bx bx-log-out bx-rotate-180'></i> Logout
            </a>
        </div>
    </div>
</nav>

<!-- Sidebar -->
<div class="sidebar">
    <div class="text-center mb-4">
        <img src="admin/images/user.png" class="rounded-circle" width="80" alt="User Image">
        <h5 class="mt-3">${sessionScope.user.lastName}</h5>
        <p class="text-muted">Giáo viên</p>
    </div>
    <ul class="nav flex-column px-2">
        <li class="nav-item">
            <a class="nav-link" href="TeacherDashboard">
                <i class="bi bi-house-door"></i> Bảng điều khiển
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="CourseController?action=manageCourse">
                <i class="bi bi-journal-bookmark"></i> Quản lý khóa học
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="LessonController?action=manageLesson">
                <i class="bi bi-people"></i> Quản lý bài học
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="feedback">
                <i class="bi bi-chat-dots"></i> Phản hồi
            </a>
        </li>
    </ul>
</div>

<!-- Main Content -->
<main class="container-fluid">
    <div class="px-4">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2>Danh sách bài học</h2>
            <c:if test="${sessionScope.user.roleId == 2}">
                <a href="AddLesson.jsp" class="btn btn-success">
                    <i class="bi bi-plus-circle"></i> Thêm bài học mới
                </a>
            </c:if>
        </div>

        <!-- Filter -->
        <form class="row g-3 mb-4" method="get" action="LessonController">
            <input type="hidden" name="action" value="manageLesson">
            <div class="col-auto">
                <label for="courseId" class="col-form-label">Lọc theo khóa học:</label>
            </div>
            <div class="col-auto">
                <select class="form-select" name="courseId" id="courseId" onchange="this.form.submit()">
                    <option value="">Tất cả khóa học</option>
                    <c:forEach items="${courses}" var="course">
                        <option value="${course.id}" ${selectedCourseId == course.id ? 'selected' : ''}>
                            ${course.title}
                        </option>
                    </c:forEach>
                </select>
            </div>
        </form>

        <!-- Lessons List -->
        <div class="row row-cols-1 row-cols-md-2 row-cols-lg-3 g-4">
            <c:forEach items="${lessons}" var="lesson">
                <div class="col">
                    <div class="card h-100 shadow-sm">
                        <div class="card-body d-flex flex-column">
                            <h5 class="card-title">${lesson.title}</h5>
                            <h6 class="card-subtitle mb-2 text-muted">Course ID: ${lesson.courseId}</h6>
                            <p class="card-text flex-grow-1">Content: ${lesson.content}</p>
                            <p class="card-text"><small class="text-muted">Video URL: ${lesson.vidURL}</small></p>
                            <p class="card-text"><small class="text-muted">Tạo ngày:
                                <fmt:formatDate value="${lesson.createdAt}" pattern="dd/MM/yyyy"/>
                            </small></p>
                            <a href="LessonController?action=editLesson&lessonId=${lesson.lessonId}" class="btn btn-warning mt-2">
                                <i class="bi bi-pencil-square"></i> Edit lesson
                            </a>
                            <a href="QuizController?action=manageQuiz&lessonId=${lesson.lessonId}" class="btn btn-warning mt-2">
                                <i class="bi bi-pencil-square"></i> Quiz Management 
                            </a>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>

    </div>
</main>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
