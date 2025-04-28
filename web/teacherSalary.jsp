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
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
        <style>
            body {
                background-color: #f8f9fa;
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                margin: 0;
                overflow-x: hidden;
            }
            .content {
                margin-left: 30px;
                padding: 20px;
                transition: margin-left 0.3s ease;
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
        <%@ include file="/layout/header.jsp" %>
        <%@ include file="/layout/sidebar.jsp" %>

        <!-- Main Content -->
        <div class="content">
            <div class="container-fluid">
                <h1 class="mb-4 text-primary fw-bold">Teacher Salaries</h1>

                <!-- Ensure salaryList is not null -->
                <%
                    List<Salary> salaryList = (List<Salary>) request.getAttribute("salaryList");
                    if (salaryList == null) {
                        salaryList = new ArrayList<>();
                    }
                %>

                <!-- Search Form -->
                <div class="card search-card shadow-sm rounded-3 mb-4">
                    <div class="card-body">
                        <form class="row g-3 align-items-center" action="viewTeacherSalary" method="GET">
                            <div class="col-auto">
                                <div class="input-group">
                                    <span class="input-group-text"><i class="bi bi-search"></i></span>
                                    <input type="text" name="keyword" value="${keyword}" class="form-control" placeholder="Search by name">
                                </div>
                            </div>
                            <div class="col-auto">
                                <button type="submit" class="btn btn-primary">Search</button>
                            </div>
                            <div class="col-auto">
                                <button type="reset" class="btn btn-outline-secondary" onclick="window.location.href='viewTeacherSalary'">Reset</button>
                            </div>
                        </form>
                    </div>
                </div>

                <!-- No Data Message -->
                <% if (salaryList.isEmpty()) { %>
                <div class="alert alert-info shadow-sm rounded-3" role="alert">
                    No data found.
                </div>
                <% } %>

                <!-- Data Table -->
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
                                <td><%= s.getTeacherName() != null ? s.getTeacherName() : "" %></td>
                                <td>
                                    <% if (s.getPaid() == 1) { %>
                                    <span class="badge bg-success">Paid</span>
                                    <% } else if (s.getPaid() == 0) { %>
                                    <span class="badge bg-danger">Not Paid</span>
                                    <% } else { %>
                                    <span class="badge bg-secondary">Unknown</span>
                                    <% } %>
                                </td>
                                <td><%= s.getMonth() != null ? s.getMonth() : "" %></td>
                                <td><%= s.getYear() %></td>
                                <td>
                                    <% if (s.getTeacherId() != 0) { %>
                                    <a href="teacherSalaryDetail?teacherId=<%= s.getTeacherId() %>" class="btn btn-info btn-sm btn-details">Details</a>
                                    <% } else { %>
                                    <span class="text-muted">N/A</span>
                                    <% } %>
                                </td>
                            </tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>

                <!-- Pagination Controls -->
                <% if (request.getAttribute("totalPages") != null && (int)request.getAttribute("totalPages") > 0) { %>
                <nav aria-label="Page navigation" class="mt-4">
                    <ul class="pagination justify-content-center">
                        <!-- Previous Button -->
                        <li class="page-item <%= (int)request.getAttribute("currentPage") == 1 ? "disabled" : "" %>">
                            <a class="page-link" href="viewTeacherSalary?page=<%= (int)request.getAttribute("currentPage") - 1 %>&keyword=${keyword}" aria-label="Previous">
                                <span aria-hidden="true">« Previous</span>
                            </a>
                        </li>

                        <!-- Page Numbers -->
                        <%
                            int currentPage = (int) request.getAttribute("currentPage");
                            int totalPages = (int) request.getAttribute("totalPages");
                            int startPage = Math.max(1, currentPage - 2);
                            int endPage = Math.min(totalPages, currentPage + 2);

                            if (endPage - startPage < 4) {
                                if (startPage == 1) {
                                    endPage = Math.min(totalPages, startPage + 4);
                                } else if (endPage == totalPages) {
                                    startPage = Math.max(1, endPage - 4);
                                }
                            }

                            for (int i = startPage; i <= endPage; i++) {
                        %>
                        <li class="page-item <%= currentPage == i ? "active" : "" %>">
                            <a class="page-link" href="viewTeacherSalary?page=<%= i %>&keyword=${keyword}"><%= i %></a>
                        </li>
                        <% } %>

                        <!-- Next Button -->
                        <li class="page-item <%= (int)request.getAttribute("currentPage") == (int)request.getAttribute("totalPages") ? "disabled" : "" %>">
                            <a class="page-link" href="viewTeacherSalary?page=<%= (int)request.getAttribute("currentPage") + 1 %>&keyword=${keyword}" aria-label="Next">
                                <span aria-hidden="true">Next »</span>
                            </a>
                        </li>
                    </ul>
                </nav>
                <% } %>
            </div>
        </div>

        <%@ include file="/layout/footer.jsp" %>
    </body>
</html>