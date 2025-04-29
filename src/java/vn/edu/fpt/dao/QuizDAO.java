/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package vn.edu.fpt.dao;

import java.sql.*;
import java.util.*;
import vn.edu.fpt.dao.DBContext;
import vn.edu.fpt.model.Answer_Option;
import vn.edu.fpt.model.Course;
import vn.edu.fpt.model.Lesson;
import vn.edu.fpt.model.Question;
import vn.edu.fpt.model.Quiz;
import vn.edu.fpt.model.Quiz_Attempt;
import vn.edu.fpt.model.User_Answer;

public class QuizDAO extends DBContext {

    // 1. Lấy quiz theo LessonID
    public Quiz getQuizByLessonId(int lessonId) {
        Quiz quiz = null;
        String sql = "SELECT * FROM Quiz WHERE LessonID = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, lessonId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                quiz = new Quiz(
                        rs.getInt("QuizID"),
                        rs.getInt("LessonID"),
                        rs.getString("Title"),
                        rs.getInt("duration_minutes")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return quiz;
    }

    // 2. Lấy danh sách câu hỏi theo QuizID
    public List<Question> getQuestionsByQuizId(int quizId) {
        List<Question> questions = new ArrayList<>();
        String sql = "SELECT * FROM Question WHERE QuizID = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, quizId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Question q = new Question(
                        rs.getInt("QuestionID"),
                        rs.getInt("QuizID"),
                        rs.getString("Text")
                );
                questions.add(q);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return questions;
    }

    // 3. Lấy đáp án theo QuestionID
    public List<Answer_Option> getAnswerOptionsByQuestionId(int questionId) {
        List<Answer_Option> list = new ArrayList<>();
        String sql = "SELECT * FROM Answer_Option WHERE QuestionID = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, questionId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Answer_Option ao = new Answer_Option(
                        rs.getInt("OptionID"),
                        rs.getInt("QuestionID"),
                        rs.getString("Text"),
                        rs.getBoolean("IsCorrect")
                );
                list.add(ao);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // 4. Lưu một lần làm quiz (Quiz_Attempt)
    public int saveQuizAttempt(Quiz_Attempt attempt) {
        int generatedId = -1;
        String sql = "INSERT INTO Quiz_Attempt (UserID, QuizID, AttemptDate, Score, completion_time_minutes) VALUES (?, ?, ?, ?, ?)";
        try {
            PreparedStatement ps = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            ps.setInt(1, attempt.getUserId());
            ps.setInt(2, attempt.getQuizId());
            ps.setTimestamp(3, new java.sql.Timestamp(attempt.getAttemptDate().getTime()));
            ps.setInt(4, attempt.getScore());
            ps.setInt(5, attempt.getCompletionTimeMinutes());
            ps.executeUpdate();
            ResultSet rs = ps.getGeneratedKeys();
            if (rs.next()) {
                generatedId = rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return generatedId;
    }

    // 5. Lưu câu trả lời của user (User_Answer)
    public void saveUserAnswer(User_Answer ua) {
        String sql = "INSERT INTO User_Answer (AttemptID, QuestionID, OptionID) VALUES (?, ?, ?)";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, ua.getAttemptId());
            ps.setInt(2, ua.getQuestionId());
            ps.setInt(3, ua.getOptionId());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // 6. Lấy đáp án theo OptionID (để kiểm tra đúng/sai)
    public Answer_Option getAnswerOptionById(int optionId) {
        String sql = "SELECT * FROM Answer_Option WHERE OptionID = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, optionId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new Answer_Option(
                        rs.getInt("OptionID"),
                        rs.getInt("QuestionID"),
                        rs.getString("Text"),
                        rs.getBoolean("IsCorrect")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // 7. Cập nhật điểm (score) và thời gian hoàn thành của lần làm quiz
    public void updateQuizAttemptScore(Quiz_Attempt attempt) {
        String sql = "UPDATE Quiz_Attempt SET Score = ?, completion_time_minutes = ? WHERE AttemptID = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, attempt.getScore());
            ps.setInt(2, attempt.getCompletionTimeMinutes());
            ps.setInt(3, attempt.getAttemptId());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // 8. Lấy kết quả làm quiz của user (Quiz_Attempt)
    public Quiz_Attempt getQuizAttempt(int attemptId) {
        String sql = "SELECT * FROM Quiz_Attempt WHERE AttemptID = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, attemptId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new Quiz_Attempt(
                        rs.getInt("AttemptID"),
                        rs.getInt("UserID"),
                        rs.getInt("QuizID"),
                        rs.getTimestamp("AttemptDate"),
                        rs.getInt("Score"),
                        rs.getInt("completion_time_minutes")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // 9. Lấy toàn bộ đáp án user chọn trong một lần làm quiz (User_Answer)
    public List<User_Answer> getUserAnswers(int attemptId) {
        List<User_Answer> list = new ArrayList<>();
        String sql = "SELECT * FROM User_Answer WHERE AttemptID = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, attemptId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                User_Answer ua = new User_Answer(
                        rs.getInt("UserAnswerID"),
                        rs.getInt("AttemptID"),
                        rs.getInt("QuestionID"),
                        rs.getInt("OptionID")
                );
                list.add(ua);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    //total question cua 1 quiz
    public int getTotalQuestionsByQuizId(int quizId) {
        int totalQuestions = 0;
        String sql = "SELECT COUNT(*) AS total_questions FROM Question WHERE QuizID = ?";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, quizId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                totalQuestions = rs.getInt("total_questions");
            }

            rs.close();
            ps.close();

        } catch (Exception e) {
            e.printStackTrace();
        }
        return totalQuestions;
    }

    public int addQuiz(Quiz quiz) {
        String sql = "INSERT INTO Quizzes (lessonId, title, duration_minutes) VALUES (?, ?, ?)";
        try (PreparedStatement statement = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            statement.setInt(1, quiz.getLessonId());
            statement.setString(2, quiz.getTitle());
            statement.setInt(3, quiz.getDurationMinutes());

            statement.executeUpdate();

            ResultSet generatedKeys = statement.getGeneratedKeys();
            if (generatedKeys.next()) {
                return generatedKeys.getInt(1);
            } else {
                throw new SQLException("Creating quiz failed, no ID obtained.");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return -1;
        }
    }

    public int addQuestion(Question question) {
        String sql = "INSERT INTO Questions (quizId, text) VALUES (?, ?)";
        try (PreparedStatement statement = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            statement.setInt(1, question.getQuizId());
            statement.setString(2, question.getText());

            statement.executeUpdate();

            ResultSet generatedKeys = statement.getGeneratedKeys();
            if (generatedKeys.next()) {
                return generatedKeys.getInt(1);
            } else {
                throw new SQLException("Creating question failed, no ID obtained.");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return -1;
        }
    }

    public int addAnswerOption(Answer_Option answerOption) {
        String sql = "INSERT INTO AnswerOptions (questionId, text, isCorrect) VALUES (?, ?, ?)";
        try (PreparedStatement statement = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            statement.setInt(1, answerOption.getQuestionId());
            statement.setString(2, answerOption.getText());
            statement.setBoolean(3, answerOption.isIsCorrect());

            statement.executeUpdate();

            ResultSet generatedKeys = statement.getGeneratedKeys();
            if (generatedKeys.next()) {
                return generatedKeys.getInt(1);
            } else {
                throw new SQLException("Creating answer option failed, no ID obtained.");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return -1;
        }
    }

    public List<Course> getAllCourses() throws SQLException {
        List<Course> courses = new ArrayList<>();
        String sql = "SELECT * FROM courses";
        PreparedStatement stmt = connection.prepareStatement(sql);
        ResultSet rs = stmt.executeQuery();
        while (rs.next()) {
            courses.add(new Course(
                    rs.getInt("id"),
                    rs.getInt("teacher_id"),
                    rs.getString("title"),
                    rs.getString("thumbnail_url"),
                    rs.getString("description"),
                    rs.getInt("category_id"),
                    rs.getString("status"),
                    rs.getDate("created_at"),
                    rs.getInt("price")
            ));
        }
        return courses;
    }

    public List<Lesson> getLessonsByCourseId(int courseId) throws SQLException {
        List<Lesson> lessons = new ArrayList<>();
        String sql = "SELECT * FROM Lesson WHERE CourseID = ?";
        PreparedStatement stmt = connection.prepareStatement(sql);
        stmt.setInt(1, courseId);
        ResultSet rs = stmt.executeQuery();
        while (rs.next()) {
            lessons.add(new Lesson(
                    rs.getInt("LessonID"),
                    rs.getInt("CourseID"),
                    rs.getString("Title"),
                    rs.getString("Content"),
                    rs.getString("VideoURL"),
                    rs.getDate("CreatedAt")
            ));
        }
        return lessons;
    }

    public List<Quiz> getQuizzesByLessonId(int lessonId) throws SQLException {
        List<Quiz> quizzes = new ArrayList<>();
        String sql = "SELECT * FROM Quiz WHERE LessonID = ?";
        PreparedStatement stmt = connection.prepareStatement(sql);
        stmt.setInt(1, lessonId);
        ResultSet rs = stmt.executeQuery();
        while (rs.next()) {
            quizzes.add(new Quiz(
                    rs.getInt("QuizID"),
                    rs.getInt("LessonID"),
                    rs.getString("Title"),
                    rs.getInt("duration_minutes")
            ));
        }
        return quizzes;
    }

    public void createQuiz(Quiz quiz) throws SQLException {
        String sql = "INSERT INTO Quiz (LessonID, Title, duration_minutes) VALUES (?, ?, ?)";
        PreparedStatement stmt = connection.prepareStatement(sql);
        stmt.setInt(1, quiz.getLessonId());
        stmt.setString(2, quiz.getTitle());
        stmt.setInt(3, quiz.getDurationMinutes());
        stmt.executeUpdate();
    }

    public void updateQuiz(Quiz quiz) throws SQLException {
        String sql = "UPDATE Quiz SET Title = ?, duration_minutes = ? WHERE QuizID = ?";
        PreparedStatement stmt = connection.prepareStatement(sql);
        stmt.setString(1, quiz.getTitle());
        stmt.setInt(2, quiz.getDurationMinutes());
        stmt.setInt(3, quiz.getQuizId());
        stmt.executeUpdate();
    }

    public void createQuestion(Question question) throws SQLException {
        String sql = "INSERT INTO Question (QuizID, Text) VALUES (?, ?)";
        PreparedStatement stmt = connection.prepareStatement(sql);
        stmt.setInt(1, question.getQuizId());
        stmt.setString(2, question.getText());
        stmt.executeUpdate();
    }

    public void createAnswerOption(Answer_Option option) throws SQLException {
        String sql = "INSERT INTO Answer_Option (QuestionID, Text, IsCorrect) VALUES (?, ?, ?)";
        PreparedStatement stmt = connection.prepareStatement(sql);
        stmt.setInt(1, option.getQuestionId());
        stmt.setString(2, option.getText());
        stmt.setBoolean(3, option.isIsCorrect());
        stmt.executeUpdate();
    }

    // Thêm câu hỏi mới cho quiz, trả về questionId vừa tạo
    public int addQuestionToQuiz(int quizId, String questionText) throws SQLException {
        String sql = "INSERT INTO Question (QuizID, Text) VALUES (?, ?)";
        try (PreparedStatement stmt = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            stmt.setInt(1, quizId);
            stmt.setString(2, questionText);
            stmt.executeUpdate();
            ResultSet rs = stmt.getGeneratedKeys();
            if (rs.next()) {
                return rs.getInt(1);
            }
        }
        return -1;
    }

    // Thêm đáp án mới cho câu hỏi, trả về optionId vừa tạo
    public int addAnswerOptionToQuestion(int questionId, String answerText, boolean isCorrect) throws SQLException {
        String sql = "INSERT INTO Answer_Option (QuestionID, Text, IsCorrect) VALUES (?, ?, ?)";
        try (PreparedStatement stmt = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            stmt.setInt(1, questionId);
            stmt.setString(2, answerText);
            stmt.setBoolean(3, isCorrect);
            stmt.executeUpdate();
            ResultSet rs = stmt.getGeneratedKeys();
            if (rs.next()) {
                return rs.getInt(1);
            }
        }
        return -1;
    }

    // Cập nhật đáp án đúng/sai cho một option
    public void updateAnswerOptionIsCorrect(int optionId, boolean isCorrect) throws SQLException {
        String sql = "UPDATE Answer_Option SET IsCorrect = ? WHERE OptionID = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setBoolean(1, isCorrect);
            stmt.setInt(2, optionId);
            stmt.executeUpdate();
        }
    }

    // Xóa một đáp án
    public void deleteAnswerOption(int optionId) throws SQLException {
        String sql = "DELETE FROM Answer_Option WHERE OptionID = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, optionId);
            stmt.executeUpdate();
        }
    }

    // Xóa một câu hỏi (và tất cả đáp án liên quan)
    public void deleteQuestion(int questionId) throws SQLException {
        // Xóa đáp án trước
        String sql1 = "DELETE FROM Answer_Option WHERE QuestionID = ?";
        try (PreparedStatement stmt1 = connection.prepareStatement(sql1)) {
            stmt1.setInt(1, questionId);
            stmt1.executeUpdate();
        }
        // Xóa câu hỏi
        String sql2 = "DELETE FROM Question WHERE QuestionID = ?";
        try (PreparedStatement stmt2 = connection.prepareStatement(sql2)) {
            stmt2.setInt(1, questionId);
            stmt2.executeUpdate();
        }
    }

    // Xóa quiz (và toàn bộ câu hỏi + đáp án liên quan)
    public void deleteQuiz(int quizId) throws SQLException {
        // Xóa đáp án
        String sql1 = "DELETE FROM Answer_Option WHERE QuestionID IN (SELECT QuestionID FROM Question WHERE QuizID = ?)";
        try (PreparedStatement stmt1 = connection.prepareStatement(sql1)) {
            stmt1.setInt(1, quizId);
            stmt1.executeUpdate();
        }
        // Xóa câu hỏi
        String sql2 = "DELETE FROM Question WHERE QuizID = ?";
        try (PreparedStatement stmt2 = connection.prepareStatement(sql2)) {
            stmt2.setInt(1, quizId);
            stmt2.executeUpdate();
        }
        // Xóa quiz
        String sql3 = "DELETE FROM Quiz WHERE QuizID = ?";
        try (PreparedStatement stmt3 = connection.prepareStatement(sql3)) {
            stmt3.setInt(1, quizId);
            stmt3.executeUpdate();
        }
    }

    // Lấy quiz theo quizId
    public Quiz getQuizById(int quizId) throws SQLException {
        String sql = "SELECT * FROM Quiz WHERE QuizID = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, quizId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return new Quiz(
                        rs.getInt("QuizID"),
                        rs.getInt("LessonID"),
                        rs.getString("Title"),
                        rs.getInt("duration_minutes")
                );
            }
        }
        return null;
    }

    // Lấy question theo questionId
    public Question getQuestionById(int questionId) throws SQLException {
        String sql = "SELECT * FROM Question WHERE QuestionID = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, questionId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return new Question(
                        rs.getInt("QuestionID"),
                        rs.getInt("QuizID"),
                        rs.getString("Text")
                );
            }
        }
        return null;
    }

    /**
     * Cập nhật đáp án (text, isCorrect)
     */
    public void updateAnswerOption(Answer_Option answerOption) throws SQLException {
        String sql = "UPDATE Answer_Option SET Text = ?, IsCorrect = ? WHERE OptionID = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, answerOption.getText());
            ps.setBoolean(2, answerOption.isIsCorrect());
            ps.setInt(3, answerOption.getOptionId());  // Lưu ý: đổi getter thành getOptionID()
            ps.executeUpdate();
        }
    }
}
