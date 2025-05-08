<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Teacher Profile</title>
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
            /* Add new styles for request status */
            .request-badge {
                padding: 5px 10px;
                border-radius: 15px;
                font-size: 0.9em;
            }
            .request-pending {
                background-color: #fff3cd;
                color: #856404;
            }
            .request-approved {
                background-color: #d4edda;
                color: #155724;
            }
            .request-rejected {
                background-color: #f8d7da;
                color: #721c24;
            }
            .toast-container {
                position: fixed;
                top: 20px;
                right: 20px;
                z-index: 1000;
            }
            .custom-toast {
                min-width: 300px;
                margin-bottom: 10px;
                display: none;
                background: white;
                box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.15);
                border-radius: 0.25rem;
            }
            .toast-header {
                display: flex;
                align-items: center;
                padding: 0.5rem 0.75rem;
                border-bottom: 1px solid #dee2e6;
            }
            .toast-body {
                padding: 0.75rem;
            }
            .toast-success {
                border-left: 4px solid #198754;
            }
            .toast-error {
                border-left: 4px solid #dc3545;
            }
            .toast-warning {
                border-left: 4px solid #ffc107;
            }
        </style>
    </head>
    <body class="bg-light">
        <!-- Navbar -->
        <nav class="navbar navbar-expand-lg navbar-dark bg-primary">
            <div class="container-fluid">
                <a class="navbar-brand" href="#">Teacher Profile</a>
                <div class="d-flex">
                    <a class="btn btn-outline-light" href="login?action=logout"><i class='bx bx-log-out bx-rotate-180'></i> Logout</a>
                </div>
            </div>
        </nav>
        <div class="container-fluid">
            <div class="row">

                <!-- Sidebar -->
                <div class="col-md-3 bg-light p-4 shadow-sm rounded-end">
                    <div class="text-center mb-4">
                        <img src="admin/images/user.png" class="rounded-circle mb-2 border border-2" width="100" alt="User Image">
                        <h5 class="mb-0">${sessionScope.user.lastName}</h5>
                        <small class="text-muted">Teacher</small>
                    </div>

                    <div class="list-group">
                        <a href="teacher/profile" class="list-group-item list-group-item-action d-flex align-items-center">
                            <i class="bi bi-person me-2"></i> Teacher Profile
                        </a>
                        <a href="../TeacherDashboard" class="list-group-item list-group-item-action d-flex align-items-center">
                            <i class="bi bi-speedometer2 me-2"></i> Dashboard
                        </a>
                        <a href="../CourseController?action=manageCourse" class="list-group-item list-group-item-action d-flex align-items-center">
                            <i class="bi bi-journal-bookmark me-2"></i> Manage Courses
                        </a>
                        <a href="../LessonController?action=manageLesson" class="list-group-item list-group-item-action d-flex align-items-center">
                            <i class="bi bi-book me-2"></i> Manage Lessons
                        </a>
                    </div>
                </div>
                <!--                <div class="col-md-3 sidebar">
                                    <img src="${user.avatarUrl != null ? user.avatarUrl : 'assets/images/default-avatar.png'}" 
                                         alt="Profile" class="profile-pic">
                                    <h5 class="user-name">${user.firstName} ${user.lastName}</h5>
                
                                    <nav class="nav flex-column">
                                        <a class="nav-link active" href="profile">Profile</a>
                                        <a class="nav-link" href="password">Change Password</a>
                                        <a class="nav-link" href="#">Course and Exercise</a>
                                        <a class="nav-link" href="#">Wishlist</a>
                                        <a class="nav-link" href="#">Order History</a>
                                    </nav>
                                </div>-->

                <div class="col-md-9 p-4">
                    <div class="card shadow mb-4">
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

                            <form id="profileForm" action="${pageContext.request.contextPath}/teacher/profile" method="POST">
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
                                <div class="card shadow mb-4">
                                    <div class="card-body">
                                        <h4 class="mb-4">Teaching Information</h4>

                                        <div class="row mb-3">
                                            <div class="col-md-6">
                                                <label class="form-label">Education Level</label>
                                                <input type="text" class="form-control" name="educationLevel" 
                                                       value="${user.educationLevel}" disabled required>
                                            </div>
                                            <div class="col-md-6">
                                                <label class="form-label">Graduated School</label>
                                                <input type="text" class="form-control" name="graduatedSchool" 
                                                       value="${user.graduatedSchool}" disabled required>
                                            </div>
                                        </div>

                                        <div class="row mb-3">
                                            <div class="col-md-6">
                                                <label class="form-label">Graduated Year(Larger than 2000)</label>
                                                <input type="number" class="form-control" name="graduatedYear" 
                                                       value="${user.graduatedYear}" min="1900" 
                                                       max="<%= java.time.Year.now().getValue() %>" disabled required>
                                            </div>
                                            <div class="col-md-6">
                                                <label class="form-label">Major</label>
                                                <input type="text" class="form-control" name="major" 
                                                       value="${user.major}" disabled required>
                                            </div>
                                        </div>

                                        <div class="row mb-3">
                                            <div class="col-md-6">
                                                <label class="form-label">Teaching Experience (Years)</label>
                                                <input type="number" class="form-control" name="teachingExperienceYears" 
                                                       value="${user.teachingExperienceYears}" min="0" disabled required>
                                            </div>
                                            <div class="col-md-6">
                                                <label class="form-label">Teaching Levels</label>
                                                <input type="text" class="form-control" name="teachingLevels" 
                                                       value="${user.teachingLevels}" disabled required>
                                            </div>
                                        </div>

                                        <div class="mb-3">
                                            <label class="form-label">Subjects</label>
                                            <textarea class="form-control" name="subjects" rows="2" 
                                                      disabled required>${user.subjects}</textarea>
                                        </div>

                                        <div class="mb-3">
                                            <label class="form-label">Skills</label>
                                            <textarea class="form-control" name="skills" rows="3" 
                                                      disabled>${user.skills}</textarea>
                                        </div>

                                        <div class="mb-3">
                                            <label class="form-label">Certifications</label>
                                            <textarea class="form-control" name="certifications" rows="3" 
                                                      disabled>${user.certifications}</textarea>
                                        </div>

                                        <div class="mb-3">
                                            <label class="form-label">Teaching Philosophy</label>
                                            <textarea class="form-control" name="teachingPhilosophy" rows="4" 
                                                      disabled>${user.teachingPhilosophy}</textarea>
                                        </div>

                                        <div class="mb-3">
                                            <label class="form-label">Career Goals</label>
                                            <textarea class="form-control" name="careerGoals" rows="4" 
                                                      disabled>${user.careerGoals}</textarea>
                                        </div>
                                    </div>
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

                    <!-- Teacher Request Section -->
                    <div class="card shadow">
                        <div class="card-body">
                            <h4 class="mb-4">Teacher Verification Requests</h4>

                            <!-- Request Button -->
                            <c:if test="${!hasActiveRequest}">
                                <form action="${pageContext.request.contextPath}/teacher/request" method="POST" class="mb-4">
                                    <button type="submit" class="btn btn-primary">
                                        <i class="fas fa-paper-plane"></i> Send Verification Request
                                    </button>
                                </form>
                            </c:if>

                            <!-- Requests History Table -->
                            <div class="table-responsive">
                                <table class="table table-hover">
                                    <thead>
                                        <tr>
                                            <th>Request Date</th>
                                            <th>Status</th>
                                            <th>Reviewer</th>
                                            <th>Review Date</th>
                                            <th>Comments</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach items="${teacherRequests}" var="request">
                                            <tr>
                                                <td>${request.requestDate}</td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${request.status == 0}">
                                                            <span class="request-badge request-pending">
                                                                <i class="fas fa-clock"></i> Pending
                                                            </span>
                                                        </c:when>
                                                        <c:when test="${request.status == 1}">
                                                            <span class="request-badge request-approved">
                                                                <i class="fas fa-check-circle"></i> Approved
                                                            </span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="request-badge request-rejected">
                                                                <i class="fas fa-times-circle"></i> Rejected
                                                            </span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                                <td>${request.approverEmail}</td>
                                                <td>${request.approveDate}</td>
                                                <td>${request.rejectReason}</td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>                                
                            </div>
                        </div>
                    </div>
                    <a href="${pageContext.request.contextPath}/TeacherDashboard" class="btn btn-secondary mt-3">Back</a>

                </div>
            </div>
        </div>
        <div class="toast-container"></div>
        <jsp:include page="layout/footer.jsp" />


        <script>
            function showToast(message, type = 'error') {
                console.log('alo')
                const toastContainer = document.querySelector('.toast-container');
                const toast = document.createElement('div');
                toast.className = `custom-toast toast-${type}`;

                toast.innerHTML = `
            <div class="toast-header">
                <strong class="me-auto">${type.charAt(0).toUpperCase() + type.slice(1)}</strong>
                <button type="button" class="btn-close" onclick="this.parentElement.parentElement.remove()"></button>
            </div>
            <div class="toast-body">${message}</div>
        `;

                toastContainer.appendChild(toast);
                toast.style.display = 'block';

                // Auto hide after 5 seconds
                setTimeout(() => {
                    toast.remove();
                }, 5000);
            }
            document.addEventListener('DOMContentLoaded', function () {
                const form = document.getElementById('profileForm');
                const editButton = document.getElementById('editButton');
                const saveButton = document.getElementById('saveButton');
                const cancelButton = document.getElementById('cancelButton');
                const formInputs = form.querySelectorAll('input, textarea, select');

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
                    // Basic information validation
                    const firstName = form.firstName.value.trim();
                    const lastName = form.lastName.value.trim();
                    const email = form.email.value.trim();

                    // Name validation
                    const nameRegex = /^[a-zA-Z\s]{2,50}$/;
                    if (!nameRegex.test(firstName)) {
                        showToast('First name must be 2-50 characters long and contain only letters');
                        form.firstName.focus();
                        return;
                    }

                    if (!nameRegex.test(lastName)) {
                        showToast('Last name must be 2-50 characters long and contain only letters');
                        form.lastName.focus();
                        return;
                    }

                    // Email validation
                    const emailRegex = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6}$/;
                    if (!emailRegex.test(email)) {
                        showToast('Please enter a valid email address');
                        form.email.focus();
                        return;
                    }
                    // Validate text fields
                    const textFields = {
                        'educationLevel': 'Education Level',
                        'graduatedSchool': 'Graduated School',
                        'major': 'Major',
                        'teachingLevels': 'Teaching Levels'
                    };
                    const specialCharsRegex = /[!@#$%^&*()_+\-=\[\]{};':"\\|,.<>/?]+/;

                    for (let [fieldName, displayName] of Object.entries(textFields)) {
                        const field = form[fieldName];
                        const value = field.value.trim();

                        if (!value) {
                            showToast(displayName + ' cannot be empty or contain only spaces');
                            field.focus();
                            return;
                        }

                        if (specialCharsRegex.test(value)) {
                            showToast(displayName + ' cannot contain special characters');
                            field.focus();
                            return;
                        }
                    }

                    // Validate graduated year
                    const graduatedYear = parseInt(form.graduatedYear.value);
                    const currentYear = new Date().getFullYear();
                    if (isNaN(graduatedYear) || graduatedYear < 2000) {
                        showToast('Graduated year must be larger than 2000 ');
                        console.log('Graduated year must be larger than 2000 ');
                        form.graduatedYear.focus();
                        return;
                    }

                    // Validate teaching experience
                    const experience = parseInt(form.teachingExperienceYears.value);
                    if (isNaN(experience) || experience < 0) {
                        showToast('Teaching experience years cannot be negative');
                        form.teachingExperienceYears.focus();
                        return;
                    }

                    // Validate textarea fields
                    const textareaFields = {
                        'subjects': 'Subjects',
                        'skills': 'Skills',
                        'certifications': 'Certifications',
                        'teachingPhilosophy': 'Teaching Philosophy',
                        'careerGoals': 'Career Goals'
                    };

                    for (let [fieldName, displayName] of Object.entries(textareaFields)) {
                        const field = form[fieldName];
                        const value = field.value.trim();

                        if (value && specialCharsRegex.test(value)) {
                            showToast(displayName + ' cannot contain special characters');
                            field.focus();
                            return;
                        }
                    }
                    if (confirm('Are you sure you want to save these changes?')) {
                        this.submit();
                    }
                });
            });
        </script>
    </body>
</html>