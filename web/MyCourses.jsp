<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>My Courses</title>
        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

    </head>
    <body class="bg-light">
        <!-- Header -->
        <%@ include file="/layout/header.jsp" %>
        <div class="container mt-5">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h1 class="text-primary">My Courses</h1>

            </div>

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
                                            <span class="badge
                                                  ${course.status == 'Completed' ? 'bg-success' : 'bg-warning text-dark'}">
                                                ${course.status}
                                            </span>
                                        </td>
                                        <td class="text-center">
                                            <a href="LessonController?courseId=${course.id}" class="btn btn-sm btn-outline-primary">
                                                View lesson
                                            </a>
                                        </td>
                                        <td class="text-center">
                                            <a href="LessonController?action=myQuizHistory&courseId=${course.id}" class="btn btn-sm btn-outline-primary">
                                                View quiz history
                                            </a>
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
            <a href="home" class="btn btn-outline-secondary">
                    ⬅ Back to Homepage
                </a>
        </div>
        <!-- Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
        <!-- Bootstrap JS (Optional) -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
