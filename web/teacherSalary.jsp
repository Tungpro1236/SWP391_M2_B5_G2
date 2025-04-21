<%-- 
    Document   : teacherSalary
    Created on : Apr 21, 2025, 1:12:57 AM
    Author     : regio
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="vn.edu.fpt.model.Salary" %>
<html>
    <head>
        <title>Teacher Salaries</title>
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
            .search-card {
                transition: box-shadow 0.3s;
            }
            .search-card:hover {
                box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2) !important;
            }
            .table-row {
                transition: transform 0.2s, box-shadow 0.2s;
            }
            .table-row:hover {
                transform: translateY(-2px);
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            }
            .btn-details {
                transition: transform 0.2s, background-color 0.3s;
            }
            .btn-details:hover {
                transform: scale(1.05);
                background-color: #0d6efd;
            }
        </style>
    </head>
    <body>
        <!-- Navbar -->
        <%@ include file="/layout/header.jsp" %>

        <div class="container mt-5">
            <h1 class="mb-4 text-primary fw-bold">Teacher Salaries</h1>

            <!-- Ensure salaryList is not null -->
            <%
                List<Salary> salaryList = (List<Salary>) request.getAttribute("salaryList");
                if (salaryList == null) {
                    salaryList = new ArrayList<>();
                }
            %>

            <!-- Form tìm kiếm -->
            <div class="card search-card shadow-sm rounded-3 mb-4">
                <div class="card-body">
                    <form class="row g-3 align-items-center" action="ViewTeacherSalary" method="GET">
                        <div class="col-auto">
                            <div class="input-group">
                                <span class="input-group-text"><i class="bi bi-search"></i></span>
                                <input type="text" name="keyword" value="<%= request.getParameter("keyword") != null ? request.getParameter("keyword") : "" %>" class="form-control" placeholder="Search by name">
                            </div>
                        </div>
                        <div class="col-auto">
                            <button type="submit" class="btn btn-primary">Search</button>
                        </div>
                        <div class="col-auto">
                            <button type="reset" class="btn btn-outline-secondary">Reset</button>
                        </div>
                    </form>
                </div>
            </div>

            <!-- Thông báo nếu không có dữ liệu -->
            <% if (salaryList.isEmpty()) { %>
            <div class="alert alert-info shadow-sm rounded-3" role="alert">
                No data found.
            </div>
            <% } %>

            <!-- Bảng dữ liệu -->
            <div class="table-responsive">
                <table class="table table-striped table-bordered table-hover">
                    <thead class="table-dark">
                        <tr>
                            <th>Teacher ID</th>
                            <th>Name</th>
                            <th>Payment Status</th>
                            <th>Month</th>
                            <th>Year</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for (Salary s : salaryList) { %>
                        <tr class="table-row">
                            <td><span class="badge bg-info text-dark"><%= s.getTeacherId() != 0 ? s.getTeacherId() : "N/A" %></span></td>
                            <td Brandt: text/html><%= s.getTeacherName() != null ? s.getTeacherName() : "" %></td>
                            <td>
                                <% if (s.getPaid() == 1) { %>
                                <span class="badge bg-success">Paid</span>
                                <% } else if (s.getPaid() == 0) { %>
                                <span class="badge bg-danger">not Paid</span>
                                <% } else { %>
                                <span class="badge bg-secondary">Unknown</span>
                                <% } %>
                            </td>
                            <td><%= s.getMonth() != null ? s.getMonth() : "" %></td>
                            <td><%= s.getYear() %></td>
                            <td>
                                <% if (s.getTeacherId() != 0) { %>
                                <a href="TeacherSalaryDetail?teacherId=<%= s.getTeacherId() %>" class="btn btn-info btn-sm btn-details">Details</a>
                                <% } else { %>
                                <span class="text-muted">N/A</span>
                                <% } %>
                            </td>
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
