<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Login - Boost Your Style</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .login-container {
            max-width: 400px;
            margin: 100px auto;
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
        .btn-login {
            width: 100%;
            padding: 10px;
            background-color: #0d6efd;
            border: none;
        }
        .signup-link {
            text-align: center;
            margin-top: 20px;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="login-container">
            <h2 class="text-center mb-4">Login</h2>
            
            <c:if test="${not empty error}">
                <div class="error-message">
                    <c:out value="${error}"/>
                </div>
            </c:if>
            
            <form action="<c:url value='/user'/>" method="post">
                <input type="hidden" name="action" value="login">
                
                <div class="mb-3">
                    <label class="form-label">Email</label>
                    <input type="email" name="email" class="form-control" required>
                </div>
                
                <div class="mb-3">
                    <label class="form-label">Password</label>
                    <input type="password" name="password" class="form-control" required>
                </div>
                
                <button type="submit" class="btn btn-primary btn-login">Login</button>
            </form>
            
            <div class="signup-link">
                Don't have an account? <a href="<c:url value='/register.jsp'/>">Sign up</a>
            </div>
        </div>
    </div>
</body>
</html>