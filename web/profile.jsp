<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>User Profile</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
        <style>
            .profile-image {
                width: 150px;
                height: 150px;
                object-fit: cover;
                border-radius: 50%;
            }
            .form-control:disabled {
                background-color: #f8f9fa;
                opacity: 1;
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
            .error-message {
                color: #dc3545;
            }
            .success-message {
                color: #198754;
            }
        </style>
    </head>
    <body class="bg-light">
        <div class="container-fluid">
            <div class="row">
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
                        <a class="nav-link" href="home">Home Page</a>
                        <a class="nav-link text-danger" href="login?action=logout">Logout</a>
                    </nav>
                </div>
                <div class="col-md-9 content">
                    <div class="card shadow">
                        <div class="card-body">
                            <div class="text-center mb-4">
                                <img src="${user.avatarUrl != null ? user.avatarUrl : 'assets/images/default-avatar.png'}" 
                                     alt="Profile" class="profile-image mb-3">
                                <h3>Profile Information</h3>
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
                            </div>

                            <form id="profileForm" action="${pageContext.request.contextPath}/profile" method="POST">
                                <input type="hidden" name="action" value="update">
                                <div class="row mb-3">
                                    <div class="col-md-6">
                                        <label class="form-label">First Name</label>
                                        <input type="text" class="form-control" name="firstName" 
                                               value="${user.firstName}" disabled required>
                                    </div>
                                    <div class="col-md-6">
                                        <label class="form-label">Last Name</label>
                                        <input type="text" class="form-control" name="lastName" 
                                               value="${user.lastName}" disabled required>
                                    </div>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Gender</label>
                                    <select name="genderId" class="form-select" disabled required>
                                        <option value="1" ${user.genderId == 1 ? 'selected' : ''}>Male</option>
                                        <option value="2" ${user.genderId == 2 ? 'selected' : ''}>Female</option>
                                        <option value="3" ${user.genderId == 3 ? 'selected' : ''}>Other</option>
                                    </select>
                                </div>

                                <div class="mb-3">
                                    <label class="form-label">Email</label>
                                    <input type="email" class="form-control" name="email" 
                                           value="${user.email}" disabled required>
                                </div>

                                <div class="mb-3">
                                    <label class="form-label">Avatar URL</label>
                                    <input type="url" class="form-control" name="avatarUrl" 
                                           value="${user.avatarUrl}" disabled>
                                </div>

                                <div class="d-flex justify-content-end gap-2">
                                    <button type="button" id="editButton" class="btn btn-primary">
                                        <i class="fas fa-edit"></i> Edit Profile
                                    </button>
                                    <button type="submit" id="saveButton" class="btn btn-success" style="display: none;">
                                        <i class="fas fa-save"></i> Save Changes
                                    </button>
                                    <button type="button" id="cancelButton" class="btn btn-secondary" style="display: none;">
                                        <i class="fas fa-times"></i> Cancel
                                    </button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
        <script>
            document.addEventListener('DOMContentLoaded', function () {
                const form = document.getElementById('profileForm');
                const editButton = document.getElementById('editButton');
                const saveButton = document.getElementById('saveButton');
                const cancelButton = document.getElementById('cancelButton');
                const formInputs = form.querySelectorAll('input, textarea , select');

                // Store original values for cancel functionality
                const originalValues = {};
                formInputs.forEach(input => {
                    originalValues[input.name] = input.value;
                });

                editButton.addEventListener('click', function () {
                    formInputs.forEach(input => input.disabled = false);
                    editButton.style.display = 'none';
                    saveButton.style.display = 'block';
                    cancelButton.style.display = 'block';
                });

                cancelButton.addEventListener('click', function () {
                    formInputs.forEach(input => {
                        input.value = originalValues[input.name];
                        input.disabled = true;
                    });
                    editButton.style.display = 'block';
                    saveButton.style.display = 'none';
                    cancelButton.style.display = 'none';
                });

                form.addEventListener('submit', function (e) {
                    e.preventDefault();
                    if (confirm('Are you sure you want to save these changes?')) {
                        this.submit();
                    }
                });
            });
        </script>
    </body>
</html>