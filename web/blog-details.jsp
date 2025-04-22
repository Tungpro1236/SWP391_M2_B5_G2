<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="vn.edu.fpt.model.Blog, vn.edu.fpt.dao.BlogDAO, java.sql.*, vn.edu.fpt.dao.DBContext"%>
<%
    String blogId = request.getParameter("id");
    DBContext dbContext = new DBContext();
    BlogDAO blogDAO = new BlogDAO(dbContext.getConnection());
    
    // Lấy thông tin blog theo ID
    Blog blog = blogDAO.getBlogById(Integer.parseInt(blogId));
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><%= blog.getTitle() %> | OnlineLearning</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <!-- Container Start -->
    <div class="container py-5">
        <div class="row">
            <div class="col-md-12">
                <h2><%= blog.getTitle() %></h2>
                <p><%= blog.getContent() %></p>
                <p><strong>Tác giả:</strong> <%= blog.getAuthorId() %></p>
                <p><strong>Ngày tạo:</strong> <%= blog.getCreatedAt() %></p>
                <p><strong>Ngày xuất bản:</strong> <%= blog.getPublishedAt() != null ? blog.getPublishedAt() : "Chưa xuất bản" %></p>
            </div>
        </div>
    </div>
    <!-- Container End -->
</body>
</html>
