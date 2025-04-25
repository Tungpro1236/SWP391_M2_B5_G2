<%-- 
    Document   : statistics
    Created on : Apr 25, 2025, 1:57:02 PM
    Author     : regio
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <title>Statistics</title>
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
        .stat-box {
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            padding: 20px;
            text-align: center;
            transition: transform 0.2s;
        }
        .stat-box:hover {
            transform: translateY(-5px);
        }
        .stat-box h3 {
            font-size: 2rem;
            color: #007bff;
        }
        .stat-box p {
            font-size: 1rem;
            color: #6c757d;
        }
    </style>
</head>
<body>
    <%@ include file="/layout/header.jsp" %>
    <%@ include file="/layout/sidebar.jsp" %>

    <!-- Main Content -->
    <div class="content">
        <div class="container-fluid">
            <h1 class="mb-4">Statistics</h1>

            <!-- Year Filter -->
            <div class="card mb-4">
                <div class="card-header">
                    Select Year
                </div>
                <div class="card-body">
                    <form action="statistics" method="get">
                        <div class="row g-3">
                            <div class="col-md-4">
                                <label for="year" class="form-label">Year</label>
                                <input type="number" class="form-control" id="year" name="year" value="${selectedYear}" min="2000" max="2025" required>
                            </div>
                            <div class="col-md-4 d-flex align-items-end">
                                <button type="submit" class="btn btn-primary w-100">Update Statistics</button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>

            <!-- Check if statisticsList is empty -->
            <c:if test="${empty statisticsList}">
                <div class="alert alert-info" role="alert">
                    No data available for the selected year (${selectedYear}).
                </div>
            </c:if>

            <c:if test="${not empty statisticsList}">
                <!-- Summary Statistics -->
                <div class="row mb-4">
                    <div class="col-md-3">
                        <div class="stat-box">
                            <h3>${statisticsList[0].totalTeachers}</h3>
                            <p>Total Teachers</p>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="stat-box">
                            <h3>${statisticsList[0].totalStudents}</h3>
                            <p>Total Students</p>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="stat-box">
                            <h3>${statisticsList[0].totalCourses}</h3>
                            <p>Total Courses</p>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="stat-box">
                            <h3>${statisticsList[0].totalSuccessfulTransactions}</h3>
                            <p>Total Successful Transactions</p>
                        </div>
                    </div>
                </div>

                <!-- Total Revenue Chart -->
                <div class="row mb-4">
                    <div class="col-lg-12">
                        <div class="card">
                            <div class="card-header">
                                Total Revenue by Month (${selectedYear})
                            </div>
                            <div class="card-body">
                                <div class="chart-container">
                                    <canvas id="revenueChart"></canvas>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Top 5 Teachers -->
                <div class="row">
                    <div class="col-lg-12">
                        <div class="card">
                            <div class="card-header">
                                Top 5 Teachers by Salary (${selectedYear})
                            </div>
                            <div class="card-body">
                                <div class="table-responsive">
                                    <table class="table table-striped table-bordered table-hover">
                                        <thead class="table-dark">
                                            <tr>
                                                <th>Teacher ID</th>
                                                <th>Name</th>
                                                <th>Total Salary ($)</th>
                                                <th>Year</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="teacher" items="${topTeachers}">
                                                <tr>
                                                    <td>${teacher.teacherId}</td>
                                                    <td>${teacher.teacherName}</td>
                                                    <td>${teacher.totalSalary}</td>
                                                    <td>${teacher.year}</td>
                                                </tr>
                                            </c:forEach>
                                            <c:if test="${empty topTeachers}">
                                                <tr>
                                                    <td colspan="4" class="text-center">No data available.</td>
                                                </tr>
                                            </c:if>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </c:if>
        </div>
    </div>

    <!-- Chart.js Script -->
    <c:if test="${not empty statisticsList}">
        <script>
            // Prepare data for chart
            const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
            const revenueData = new Array(12).fill(0);

            <c:forEach var="stats" items="${statisticsList}">
                revenueData[${stats.month - 1}] = ${stats.totalRevenue};
            </c:forEach>

            // Revenue Chart
            new Chart(document.getElementById('revenueChart'), {
                type: 'bar',
                data: {
                    labels: months,
                    datasets: [{
                        label: 'Total Revenue ($)',
                        data: revenueData,
                        backgroundColor: 'rgba(255, 99, 132, 0.5)',
                        borderColor: 'rgba(255, 99, 132, 1)',
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
        </script>
    </c:if>
    <%@ include file="/layout/footer.jsp" %>
</body>
</html>