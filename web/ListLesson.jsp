<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Danh sách bài học</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    </head>
    <body>
        <div class="container">
            <h2 class="mt-4">Danh sách bài học</h2>
            <table class="table table-bordered">
                <thead class="thead-light">
                    <tr>
                        <th>Title</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="lesson" items="${lessons}">
                        <tr>
                            <td>${lesson.title}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${enrolled}">
                                        <a href="LessonController?action=detail&courseId=${lesson.courseId}&lessonId=${lesson.lessonId}" class="btn btn-primary">Xem chi tiết</a>
                                    </c:when>
                                    <c:otherwise>
                                        <form action="LessonController" method="post">
                                            <input type="hidden" name="action" value="enroll"/>
                                            <input type="hidden" name="courseId" value="${lesson.courseId}"/>
                                            <button type="submit" class="btn btn-success">Đăng ký khóa học ngay!</button>
                                        </form>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
            <a href="CourseController">Quay lại danh sách khóa học</a>
        </div>

        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.3/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    </body>
</html>
