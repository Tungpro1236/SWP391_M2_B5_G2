<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>

    <head>
        <title>Orders Management</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css"
              rel="stylesheet">
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
                height: 38px;
                /* Đồng bộ chiều cao với input */
                line-height: 1.5;
                /* Căn chỉnh văn bản trong nút */
            }

            .btn-primary:hover {
                background-color: #0056b3;
            }

            .btn-success {
                background-color: #28a745;
                border: none;
                transition: background-color 0.3s;
            }

            .btn-success:hover {
                background-color: #218838;
            }

            .btn-warning {
                background-color: #ffc107;
                border: none;
                transition: background-color 0.3s;
            }

            .btn-warning:hover {
                background-color: #e0a800;
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
                text-align: left;
            }

            .table td {
                vertical-align: middle;
                text-align: left;
            }

            .table tbody tr:hover {
                background-color: #f8f9fa;
            }

            .form-control:focus {
                border-color: #007bff;
                box-shadow: 0 0 0 0.2rem rgba(0, 123, 255, 0.25);
            }

            .bi-check-circle-fill {
                color: #28a745;
                font-size: 1.5rem;
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

            .no-data-message {
                text-align: center;
                padding: 20px;
                color: #6c757d;
                font-size: 1.1rem;
            }

            .alert {
                margin-bottom: 20px;
            }

            .form-group {
                margin-bottom: 0;
            }

            .form-group small {
                display: block;
                min-height: 1.5em;
            }
        </style>
    </head>

    <body>
        <%@ include file="/layout/sidebar.jsp" %>

        <!-- Main Content -->
        <div class="content">
            <div class="container-fluid">
                <h1 class="mb-4">Orders Management</h1>

                <!-- Display Message -->
                <c:if test="${not empty message}">
                    <div class="alert alert-${messageType} alert-dismissible fade show" role="alert">
                        ${message}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"
                                aria-label="Close"></button>
                    </div>
                </c:if>

                <!-- Filter Form -->
                <div class="card mb-4">
                    <div class="card-header">
                        Filter Order
                    </div>
                    <div class="card-body">
                        <form action="manageOrder" method="get">
                            <div class="row g-3 align-items-end">
                                <div class="col-md-4">
                                    <label for="paymentStatus" class="form-label">Status</label>
                                    <select class="form-control" id="paymentStatus" name="status">
                                        <option value="1">All</option>
                                        <option value="Pending" ${param.status=='Pending' ? 'selected' : ''
                                                }>Pending</option>
                                        <option value="Confirmed" ${param.status=='Confirmed' ? 'selected'
                                                                    : '' }>Confirmed</option>
                                    </select>
                                </div>
                                <div class="col-md-2">
                                    <button type="submit" class="btn btn-primary w-100">Apply
                                        Filter</button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>

                <!-- Payroll Records Table -->
                <div class="card">
                    <div class="card-header">
                        Order Records
                    </div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <c:choose>
                                <c:when test="${empty orders}">
                                    <div class="no-data-message">
                                        No orders data available
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <table class="table table-striped">
                                        <thead>
                                            <tr>
                                                <th>User</th>
                                                <th>Course</th>
                                                <th>Total</th>
                                                <th>Date</th>
                                                <th>Status</th>
                                                <th>Action</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="o" items="${orders}">
                                                <tr>
                                                    <td>${o.user}</td>
                                                    <td>${o.courses}</td>
                                                    <td>$${o.totalAmount}</td>
                                                    <td>$${o.orderDate}</td>
                                                    <td>
                                                        <c:if test="${o.status eq 'Pending'}">
                                                            <button type="button"
                                                                    class="btn btn-warning">Pending</button>
                                                        </c:if>
                                                        <c:if test="${o.status eq 'Confirmed'}">
                                                            <button type="button"
                                                                    class="btn btn-primary">Confirmed</button>
                                                        </c:if>
                                                    </td>
                                                    <td>
                                                        <c:if test="${o.status eq 'Pending'}">
                                                            <a href="manageOrder?action=confirm&id=${o.orderID}&status=Confirmed"
                                                               type="button" class="btn btn-success"
                                                               onclick="return confirm('Are you sure to confirm this order?');">
                                                                Confirm
                                                            </a>
                                                        </c:if>
                                                    </td>

                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                    <!-- Pagination Controls -->
                                    <nav aria-label="Payroll pagination">
                                        <ul class="pagination">
                                            <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                                <a class="page-link"
                                                   href="manageOrder?page=${currentPage - 1}&status=${param.status}"
                                                   aria-label="Previous">
                                                    <span aria-hidden="true">« Previous</span>
                                                </a>
                                            </li>
                                            <c:forEach begin="1" end="${totalPages}" var="i">
                                                <li class="page-item ${currentPage == i ? 'active' : ''}">
                                                    <a class="page-link"
                                                       href="manageOrder?page=${i}&status=${param.status}">${i}</a>
                                                </li>
                                            </c:forEach>
                                            <li
                                                class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                                                <a class="page-link"
                                                   href="manageOrder?page=${currentPage + 1}&status=${param.status}"
                                                   aria-label="Next">
                                                    <span aria-hidden="true">Next »</span>
                                                </a>
                                            </li>
                                        </ul>
                                    </nav>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <%@ include file="/layout/footer.jsp" %>


    </body>

</html>