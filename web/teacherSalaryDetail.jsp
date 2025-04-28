<%-- 
    Document   : teacherSalaryDetail
    Created on : Apr 21, 2025, 1:13:18 AM
    Author     : regio
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="vn.edu.fpt.model.Salary" %>
<% 
    Salary s = (Salary) request.getAttribute("salary");
%>
<html>
    <head>
        <title>Salary Info</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
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
            .card {
                transition: transform 0.2s, box-shadow 0.2s;
            }
            .card:hover {
                transform: translateY(-5px);
                box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2) !important;
            }
            .btn-back:hover {
                background-color: #0056b3;
                transform: scale(1.05);
            }
        </style>
    </head>
    <body>
        <%@ include file="/layout/header.jsp" %>
        <%@ include file="/layout/sidebar.jsp" %>

        <!-- Main Content -->
        <div class="content">
            <div class="container-fluid">
                <h2 class="mb-4 text-primary fw-bold">Salary Info</h2>

                <% if (s != null) { %>
                <div class="card shadow-sm rounded-3">
                    <div class="card-body">
                        <h5 class="card-title text-secondary mb-4">Teacher Salary Information</h5>
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <p class="mb-1"><strong class="text-muted">Teacher ID:</strong> <span class="badge bg-info text-dark"><%= s.getTeacherId() != 0 ? s.getTeacherId() : "N/A" %></span></p>
                            </div>
                            <div class="col-md-6 mb-3">
                                <p class="mb-1"><strong class="text-muted">Name:</strong> <%= s.getTeacherName() != null ? s.getTeacherName() : "N/A" %></p>
                            </div>
                            <div class="col-md-6 mb-3">
                                <p class="mb-1"><strong class="text-muted">Total Amount:</strong> <span class="text-success"><%= String.format("%.2f", s.getTotalAmount()) %> VND</span></p>
                            </div>
                            <div class="col-md-6 mb-3">
                                <p class="mb-1"><strong class="text-muted">Payment Status:</strong>
                                    <% if (s.getPaid() == 1) { %>
                                    <span class="badge bg-success">Paid</span>
                                    <% } else if (s.getPaid() == 0) { %>
                                    <span class="badge bg-danger">Not Paid</span>
                                    <% } else { %>
                                    <span class="badge bg-secondary">Unknown</span>
                                    <% } %>
                                </p>
                            </div>
                            <div class="col-md-6 mb-3">
                                <p class="mb-1"><strong class="text-muted">Month:</strong> <%= s.getMonth() != null ? s.getMonth() : "N/A" %></p>
                            </div>
                            <div class="col-md-6 mb-3">
                                <p class="mb-1"><strong class="text-muted">Year:</strong> <%= s.getYear() %></p>
                            </div>
                        </div>
                    </div>
                </div>
                <% } else { %>
                <div class="alert alert-warning shadow-sm rounded-3" role="alert">
                    Salary details not found.
                </div>
                <% } %>

                <div class="mt-4">
                    <a href="viewTeacherSalary" class="btn btn-primary btn-back shadow-sm rounded-pill px-4">Back to List</a>
                </div>
            </div>
        </div>

        <%@ include file="/layout/footer.jsp" %>
    </body>
</html>