<%-- 
    Document   : sidebar
    Created on : Apr 25, 2025, 2:28:45 PM
    Author     : regio
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>


<!-- Sidebar -->
<nav class="sidebar">
    <div class="text-center mb-4">
        <h4 class="text-white">Admin Dashboard</h4>
    </div>
    <ul class="nav flex-column">
        <li class="nav-item">
            <a href="dashBoard" class="nav-link ${pageContext.request.requestURI.contains('dashboard') ? 'active' : ''}">
                <i class="bi bi-house me-2"></i> Dashboard
            </a>
        </li>
        <li class="nav-item">
            <a href="payRoll" class="nav-link ${pageContext.request.requestURI.contains('payroll') ? 'active' : ''}">
                <i class="bi bi-wallet me-2"></i> Payroll
            </a>
        </li>
        <li class="nav-item">
            <a href="viewTeacherSalary" class="nav-link ${pageContext.request.requestURI.contains('viewTeacherSalary') ? 'active' : ''}">
                <i class="bi bi-bar-chart me-2"></i> Teacher's salary
            </a>
        </li>
        <li class="nav-item">
            <a href="viewTeacherCourses" class="nav-link ${pageContext.request.requestURI.contains('courses') ? 'active' : ''}">
                <i class="bi bi-book me-2"></i> Teacher's Courses list
            </a>
        </li>
        <li class="nav-item">
            <a href="users" class="nav-link ${pageContext.request.requestURI.contains('users') ? 'active' : ''}">
                <i class="bi bi-people me-2"></i> Users
            </a>
        </li>
        <li class="nav-item">
            <a href="revenue" class="nav-link ${pageContext.request.requestURI.contains('revenue') ? 'active' : ''}">
                <i class="bi bi-receipt me-2"></i> Revenue
            </a>
        </li>
        <li class="nav-item">
            <a href="statistics" class="nav-link ${pageContext.request.requestURI.contains('statistics') ? 'active' : ''}">
                <i class="bi bi-graph-up me-2"></i> Statistics
            </a>
        </li>
        <li class="nav-item">
            <a href="reports" class="nav-link ${pageContext.request.requestURI.contains('reports') ? 'active' : ''}">
                <i class="bi bi-bar-chart me-2"></i> Reports
            </a>
        </li>
        <li class="nav-item">
            <a href="user?action=logout" class="nav-link">
                <i class="bi bi-box-arrow-left me-2"></i> Logout
            </a>
        </li>
    </ul>
</nav>

<style>
    .sidebar {
        position: fixed;
        top: 0;
        left: -220px;
        height: 100%;
        width: 250px;
        background-color: #343a40;
        padding-top: 20px;
        box-shadow: 2px 0 5px rgba(0, 0, 0, 0.1);
        transition: left 0.3s ease;
        z-index: 1000;
    }

    .sidebar:hover {
        left: 0;
    }

    .sidebar .nav-link {
        color: #ffffff;
        padding: 15px 20px;
        display: block;
        text-decoration: none;
        font-weight: 500;
        transition: background-color 0.3s;
    }

    .sidebar .nav-link:hover {
        background-color: #495057;
    }

    .sidebar .nav-link.active {
        background-color: #007bff;
    }

    .content {
        margin-left: 30px;
        padding: 20px;
        transition: margin-left 0.3s ease;
    }

    .sidebar:hover ~ .content {
        margin-left: 250px;
    }

    @media (max-width: 768px) {
        .sidebar {
            width: 100%;
            height: auto;
            position: relative;
            left: 0;
        }
        .content {
            margin-left: 0;
        }
        .sidebar:hover ~ .content {
            margin-left: 0;
        }
    }
</style>