<%-- 
    Document   : add-Blogs
    Created on : Apr 23, 2025, 3:03:19 AM
    Author     : ACER
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Thêm bài viết mới</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <%@ include file="/layout/header.jsp" %>
    
    <div class="container py-5">
        <h1 class="text-center mb-5">Thêm bài viết mới</h1>
        
        <form action="process-add-blog.jsp" method="POST" enctype="multipart/form-data" class="card p-4">
            <div class="mb-3">
                <label for="title" class="form-label">Tiêu đề</label>
                <input type="text" class="form-control" id="title" name="title" required>
            </div>
            
            <div class="mb-3">
                <label for="shortDescription" class="form-label">Mô tả ngắn</label>
                <textarea class="form-control" id="shortDescription" name="shortDescription" rows="3" required></textarea>
            </div>
            
            <div class="mb-3">
                <label for="content" class="form-label">Nội dung</label>
                <textarea class="form-control" id="content" name="content" rows="10" required></textarea>
            </div>
            
            <div class="mb-3">
                <label for="thumbnail" class="form-label">Ảnh thumbnail</label>
                <input type="file" class="form-control" id="thumbnail" name="thumbnail" accept="image/*">
            </div>
            
            <input type="hidden" name="authorId" value="${sessionScope.user.id}">
            
            <div class="text-center">
                <button type="submit" class="btn btn-primary px-4">Đăng bài</button>
            </div>
        </form>
    </div>
    
    <%@ include file="/layout/footer.jsp" %>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>