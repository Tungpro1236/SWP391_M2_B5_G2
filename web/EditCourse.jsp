<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.util.List" %>
<%@ page import="vn.edu.fpt.model.Category" %>
<%@ page import="vn.edu.fpt.model.Course" %>
<%@ page import="vn.edu.fpt.dao.CourseDAO" %>
<%
    int courseId = Integer.parseInt(request.getParameter("courseId"));
    CourseDAO courseDAO = new CourseDAO();
    Course course = courseDAO.getCourseById(courseId);
    List<Category> categoryList = courseDAO.getAllCategories();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Chỉnh sửa Khóa Học</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container py-5">
    <h1 class="text-center mb-5">Chỉnh sửa Khóa Học</h1>
    <div class="row justify-content-center">
        <div class="col-md-10">
            <form action="CourseController" method="post">
                <input type="hidden" name="courseId" value="<%= course.getId() %>">
                <!-- Title -->
                <div class="mb-3">
                    <label for="title" class="form-label">Tên khóa học</label>
                    <input type="text" class="form-control" id="title" name="title" value="<%= course.getTitle() %>" required>
                </div>
                <!-- Thumbnail URL -->
                <div class="mb-3">
                    <label for="thumbnailUrl" class="form-label">URL ảnh bìa</label>
                    <input type="url" class="form-control" id="thumbnailUrl" name="thumbnailUrl" value="<%= course.getThumbnailUrl() %>" required>
                </div>
                <!-- Description -->
                <div class="mb-3">
                    <label for="description" class="form-label">Mô tả</label>
                    <textarea class="form-control" id="description" name="description" rows="4" required><%= course.getDescription() %></textarea>
                </div>
                <!-- Category Select -->
                <div class="mb-3">
                    <label for="categoryId" class="form-label">Học kỳ</label>
                    <select class="form-select" id="categoryId" name="categoryId" required>
                        <option value="">-- Chọn học kỳ --</option>
                        <% for (Category category : categoryList) { %>
                        <option value="<%= category.getId() %>" <%= category.getId() == course.getCategoryId() ? "selected" : "" %>><%= category.getSemester() %></option>
                        <% } %>
                    </select>
                </div>
                <!-- Status -->
                <div class="mb-3">
                    <label for="status" class="form-label">Trạng thái</label>
                    <select class="form-select" id="status" name="status" required>
                        <option value="active" <%= "active".equals(course.getStatus()) ? "selected" : "" %>>Bật chế độ hoạt động</option>
                        <option value="inactive" <%= "inactive".equals(course.getStatus()) ? "selected" : "" %>>Tắt hoạt động</option>
                    </select>
                </div>
                <!-- Price -->
                <div class="mb-3">
                    <label for="price" class="form-label">Giá (USD)</label>
                    <input type="number" class="form-control" id="price" name="price" value="<%= course.getPrice() %>" min="0" required>
                </div>
                <input type="hidden" name="action" value="edit">
                <div class="d-grid gap-2">
                    <button type="submit" class="btn btn-success btn-lg">Lưu thay đổi</button>
                </div>
            </form>
            <a href="CourseController?action=manageCourse">Quay lại danh sách khóa học</a>
        </div>
    </div>
</div>
</body>
</html>
