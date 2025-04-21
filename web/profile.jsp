<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Profile - Boost Your Style</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .sidebar {
            padding: 20px;
            border-right: 1px solid #dee2e6;
            height: 100vh;
        }
        .sidebar .nav-link {
            color: #333;
            padding: 10px 0;
        }
        .sidebar .nav-link:hover {
            color: #0d6efd;
        }
        .sidebar .nav-link.active {
            color: #0d6efd;
            font-weight: 500;
        }
        .profile-pic {
            width: 100px;
            height: 100px;
            border-radius: 50%;
            margin: 0 auto 20px;
            display: block;
        }
        .user-name {
            text-align: center;
            margin-bottom: 30px;
        }
        .content {
            padding: 30px;
        }
        .error-message {
            color: #dc3545;
        }
        .success-message {
            color: #198754;
        }
    </style>
</head>
<body>
    <div class="container-fluid">
        <div class="row">
            <!-- Sidebar -->
            <div class="col-md-3 sidebar">
                <img src="${user.avatarUrl != null ? user.avatarUrl : 'assets/images/default-avatar.png'}" 
                     alt="Profile" class="profile-pic">
                <h5 class="user-name">${user.firstName} ${user.lastName}</h5>
                
                <nav class="nav flex-column">
                    <a class="nav-link active" href="profile">Profile</a>
                    <a class="nav-link" href="password">Change Password</a>
                    <a class="nav-link" href="#">Course and Exercise</a>
                    <a class="nav-link" href="#">Wishlist</a>
                    <a class="nav-link" href="#">Order History</a>
                    <a class="nav-link text-danger" href="login?action=logout">Logout</a>
                </nav>
            </div>
            
            <!-- Main Content -->
            <div class="col-md-9 content">
                <h2 class="mb-4">Personal Information</h2>
                
                <c:if test="${not empty error}">
                    <div class="alert alert-danger">
                        <c:out value="${error}"/>
                    </div>
                </c:if>
                
                <c:if test="${not empty success}">
                    <div class="alert alert-success">
                        <c:out value="${success}"/>
                    </div>
                </c:if>
                
                <form action="profile" method="post">
                    <input type="hidden" name="action" value="update">
                    
                    <div class="row mb-3">
                        <div class="col-md-6">
                            <label class="form-label">First Name</label>
                            <input type="text" name="firstName" class="form-control" 
                                   value="${user.firstName}" required>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">Last Name</label>
                            <input type="text" name="lastName" class="form-control" 
                                   value="${user.lastName}" required>
                        </div>
                    </div>
                    
                    <div class="mb-3">
                        <label class="form-label">Gender</label>
                        <select name="genderId" class="form-select">
                            <option value="1" ${user.genderId == 1 ? 'selected' : ''}>Male</option>
                            <option value="2" ${user.genderId == 2 ? 'selected' : ''}>Female</option>
                            <option value="3" ${user.genderId == 3 ? 'selected' : ''}>Other</option>
                        </select>
                    </div>
                    
                    <div class="mb-4">
                        <label class="form-label">Avatar URL</label>
                        <input type="url" name="avatarUrl" class="form-control" 
                               value="${user.avatarUrl}">
                    </div>
                    
                    <button type="submit" class="btn btn-primary">Update Profile</button>
                </form>
            </div>
        </div>
    </div>
</body>
</html>