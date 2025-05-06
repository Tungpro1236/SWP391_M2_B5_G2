<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>My Courses</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            min-height: 100vh;
        }
        .sidebar {
            background-color: #f8f9fa;
            min-height: 100%;
            padding-top: 1rem;
        }
        .sidebar a {
            display: block;
            padding: 10px 15px;
            color: #000;
            text-decoration: none;
        }
        .sidebar a:hover, .sidebar .active {
            background-color: #e9ecef;
            font-weight: 500;
        }
    </style>
</head>
<body class="bg-light">
    <!-- Header -->
    <%@ include file="/layout/header.jsp" %>

    <div class="container-fluid">
        <div class="row">
            <!-- Sidebar -->
            <div class="col-md-3 sidebar">
                <div class="text-center mb-3">
                    <img src="${user.avatarUrl != null ? user.avatarUrl : 'assets/images/default-avatar.png'}" 
                         alt="Profile" class="rounded-circle mb-2" width="100" height="100">
                    <h5>${user.firstName} ${user.lastName}</h5>
                </div>
                <a href="profile" class="${pageContext.request.requestURI.endsWith('profile') ? 'active' : ''}">Profile</a>
                <a href="password" class="${pageContext.request.requestURI.contains('password') ? 'active' : ''}">Change Password</a>
                <a href="CourseController?action=myCourse" class="${pageContext.request.requestURI.contains('myCourse') ? 'active' : ''}">Course and Exercise</a>
                <a href="#">Wishlist</a>
                <a href="#">Order History</a>
                <c:if test="${user.roleId == 3}">
                    <a href="${pageContext.request.contextPath}/student/refund">Refund Request</a>
                </c:if>
            </div>

            <!-- Main Content -->
            <div class="col-md-9 py-4">
                <c:choose>
                    <c:when test="${not empty myCourses}">
                        <div class="table-responsive shadow rounded">
                            <table class="table table-bordered table-striped table-hover align-middle bg-white">
                                <thead class="table-primary text-center">
                                    <tr>
                                        <th>Title</th>
                                        <th>Description</th>
                                        <th>Status</th>
                                        <th>View lesson</th>
                                        <th>View quiz history</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="course" items="${myCourses}">
                                        <tr>
                                            <td>${course.title}</td>
                                            <td>${course.description}</td>
                                            <td>
                                                <span class="badge ${course.status == 'Completed' ? 'bg-success' : 'bg-warning text-dark'}">
                                                    ${course.status}
                                                </span>
                                            </td>
                                            <td class="text-center">
                                                <a href="LessonController?courseId=${course.id}" class="btn btn-sm btn-outline-primary">View lesson</a>
                                            </td>
                                            <td class="text-center">
                                                <a href="LessonController?action=myQuizHistory&courseId=${course.id}" class="btn btn-sm btn-outline-primary">View quiz history</a>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="alert alert-info text-center" role="alert">
                            No courses found.
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>

        <!-- Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
