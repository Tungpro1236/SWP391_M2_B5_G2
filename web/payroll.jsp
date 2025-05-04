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
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
    <head>
        <title>Teacher Payroll</title>
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
                height: 38px; /* Đồng bộ chiều cao với input */
                line-height: 1.5; /* Căn chỉnh văn bản trong nút */
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
        <%@ include file="/layout/header.jsp" %>
        <%@ include file="/layout/sidebar.jsp" %>

        <!-- Main Content -->
        <div class="content">
            <div class="container-fluid">
                <h1 class="mb-4">Teacher Payroll Management</h1>

                <!-- Display Message -->
                <c:if test="${not empty message}">
                    <div class="alert alert-${messageType} alert-dismissible fade show" role="alert">
                        ${message}
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                </c:if>

                <!-- Form to Generate Payroll -->
                <div class="card mb-4">
                    <div class="card-header">
                        Generate Payroll
                    </div>
                    <div class="card-body">
                        <form action="payRoll" method="post" id="generatePayrollForm">
                            <div class="row g-3">
                                <div class="col-md-3">
                                    <div class="form-group">
                                        <label for="payrollDate" class="form-label">Month and Year</label>
                                        <input type="month" class="form-control" id="payrollDate" name="payrollDate" 
                                               min="2000-01" max="2025-12" required>
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="form-group">
                                        <label for="teacherName" class="form-label">Teacher Name</label>
                                        <input type="text" class="form-control" id="teacherName" name="teacherName" 
                                               placeholder="e.g., John Doe" required>
                                    </div>
                                </div>
                            </div>
                            <div class="row g-3 mt-3">
                                <div class="col-md-2">
                                    <button type="submit" class="btn btn-primary w-100" 
                                            onclick="return confirm('Generate payroll for this month, year, and teacher?')">Generate Payroll</button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>

                <!-- Filter Form -->
                <div class="card mb-4">
                    <div class="card-header">
                        Filter Payroll
                    </div>
                    <div class="card-body">
                        <form action="payRoll" method="get">
                            <div class="row g-3 align-items-end">
                                <div class="col-md-4">
                                    <label for="paymentStatus" class="form-label">Payment Status</label>
                                    <select class="form-control" id="paymentStatus" name="paymentStatus">
                                        <option value="">All</option>
                                        <option value="Paid" ${param.paymentStatus == 'Paid' ? 'selected' : ''}>Paid</option>
                                        <option value="Unpaid" ${param.paymentStatus == 'Unpaid' ? 'selected' : ''}>Unpaid</option>
                                    </select>
                                </div>
                                <div class="col-md-2">
                                    <button type="submit" class="btn btn-primary w-100">Apply Filter</button>
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
                            <c:choose>
                                <c:when test="${empty payrolls}">
                                    <div class="no-data-message">
                                        No payroll data available
                                    </div>
                                </c:when>
                                <c:otherwise>
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
                                                    <td>
                                                        <fmt:formatNumber value="${payroll.commissionRate}" maxFractionDigits="2" minFractionDigits="2"/>%
                                                        ($${payroll.commissionAmount})
                                                    </td>
                                                    <td>$${payroll.salaryAmount}</td>
                                                    <td>${payroll.salaryMonth}/${payroll.salaryYear}</td>
                                                    <td>${payroll.status}</td>
                                                    <td>${payroll.paymentStatus}</td>
                                                    <td>${payroll.transactionCount}</td>
                                                    <td>
                                                        <c:choose>
                                                            <c:when test="${payroll.paymentStatus == 'Unpaid'}">
                                                                <form action="markPaid" method="post" style="display:inline;">
                                                                    <input type="hidden" name="salaryId" value="${payroll.salaryId}">
                                                                    <button type="submit" class="btn btn-success btn-sm">Mark Paid</button>
                                                                </form>
                                                                <button type="button" class="btn btn-warning btn-sm" 
                                                                        data-bs-toggle="modal" 
                                                                        data-bs-target="#editCommissionModal${payroll.salaryId}">
                                                                    Edit Commission
                                                                </button>
                                                                <!-- Modal -->
                                                                <div class="modal fade" id="editCommissionModal${payroll.salaryId}" tabindex="-1">
                                                                    <div class="modal-dialog">
                                                                        <div class="modal-content">
                                                                            <div class="modal-header">
                                                                                <h5 class="modal-title">Edit Commission Rate</h5>
                                                                                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                                                                            </div>
                                                                            <div class="modal-body">
                                                                                <form id="editCommissionForm${payroll.salaryId}" action="editCommission" method="post">
                                                                                    <input type="hidden" name="salaryId" value="${payroll.salaryId}">
                                                                                    <div class="mb-3">
                                                                                        <label class="form-label">Commission Rate (%):</label>
                                                                                        <input type="number" step="0.01" min="20" max="100" 
                                                                                               name="commissionRate" class="form-control" 
                                                                                               value="${payroll.commissionRate}" required>
                                                                                        <small class="form-text text-muted">
                                                                                            Enter commission rate as a percentage (e.g., 20.00 for 20%). Minimum is 20.00%.
                                                                                        </small>
                                                                                    </div>
                                                                                    <button type="submit" class="btn btn-primary">Save</button>
                                                                                </form>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
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
                                    <!-- Pagination Controls -->
                                    <nav aria-label="Payroll pagination">
                                        <ul class="pagination">
                                            <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                                <a class="page-link" href="payRoll?page=${currentPage - 1}&paymentStatus=${param.paymentStatus}" aria-label="Previous">
                                                    <span aria-hidden="true">« Previous</span>
                                                </a>
                                            </li>
                                            <c:forEach begin="1" end="${totalPages}" var="i">
                                                <li class="page-item ${currentPage == i ? 'active' : ''}">
                                                    <a class="page-link" href="payRoll?page=${i}&paymentStatus=${param.paymentStatus}">${i}</a>
                                                </li>
                                            </c:forEach>
                                            <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                                                <a class="page-link" href="payRoll?page=${currentPage + 1}&paymentStatus=${param.paymentStatus}" aria-label="Next">
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

        <script>
            // Handle form submission with AJAX and validate minimum 20%
            document.querySelectorAll('[id^="editCommissionForm"]').forEach(form => {
            form.addEventListener('submit', function(e) {
            e.preventDefault();
                    const formData = new FormData(this);
                    let commissionRate = parseFloat(formData.get('commissionRate'));
                    // Validate commission rate >= 20%
                    if (commissionRate < 20) {
            alert('Commission rate must be at least 20.00%. Please enter a valid percentage (e.g., 20.00 or higher).');
                    return;
            }

            // Store commission rate as-is (already a percentage)
            formData.set('commissionRate', commissionRate.toFixed(2));
                    const url = 'editCommission';
                    console.log('Sending request to: ' + url);
                    console.log('Form data:', Object.fromEntries(formData));
                    fetch(url, {
                    method: 'POST',
                            body: new URLSearchParams(formData)
                    })
                    .then(response => {
                    console.log('Response status:', response.status);
                            console.log('Response headers:', response.headers.get('content-type'));
                            const contentType = response.headers.get('content-type');
                            if (contentType && contentType.includes('text/plain')) {
                    return response.text();
                    } else {
                    return response.text().then(text => {
                    console.log('Unexpected response content:', text);
                            throw new Error('Unexpected response format: Expected text/plain, got ' + contentType);
                    });
                    }
                    })
                    .then(data => {
                    console.log('Response data:', data);
                            if (data === 'success') {
                    alert('Commission updated successfully');
                            location.reload();
                    } else {
                    const errorMessage = data.startsWith('error:') ? data.substring(6) : data;
                            alert('Error updating commission: ' + errorMessage);
                    }
                    })
                    .catch(error => {
                    console.error('Error:', error);
                            alert('Error updating commission: ' + error.message);
                    });
            });
                    // Handle payroll form submission to parse month/year
                    document.getElementById('generatePayrollForm').addEventListener('submit', function(e) {
            const payrollDate = document.getElementById('payrollDate').value;
                    if (payrollDate) {
            const [year, month] = payrollDate.split('-');
                    const hiddenMonth = document.createElement('input');
                    hiddenMonth.type = 'hidden';
                    hiddenMonth.name = 'month';
                    hiddenMonth.value = month;
                    this.appendChild(hiddenMonth);
                    const hiddenYear = document.createElement('input');
                    hiddenYear.type = 'hidden';
                    hiddenYear.name = 'year';
                    hiddenYear.value = year;
                    this.appendChild(hiddenYear);
            }
            });
        </script>
    </body>
</html>