<%-- 
    Document   : teacherDashboard
    Created on : Apr 23, 2025, 1:50:06 AM
    Author     : ASUS
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <title>Teacher Dashboard</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

        <!-- Boxicons + FontAwesome -->
        <link href="https://unpkg.com/boxicons@latest/css/boxicons.min.css" rel="stylesheet">
    </head>
    <body onload="time()">

        <!-- Navbar -->
        <nav class="navbar navbar-expand-lg navbar-dark bg-primary">
            <div class="container-fluid">
                <a class="navbar-brand" href="#">Teacher Dashboard</a>
                <div class="d-flex">
                    <a class="btn btn-outline-light" href="login?action=logout"><i class='bx bx-log-out bx-rotate-180'></i> Logout</a>
                </div>
            </div>
        </nav>

        <div class="container-fluid">
            <div class="row">
                <!-- Sidebar -->
                <div class="col-md-3 sidebar p-4">
                    <div class="text-center mb-4">
                        <img src="admin/images/user.png" class="rounded-circle" width="80" alt="User Image">
                        <h5 class="mt-3">${sessionScope.user.lastName}</h5>
                        <p class="text-muted">Giáo viên</p>
                    </div>
                        <ul class="nav flex-column">
                        <li class="nav-item">
                            <a class="nav-link" href="teacher/profile">
                                <i class="bi bi-house-door"></i> Thông tin giáo viên
                            </a>
                        </li>
                    <ul class="nav flex-column">
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
<!--                        <li class="nav-item">
                            <a class="nav-link" href="QuizController?action=manageQuiz">
                                <i class="bi bi-clipboard-check"></i> Quản lý bài kiểm tra
                            </a>
                        </li>-->
                        <li class="nav-item">
                            <a class="nav-link" href="feedback">
                                <i class="bi bi-chat-dots"></i> Phản hồi
                            </a>
                        </li>
                    </ul>
                </div>

                <!-- Main Content -->
                <main class="col-md-9 p-4">
                    <div class="d-flex justify-content-between align-items-center mb-4">
                        <h4>Bảng điều khiển</h4>
                        <div id="clock" class="text-muted"></div>
                    </div>

                    <div class="row g-4">
                        <div class="col-md-6">
                            <div class="card border-primary">
                                <div class="card-body">
                                    <h5 class="card-title"><i class='bx bxs-user-account'></i> Tổng học viên: ${totalLearner}</h5>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="card border-info">
                                <div class="card-body">
                                    <h5 class="card-title"><i class='bx bxs-book'></i>Tổng khóa học đã tạo: ${totalCourses}</h5>
                                </div>
                            </div>
                        </div>
                        <!-- More widgets if needed -->
                    </div>

                    <div class="mt-5">
                        <h5>Danh sách đơn đăng ký hôm nay</h5>
                        <table class="table table-striped">
                            <thead class="table-light">
                                <tr>
                                    <th>Họ tên</th>
                                    <th>Email</th>
                                    <th>Giới tính</th>
                                    <th>Khóa học</th>
                                    <th>Trạng thái</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${enrollments}" var="b">
                                    <tr>
                                        <td>${b.getFullName()}</td>
                                        <td>${b.email}</td>
                                        <td>${b.genderName}</td>
                                        <td>${b.courseTitle}</td>
                                        <td>${b.enrollmentStatus}</td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>

                    <footer class="text-center mt-4">
                        <p class="text-muted small">
                            &copy; <script>document.write(new Date().getFullYear());</script> Online Learning Platform
                        </p>
                    </footer>
                </main>
            </div>
        </div>

        <!-- Scripts -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
        <script>
                                function time() {
                                    const today = new Date();
                                    const weekdays = ["Chủ Nhật", "Thứ Hai", "Thứ Ba", "Thứ Tư", "Thứ Năm", "Thứ Sáu", "Thứ Bảy"];
                                    const day = weekdays[today.getDay()];
                                    const date = today.toLocaleDateString('vi-VN');
                                    const time = today.toLocaleTimeString('vi-VN');
                                    document.getElementById("clock").innerHTML = `${day}, ${date} - ${time}`;
                                            setTimeout(time, 1000);
                                        }
        </script>
    </body>
</html>

