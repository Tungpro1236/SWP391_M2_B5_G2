<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="vn.edu.fpt.model.Blog, vn.edu.fpt.dao.BlogDAO, java.sql.*, vn.edu.fpt.dao.DBContext"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String blogId = request.getParameter("id");
    DBContext dbContext = new DBContext();
    BlogDAO blogDAO = new BlogDAO(dbContext.getConnection());
    Blog blog = blogDAO.getBlogById(Integer.parseInt(blogId));
    request.setAttribute("blog", blog);
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${blog.title} | OnlineLearning</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body {
            background-color: #f4f6f9;
            font-family: 'Segoe UI', sans-serif;
        }
        .navbar {
            background-color: #0d6efd;
        }
        .navbar-brand {
            color: white;
        }
        .navbar-brand:hover {
            color: #e2e6ea;
        }
        .blog-container {
            background-color: #fff;
            border-radius: 0.75rem;
            box-shadow: 0 0.5rem 1rem rgba(0,0,0,0.05);
            padding: 2rem;
            margin-bottom: 2rem;
        }
        .blog-title {
            font-size: 2.25rem;
            font-weight: 600;
            color: #212529;
        }
        .blog-meta {
            color: #6c757d;
            margin-bottom: 1.25rem;
        }
        .blog-content {
            font-size: 1.1rem;
            color: #495057;
            line-height: 1.75;
        }
        .blog-image {
    width: 100%;
    height: 350px;
    object-fit: cover;
    border-radius: 0.5rem;
    margin-bottom: 1.5rem;
}

        .btn-back {
            margin-top: 2rem;
        }
        .comment-section {
            background-color: #fdfdfe;
            border-radius: 0.75rem;
            padding: 2rem;
        }
        .comment-toggle-btn {
            transition: background 0.2s ease;
        }
        .radius-10 {
            border-radius: 10px;
        }
        .d-hidden {
            display: none;
        }
    </style>
</head>
<body>

    <%@ include file="/layout/header.jsp" %>

    <div class="container py-5">
        <div class="row">
            <div class="col-md-12">
                <div class="blog-container">
                    <h1 class="blog-title">${blog.title}</h1>

                    <div class="blog-meta">
                        <span class="me-4">
                            <i class="bi bi-calendar-event"></i>
                            <fmt:formatDate value="${blog.createdAt}" pattern="dd MMM yyyy" />
                        </span>
                        <c:if test="${blog.publishedAt != null}">
                            <span>
                                <i class="bi bi-check-circle-fill"></i>
                                <fmt:formatDate value="${blog.publishedAt}" pattern="dd MMM yyyy" />
                            </span>
                        </c:if>
                    </div>

                    <c:if test="${not empty blog.thumbnailUrl}">
                        <img src="${blog.thumbnailUrl}" class="blog-image" alt="${blog.title}">
                    </c:if>

                    <div class="blog-content">
                        ${blog.content}
                    </div>

                    <a href="blogs.jsp" class="btn btn-outline-primary btn-back">
                        <i class="bi bi-arrow-left"></i> Back to Blog List
                    </a>
                </div>

                <!-- Comment Section -->
                <div class="comment-section mt-4">
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <h4 class="mb-0">Comments (0)</h4>
                        <button class="btn btn-sm btn-outline-primary comment-toggle-btn" onclick="toggleCommentForm()">
                            <i class="fas fa-comment-dots me-1"></i> Add Your Comment
                        </button>
                    </div>

                    <div class="d-hidden mt-3" id="add_your_comment">
                        <form action="add_comment" method="post">
                            <div class="mb-3">
                                <textarea class="form-control" rows="4" placeholder="Write your comment here..." name="comment" required></textarea>
                                <input type="hidden" name="blog_id" value="${blog.id}">
                                <input type="hidden" name="parent_id" value="">
                            </div>
                            <div>
                                <button type="submit" class="btn btn-primary radius-10">
                                    Submit Comment
                                </button>
                            </div>
                        </form>
                    </div>
                </div>

            </div>
        </div>
    </div>

    <%@ include file="/layout/footer.jsp" %>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function toggleCommentForm() {
            $('#add_your_comment').toggleClass('d-hidden');
        }
    </script>
</body>
</html>
