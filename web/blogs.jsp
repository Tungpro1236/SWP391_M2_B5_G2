<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="vn.edu.fpt.model.Blog, vn.edu.fpt.dao.BlogDAO, java.util.List, vn.edu.fpt.dao.DBContext"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Blog</title>
        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Bootstrap Icons -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
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
            .course-card {
                transition: transform 0.3s;
                border: none;
                box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
                border-radius: 0.5rem;
            }
            .course-card:hover {
                transform: translateY(-5px);
                box-shadow: 0 10px 20px rgba(0,0,0,0.1);
            }
            .course-image {
                height: 200px;
                object-fit: cover;
                border-radius: 0.5rem 0.5rem 0 0;
            }
            .category-section {
                margin-bottom: 30px;
            }
            .pagination .page-link {
                color: #007bff;
            }
            .pagination .page-item.active .page-link {
                background-color: #007bff;
                border-color: #007bff;
                color: white;
            }
        </style>
    </head>
<body>
    <%@ include file="/layout/header.jsp" %>

    <div class="container py-5">
        <h1 class="text-center mb-5">List Blogs</h1>

        <!-- Phần tìm kiếm -->
        <div class="search-section">
            <form action="blogs.jsp" method="GET" class="card p-4">
                <h4 class="mb-3">Search</h4>
                <div class="input-group">
                    <input type="text" class="form-control" placeholder="Search articles..." 
                           name="search" value="${param.search}">
                    <button class="btn btn-primary" type="submit">
                        <i class="bi bi-search"></i> Search
                    </button>
                </div>
            </form>
        </div>
                     <div class="text-end mb-4">
    <a href="add-Blogs.jsp" class="btn btn-primary">
        <i class="bi bi-plus-circle"></i> Thêm Blog Mới
    </a>
</div>

        <%
            // Thiết lập phân trang
            int currentPage = 1;
            int recordsPerPage = 6;
            
            if(request.getParameter("page") != null) {
                currentPage = Integer.parseInt(request.getParameter("page"));
            }
            
            String searchQuery = request.getParameter("search");
            DBContext dbContext = new DBContext();
            BlogDAO blogDAO = new BlogDAO(dbContext.getConnection());
            List<Blog> blogList;
            int totalRecords;
            
            if (searchQuery != null && !searchQuery.trim().isEmpty()) {
                // Xử lý tìm kiếm (không phân trang cho tìm kiếm để đơn giản)
                blogList = blogDAO.searchBlogs(searchQuery);
                totalRecords = blogList.size();
            } else {
                // Lấy dữ liệu phân trang
                blogList = blogDAO.getBlogsByPage(currentPage, recordsPerPage);
                totalRecords = blogDAO.getTotalPublishedBlogs();
            }
            
            int totalPages = (int) Math.ceil((double) totalRecords / recordsPerPage);
            
            request.setAttribute("blogList", blogList);
            request.setAttribute("currentPage", currentPage);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("totalRecords", totalRecords);
        %>

        <!-- Tiêu đề kết quả -->
        <c:if test="${not empty param.search}">
            <h2 class="mb-4">Search results for "${param.search}" (${totalRecords} results)</h2>
        </c:if>
        <c:if test="${empty param.search}">
            <h2 class="mb-4">Latest Articles</h2>
        </c:if>

        <!-- Danh sách bài viết -->
        <div class="row row-cols-1 row-cols-md-2 row-cols-lg-3 g-4">
            <c:forEach items="${blogList}" var="blog">
                <div class="col">
                    <div class="card blog-card h-100">
                        <c:choose>
                            <c:when test="${not empty blog.thumbnailUrl}">
                                <img src="${blog.thumbnailUrl}" class="card-img-top blog-image" alt="${blog.title}">
                            </c:when>
                            <c:otherwise>
                                <img src="https://via.placeholder.com/300x200?text=No+Thumbnail" 
                                     class="card-img-top blog-image" alt="Default thumbnail">
                            </c:otherwise>
                        </c:choose>
                        <div class="card-body">
                            <h5 class="card-title">${blog.title}</h5>
                            <p class="card-text">${blog.shortDescription}</p>
                            <div class="d-flex justify-content-between align-items-center mt-3">
                                <small class="text-muted">
                                    <i class="bi bi-calendar"></i> 
                                    <fmt:formatDate value="${blog.createdAt}" pattern="dd/MM/yyyy" />
                                </small>
                            </div>
                        </div>
                        <div class="card-footer">
                            <a href="blog-details.jsp?id=${blog.id}" class="btn btn-primary w-100">
                                <i class="bi bi-book"></i> Read More
                            </a>
                        </div>
                    </div>
                </div>
            </c:forEach>

            <c:if test="${empty blogList}">
                <div class="col-12 text-center">
                    <div class="alert alert-info">
                        No articles found.
                    </div>
                </div>
            </c:if>
        </div>

        <!-- Phân trang - chỉ hiển thị khi không có tìm kiếm -->
        <c:if test="${empty param.search && totalPages > 1}">
            <nav aria-label="Page navigation" class="mt-4">
                <ul class="pagination justify-content-center">
                    <c:if test="${currentPage > 1}">
                        <li class="page-item">
                            <a class="page-link" href="blogs.jsp?page=${currentPage - 1}">
                                <i class="bi bi-chevron-left"></i> Previous
                            </a>
                        </li>
                    </c:if>
                    
                    <c:forEach begin="1" end="${totalPages}" var="i">
                        <c:choose>
                            <c:when test="${currentPage eq i}">
                                <li class="page-item active"><a class="page-link" href="#">${i}</a></li>
                            </c:when>
                            <c:otherwise>
                                <li class="page-item"><a class="page-link" href="blogs.jsp?page=${i}">${i}</a></li>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>
                    
                    <c:if test="${currentPage < totalPages}">
                        <li class="page-item">
                            <a class="page-link" href="blogs.jsp?page=${currentPage + 1}">
                                Next <i class="bi bi-chevron-right"></i>
                            </a>
                        </li>
                    </c:if>
                </ul>
            </nav>
        </c:if>
    </div>
       

    <%@ include file="/layout/footer.jsp" %>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>