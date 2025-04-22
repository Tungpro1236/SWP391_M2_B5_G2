<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="vn.edu.fpt.model.Blog, vn.edu.fpt.dao.BlogDAO, java.util.List, vn.edu.fpt.dao.DBContext"%>
<%
// Xử lý tham số tìm kiếm
String searchQuery = request.getParameter("search");
DBContext dbContext = new DBContext();
BlogDAO blogDAO = new BlogDAO(dbContext.getConnection());
List<Blog> blogList;

if (searchQuery != null && !searchQuery.trim().isEmpty()) {
    blogList = blogDAO.searchBlogs(searchQuery);
} else {
    blogList = blogDAO.getAllPublishedBlogs();
}
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Blogs | OnlineLearning</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <!-- Container Start -->
    <div class="container py-5">
        <div class="row">
            <!-- Sidebar (Search Form) -->
            <div class="col-md-4 mb-4">
                <div class="card p-4">
                    <h4>Tìm kiếm bài viết</h4>
                    <form action="blogs.jsp" method="POST">
                        <div class="input-group">
                            <input type="text" class="form-control" placeholder="Tìm kiếm bài viết..." name="search" value="<%= searchQuery != null ? searchQuery : "" %>">
                            <button class="btn btn-primary" type="submit">Tìm kiếm</button>
                        </div>
                    </form>
                </div>
            </div>

            <!-- Blog Content -->
            <div class="col-md-8">
                <h2 class="mb-4">
                    <% if (searchQuery != null && !searchQuery.isEmpty()) { %>
                        Kết quả tìm kiếm cho "<%= searchQuery %>"
                    <% } else { %>
                        Bài Viết Mới Nhất
                    <% } %>
                </h2>

                <% if (blogList.isEmpty()) { %>
                    <p>Không có bài viết nào được tìm thấy.</p>
                <% } else { %>
                    <div class="row">
                        <% for (Blog blog : blogList) { %>
                            <div class="col-md-6 mb-4">
                                <div class="card h-100">
                                    <% if (blog.getThumbnailUrl() != null && !blog.getThumbnailUrl().isEmpty()) { %>
                                        <img src="<%= blog.getThumbnailUrl() %>" class="card-img-top" alt="<%= blog.getTitle() %>">
                                    <% } else { %>
                                        <img src="https://via.placeholder.com/300x200" class="card-img-top" alt="Default thumbnail">
                                    <% } %>
                                    <div class="card-body">
                                        <h5 class="card-title">
                                            <a href="blog-details.jsp?id=<%= blog.getId() %>"><%= blog.getTitle() %></a>
                                        </h5>
                                        <p class="card-text"><%= blog.getShortDescription() %></p>
                                    </div>
                                    <div class="card-footer">
                                        <a href="blog-details.jsp?id=<%= blog.getId() %>" class="btn btn-primary">Xem chi tiết</a>
                                    </div>
                                </div>
                            </div>
                        <% } %>
                    </div>
                <% } %>

                <!-- Pagination (Nếu cần) -->
                <nav aria-label="Page navigation example" class="mt-4">
                    <ul class="pagination justify-content-center">
                        <li class="page-item disabled">
                            <a class="page-link" href="#" tabindex="-1" aria-disabled="true">Trước</a>
                        </li>
                        <li class="page-item active"><a class="page-link" href="blogs.jsp">1</a></li>
                        <li class="page-item"><a class="page-link" href="blogs.jsp">2</a></li>
                        <li class="page-item"><a class="page-link" href="blogs.jsp">3</a></li>
                        <li class="page-item">
                            <a class="page-link" href="#">Tiếp theo</a>
                        </li>
                    </ul>
                </nav>
            </div>
        </div>
    </div>
    <!-- Container End -->
</body>
</html>
    