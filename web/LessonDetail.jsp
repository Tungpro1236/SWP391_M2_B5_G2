<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Chi tiết bài học</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
<div class="container">
    <h2>${lesson.title}</h2>
    <p><b>Nội dung:</b> ${lesson.content}</p>
    <p><b>Video URL:</b> <a href="${lesson.vidURL}">${lesson.vidURL}</a></p>
    <p><b>Ngày tạo:</b> ${lesson.createdAt}</p>

  
    <a href="LessonController?courseId=${lesson.courseId}" class="btn btn-secondary">Quay lại danh sách bài học</a>
</div>
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.3/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>

