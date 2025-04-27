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
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>${blog.title} | OnlineLearning</title>
        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Bootstrap Icons -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
        <!-- Font Awesome -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <style>
            body {
                background-color: #f8f9fa;
            }
            .navbar {
                background-color: #343a40;
            }
            .navbar-brand {
                color: white;
            }
            .navbar-brand:hover {
                color: #ddd;
            }
            .blog-container {
                background-color: white;
                border-radius: 0.5rem;
                box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
                padding: 2rem;
                margin-bottom: 2rem;
            }
            .blog-title {
                font-size: 2.5rem;
                margin-bottom: 1.5rem;
                color: #343a40;
            }
            .blog-content {
                font-size: 1.1rem;
                line-height: 1.8;
                color: #495057;
            }
            .blog-meta {
                color: #6c757d;
                margin-bottom: 1.5rem;
            }
            .blog-meta i {
                margin-right: 0.5rem;
            }
            .btn-back {
                margin-top: 1.5rem;
            }
            .blog-image {
                max-width: 100%;
                height: auto;
                border-radius: 0.5rem;
                margin-bottom: 1.5rem;
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
        <!-- Header -->
        <%@ include file="/layout/header.jsp" %>

        <div class="container py-5">
            <div class="row">
                <div class="col-md-12">
                    <div class="blog-container">
                        <!-- Blog Title -->
                        <h1 class="blog-title">${blog.title}</h1>
                        
                        <!-- Blog Meta -->
                        <div class="blog-meta">
                         
                            <span class="me-4"><i class="bi bi-calendar"></i> 
                                <fmt:formatDate value="${blog.createdAt}" pattern="dd/MM/yyyy" />
                            </span>
                            <c:if test="${blog.publishedAt != null}">
                                <span><i class="bi bi-check-circle"></i> 
                                    <fmt:formatDate value="${blog.publishedAt}" pattern="dd/MM/yyyy" />
                                </span>
                            </c:if>
                        </div>
                        
                        <!-- Blog Image -->
                        <c:if test="${not empty blog.thumbnailUrl}">
                            <img src="${blog.thumbnailUrl}" class="blog-image" alt="${blog.title}">
                        </c:if>
                        
                        <!-- Blog Content -->
                        <div class="blog-content">
                            ${blog.content}
                        </div>
                        
                        <!-- Back Button -->
                        <a href="blogs.jsp" class="btn btn-primary btn-back">
                            <i class="bi bi-arrow-left"></i> Quay lại danh sách bài viết
                        </a>
                    </div>

                    <!-- Comment Section -->
                    <div class="blog-container mt-4">
                        <div class="row mt-4 mb-3">
                            <div class="col-md-6">
                                <h4 class="fw-light">Bình luận (0)</h4>
                            </div>
                            <div class="col-md-6 text-end">
                                <button class="btn btn-primary" onclick="$('#add_your_comment').toggle();">
                                    <i class="fas fa-plus"></i> Thêm nhận xét của bạn
                                </button>
                            </div>
                        </div>

                        <div class="w-100 d-hidden mt-3" id="add_your_comment">
                            <form action="add_comment" method="post">
                                <div class="form-group">
                                    <textarea class="form-control" rows="4" 
                                              placeholder="Nhập câu trả lời của bạn" 
                                              name="comment" required></textarea>
                                    <input type="hidden" name="blog_id" value="${blog.id}">
                                    <input type="hidden" name="parent_id" value="">
                                </div>
                                <div class="form-group my-3">
                                    <button type="submit" class="btn btn-primary py-2 radius-10">
                                        Xuất bản
                                    </button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Footer -->
        <%@ include file="/layout/footer.jsp" %>

        <!-- jQuery and Bootstrap JS -->
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script>
            // Function to toggle comment form
            function toggleCommentForm() {
                $('#add_your_comment').toggleClass('d-hidden');
            }
        </script>
    </body>
</html>