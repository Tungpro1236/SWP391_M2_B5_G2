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
        <li class="nav-item dropdown">
            <a class="nav-link dropdown-toggle ${pageContext.request.requestURI.contains('dashboard') || pageContext.request.requestURI.contains('revenue') || pageContext.request.requestURI.contains('statistics') ? 'active' : ''}" 
               href="#" id="dashboardDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                <i class="bi bi-house me-2"></i> Dashboard
            </a>
            <ul class="dropdown-menu" aria-labelledby="dashboardDropdown">
                <li><a class="dropdown-item ${pageContext.request.requestURI.contains('dashboard') ? 'active' : ''}" href="dashBoard"><i class="bi bi-house me-2"></i> Overview</a></li>
                <li><a class="dropdown-item ${pageContext.request.requestURI.contains('revenue') ? 'active' : ''}" href="revenue"><i class="bi bi-receipt me- ++2"></i> Revenue</a></li>
                <li><a class="dropdown-item ${pageContext.request.requestURI.contains('statistics') ? 'active' : ''}" href="statistics"><i class="bi bi-graph-up me-2"></i> Statistics</a></li>
            </ul>
        </li>
        <li class="nav-item dropdown">
            <a class="nav-link dropdown-toggle ${pageContext.request.requestURI.contains('payroll') || pageContext.request.requestURI.contains('viewTeacherSalary') || pageContext.request.requestURI.contains('courses') ? 'active' : ''}" 
               href="#" id="teacherManagementDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                <i class="bi bi-person-workspace me-2"></i> Teacher Management
            </a>
            <ul class="dropdown-menu" aria-labelledby="teacherManagementDropdown">
                <li><a class="dropdown-item ${pageContext.request.requestURI.contains('payroll') ? 'active' : ''}" href="payRoll"><i class="bi bi-wallet me-2"></i> Payroll</a></li>
                <li><a class="dropdown-item ${pageContext.request.requestURI.contains('viewTeacherSalary') ? 'active' : ''}" href="viewTeacherSalary"><i class="bi bi-bar-chart me-2"></i> Teacher's Salary</a></li>
                <li><a class="dropdown-item ${pageContext.request.requestURI.contains('courses') ? 'active' : ''}" href="viewTeacherCourses"><i class="bi bi-book me-2"></i> Teacher's Courses</a></li>
            </ul>
        </li>
        <li class="nav-item dropdown">
            <a class="nav-link dropdown-toggle ${pageContext.request.requestURI.contains('users') ? 'active' : ''}" 
               href="#" id="userManagementDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                <i class="bi bi-people me-2"></i> User Management
            </a>
            <ul class="dropdown-menu" aria-labelledby="userManagementDropdown">
                <li><a class="dropdown-item ${pageContext.request.requestURI.contains('users') ? 'active' : ''}" href="admin/users"><i class="bi bi-people me-2"></i> Users list</a></li>
            </ul>
            <ul class="dropdown-menu" aria-labelledby="userManagementDropdown">
                <li><a class="dropdown-item ${pageContext.request.requestURI.contains('users') ? 'active' : ''}" href="admin/teacher-requests"><i class="bi bi-people me-2"></i> Request Teacher</a></li>
            </ul>
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
        box-shadow: 2px 0 5px rgba(0, 0, 0, 0.2);
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
        transition: background-color 0.3s, padding-left 0.3s;
    }

    .sidebar .nav-link:hover {
        background-color: #495057;
        padding-left: 25px;
    }

    .sidebar .nav-link.active {
        background-color: #007bff;
        border-left: 4px solid #ffffff;
    }

    .sidebar .dropdown-toggle {
        position: relative;
    }

    .sidebar .dropdown-toggle::after {
        position: absolute;
        right: 20px;
        transition: transform 0.3s ease;
    }

    .sidebar .dropdown-toggle.show::after {
        transform: rotate(180deg);
    }

    .sidebar .dropdown-menu {
        background-color: #2c3136;
        border: none;
        width: 100%;
        padding: 10px 0;
        margin: 0;
        border-radius: 0;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        transform: translateY(0);
        transition: opacity 0.3s ease, transform 0.3s ease;
        opacity: 0;
        visibility: hidden;
    }

    .sidebar .dropdown-menu.show {
        opacity: 1;
        visibility: visible;
        transform: translateY(5px);
    }

    .sidebar .dropdown-item {
        color: #ffffff;
        padding: 10px 30px;
        transition: background-color 0.3s, padding-left 0.3s;
        font-size: 0.95rem;
    }

    .sidebar .dropdown-item:hover {
        background-color: #495057;
        padding-left: 35px;
    }

    .sidebar .dropdown-item.active {
        background-color: #007bff;
        color: #ffffff;
        font-weight: 600;
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
        .sidebar .dropdown-menu {
            position: static;
            width: 100%;
            transform: none;
            box-shadow: none;
        }
        .sidebar .dropdown-menu.show {
            transform: none;
        }
    }
</style>