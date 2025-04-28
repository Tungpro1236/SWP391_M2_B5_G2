<%-- 
    Document   : teacherCourses
    Created on : Apr 21, 2025, 2:21:07 AM
    Author     : regio
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="vn.fpt.edu.model.Course" %>
<html>
    <head>
        <title>Teacher Courses</title>
        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
        <!-- Bootstrap Icons -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
        <style>
            .navbar-brand img {
                height: 40px;
            }
            .nav-link {
                transition: color 0.3s;
            }
            .nav-link:hover {
                color: #0d6efd !important;
            }
            .table-row {
                transition: transform 0.2s, box-shadow 0.2s;
            }
            .table-row:hover {
                transform: translateY(-2px);
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            }
        </style>
    </head>
    <body>
        <!-- Navbar -->
        <%@ include file="/layout/header.jsp" %>

        <div class="container mt-5">
            <h1 class="mb-4 text-primary fw-bold">Teacher Courses</h1>

            <!-- Ensure courseList is not null -->
            <%
                List<Course> courseList = (List<Course>) request.getAttribute("courseList");
                if (courseList == null) {
                    courseList = new ArrayList<>();
                }
            %>

            <!-- Thông báo nếu không có dữ liệu -->
            <% if (courseList.isEmpty()) { %>
            <div class="alert alert-info shadow-sm rounded-3" role="alert">
                No courses found.
            </div>
            <% } %>

            <!-- Bảng dữ liệu -->
            <div class="table-responsive">
                <table class="table table-striped table-bordered table-hover">
                    <thead class="table-dark">
                        <tr>
                            <th>Course ID</th>
                            <th>Course Name</th>
                            <th>Teacher Name</th>
                            <th>Schedule</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for (Course c : courseList) { %>
                        <tr class="table-row">
                            <td><span class="badge bg-info text-dark"><%= c.getCourseId() %></span></td>
                            <td><%= c.getCourseName() != null ? c.getCourseName() : "" %></td>
                            <td><%= c.getTeacherName() != null ? c.getTeacherName() : "" %></td>
                            <td><%= c.getSchedule() != null ? c.getSchedule() : "" %></td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
        </div>
        <%@ include file="/layout/footer.jsp" %>           
        <!-- Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
    </body>
</html>