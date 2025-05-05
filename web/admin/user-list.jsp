<%@page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>User Management</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <style>
        body {
            background-color: #f8f9fa;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            overflow-x: hidden;
        }
        .status-badge {
            width: 85px;
            text-align: center;
        }
        .table td {
            vertical-align: middle;
        }
    </style>
</head>
<body class="bg-light">
    <%@ include file="/layout/sidebar.jsp" %>

    <div class="container mt-4">
        <div class="card shadow-sm">
            <div class="card-body">
                <h2 class="card-title mb-4">User Management</h2>
                
                <!-- Search and Filter section -->
                <div class="row mb-4">
                    <div class="col-md-6">
                        <div class="input-group">
                            <input type="text" id="searchInput" class="form-control" placeholder="Search by name or email...">
                            <button class="btn btn-primary" id="searchBtn">
                                <i class="fas fa-search"></i> Search
                            </button>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <select class="form-select" id="roleFilter">
                            <option value="">All Roles</option>
                            <option value="1">Admin</option>
                            <option value="2">Teacher</option>
                            <option value="3">Student</option>
                        </select>
                    </div>
                    <div class="col-md-3">
                        <select class="form-select" id="statusFilter">
                            <option value="">All Status</option>
                            <option value="true">Active</option>
                            <option value="false">Inactive</option>
                        </select>
                    </div>
                </div>

                <!-- User Table -->
                <div class="table-responsive">
                    <table class="table table-hover">
                        <thead class="table-light">
                            <tr>
                                <th>ID</th>
                                <th>Name</th>
                                <th>Email</th>
                                <th>Role</th>
                                <th>Created Date</th>
                                <th>Status</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${users}" var="user">
                                <tr>
                                    <td>${user.id}</td>
                                    <td>${user.firstName} ${user.lastName}</td>
                                    <td>${user.email}</td>
                                    <td>
                                        <span class="badge bg-info">
                                            ${user.roleId == 1 ? 'Admin' : user.roleId == 2 ? 'Teacher' : 'Student'}
                                        </span>
                                    </td>
                                    <td>${user.createdAt}</td>
                                    <td>
                                        <span class="badge status-badge ${user.status ? 'bg-success' : 'bg-danger'}">
                                            ${user.status ? 'Active' : 'Inactive'}
                                        </span>
                                    </td>
                                    <td>
                                        <button class="btn btn-sm ${user.status ? 'btn-outline-danger' : 'btn-outline-success'} toggle-status" 
                                                data-user-id="${user.id}" 
                                                data-status="${!user.status}">
                                            <i class="fas ${user.status ? 'fa-ban' : 'fa-check-circle'}"></i>
                                            ${user.status ? 'Deactivate' : 'Activate'}
                                        </button>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>

                <!-- Pagination -->
                <nav class="mt-4">
                    <ul class="pagination justify-content-center">
                        <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                            <a class="page-link" href="?page=${currentPage - 1}${not empty param.search ? '&search='.concat(param.search) : ''}${not empty param.role ? '&role='.concat(param.role) : ''}${not empty param.status ? '&status='.concat(param.status) : ''}">
                                <i class="fas fa-chevron-left"></i>
                            </a>
                        </li>
                        <c:forEach begin="1" end="${totalPages}" var="i">
                            <li class="page-item ${currentPage == i ? 'active' : ''}">
                                <a class="page-link" href="?page=${i}${not empty param.search ? '&search='.concat(param.search) : ''}${not empty param.role ? '&role='.concat(param.role) : ''}${not empty param.status ? '&status='.concat(param.status) : ''}">${i}</a>
                            </li>
                        </c:forEach>
                        <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                            <a class="page-link" href="?page=${currentPage + 1}${not empty param.search ? '&search='.concat(param.search) : ''}${not empty param.role ? '&role='.concat(param.role) : ''}${not empty param.status ? '&status='.concat(param.status) : ''}">
                                <i class="fas fa-chevron-right"></i>
                            </a>
                        </li>
                    </ul>
                </nav>
            </div>
        </div>
    </div>

    <%@ include file="/layout/footer.jsp" %>

    <script>
        function performSearch() {
            const searchText = document.getElementById('searchInput').value;
            const roleValue = document.getElementById('roleFilter').value;
            const statusValue = document.getElementById('statusFilter').value;
            
            let url = '${pageContext.request.contextPath}/admin/users?page=1';
            
            if (searchText) {
                url += '&search=' + encodeURIComponent(searchText);
            }
            if (roleValue) {
                url += '&role=' + roleValue;
            }
            if (statusValue) {
                url += '&status=' + statusValue;
            }
            
            window.location.href = url;
        }

        // Search button click
        document.getElementById('searchBtn').addEventListener('click', performSearch);

        // Enter key in search input
        document.getElementById('searchInput').addEventListener('keypress', function(e) {
            if (e.key === 'Enter') {
                performSearch();
            }
        });

        // Role and Status filter change
        document.getElementById('roleFilter').addEventListener('change', performSearch);
        document.getElementById('statusFilter').addEventListener('change', performSearch);

        // Set initial values from URL params
        window.addEventListener('load', function() {
            const urlParams = new URLSearchParams(window.location.search);
            const search = urlParams.get('search');
            const role = urlParams.get('role');
            const status = urlParams.get('status');

            if (search) document.getElementById('searchInput').value = search;
            if (role) document.getElementById('roleFilter').value = role;
            if (status) document.getElementById('statusFilter').value = status;
        });

        document.querySelectorAll('.toggle-status').forEach(button => {
            button.addEventListener('click', function() {
                if (!confirm('Are you sure you want to change this user\'s status?')) {
                    return;
                }
                
                const userId = this.getAttribute('data-user-id');
                const newStatus = this.getAttribute('data-status');
                
                fetch('${pageContext.request.contextPath}/admin/users', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/x-www-form-urlencoded',
                    },
                    body: 'action=updateStatus&userId=' + userId + '&status=' + newStatus
                })
                .then(response => response.json())
                .then(data => {
                    if(data.success) {
                        window.location.reload();
                    } else {
                        alert('Failed to update status');
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                    alert('Error updating status');
                });
            });
        });
    </script>
</body>
</html>