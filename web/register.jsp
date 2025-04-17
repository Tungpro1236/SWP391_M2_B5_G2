<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Register - Boost Your Style</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .register-container {
            max-width: 600px;
            margin: 50px auto;
            padding: 20px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
            border-radius: 8px;
        }
        .error-message {
            color: #dc3545;
            margin-bottom: 10px;
            text-align: center;
        }
        .form-label {
            font-weight: 500;
        }
        .btn-register {
            width: 100%;
            padding: 10px;
            background-color: #0d6efd;
            border: none;
        }
        .login-link {
            text-align: center;
            margin-top: 20px;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="register-container">
            <h2 class="text-center mb-4">Create Account</h2>
            
            <c:if test="${not empty error}">
                <div class="error-message">
                    <c:out value="${error}"/>
                </div>
            </c:if>
            
            <form action="<c:url value='/user'/>" method="post" id="registerForm" onsubmit="return validateForm()">
                <input type="hidden" name="action" value="register">
                
                <div class="row">
                    <div class="col-md-4 mb-3">
                        <label class="form-label">First Name</label>
                        <input type="text" name="firstName" class="form-control" required>
                    </div>
                    <div class="col-md-4 mb-3">
                        <label class="form-label">Middle Name</label>
                        <input type="text" name="middleName" class="form-control">
                    </div>
                    <div class="col-md-4 mb-3">
                        <label class="form-label">Last Name</label>
                        <input type="text" name="lastName" class="form-control" required>
                    </div>
                </div>
                
                <div class="mb-3">
                    <label class="form-label">Email</label>
                    <input type="email" name="email" class="form-control" required>
                </div>
                
                <div class="mb-3">
                    <label class="form-label">Gender</label>
                    <select name="genderId" class="form-select" required>
                        <option value="1">Male</option>
                        <option value="2">Female</option>
                        <option value="3">Other</option>
                    </select>
                </div>
                
                <div class="mb-3">
                    <label class="form-label">Password</label>
                    <input type="password" name="password" id="password" class="form-control" required>
                </div>
                
                <div class="mb-3">
                    <label class="form-label">Confirm Password</label>
                    <input type="password" id="confirmPassword" class="form-control" required>
                </div>
                
                <div class="mb-3">
                    <label class="form-label">Avatar URL</label>
                    <input type="url" name="avatarUrl" class="form-control">
                </div>
                
                <button type="submit" class="btn btn-primary btn-register">Create Account</button>
            </form>
            
            <div class="login-link">
                Already have an account? <a href="<c:url value='/login.jsp'/>">Login</a>
            </div>
        </div>
    </div>
    
    <script>
    function validateForm() {
        const form = document.getElementById('registerForm');
        const password = document.getElementById('password').value;
        const confirmPassword = document.getElementById('confirmPassword').value;
        
        // Password validation
        if (password.length < 8) {
            alert('Password must be at least 8 characters long');
            return false;
        }
        
        if (!/[A-Z]/.test(password)) {
            alert('Password must contain at least one uppercase letter');
            return false;
        }
        
        if (!/[a-z]/.test(password)) {
            alert('Password must contain at least one lowercase letter');
            return false;
        }
        
        if (!/[0-9]/.test(password)) {
            alert('Password must contain at least one number');
            return false;
        }
        
        if (!/[!@#$%^&*]/.test(password)) {
            alert('Password must contain at least one special character (!@#$%^&*)');
            return false;
        }
        
        // Confirm password validation
        if (password !== confirmPassword) {
            alert('Passwords do not match');
            return false;
        }
        
        // Name validation
        const firstName = form.firstName.value.trim();
        const lastName = form.lastName.value.trim();
        
        if (firstName.length < 2 || lastName.length < 2) {
            alert('First name and last name must be at least 2 characters long');
            return false;
        }
        
        // Email validation
        const email = form.email.value;
        const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        if (!emailRegex.test(email)) {
            alert('Please enter a valid email address');
            return false;
        }
        
        return true;
    }
    </script>
</body>
</html>