<%-- 
    Document   : revenue
    Created on : Apr 25, 2025, 7:15:00 PM
    Author     : regio
--%> 

<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
    <head>
        <title>Revenue Management</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
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
                border: none;
                border-radius: 10px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            }
            .card-header {
                background-color: #007bff;
                color: white;
                border-radius: 10px 10px 0 0;
                font-weight: 500;
            }
            .btn-primary {
                background-color: #007bff;
                border: none;
                transition: background-color 0.3s;
            }
            .btn-primary:hover {
                background-color: #0056b3;
            }
            .table {
                background-color: white;
                border-radius: 10px;
                overflow: hidden;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            }
            .table th {
                background-color: #f1f3f5;
                font-weight: 500;
                text-align: center;
            }
            .table td {
                vertical-align: middle;
                text-align: center;
            }
            .table tbody tr:hover {
                background-color: #f8f9fa;
            }
            .form-control:focus {
                border-color: #007bff;
                box-shadow: 0 0 0 0.2rem rgba(0, 123, 255, 0.25);
            }
            .alert {
                margin-bottom: 20px;
            }
        </style>
    </head>
    <body>
        <%@ include file="/layout/header.jsp" %>
        <%@ include file="/layout/sidebar.jsp" %>

        <!-- Main Content -->
        <div class="content">
            <div class="container-fluid">
                <h1 class="mb-4">Revenue Management</h1>

                <!-- Success/Error Messages -->
                <c:if test="${not empty success}">
                    <div class="alert alert-success" role="alert">
                        ${success}
                    </div>
                </c:if>
                <c:if test="${not empty error}">
                    <div class="alert alert-danger" role="alert">
                        ${error}
                    </div>
                </c:if>

                <!-- Form to Generate Revenue -->
                <div class="card mb-4">
                    <div class="card-header">
                        Generate Revenue
                    </div>
                    <div class="card-body">
                        <form action="revenue" method="post">
                            <input type="hidden" name="action" value="generate">
                            <div class="row g-3">
                                <div class="col-md-4">
                                    <label for="month" class="form-label">Month (1-12)</label>
                                    <input type="number" class="form-control" id="month" name="month" min="1" max="12" placeholder="e.g., 10" required>
                                </div>
                                <div class="col-md-4">
                                    <label for="year" class="form-label">Year</label>
                                    <input type="number" class="form-control" id="year" name="year" min="2000" max="2025" placeholder="e.g., 2024" required>
                                </div>
                                <div class="col-md-4 d-flex align-items-end">
                                    <button type="submit" class="btn btn-primary w-100" onclick="return confirm('Generate revenue for this month and year?')">Generate Revenue</button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>

                <!-- Revenue Records Table -->
                <div class="card">
                    <div class="card-header">
                        Revenue Records
                    </div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table table-striped">
                                <thead>
                                    <tr>
                                        <th>ID</th>
                                        <th>Total Amount</th>
                                        <th>Commission Rate</th>
                                        <th>Commission Amount</th>
                                        <th>Month/Year</th>
                                        <th>Generated At</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="revenue" items="${revenues}">
                                        <tr>
                                            <td>${revenue.id}</td>
                                            <td>$${revenue.totalAmount}</td>
                                            <td>${revenue.commissionRate}%</td>
                                            <td>$${revenue.commissionAmount}</td>
                                            <td>${revenue.month}/${revenue.year}</td>
                                            <td>${revenue.generatedAt}</td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <%@ include file="/layout/footer.jsp" %>
    </body>
</html>
