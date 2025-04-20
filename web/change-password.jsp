<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Change Password - Boost Your Style</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css" rel="stylesheet">
        <style>
            .password-container {
                max-width: 600px;
                margin: 50px auto;
                padding: 30px;
                box-shadow: 0 0 10px rgba(0,0,0,0.1);
                border-radius: 8px;
            }
            .form-label {
                font-weight: 500;
                margin-bottom: 10px;
            }
            .input-group {
                margin-bottom: 20px;
            }
            .input-group-text {
                background-color: #f8f9fa;
                cursor: pointer;
            }
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
                        <a class="nav-link" href="profile">Profile</a>
                        <a class="nav-link active" href="password">Change Password</a>
                        <a class="nav-link" href="#">Course and Exercise</a>
                        <a class="nav-link" href="#">Wishlist</a>
                        <a class="nav-link" href="#">Order History</a>
                        <a class="nav-link text-danger" href="login?action=logout">Logout</a>
                    </nav>
                </div>

                <!-- Main Content -->
                <div class="col-md-9 content">
                    <div class="password-container">
                        <h2 class="mb-4">Password Information</h2>

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

                        <form action="password" method="post" onsubmit="return validateForm()">
                            <input type="hidden" name="action" value="change">

                            <div class="mb-3">
                                <label class="form-label">Email</label>
                                <input type="email" class="form-control" value="${user.email}" readonly>
                            </div>

                            <div class="mb-3">
                                <label class="form-label">Current Password</label>
                                <div class="input-group">
                                    <input type="password" name="currentPassword" id="currentPassword" class="form-control" required>
                                    <span class="input-group-text" onclick="togglePassword('currentPassword')">
                                        <i class="bi bi-eye-slash"></i>
                                    </span>
                                </div>
                            </div>

                            <div class="mb-3">
                                <label class="form-label">New Password</label>
                                <div class="input-group">
                                    <input type="password" name="newPassword" id="newPassword" class="form-control" 
                                           placeholder="Enter new password" required>
                                    <span class="input-group-text" onclick="togglePassword('newPassword')">
                                        <i class="bi bi-eye-slash"></i>
                                    </span>
                                </div>
                            </div>

                            <div class="mb-4">
                                <label class="form-label">Confirm Password</label>
                                <div class="input-group">
                                    <input type="password" id="confirmPassword" class="form-control" 
                                           placeholder="Re-enter password" required>
                                    <span class="input-group-text" onclick="togglePassword('confirmPassword')">
                                        <i class="bi bi-eye-slash"></i>
                                    </span>
                                </div>
                            </div>

                            <button type="submit" class="btn btn-primary">Save Change</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </body>

    <script>
        function togglePassword(inputId) {
            const input = document.getElementById(inputId);
            const icon = input.nextElementSibling.querySelector('i');
            if (input.type === 'password') {
                input.type = 'text';
                icon.classList.replace('bi-eye-slash', 'bi-eye');
            } else {
                input.type = 'password';
                icon.classList.replace('bi-eye', 'bi-eye-slash');
            }
        }

        function validateForm() {
            const newPassword = document.getElementById('newPassword').value;
            const confirmPassword = document.getElementById('confirmPassword').value;

            if (newPassword.length < 8) {
                alert('Password must be at least 8 characters long');
                return false;
            }

            if (!/[A-Z]/.test(newPassword)) {
                alert('Password must contain at least one uppercase letter');
                return false;
            }

            if (!/[a-z]/.test(newPassword)) {
                alert('Password must contain at least one lowercase letter');
                return false;
            }

            if (!/[0-9]/.test(newPassword)) {
                alert('Password must contain at least one number');
                return false;
            }

            if (!/[!@#$%^&*]/.test(newPassword)) {
                alert('Password must contain at least one special character (!@#$%^&*)');
                return false;
            }

            if (newPassword !== confirmPassword) {
                alert('Passwords do not match');
                return false;
            }

            return true;
        }
    </script>
</body>
</html>