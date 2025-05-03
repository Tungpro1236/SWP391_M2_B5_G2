<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.util.List" %>
<%@ page import="vn.edu.fpt.model.Category" %> 
<%@ page import="vn.edu.fpt.dao.CourseDAO" %> 

<%
    CourseDAO courseDAO = new CourseDAO();
    List<Category> categoryList = courseDAO.getAllCategories();
%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Thêm Khóa Học</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </head>
    <body>
        <div class="container py-5">
            <h1 class="text-center mb-5">Thêm Khóa Học Mới</h1>
            <div class="row justify-content-center">
                <div class="col-md-10">
                    <form action="CourseController" method="post">
                        <!-- Title -->
                        <div class="mb-3">
                            <label for="title" class="form-label">Tên khóa học</label>
                            <input type="text" class="form-control" id="title" name="title" placeholder="Nhập tên khóa học" required>
                        </div>

                        <!-- Thumbnail URL -->
                        <div class="mb-3">
                            <label for="thumbnailUrl" class="form-label">URL ảnh bìa</label>
                            <input type="url" class="form-control" id="thumbnailUrl" name="thumbnailUrl" placeholder="Nhập đường dẫn ảnh" required>
                        </div>

                        <!-- Description -->
                        <div class="mb-3">
                            <label for="description" class="form-label">Mô tả</label>
                            <textarea class="form-control" id="description" name="description" rows="4" placeholder="Mô tả ngắn về khóa học" required></textarea>
                        </div>

                        <!-- Category Select --> 
                        <div class="mb-3">
                            <label for="categoryId" class="form-label">Học kỳ</label>
                            <select class="form-select" id="categoryId" name="categoryId" required>
                                <option value="">-- Chọn học kỳ --</option>
                                <% for (Category category : categoryList) { %>
                                <option value="<%= category.getId() %>"><%= category.getSemester() %></option>
                                <% } %>
                            </select>
                        </div>

                        <!-- Status -->
                        <div class="mb-3">
                            <label for="status" class="form-label">Trạng thái</label>
                            <select class="form-select" id="status" name="status" required>
                                <option value="active">Bật chế độ hoạt động</option>
                                <option value="inactive">Tắt hoạt động</option>
                            </select>
                        </div>

                        <!-- Price -->
                        <div class="mb-3">
                            <label for="price" class="form-label">Giá (USD)</label>
                            <input type="number" class="form-control" id="price" name="price" placeholder="Nhập giá khóa học" min="0" required>
                        </div>

                        <input type="hidden" name="action" value="add">
                        <div class="d-grid gap-2">
                            <button type="submit" class="btn btn-success btn-lg">Lưu khóa học</button>
                        </div>
                    </form>
                    <a href="CourseController?action=manageCourse">Quay lại danh sách khóa học</a>
                </div>
            </div>
        </div>
    </body>
</html>

