/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package vn.edu.fpt.controller;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.Date;
import java.util.List;
import vn.edu.fpt.dao.CourseDAO;
import vn.edu.fpt.dao.LessonDAO;
import vn.edu.fpt.dao.QuizDAO;
import vn.edu.fpt.model.Answer_Option;
import vn.edu.fpt.model.Course;
import vn.edu.fpt.model.Lesson;
import vn.edu.fpt.model.Lesson_Completion;
import vn.edu.fpt.model.Question;
import vn.edu.fpt.model.QuestionOption;
import vn.edu.fpt.model.Quiz;
import vn.edu.fpt.model.QuizHistory;
import vn.edu.fpt.model.Quiz_Attempt;
import vn.edu.fpt.model.User_Answer;
import vn.edu.fpt.model.UserModel;

/**
 *
 * @author ASUS
 */
@WebServlet(name = "LessonController", urlPatterns = {"/LessonController"})
public class LessonController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        CourseDAO CourseDAO = new CourseDAO();
        LessonDAO lessonDAO = new LessonDAO();
        QuizDAO quizDAO = new QuizDAO();
        String action = request.getParameter("action");
        if ("quizDetail".equals(action)) { //lấy ra danh sách câu hỏi, câu trl từ view list quiz for student
            String attemptIdStr = request.getParameter("attemptId");
            if (attemptIdStr == null || attemptIdStr.isEmpty()) {
                response.sendRedirect("errorPage.jsp");
            } else {
                // Proceed with parsing
                int attemptId = Integer.parseInt(attemptIdStr);
                List<QuestionOption> Quiz = lessonDAO.getQuestionOptions(attemptId);
                request.setAttribute("QuizDetail", Quiz);
                request.getRequestDispatcher("ViewQuizDetail.jsp").forward(request, response);
            }
        } else if ("manageLesson".equals(action)) {         //danh cho teacher
            HttpSession session = request.getSession();
            UserModel user = (UserModel) session.getAttribute("user");
            String courseIdStr = request.getParameter("courseId");
            List<Course> courses = CourseDAO.getCourseByTeacherId(user.getId());
            List<Lesson> lessons;

            if (courseIdStr != null && !courseIdStr.isEmpty()) {
                int courseId = Integer.parseInt(courseIdStr);
                lessons = lessonDAO.getLessonsByCourseId(courseId);
                request.setAttribute("selectedCourseId", courseId);
            } else {
                lessons = lessonDAO.getLessonsByTeacherId(user.getId());
            }

            request.setAttribute("courses", courses);
            request.setAttribute("lessons", lessons);
            request.getRequestDispatcher("ManageLesson.jsp").forward(request, response);
        } else if ("addLesson".equals(action)) {
            HttpSession session = request.getSession();
            UserModel user = (UserModel) session.getAttribute("user");
            if (user != null) {
                CourseDAO courseDAO = new CourseDAO();
                List<Course> courses = courseDAO.getCourseByTeacherId(user.getId());
                request.setAttribute("user", user);
                request.setAttribute("courses", courses);
                request.getRequestDispatcher("AddLesson.jsp").forward(request, response);
            } else {
                response.sendRedirect("login.jsp"); // hoặc xử lý khác nếu chưa đăng nhập
            }
        } else if ("editLesson".equals(action)) { //  ADD THIS BLOCK
            int lessonId = Integer.parseInt(request.getParameter("lessonId"));
            Lesson lesson = lessonDAO.getLessonById(lessonId);
            List<Course> courses = CourseDAO.getAllCourses(); // Or however you get the courses

            request.setAttribute("lesson", lesson);
            request.setAttribute("courses", courses);
            request.getRequestDispatcher("EditLesson.jsp").forward(request, response);
        } else {  //for student
            int courseId = Integer.parseInt(request.getParameter("courseId"));
            HttpSession session = request.getSession();
            UserModel user = (UserModel) session.getAttribute("user"); // Giả sử đã login
            List<Lesson> lessons = lessonDAO.getLessonsByCourseId(courseId);
            request.setAttribute("lessons", lessons);
            if (user == null) {
                response.sendRedirect("login.jsp"); // Chuyển hướng đến trang đăng nhập nếu chưa đăng nhập
                return;
            } else {    //show lesson detail list for student
                if ("detail".equals(action)) {
                    int lessonId = Integer.parseInt(request.getParameter("lessonId"));
                    boolean enrolled = lessonDAO.isUserEnrolled(user.getId(), courseId);
                    if (enrolled) {
                        Lesson lesson = lessonDAO.getLessonDetails(lessonId, courseId);
                        request.setAttribute("lesson", lesson);

                        // Lấy quiz cho bài học
                        Quiz quiz = quizDAO.getQuizByLessonId(lessonId);
                        if (quiz != null) {
                            List<Question> questions = quizDAO.getQuestionsByQuizId(quiz.getQuizId());
                            for (Question question : questions) {
                                List<Answer_Option> options = quizDAO.getAnswerOptionsByQuestionId(question.getQuestionId());
                                question.setAnswerOptions(options);
                            }
                            quiz.setQuestions(questions);

                            int totalQuestion = quizDAO.getTotalQuestionsByQuizId(quiz.getQuizId());
                            request.setAttribute("totalQuestion", totalQuestion);
                            request.setAttribute("quiz", quiz);

                            request.setAttribute("durationMinutes", quiz.getDurationMinutes());
                        }

                        request.getRequestDispatcher("LessonDetail.jsp").forward(request, response);
                    } else {
                        response.sendRedirect("LessonController?courseId=" + courseId);
                    }
                } else if ("myQuizHistory".equals(action)) {
                    List<QuizHistory> listQuiz = lessonDAO.getQuizHistoryByCourseAndUser(courseId, user.getId());
                    request.setAttribute("listQuiz", listQuiz);
                    request.getRequestDispatcher("ViewQuizHistory.jsp").forward(request, response);
                } else {
                    boolean enrolled = lessonDAO.isUserEnrolled(user.getId(), courseId);
                    List<Lesson_Completion> lessonCompleted = lessonDAO.getListLessonCompleted(courseId);
                    request.setAttribute("userId", user.getId());
                    request.setAttribute("lessonCompleted", lessonCompleted);
                    request.setAttribute("lessons", lessons);
                    request.setAttribute("enrolled", enrolled);
                    request.setAttribute("courseId", courseId);
                    request.getRequestDispatcher("ListLesson.jsp").forward(request, response);
                }
                List<Course> courses = CourseDAO.getAllCourses();
                request.setAttribute("courses", courses);
                request.getRequestDispatcher("addLesson.jsp").forward(request, response);
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        HttpSession session = request.getSession();
        UserModel user = (UserModel) session.getAttribute("user");

        // Kiểm tra đăng nhập
        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        LessonDAO lessonDAO = new LessonDAO();

        try {
            if ("enroll".equals(action)) {
                // Xử lý enroll
                // TODO: Thêm logic enroll tại đây nếu cần
            } else if ("submitQuiz".equals(action)) {
                // Xử lý nộp bài kiểm tra
                processQuizSubmission(request, response, user.getId());
            } else if ("updateLesson".equals(action)) {
                // Xử lý cập nhật bài học
                int lessonId = Integer.parseInt(request.getParameter("lessonId"));
                String title = request.getParameter("title");
                String content = request.getParameter("content");
                String videoUrl = request.getParameter("videoUrl");

                Lesson lesson = lessonDAO.getLessonById(lessonId);
                lesson.setTitle(title);
                lesson.setContent(content);
                lesson.setVidURL(videoUrl);

                lessonDAO.updateLesson(lesson);

                response.sendRedirect("LessonController?action=manageLesson");
                return; // Quan trọng: không cho chạy tiếp xuống dưới
            } else if ("addLesson".equals(action)) {
                // Xử lý thêm bài học mới
                int courseId = Integer.parseInt(request.getParameter("courseId"));
                String title = request.getParameter("title");
                String content = request.getParameter("content");
                String videoUrl = request.getParameter("videoUrl");
                Date createdAt = new Date(); // lấy thời điểm hiện tại

                Lesson lesson = new Lesson(0, courseId, title, content, videoUrl, createdAt);
                boolean success = lessonDAO.addLesson(lesson);

                if (success) {
                    response.sendRedirect("AddLesson.jsp?success=1");
                } else {
                    response.sendRedirect("AddLesson.jsp?error=1");
                }
                return;
            }
        } catch (Exception ex) {
            ex.printStackTrace();
            response.sendRedirect("error.jsp"); // hoặc hiện lỗi ra đẹp hơn
        }
    }

    private void processQuizSubmission(HttpServletRequest request, HttpServletResponse response, int userId) throws ServletException, IOException {
        LessonDAO lessonDAO = new LessonDAO();
        QuizDAO quizDAO = new QuizDAO();
        CourseDAO CourseDAO = new CourseDAO();
        HttpSession session = request.getSession();
        UserModel user = (UserModel) session.getAttribute("user");
        int quizId = Integer.parseInt(request.getParameter("quizId"));
        int lessonId = Integer.parseInt(request.getParameter("lessonId"));
        Lesson lesson = lessonDAO.getLessonDetails(lessonId, Integer.parseInt(request.getParameter("courseId")));
        List<Question> questions = quizDAO.getQuestionsByQuizId(quizId);
        int score = 0;

        // Save Quiz Attempt
        Quiz_Attempt attempt = new Quiz_Attempt();
        attempt.setUserId(userId);
        attempt.setQuizId(quizId);
        attempt.setAttemptDate(new java.util.Date());
        int attemptId = quizDAO.saveQuizAttempt(attempt);

        // Xử lý câu trả lời
        for (Question question : questions) {
            int questionId = question.getQuestionId();
            String selectedOptionIdStr = request.getParameter("question_" + questionId);
            if (selectedOptionIdStr != null && !selectedOptionIdStr.isEmpty()) { // Kiểm tra nếu có option được chọn
                int selectedOptionId = Integer.parseInt(selectedOptionIdStr);
                Answer_Option selectedOption = quizDAO.getAnswerOptionById(selectedOptionId);

                // Lưu câu trả lời của user
                User_Answer userAnswer = new User_Answer();
                userAnswer.setAttemptId(attemptId);
                userAnswer.setQuestionId(questionId);
                userAnswer.setOptionId(selectedOptionId);
                quizDAO.saveUserAnswer(userAnswer);

                if (selectedOption != null && selectedOption.isIsCorrect()) {
                    score++;
                }
            }
        }

        int totalQuestion = quizDAO.getTotalQuestionsByQuizId(quizId);

        if ((double) score / totalQuestion >= 0.7) {
            lessonDAO.saveLessonCompletion(userId, lessonId);
            CourseDAO.updateEnrollmentStatusForStudent(user.getId());
        }

        request.setAttribute("totalQuestion", totalQuestion);

        // Cập nhật Quiz Attempt với điểm
        attempt.setAttemptId(attemptId);
        attempt.setScore(score);
        quizDAO.updateQuizAttemptScore(attempt);

        // Chuyển hướng đến trang kết quả hoặc hiển thị kết quả
        request.setAttribute("lesson", lesson);
        request.setAttribute("attemptId", attemptId);
        request.getRequestDispatcher("ResultQuiz.jsp").forward(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
