<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, vn.edu.fpt.model.Course, vn.edu.fpt.model.Lesson, vn.edu.fpt.model.Quiz, vn.edu.fpt.model.Question, vn.edu.fpt.model.Answer_Option" %>
<%
    List<Course> courses = (List<Course>) request.getAttribute("courses");
    List<Lesson> lessons = (List<Lesson>) request.getAttribute("lessons");
    List<Quiz> quizzes = (List<Quiz>) request.getAttribute("quizzes");
    Map<Integer, List<Question>> questionsMap = (Map<Integer, List<Question>>) request.getAttribute("questions");
    Map<Integer, List<Answer_Option>> answersMap = (Map<Integer, List<Answer_Option>>) request.getAttribute("answers");

    String lessonIdStr = request.getParameter("lessonId");
    String message = request.getParameter("message");
%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Quản lý Quiz</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    </head>
    <body class="container py-4">

        <h2 class="mb-4">Quản lý Quiz</h2>

        <% if ("success".equals(message)) { %>
        <script>
            window.onload = function () {
                alert("Lưu thành công!");
            }
        </script>
        <% } %>
        <% if (quizzes == null || quizzes.isEmpty()) { %>
        <!-- Form tạo quiz mới -->
        <div class="card mb-4">
            <div class="card-body">
                <h5 class="card-title">Tạo Quiz mới</h5>
                <form method="post" action="QuizController" class="row g-3">
                    <input type="hidden" name="action" value="createQuiz"/>
                    <input type="hidden" name="lessonId" value="<%= lessonIdStr != null ? lessonIdStr : "" %>"/>

                    <div class="col-md-6">
                        <label class="form-label">Tiêu đề Quiz</label>
                        <input type="text" name="title" class="form-control" required/>
                    </div>

                    <div class="col-md-6">
                        <label class="form-label">Thời lượng (phút)</label>
                        <input type="number" name="duration" class="form-control" min="1" required/>
                    </div>

                    <div class="col-12">
                        <button type="submit" class="btn btn-success">Thêm Quiz mới</button>
                    </div>
                </form>
            </div>
        </div>

        <% } else { 
            Quiz quizToEdit = quizzes.get(0);
        %>
        <!-- Form chỉnh sửa quiz -->
        <div class="card mb-4">
            <div class="card-body">
                <h5 class="card-title">Chỉnh sửa Quiz</h5>
                <form method="post" action="QuizController" class="row g-3">
                    <input type="hidden" name="action" value="editQuiz"/>
                    <input type="hidden" name="quizId" value="<%= quizToEdit.getQuizId() %>"/>
                    <input type="hidden" name="lessonId" value="<%= lessonIdStr != null ? lessonIdStr : "" %>"/>

                    <div class="col-md-6">
                        <label class="form-label">Tiêu đề Quiz</label>
                        <input type="text" name="title" class="form-control" value="<%= quizToEdit.getTitle() %>" required/>
                    </div>

                    <div class="col-md-6">
                        <label class="form-label">Thời lượng (phút)</label>
                        <input type="number" name="duration" class="form-control" min="1" value="<%= quizToEdit.getDurationMinutes() %>" required/>
                    </div>

                    <div class="col-12 d-flex gap-2">
                        <button type="submit" class="btn btn-primary">Lưu thay đổi</button>
                        <form method="post" action="QuizController" onsubmit="return confirm('Bạn có chắc chắn muốn xóa quiz này?');">
                            <input type="hidden" name="action" value="deleteQuiz"/>
                            <input type="hidden" name="quizId" value="<%= quizToEdit.getQuizId() %>"/>
                            <input type="hidden" name="lessonId" value="<%= lessonIdStr != null ? lessonIdStr : "" %>"/>
                        </form>
                    </div>
                </form>
            </div>
        </div>
        <% } %>

        <% if (quizzes != null && !quizzes.isEmpty()) {
        for (Quiz q : quizzes) { %>
        <div class="card mb-4">
            <div class="card-header bg-primary text-white">
                <strong><%= q.getTitle() %></strong> (Thời lượng: <%= q.getDurationMinutes() %> phút)
            </div>

            <div class="card-body">
                <% 
                List<Question> questions = (questionsMap != null) ? questionsMap.get(q.getQuizId()) : null;
                if (questions != null) {
                    for (Question ques : questions) { %>
                <div class="mb-4 p-3 border rounded">
                    <h6><strong>Câu hỏi:</strong> <%= ques.getText() %></h6>

                    <% 
                    List<Answer_Option> answerOptions = (answersMap != null) ? answersMap.get(ques.getQuestionId()) : null;
                    if (answerOptions != null) { 
                    %>
                    <!-- Form chỉnh sửa đáp án -->
                    <form method="post" action="QuizController" class="mt-3">
                        <input type="hidden" name="action" value="editAnswersBulk"/>
                        <input type="hidden" name="questionId" value="<%= ques.getQuestionId() %>"/>
                        <input type="hidden" name="lessonId" value="<%= lessonIdStr != null ? lessonIdStr : "" %>"/>

                        <% for (Answer_Option ao : answerOptions) { %>
                        <div class="d-flex align-items-center gap-2 mb-2">
                            <input type="hidden" name="answerIds" value="<%= ao.getOptionId() %>"/>
                            <input type="text" name="answerTexts" value="<%= ao.getText() %>"
                                   class="form-control form-control-sm flex-grow-1" required/>

                            <div class="form-check form-check-inline mb-0">
                                <input class="form-check-input" type="checkbox" name="correctAnswers" value="<%= ao.getOptionId() %>"
                                       id="correct_<%= ao.getOptionId() %>" <%= ao.isIsCorrect() ? "checked" : "" %>>
                                <label class="form-check-label" for="correct_<%= ao.getOptionId() %>">Đúng</label>
                            </div>
                        </div>
                        <% } %>

                        <button type="submit" class="btn btn-primary btn-sm mt-2">Lưu thay đổi đáp án</button>
                    </form>
                    <% } %>

                    <!-- Form thêm đáp án mới -->
                    <form method="post" action="QuizController" class="row g-2 align-items-center mt-3">
                        <input type="hidden" name="action" value="addAnswer"/>
                        <input type="hidden" name="questionId" value="<%= ques.getQuestionId() %>"/>
                        <input type="hidden" name="lessonId" value="<%= lessonIdStr != null ? lessonIdStr : "" %>"/>

                        <div class="col-md-6">
                            <input type="text" name="answerText" class="form-control" placeholder="Đáp án mới" required/>
                        </div>

                        <div class="col-md-3">
                            <div class="form-check">
                                <input class="form-check-input" type="checkbox" name="isCorrect" value="1" id="newCorrect_<%= ques.getQuestionId() %>">
                                <label class="form-check-label" for="newCorrect_<%= ques.getQuestionId() %>">Đúng</label>
                            </div>
                        </div>

                        <div class="col-md-3">
                            <button class="btn btn-success" type="submit">Thêm đáp án</button>
                        </div>
                    </form>
                </div>
                <% } 
            } %>

                <!-- Form thêm câu hỏi mới -->
                <form method="post" action="QuizController" class="row g-2 mt-4">
                    <input type="hidden" name="action" value="addQuestion"/>
                    <input type="hidden" name="quizId" value="<%= q.getQuizId() %>"/>
                    <input type="hidden" name="lessonId" value="<%= lessonIdStr != null ? lessonIdStr : "" %>"/>

                    <div class="col-md-8">
                        <input type="text" name="questionText" class="form-control" placeholder="Câu hỏi mới" required/>
                    </div>

                    <div class="col-md-4">
                        <button class="btn btn-success" type="submit">Thêm câu hỏi</button>
                    </div>
                </form>
            </div>
        </div>
        <% } 
    } else { %>
        <div class="alert alert-warning">Chưa có quiz nào cho bài học này.</div>
        <% } %>

        <a href="LessonController?action=manageLesson" class="btn btn-secondary mt-4">Quay lại danh sách bài học</a>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

    </body>
</html>
