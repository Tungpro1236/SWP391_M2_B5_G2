<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
    <head>
        <title>Kết quả Quiz</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    </head>
    <body>
        <div class="container">
            <h2>Kết quả Quiz</h2>
            <p><b>Bài học:</b> ${lesson.title}</p>

            <c:choose>
                <c:when test="${not empty attemptId}">
                    <p><b>Bạn đã hoàn thành bài quiz.</b></p>
                    <%-- Get Quiz Attempt --%>
                    <jsp:useBean id="quizDAO" class="vn.edu.fpt.dao.QuizDAO" scope="request"/>
                    <c:set var="attempt" value="${quizDAO.getQuizAttempt(attemptId)}" scope="request"/>
                    <c:set var="quiz" value="${quizDAO.getQuizByLessonId(lesson.lessonId)}" scope="request"/>
                    <c:set var="questions" value="${quizDAO.getQuestionsByQuizId(quiz.quizId)}" scope="request"/>
                    <c:set var="userAnswers" value="${quizDAO.getUserAnswers(attemptId)}" scope="request"/>

                    <p><b>Số câu trả lời đúng:</b> ${attempt.score} / ${totalQuestion}</p>

                    <c:choose>
                        <c:when test="${(attempt.score * 1.0) / totalQuestion >= 0.5}">
                            <p style="color: green;"><b>Đã đạt yêu cầu</b></p>
                        </c:when>
                        <c:otherwise>
                            <p style="color: red;"><b>Chưa đạt yêu cầu(cần đúng được >=50% số câu hỏi)</b></p>
                        </c:otherwise>
                    </c:choose>

                    <c:forEach var="question" items="${questions}">
                        <div class="card mb-3">
                            <div class="card-body">
                                <h5 class="card-title">${question.text}</h5>
                                <c:set var="userAnswer" value="${null}"/>
                                <c:forEach var="ua" items="${userAnswers}">
                                    <c:if test="${ua.questionId == question.questionId}">
                                        <c:set var="userAnswer" value="${ua}"/>
                                    </c:if>
                                </c:forEach>

                                <c:set var="correctOptionId" value="0"/>
                                <c:forEach var="option" items="${quizDAO.getAnswerOptionsByQuestionId(question.questionId)}">
                                    <c:if test="${option.isCorrect}">
                                        <c:set var="correctOptionId" value="${option.optionId}"/>
                                    </c:if>
                                </c:forEach>
                                <p><b>Bạn đã chọn:</b>
                                    <c:choose>
                                        <c:when test="${userAnswer != null}">
                                            <c:set var="selectedOption" value="${quizDAO.getAnswerOptionById(userAnswer.optionId)}" scope="request"/>
                                            ${selectedOption.text}
                                        </c:when>
                                        <c:otherwise>
                                            Bạn không trả lời câu hỏi này.
                                        </c:otherwise>
                                    </c:choose>
                                </p>
                                <p><b>Đáp án đúng:</b>
                                    <c:set var="correctOption" value="${quizDAO.getAnswerOptionById(correctOptionId)}" scope="request"/>
                                    ${correctOption.text}</p>
                                    <c:choose>
                                        <c:when test="${userAnswer != null && correctOptionId == selectedOption.optionId}">
                                        <p style="color:green;"><b>Bạn đã trả lời đúng!</b></p>
                                    </c:when>
                                    <c:otherwise>
                                        <p style="color:red;"><b>Bạn đã trả lời sai!</b></p>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </c:forEach>
                    <a href="LessonController?action=detail&courseId=${lesson.courseId}&lessonId=${lesson.lessonId}" class="btn btn-secondary">Quay lại bài học</a>
                    <a href="LessonController?action=detail&courseId=${lesson.courseId}&lessonId=${lesson.lessonId+1}" class="btn btn-secondary">Bài học tiếp theo</a>
                </c:when>
                <c:otherwise>
                    <p><b>Không tìm thấy thông tin về lần thử quiz này.</b></p>
                    <a href="LessonController?courseId=${lesson.courseId}" class="btn btn-secondary">Quay lại danh sách bài học</a>
                </c:otherwise>
            </c:choose>
        </div>

        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.3/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    </body>
</html>
