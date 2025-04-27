<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Reset Password - Boost Your Style</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        .password-container {
            max-width: 400px;
            margin: 100px auto;
            padding: 30px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
            border-radius: 8px;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="password-container">
            <h2 class="text-center mb-4">Change Password</h2>
            
            <form action="reset-password" method="post" onsubmit="return validateForm()">
                <input type="hidden" name="action" value="reset">
                <input type="hidden" name="email" value="${email}">
                
                <div class="mb-3">
                    <div class="input-group">
                        <input type="password" name="newPassword" id="newPassword" 
                               class="form-control" placeholder="Enter new password" required>
                        <span class="input-group-text" onclick="togglePassword('newPassword')">
                            <i class="bi bi-eye-slash"></i>
                        </span>
                    </div>
                </div>
                
                <div class="mb-4">
                    <div class="input-group">
                        <input type="password" id="confirmPassword" 
                               class="form-control" placeholder="Re-enter password" required>
                        <span class="input-group-text" onclick="togglePassword('confirmPassword')">
                            <i class="bi bi-eye-slash"></i>
                        </span>
                    </div>
                </div>
                
                <button type="submit" class="btn btn-primary w-100 mb-3">Continue</button>
                
                <div class="text-center">
                    <a href="login.jsp">Back to Login</a>
                </div>
            </form>
        </div>
    </div>
    
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