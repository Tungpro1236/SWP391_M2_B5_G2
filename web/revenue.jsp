<%-- 
    Document   : revenue
    Created on : Apr 25, 2025, 7:15:00 PM
    Author     : regio
--%> 

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
    <head>
        <title>Revenue Management</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
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
                text-align: left !important;
                padding: 8px 10px !important;
            }
            .table-striped tbody td {
                vertical-align: middle;
                text-align: left !important;
                padding: 8px 10px !important;
                min-width: 120px;
                max-width: 200px;
                box-sizing: border-box;
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
            .pagination {
                justify-content: center;
                margin-top: 20px;
            }
            .page-item.active .page-link {
                background-color: #007bff;
                border-color: #007bff;
            }
            .page-link {
                color: #007bff;
            }
            .page-link:hover {
                color: #0056b3;
                background-color: #e9ecef;
            }
        </style>
    </head>
    <body>
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

                <!-- Generate Revenue Form -->
                <div class="card mb-4">
                    <div class="card-header">
                        Generate Revenue
                    </div>
                    <div class="card-body">
                        <form action="revenue" method="post">
                            <input type="hidden" name="action" value="generate">
                            <div class="row g-3 align-items-end">
                                <div class="col-md-4">
                                    <label for="monthYear" class="form-label">Generate Month/Year</label>
                                    <input type="month" class="form-control" id="monthYear" name="monthYear" required>
                                </div>
                                <div class="col-md-2">
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
                        <!-- Filter Form -->
                        <form action="revenue" method="get" class="mb-4">
                            <div class="row g-3 align-items-end">
                                <div class="col-md-4">
                                    <label for="filterMonthYear" class="form-label">Filter Month/Year (optional)</label>
                                    <input type="month" class="form-control" id="filterMonthYear" name="filterMonthYear" value="${filterYear}-${filterMonth}">
                                </div>
                                <div class="col-md-2">
                                    <button type="submit" class="btn btn-primary w-100">Filter Records</button>
                                </div>
                            </div>
                        </form>

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
                                            <td>
                                                <c:choose>
                                                    <c:when test="${not empty revenue.generatedAt}">
                                                        <fmt:parseDate value="${revenue.generatedAt}" pattern="yyyy-MM-dd HH:mm:ss" var="parsedDate" />
                                                        <fmt:formatDate value="${parsedDate}" pattern="dd/MM/yyyy" />
                                                    </c:when>
                                                    <c:otherwise>
                                                        N/A
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    <c:if test="${empty revenues}">
                                        <tr>
                                            <td colspan="6" class="text-center">No revenue records found for the specified filters.</td>
                                        </tr>
                                    </c:if>
                                </tbody>
                            </table>
                        </div>

                        <!-- Pagination Controls -->
                        <nav aria-label="Revenue pagination">
                            <ul class="pagination">
                                <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                    <a class="page-link" href="revenue?page=${currentPage - 1}&filterMonthYear=${filterYear}-${filterMonth}" aria-label="Previous">
                                        <span aria-hidden="true">« Previous</span>
                                    </a>
                                </li>
                                <c:forEach begin="1" end="${totalPages}" var="i">
                                    <li class="page-item ${currentPage == i ? 'active' : ''}">
                                        <a class="page-link" href="revenue?page=${i}&filterMonthYear=${filterYear}-${filterMonth}">${i}</a>
                                    </li>
                                </c:forEach>
                                <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                                    <a class="page-link" href="revenue?page=${currentPage + 1}&filterMonthYear=${filterYear}-${filterMonth}" aria-label="Next">
                                        <span aria-hidden="true">Next »</span>
                                    </a>
                                </li>
                            </ul>
                        </nav>
                    </div>
                </div>
            </div>
        </div>

        <%@ include file="/layout/footer.jsp" %>
    </body>
</html>