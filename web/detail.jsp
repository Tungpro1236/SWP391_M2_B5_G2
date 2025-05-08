<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>My Order Detail</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
        <style>
            .empty-cart-icon {
                font-size: 5rem;
                color: #6c757d;
                margin-bottom: 1rem;
            }
        </style>
    </head>
    <body>
        <%@ include file="/layout/header.jsp" %>

        <div class="container py-5">
            <c:if test="${not empty message}">
                <div class="alert alert-warning alert-dismissible fade show" role="alert">
                    ${message}
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            </c:if>


            <div class="table-responsive">
                <table class="table table-bordered table-hover align-middle">
                    <thead class="table-dark text-center">
                        <tr>
                            <th>#</th>
                            <th>Course</th>
                            <th>Title</th>
                            <th>Price</th>
                            <th>Description</th>
                            <th>Status</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${details}" var="item" varStatus="status">
                            <tr>
                                <td class="text-center">${status.index + 1}</td>
                                <td class="thumbnail-img">
                                    <a href="LessonController?courseId=${item.productID}" class="text-decoration-none">
                                        <img class="img-fluid" src="${item.image}" style="width: 5rem;" alt="" />
                                    </a>
                                </td>
                                <td  class="text-success fw-bold">${item.title}</td>
                                <td>$ ${item.price}</td>
                                <td>${item.description}</td>
                                <td>${item.status}</td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>



            <!-- Nút quay lại danh sách khóa học -->
            <a href="CourseController" class="btn btn-secondary mt-3">
                <i class="bi bi-arrow-left"></i> Quay lại danh sách khóa học
            </a>
        </div>

        <%@ include file="/layout/footer.jsp" %>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>