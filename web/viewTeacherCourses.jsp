<%-- 
    Document   : viewTeacherCourses
    Created on : Apr 28, 2025, 5:56:27 PM
    Author     : regio
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Admin - View Teacher Courses</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <style>
            body {
                background-color: #f8f9fa;
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                margin: 0;
                overflow-x: hidden;
            }
            .content {
                margin-left: 30px;
                padding: 20px;
                transition: margin-left 0.3s ease;
            }
            .search-card {
                transition: box-shadow 0.3s;
            }
            .search-card:hover {
                box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2) !important;
            }
            .table-row {
                transition: transform 0.2s, box-shadow 0.2s;
            }
            .table-row:hover {
                transform: translateY(-2px);
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            }
            .form-check-input {
                cursor: pointer;
            }
            .form-check-input:checked {
                background-color: #28a745;
                border-color: #28a745;
            }
            .form-check-input:disabled {
                background-color: #6c757d;
                border-color: #6c757d;
            }
        </style>
    </head>
    <body>
        <%@ include file="/layout/sidebar.jsp" %>

        <!-- Main Content -->
        <div class="content">
            <div class="container-fluid">
                <h1 class="mb-4 text-primary fw-bold">View Teacher Courses</h1>

                <!-- Hiển thị lỗi hoặc thông báo thành công -->
                <c:if test="${not empty error}">
                    <div class="alert alert-danger shadow-sm rounded-3" role="alert">
                        ${error}
                    </div>
                </c:if>
                <c:if test="${not empty message}">
                    <div class="alert alert-success shadow-sm rounded-3" role="alert">
                        ${message}
                    </div>
                </c:if>

                <!-- Search Form -->
                <div class="card search-card shadow-sm rounded-3 mb-4">
                    <div class="card-body">
                        <form class="row g-3 align-items-center" action="viewTeacherCourses" method="GET">
                            <div class="col-auto">
                                <div class="input-group">
                                    <span class="input-group-text"><i class="bi bi-person"></i></span>
                                    <select name="teacherId" class="form-select" onchange="this.form.submit()">
                                        <option value="">Select a teacher</option>
                                        <c:forEach var="teacher" items="${teachers}">
                                            <option value="${teacher.id}" <c:if test="${selectedTeacher != null && teacher.id == selectedTeacher.id}">selected</c:if>>
                                                ${teacher.firstName} ${teacher.lastName}
                                            </option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>
                            <div class="col-auto">
                                <div class="input-group">
                                    <span class="input-group-text"><i class="bi bi-search"></i></span>
                                    <input type="text" name="search" value="${search}" class="form-control" placeholder="Search courses by title">
                                </div>
                            </div>
                            <div class="col-auto">
                                <button type="submit" class="btn btn-primary">Search</button>
                            </div>
                            <div class="col-auto">
                                <button type="reset" class="btn btn-outline-secondary" onclick="window.location.href = 'viewTeacherCourses'">Reset</button>
                            </div>
                        </form>
                    </div>
                </div>

                <!-- No Data Message -->
                <c:if test="${empty courses}">
                    <div class="alert alert-info shadow-sm rounded-3" role="alert">
                        No courses found for this teacher.
                    </div>
                </c:if>

                <!-- Data Table -->
                <div class="table-responsive">
                    <table class="table table-striped table-bordered table-hover">
                        <thead class="table-dark">
                            <tr>
                                <th>Course ID</th>
                                <th>Title</th>
                                <th>Description</th>
                                <th>Created At</th>
                                <th>Status</th>
                                <th>Change Status</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="course" items="${courses}">
                                <tr class="table-row">
                                    <td><span class="badge bg-info text-dark">${course.id}</span></td>
                                    <td>${course.title}</td>
                                    <td>${course.description}</td>
                                    <td>
                                        <fmt:formatDate value="${course.createdAt}" pattern="yyyy-MM-dd"/>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${course.status == 'active'}">
                                                <span class="badge bg-success">Active</span>
                                            </c:when>
                                            <c:when test="${course.status == 'inactive'}">
                                                <span class="badge bg-danger">Inactive</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge bg-secondary">Unknown</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <div class="form-check form-switch">
                                            <input class="form-check-input" type="checkbox" role="switch" 
                                                   id="statusSwitch_${course.id}" 
                                                   ${course.status == 'active' ? 'checked' : ''} 
                                                   onchange="changeCourseStatus(${course.id}, this.checked ? 'active' : 'inactive', this)">
                                            <label class="form-check-label" for="statusSwitch_${course.id}"></label>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>

                <!-- Pagination Controls -->
                <c:if test="${totalPages > 0}">
                    <nav aria-label="Page navigation" class="mt-4">
                        <ul class="pagination justify-content-center">
                            <!-- Previous Button -->
                            <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                <a class="page-link" href="viewTeacherCourses?page=${currentPage - 1}&teacherId=${selectedTeacher.id}&search=${search}" aria-label="Previous">
                                    <span aria-hidden="true">« Previous</span>
                                </a>
                            </li>

                            <!-- Page Numbers -->
                            <c:set var="startPage" value="${currentPage - 2 > 0 ? currentPage - 2 : 1}"/>
                            <c:set var="endPage" value="${currentPage + 2 <= totalPages ? currentPage + 2 : totalPages}"/>
                            <c:if test="${endPage - startPage < 4}">
                                <c:choose>
                                    <c:when test="${startPage == 1}">
                                        <c:set var="endPage" value="${totalPages > 5 ? 5 : totalPages}"/>
                                    </c:when>
                                    <c:when test="${endPage == totalPages}">
                                        <c:set var="startPage" value="${totalPages - 4 > 0 ? totalPages - 4 : 1}"/>
                                    </c:when>
                                </c:choose>
                            </c:if>

                            <c:forEach begin="${startPage}" end="${endPage}" var="i">
                                <li class="page-item ${currentPage == i ? 'active' : ''}">
                                    <a class="page-link" href="viewTeacherCourses?page=${i}&teacherId=${selectedTeacher.id}&search=${search}">${i}</a>
                                </li>
                            </c:forEach>

                            <!-- Next Button -->
                            <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                                <a class="page-link" href="viewTeacherCourses?page=${currentPage + 1}&teacherId=${selectedTeacher.id}&search=${search}" aria-label="Next">
                                    <span aria-hidden="true">Next »</span>
                                </a>
                            </li>
                        </ul>
                    </nav>
                </c:if>
            </div>
        </div>

        <%@ include file="/layout/footer.jsp" %>

        <!-- JavaScript cho AJAX -->
        <script>
            function changeCourseStatus(courseId, status, toggle) {
                $.ajax({
                    url: 'changeCourseStatus',
                    type: 'POST',
                    data: {
                        courseId: courseId,
                        status: status
                    },
                    success: function (response) {
                        if (response === 'success') {
                            // Cập nhật badge trạng thái
                            var badge = $(toggle).closest('tr').find('.badge');
                            if (status === 'active') {
                                badge.removeClass('bg-danger bg-secondary').addClass('bg-success').text('Active');
                            } else {
                                badge.removeClass('bg-success bg-secondary').addClass('bg-danger').text('Inactive');
                            }
                            // Hiển thị thông báo thành công
                            var alert = $('<div class="alert alert-success shadow-sm rounded-3" role="alert">' +
                                    'Status updated successfully</div>');
                            $('.container-fluid').prepend(alert);
                            setTimeout(function () {
                                alert.fadeOut('slow', function () {
                                    $(this).remove();
                                });
                            }, 3000);
                        } else {
                            // Hiển thị thông báo lỗi
                            var message = response.startsWith('error:') ? response.substring(6) : 'Failed to update status';
                            var alert = $('<div class="alert alert-danger shadow-sm rounded-3" role="alert">' +
                                    message + '</div>');
                            $('.container-fluid').prepend(alert);
                            setTimeout(function () {
                                alert.fadeOut('slow', function () {
                                    $(this).remove();
                                });
                            }, 3000);
                            // Hoàn tác trạng thái công tắc
                            toggle.checked = !toggle.checked;
                        }
                    },
                    error: function () {
                        // Hiển thị lỗi chung
                        var alert = $('<div class="alert alert-danger shadow-sm rounded-3" role="alert">' +
                                'Failed to update status. Please try again.</div>');
                        $('.container-fluid').prepend(alert);
                        setTimeout(function () {
                            alert.fadeOut('slow', function () {
                                $(this).remove();
                            });
                        }, 3000);
                        // Hoàn tác trạng thái công tắc
                        toggle.checked = !toggle.checked;
                    }
                });
            }
        </script>
    </body>
</html>