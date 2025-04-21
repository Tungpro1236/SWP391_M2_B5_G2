<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Forgot Password - Boost Your Style</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .forgot-container {
            max-width: 400px;
            margin: 100px auto;
            padding: 30px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
            border-radius: 8px;
        }
        .error-message {
            color: #dc3545;
            margin-bottom: 10px;
            text-align: center;
        }
        .success-message {
            color: #198754;
            margin-bottom: 10px;
            text-align: center;
        }
        .form-label {
            font-weight: 500;
        }
        .email-icon {
            color: #6c757d;
            margin-right: 10px;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="forgot-container">
            <h2 class="text-center mb-3">Forgot Password</h2>
            <p class="text-center text-muted mb-4">Provide your valid email address</p>
            
            <c:if test="${not empty error}">
                <div class="error-message">
                    <c:out value="${error}"/>
                </div>
            </c:if>
            
            <c:if test="${not empty success}">
                <div class="success-message">
                    <c:out value="${success}"/>
                </div>
            </c:if>
            
            <form action="<c:url value='/password'/>" method="post" id="forgotPasswordForm">
                <input type="hidden" name="action" value="forgot">
                
                <div class="mb-4">
                    <label class="form-label">Your email</label>
                    <div class="input-group">
                        <span class="input-group-text">
                            <i class="email-icon">✉</i>
                        </span>
                        <input type="email" name="email" class="form-control" placeholder="Email" required>
                    </div>
                </div>
                
                <button type="submit" class="btn btn-primary w-100 mb-3">Send request</button>
                
                <div class="text-center">
                    Want to back? <a href="<c:url value='/login.jsp'/>">Sign in</a>
                </div>
            </form>
        </div>
    </div>
</body>
</html>