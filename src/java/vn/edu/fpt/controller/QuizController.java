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
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import vn.edu.fpt.dao.QuizDAO;
import vn.edu.fpt.model.Answer_Option;
import vn.edu.fpt.model.Course;
import vn.edu.fpt.model.Lesson;
import vn.edu.fpt.model.Question;
import vn.edu.fpt.model.Quiz;

/**
 *
 * @author ASUS
 */
@WebServlet(name = "QuizController", urlPatterns = {"/QuizController"})
public class QuizController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet QuizController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet QuizController at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        QuizDAO quizDAO = new QuizDAO();
        String action = request.getParameter("action");
        if ("manageQuiz".equals(action))
        try {
            List<Course> courses = quizDAO.getAllCourses();
            request.setAttribute("courses", courses);

            String courseIdStr = request.getParameter("courseId");
            String lessonIdStr = request.getParameter("lessonId");

            if (courseIdStr != null) {
                int courseId = Integer.parseInt(courseIdStr);
                List<Lesson> lessons = quizDAO.getLessonsByCourseId(courseId);
                request.setAttribute("lessons", lessons);
            }

            if (lessonIdStr != null) {
                int lessonId = Integer.parseInt(lessonIdStr);
                List<Quiz> quizzes = quizDAO.getQuizzesByLessonId(lessonId);
                request.setAttribute("quizzes", quizzes);

                Map<Integer, List<Question>> questionsMap = new HashMap<>();
                Map<Integer, List<Answer_Option>> answersMap = new HashMap<>();

                for (Quiz quiz : quizzes) {
                    List<Question> questions = quizDAO.getQuestionsByQuizId(quiz.getQuizId());
                    questionsMap.put(quiz.getQuizId(), questions);
                    for (Question question : questions) {
                        List<Answer_Option> options = quizDAO.getAnswerOptionsByQuestionId(question.getQuestionId());
                        answersMap.put(question.getQuestionId(), options);
                    }
                }

                request.setAttribute("questions", questionsMap);
                request.setAttribute("answers", answersMap);
            }

            request.getRequestDispatcher("ManageQuiz.jsp").forward(request, response);

        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        QuizDAO quizDAO = new QuizDAO();
        try {
            String action = request.getParameter("action");

            if ("createQuiz".equals(action)) {
                int lessonId = Integer.parseInt(request.getParameter("lessonId"));
                String title = request.getParameter("title");
                int duration = Integer.parseInt(request.getParameter("duration"));
                Quiz quiz = new Quiz(0, lessonId, title, duration);
                quizDAO.createQuiz(quiz);
            } else if ("editQuiz".equals(action)) {
                int quizId = Integer.parseInt(request.getParameter("quizId"));
                String title = request.getParameter("title");
                int duration = Integer.parseInt(request.getParameter("duration"));
                Quiz quiz = new Quiz(quizId, 0, title, duration);
                quizDAO.updateQuiz(quiz);
            } else if ("addQuestion".equals(action)) {
                int quizId = Integer.parseInt(request.getParameter("quizId"));
                String questionText = request.getParameter("questionText");
                quizDAO.createQuestion(new Question(0, quizId, questionText));
            } else if ("addAnswer".equals(action)) {
                int questionId = Integer.parseInt(request.getParameter("questionId"));
                String answerText = request.getParameter("answerText");
                boolean isCorrect = "1".equals(request.getParameter("isCorrect"));
                quizDAO.createAnswerOption(new Answer_Option(0, questionId, answerText, isCorrect));
            } else if ("editAnswer".equals(action)) {
                int answerId = Integer.parseInt(request.getParameter("answerId"));
                int questionId = Integer.parseInt(request.getParameter("questionId"));
                String answerText = request.getParameter("answerText");
                boolean isCorrect = "1".equals(request.getParameter("isCorrect"));
                Answer_Option ao = new Answer_Option(answerId, questionId, answerText, isCorrect);
                quizDAO.updateAnswerOption(ao);
            } else if ("deleteAnswer".equals(action)) {
                int answerId = Integer.parseInt(request.getParameter("answerId"));
                quizDAO.deleteAnswerOption(answerId);
            } else if (action.equals("editAnswersBulk")) {
                int questionId = Integer.parseInt(request.getParameter("questionId"));
                int lessonId = Integer.parseInt(request.getParameter("lessonId"));

                String[] answerIds = request.getParameterValues("answerIds");
                String[] answerTexts = request.getParameterValues("answerTexts");
                String[] correctAnswers = request.getParameterValues("correctAnswers"); // Checkbox checked

                Set<Integer> correctSet = new HashSet<>();
                if (correctAnswers != null) {
                    for (String correctId : correctAnswers) {
                        correctSet.add(Integer.parseInt(correctId));
                    }
                }

                for (int i = 0; i < answerIds.length; i++) {
                    int answerId = Integer.parseInt(answerIds[i]);
                    String newText = answerTexts[i];
                    boolean isCorrect = correctSet.contains(answerId);

                    Answer_Option ao = new Answer_Option();
                    ao.setOptionId(answerId);     // ID của đáp án
                    ao.setText(newText);          // Nội dung đáp án
                    ao.setIsCorrect(isCorrect);   // Có đúng không

                    quizDAO.updateAnswerOption(ao);
                }
            }
            String lessonId = request.getParameter("lessonId");
            // Sau khi xử lý thành công (ví dụ thêm, sửa hoặc xóa quiz)
            response.sendRedirect("QuizController?action=manageQuiz&lessonId=" + (lessonId != null ? lessonId : "") + "&message=success");

        } catch (Exception e) {
            throw new ServletException(e);
        }
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
