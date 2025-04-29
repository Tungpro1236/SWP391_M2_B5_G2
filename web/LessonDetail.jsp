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

            <c:if test="${totalQuestion > 0}">
                <!-- Nếu chưa bấm Take Quiz (showQuiz != true) thì hiện nút -->
                <c:if test="${param.showQuiz != 'true'}">
                    <a href="LessonController?action=detail&courseId=${lesson.courseId}&lessonId=${lesson.lessonId}&showQuiz=true" class="btn btn-success mb-3">Take Quiz</a>
                </c:if>

                <!-- Nếu đã bấm Take Quiz (showQuiz == true) thì hiện phần quiz -->
                <c:if test="${param.showQuiz == 'true'}">
                    <h3>${quiz.title}</h3>

                    <!-- Hiện đồng hồ đếm ngược -->
                    <div class="alert alert-warning">
                        <strong>Thời gian còn lại:</strong> <span id="timer"></span>
                    </div>

                    <form action="LessonController" method="post">
                        <input type="hidden" name="action" value="submitQuiz"/>
                        <input type="hidden" name="quizId" value="${quiz.quizId}"/>
                        <input type="hidden" name="lessonId" value="${lesson.lessonId}"/>
                        <input type="hidden" name="courseId" value="${lesson.courseId}"/>

                        <c:choose>
                            <c:when test="${not empty quiz.questions}">
                                <c:forEach var="question" items="${quiz.questions}">
                                    <div class="card mb-3">
                                        <div class="card-body">
                                            <h5 class="card-title">${question.text}</h5>
                                            <c:forEach var="option" items="${question.answerOptions}">
                                                <div class="form-check">
                                                    <input class="form-check-input" type="radio" name="question_${question.questionId}"
                                                           id="option_${option.optionId}" value="${option.optionId}">
                                                    <label class="form-check-label" for="option_${option.optionId}">${option.text}</label>
                                                </div>
                                            </c:forEach>
                                        </div>
                                    </div>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <p>Không có câu hỏi nào cho quiz này.</p>
                            </c:otherwise>
                        </c:choose>

                        <button type="submit" class="btn btn-primary">Submit Quiz</button>
                    </form>
                </c:if>
            </c:if>

            <a href="LessonController?courseId=${lesson.courseId}" class="btn btn-secondary mt-3">Quay lại danh sách bài học</a>
        </div>

        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.3/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
        <script>
            var durationMinutes = ${durationMinutes}; // thời gian từ server
            var durationSeconds = durationMinutes * 60; // chuyển sang giây

            var timerElement = document.getElementById('timer');
            var formElement = document.querySelector('form[action="LessonController"]');

            function updateTimer() {
                var minutes = Math.floor(durationSeconds / 60);
                var seconds = durationSeconds % 60;
                timerElement.textContent = minutes + " phút " + (seconds < 10 ? "0" : "") + seconds + " giây";

                if (durationSeconds <= 0) {
                    clearInterval(countdownInterval);
                    // Hết giờ thì tự động submit
                    formElement.submit();
                }
                durationSeconds--;
            }

            var countdownInterval = setInterval(updateTimer, 1000);
            updateTimer(); // gọi lần đầu để hiện đúng
        </script>

    </body>
</html>
