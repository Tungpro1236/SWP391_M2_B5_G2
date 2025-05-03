<%-- 
    Document   : RefundRequest
    Created on : Apr 29, 2025, 3:48:28 AM
    Author     : regio
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Student Refund Requests</title>
        
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
            .search-card, .form-card {
                transition: box-shadow 0.3s;
            }
            .search-card:hover, .form-card:hover {
                box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2) !important;
            }
            .table-row {
                transition: transform 0.2s, box-shadow 0.2s;
            }
            .table-row:hover {
                transform: translateY(-2px);
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            }
            .btn-submit {
                transition: transform 0.2s, background-color 0.3s;
            }
            .btn-submit:hover {
                transform: scale(1.05);
                background-color: #0d6efd;
            }
            .btn-delete {
                transition: transform 0.2s, background-color 0.3s;
            }
            .btn-delete:hover {
                transform: scale(1.05);
                background-color: #dc3545;
            }
        </style>
    </head>
    <body>
        <%@ include file="/layout/header.jsp" %>
        <div class="content">
            <div class="container-fluid">
                <h1 class="mb-4 text-primary fw-bold">Refund Requests</h1>
                <c:if test="${not empty error}">
                    <div class="alert alert-danger shadow-sm rounded-3">${error}</div>
                </c:if>
                <div class="card form-card shadow-sm rounded-3 mb-4">
                    <div class="card-body">
                        <h3 class="mb-3">Request a Refund</h3>
                        <c:if test="${empty enrolledCourses}">
                            <div class="alert alert-warning shadow-sm rounded-3">
                                You have no enrolled courses available for a refund request.
                            </div>
                        </c:if>
                        <c:if test="${not empty enrolledCourses}">
                            <form action="${pageContext.request.contextPath}/student/refund" method="post" class="row g-3">
                                <div class="col-12">
                                    <label for="enrollmentSelection" class="form-label">Select Enrolled Course</label>
                                    <select id="enrollmentSelection" name="enrollmentSelection" class="form-control" required>
                                        <option value="">Select a course</option>
                                        <c:forEach var="enrollment" items="${enrolledCourses}">
                                            <option value="${enrollment.id}:${enrollment.courseId}">${enrollment.title}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                                <div class="col-12">
                                    <label for="reason" class="form-label">Reason for Refund</label>
                                    <textarea id="reason" name="reason" rows="4" class="form-control" required></textarea>
                                </div>
                                <div class="col-12">
                                    <button type="submit" class="btn btn-primary btn-submit">Submit Request</button>
                                </div>
                            </form>
                        </c:if>
                    </div>
                </div>
                <div class="card search-card shadow-sm rounded-3 mb-4">
                    <div class="card-body">
                        <form class="row g-3 align-items-center" method="GET">
                            <div class="col-auto">
                                <div class="input-group">
                                    <span class="input-group-text"><i class="bi bi-search"></i></span>
                                    <input type="text" name="keyword" value="${fn:escapeXml(param.keyword)}" class="form-control" placeholder="Search by Course ID or Status">
                                </div>
                            </div>
                            <div class="col-auto">
                                <button type="submit" class="btn btn-primary">Search</button>
                            </div>
                            <div class="col-auto">
                                <button type="reset" class="btn btn-outline-secondary" onclick="window.location.href = '${pageContext.request.contextPath}/student/refund'">Reset</button>
                            </div>
                        </form>
                    </div>
                </div>
                <c:if test="${empty refundRequests}">
                    <div class="alert alert-info shadow-sm rounded-3">No refund requests found.</div>
                </c:if>
                <c:if test="${not empty refundRequests}">
                    <div class="table-responsive">
                        <table class="table table-striped table-bordered table-hover">
                            <thead class="table-dark">
                                <tr><th>ID</th><th>Course ID</th><th>Request Date</th><th>Reason</th><th>Status</th><th>Processed Date</th><th>Action</th></tr>
                            </thead>
                            <tbody>
                                <c:forEach var="request" items="${refundRequests}">
                                    <tr class="table-row">
                                        <td><span class="badge bg-info text-dark">${request.id}</span></td>
                                        <td>${request.courseId}</td>
                                        <td><fmt:formatDate value="${request.requestDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                                        <td>${request.reason}</td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${request.status == 'pending'}"><span class="badge bg-warning text-dark">Pending</span></c:when>
                                                <c:when test="${request.status == 'approved'}"><span class="badge bg-success">Approved</span></c:when>
                                                <c:when test="${request.status == 'rejected'}"><span class="badge bg-danger">Rejected</span></c:when>
                                                <c:otherwise><span class="badge bg-secondary">Unknown</span></c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td><c:choose><c:when test="${not empty request.processedDate}"><fmt:formatDate value="${request.processedDate}" pattern="yyyy-MM-dd HH:mm:ss"/></c:when><c:otherwise>-</c:otherwise></c:choose></td>
                                                <td>
                                            <c:if test="${request.status == 'pending'}">
                                                <form action="${pageContext.request.contextPath}/student/refund" method="post" style="display:inline;">
                                                    <input type="hidden" name="action" value="delete">
                                                    <input type="hidden" name="requestId" value="${request.id}">
                                                    <button type="submit" class="btn btn-danger btn-delete">Delete</button>
                                                </form>
                                            </c:if>
                                            <c:if test="${request.status != 'pending'}">
                                                <span class="text-muted">Cannot delete</span>
                                            </c:if>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </c:if>
                <c:if test="${not empty totalPages && totalPages > 0}">
                    <nav aria-label="Page navigation" class="mt-4">
                        <ul class="pagination justify-content-center">
                            <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                <a class="page-link" href="${pageContext.request.contextPath}/student/refund?page=${currentPage - 1}&keyword=${fn:escapeXml(param.keyword)}" aria-label="Previous">
                                    <span aria-hidden="true">« Previous</span>
                                </a>
                            </li>
                            <c:set var="startPage" value="${currentPage - 2 > 0 ? currentPage - 2 : 1}"/>
                            <c:set var="endPage" value="${currentPage + 2 <= totalPages ? currentPage + 2 : totalPages}"/>
                            <c:if test="${endPage - startPage < 4}">
                                <c:choose>
                                    <c:when test="${startPage == 1}"><c:set var="endPage" value="${totalPages > 5 ? 5 : totalPages}"/></c:when>
                                    <c:when test="${endPage == totalPages}"><c:set var="startPage" value="${totalPages - 4 > 0 ? totalPages - 4 : 1}"/></c:when>
                                </c:choose>
                            </c:if>
                            <c:forEach var="i" begin="${startPage}" end="${endPage}">
                                <li class="page-item ${currentPage == i ? 'active' : ''}">
                                    <a class="page-link" href="${pageContext.request.contextPath}/student/refund?page=${i}&keyword=${fn:escapeXml(param.keyword)}">${i}</a>
                                </li>
                            </c:forEach>
                            <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                                <a class="page-link" href="${pageContext.request.contextPath}/student/refund?page=${currentPage + 1}&keyword=${fn:escapeXml(param.keyword)}" aria-label="Next">
                                    <span aria-hidden="true">Next »</span>
                                </a>
                            </li>
                        </ul>
                    </nav>
                </c:if>
            </div>
        </div>
        <%@ include file="/layout/footer.jsp" %>
    </body>
</html>