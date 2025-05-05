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


                <!-- Main Content -->
                <main class="col-md-9 p-4">
                    <div class="d-flex justify-content-between align-items-center mb-4">
                        <h4>Dashboard</h4>
                        <div id="clock" class="text-muted"></div>
                    </div>

                    <div class="row g-4">
                        <div class="col-md-6">
                            <div class="card border-primary">
                                <div class="card-body">
                                    <h5 class="card-title"><i class='bx bxs-user-account'></i> Total Learners: ${totalLearner}</h5>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="card border-info">
                                <div class="card-body">
                                    <h5 class="card-title"><i class='bx bxs-book'></i> Total Courses Created: ${totalCourses}</h5>
                                </div>
                            </div>
                        </div>
                        <!-- More widgets if needed -->
                    </div>

                    <div class="mt-5">
                        <h5>Today's Enrollment List</h5>
                        <table class="table table-striped">
                            <thead class="table-light">
                                <tr>
                                    <th>Full Name</th>
                                    <th>Email</th>
                                    <th>Gender</th>
                                    <th>Course</th>
                                    <th>Status</th>
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

