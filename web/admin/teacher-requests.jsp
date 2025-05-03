<%@page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Teacher Verification Requests - Admin</title>
        
        <style>
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
        </style>
    </head>
    <body class="bg-light">
        <div class="container-fluid">
            <div class="row">
                <%@ include file="/layout/header.jsp" %>
                <%@ include file="/layout/sidebar.jsp" %>

                <div class="col-md-12 p-4">
                    <div class="card shadow">
                        <div class="card-body">

                            <h3 class="card-title mb-4">Teacher Requests</h3>
                      


                            <!-- Status Filter -->
                            <div class="row mb-4">
                                <div class="col-md-3">
                                    <form action="${pageContext.request.contextPath}/admin/teacher-requests" method="GET" id="filterForm">
                                        <select name="status" class="form-select" onchange="this.form.submit()">
                                            <option value="" ${param.status == null ? 'selected' : ''}>All Status</option>
                                            <option value="0" ${param.status == '0' ? 'selected' : ''}>Pending</option>
                                            <option value="1" ${param.status == '1' ? 'selected' : ''}>Approved</option>
                                            <option value="-1" ${param.status == '-1' ? 'selected' : ''}>Rejected</option>
                                        </select>
                                    </form>
                                </div>
                            </div>

                            <!-- Requests Table -->
                            <div class="table-responsive">
                                <table class="table table-hover">
                                    <thead>
                                        <tr>
                                            <th>Request Date</th>
                                            <th>Teacher Email</th>
                                            <th>Status</th>
                                            <th>Review Date</th>
                                            <th>Comments</th>
                                            <th>Actions</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach items="${requests}" var="request">
                                            <tr>
                                                <td>${request.requestDate}</td>
                                                <td>${request.teacherEmail}</td>
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
                                                <td>${request.approveDate}</td>
                                                <td>${request.rejectReason}</td>
                                                <td>
                                                    <c:if test="${request.status == 0}">
                                                        <button class="btn btn-success btn-sm" 
                                                                onclick="approveRequest(${request.id})">
                                                            <i class="fas fa-check"></i> Approve
                                                        </button>
                                                        <button class="btn btn-danger btn-sm" 
                                                                onclick="showRejectModal(${request.id})">
                                                            <i class="fas fa-times"></i> Reject
                                                        </button>
                                                    </c:if>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>

                            <!-- Pagination -->
                            <nav aria-label="Page navigation" class="mt-4">
                                <ul class="pagination justify-content-center">
                                    <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                        <a class="page-link" href="?page=${currentPage - 1}&status=${param.status}">Previous</a>
                                    </li>
                                    <c:forEach begin="1" end="${totalPages}" var="i">
                                        <li class="page-item ${currentPage == i ? 'active' : ''}">
                                            <a class="page-link" href="?page=${i}&status=${param.status}">${i}</a>
                                        </li>
                                    </c:forEach>
                                    <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                                        <a class="page-link" href="?page=${currentPage + 1}&status=${param.status}">Next</a>
                                    </li>
                                </ul>
                            </nav>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Reject Modal -->
        <div class="modal fade" id="rejectModal" tabindex="-1">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Reject Request</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body">
                        <form id="rejectForm">
                            <input type="hidden" id="requestId" name="requestId">
                            <div class="mb-3">
                                <label class="form-label">Rejection Reason</label>
                                <textarea class="form-control" name="rejectReason" rows="3" required></textarea>
                            </div>
                        </form>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" onclick="cancelReject()">Cancel</button>
                        <button type="button" class="btn btn-danger" onclick="submitReject()">Reject</button>
                    </div>
                </div>
            </div>
        </div>
        <%@ include file="/layout/footer.jsp" %>
        
        <script>
                            const rejectModal = new bootstrap.Modal(document.getElementById('rejectModal'));

                            function showRejectModal(requestId) {
                                document.getElementById('requestId').value = requestId;
                                document.querySelector('#rejectModal textarea').value = ''; // Clear previous reason
                                rejectModal.show();
                            }

                            function approveRequest(requestId) {
                                if (confirm('Are you sure you want to approve this request?')) {
                                    const form = document.createElement('form');
                                    form.method = 'POST';
                                    form.action = '${pageContext.request.contextPath}/admin/teacher-requests/approve';

                                    const input = document.createElement('input');
                                    input.type = 'hidden';
                                    input.name = 'requestId';
                                    input.value = requestId;

                                    form.appendChild(input);
                                    document.body.appendChild(form);
                                    form.submit();
                                }
                            }

                            function cancelReject() {
                                document.querySelector('#rejectModal textarea').value = '';
                                rejectModal.hide();
                            }

                            function submitReject() {
                                const requestId = document.getElementById('requestId').value;
                                const reason = document.querySelector('#rejectModal textarea').value.trim();

                                if (!reason) {
                                    alert('Please provide a reason for rejection');
                                    return;
                                }

                                const form = document.createElement('form');
                                form.method = 'POST';
                                form.action = '${pageContext.request.contextPath}/admin/teacher-requests/reject';

                                const requestIdInput = document.createElement('input');
                                requestIdInput.type = 'hidden';
                                requestIdInput.name = 'requestId';
                                requestIdInput.value = requestId;

                                const reasonInput = document.createElement('input');
                                reasonInput.type = 'hidden';
                                reasonInput.name = 'rejectReason';
                                reasonInput.value = reason;

                                form.appendChild(requestIdInput);
                                form.appendChild(reasonInput);
                                document.body.appendChild(form);
                                form.submit();
                            }
        </script>
    </body>
</html>