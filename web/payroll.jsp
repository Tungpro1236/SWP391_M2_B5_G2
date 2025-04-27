<%-- 
    Document   : payroll
    Created on : Apr 24, 2025, 3:11:14 PM
    Author     : regio
--%>
<%-- 
    Document   : payroll
    Created on : Apr 24, 2025, 3:11:14 PM
    Author     : regio
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
   <head>
    <title>Teacher Payroll</title>
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
        .bi-check-circle-fill {
            color: #28a745;
            font-size: 1.5rem;
        }
    </style>
</head>
<body>
    <%@ include file="/layout/header.jsp" %>
    <%@ include file="/layout/sidebar.jsp" %>

    <!-- Main Content -->
    <div class="content">
        <div class="container-fluid">
            <h1 class="mb-4">Teacher Payroll Management</h1>

            <!-- Form to Generate Payroll -->
            <div class="card mb-4">
                <div class="card-header">
                    Generate Payroll
                </div>
                <div class="card-body">
                    <form action="payRoll" method="post">
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
                                <button type="submit" class="btn btn-primary w-100" onclick="return confirm('Generate payroll for this month and year?')">Generate Payroll</button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>

            <!-- Payroll Records Table -->
            <div class="card">
                <div class="card-header">
                    Payroll Records
                </div>
                <div class="card-body">
                    <div class="table-responsive">
                        <table class="table table-striped">
                            <thead>
                                <tr>
                                    <th>Salary ID</th>
                                    <th>Teacher</th>
                                    <th>Gross Amount</th>
                                    <th>Commission</th>
                                    <th>Teacher Salary</th>
                                    <th>Month/Year</th>
                                    <th>Status</th>
                                    <th>Paid?</th>
                                    <th>Transactions</th>                                   
                                    <th>Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="payroll" items="${payrolls}">
                                    <tr>
                                        <td>${payroll.salaryId}</td>
                                        <td>${payroll.teacherName}</td>
                                        <td>$${payroll.grossAmount}</td>
                                        <td>${payroll.commissionRate}% ($${payroll.commissionAmount})</td>
                                        <td>$${payroll.salaryAmount}</td>
                                        <td>${payroll.salaryMonth}/${payroll.salaryYear}</td>
                                        <td>${payroll.status}</td>
                                        <td>${payroll.paymentStatus}</td>
                                        <td>${payroll.transactionCount}</td>                                        
                                        <td>
                                            <c:choose>
                                                <c:when test="${payroll.paymentStatus == 'Unpaid'}">
                                                    <form action="markPaid" method="post">
                                                        <input type="hidden" name="salaryId" value="${payroll.salaryId}">
                                                        <button type="submit" class="btn btn-success btn-sm">Mark Paid</button>
                                                    </form>
                                                </c:when>
                                                <c:otherwise>
                                                    <i class="bi bi-check-circle-fill"></i>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
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