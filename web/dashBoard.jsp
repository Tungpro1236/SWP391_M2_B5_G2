<%-- 
    Document   : dashBoard
    Created on : Apr 24, 2025, 8:27:06 PM
    Author     : regio
--%>

<%-- 
    Document   : dashBoard
    Created on : Apr 24, 2025, 8:27:06 PM
    Author     : regio
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Admin Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/chart.js@3.9.1/dist/chart.min.js"></script>
    <style>
        body {
            background-color: #f8f9fa;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            overflow-x: hidden;
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
        .chart-container {
            position: relative;
            height: 400px;
            width: 100%;
        }
        .btn-primary {
            background-color: #007bff;
            border: none;
            transition: background-color 0.3s;
        }
        .btn-primary:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
    <%@ include file="/layout/header.jsp" %>
    <%@ include file="/layout/sidebar.jsp" %>

    <!-- Main Content -->
    <div class="content">
        <div class="container-fluid">
            <h1 class="mb-4">Admin Dashboard</h1>

            <!-- Year Filter -->
            <div class="card mb-4">
                <div class="card-header">
                    Select Year
                </div>
                <div class="card-body">
                    <form action="dashBoard" method="get">
                        <div class="row g-3">
                            <div class="col-md-4">
                                <label for="year" class="form-label">Year</label>
                                <input type="number" class="form-control" id="year" name="year" value="${selectedYear}" min="2000" max="2025" required>
                            </div>
                            <div class="col-md-4 d-flex align-items-end">
                                <button type="submit" class="btn btn-primary w-100">Update Charts</button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>

            <!-- Check if chartData is empty -->
            <c:if test="${empty chartData}">
                <div class="alert alert-info" role="alert">
                    No data available for the selected year (${selectedYear}).
                </div>
            </c:if>

            <!-- Charts -->
            <c:if test="${not empty chartData}">
                <div class="row">
                    <!-- Teacher Salaries Chart -->
                    <div class="col-lg-6 mb-4">
                        <div class="card">
                            <div class="card-header">
                                Total Teacher Salaries by Month (${selectedYear})
                            </div>
                            <div class="card-body">
                                <div class="chart-container">
                                    <canvas id="salaryChart"></canvas>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Transaction Count Chart -->
                    <div class="col-lg-6 mb-4">
                        <div class="card">
                            <div class="card-header">
                                Transaction Count by Month (${selectedYear})
                            </div>
                            <div class="card-body">
                                <div class="chart-container">
                                    <canvas id="transactionChart"></canvas>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </c:if>
        </div>
    </div>

    <!-- Chart.js Script -->
    <c:if test="${not empty chartData}">
        <script>
            // Prepare data for charts
            const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
            const salaryData = new Array(12).fill(0);
            const transactionData = new Array(12).fill(0);

            <c:forEach var="data" items="${chartData}">
                salaryData[${data.month - 1}] = ${data.totalTeacherSalary};
                transactionData[${data.month - 1}] = ${data.transactionCount};
            </c:forEach>

            // Salary Chart
            new Chart(document.getElementById('salaryChart'), {
                type: 'bar',
                data: {
                    labels: months,
                    datasets: [{
                        label: 'Total Teacher Salaries ($)',
                        data: salaryData,
                        backgroundColor: 'rgba(0, 123, 255, 0.5)',
                        borderColor: 'rgba(0, 123, 255, 1)',
                        borderWidth: 1
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    scales: {
                        y: {
                            beginAtZero: true,
                            title: {
                                display: true,
                                text: 'Amount ($)'
                            }
                        }
                    }
                }
            });

            // Transaction Chart
            new Chart(document.getElementById('transactionChart'), {
                type: 'line',
                data: {
                    labels: months,
                    datasets: [{
                        label: 'Transaction Count',
                        data: transactionData,
                        backgroundColor: 'rgba(40, 167, 69, 0.5)',
                        borderColor: 'rgba(40, 167, 69, 1)',
                        borderWidth: 2,
                        fill: false
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    scales: {
                        y: {
                            beginAtZero: true,
                            title: {
                                display: true,
                                text: 'Count'
                            }
                        }
                    }
                }
            });
        </script>
    </c:if>
    <%@ include file="/layout/footer.jsp" %>
</body>
</html>