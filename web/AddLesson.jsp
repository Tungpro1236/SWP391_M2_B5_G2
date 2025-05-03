<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="vn.edu.fpt.model.Course" %>
<%@ page import="vn.edu.fpt.dao.CourseDAO" %>

<%
    // Tạo đối tượng CourseDAO và lấy danh sách khóa học
    CourseDAO courseDAO = new CourseDAO();
    List<Course> courses = courseDAO.getAllCourses();
%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Thêm bài học mới</title>
        <!-- Kết nối với Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <style>
            body {
                padding-top: 50px;
                padding-bottom: 50px;
            }
            .container {
                max-width: 800px;
            }
        </style>
    </head>
    <body>

        <div class="container">
            <h2 class="text-center mb-4">Thêm bài học mới</h2>

            <% 
                String success = request.getParameter("success");
                String error = request.getParameter("error");
                if (success != null) {
            %>
            <div class="alert alert-success">
                Thêm bài học thành công!
            </div>
            <% 
                } else if (error != null) {
            %>
            <div class="alert alert-danger">
                Thêm bài học thất bại!
            </div>
            <% 
                }
            %>

            <!-- Form thêm bài học mới -->
            <form action="LessonController" method="post">
                <div class="mb-3">
                    <input type="hidden" name="action" value="addLesson"/>
                    <label for="courseId" class="form-label">Chọn khóa học:</label>
                    <select name="courseId" id="courseId" class="form-select" required>
                        <option value="">-- Chọn khóa học --</option>
                        <%
                            if (courses != null && !courses.isEmpty()) {
                                for (Course course : courses) {
                        %>
                        <option value="<%= course.getId() %>"><%= course.getTitle() %></option>
                        <%
                                }
                            } else {
                        %>
                        <option>Không có khóa học nào.</option>
                        <%
                            }
                        %>
                    </select>
                </div>

                <div class="mb-3">
                    <label for="title" class="form-label">Tiêu đề bài học:</label>
                    <input type="text" class="form-control" id="title" name="title" required/>
                </div>

                <div class="mb-3">
                    <label for="content" class="form-label">Nội dung bài học:</label>
                    <textarea class="form-control" id="content" name="content" rows="5" required></textarea>
                </div>

                <div class="mb-3">
                    <label for="videoUrl" class="form-label">Video URL:</label>
                    <input type="text" class="form-control" id="videoUrl" name="videoUrl"/>
                </div>

                <div class="d-grid">
                    <button type="submit" class="btn btn-primary">Thêm bài học</button>
                </div>
            </form>
        <a href="LessonController?action=manageLesson">Quay lại danh sách bài học</a>
        </div>

        <!-- Kết nối với Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/js/bootstrap.bundle.min.js"></script>

    </body>
</html>
