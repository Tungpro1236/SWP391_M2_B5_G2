/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package vn.edu.fpt.model;

import java.util.Date;

/**
 *
 * @author ASUS
 */
public class Quiz_Attempt {
    private int attemptId;
    private int userId;
    private int quizId;
    private Date attemptDate;
    private int score;
    private int completionTimeMinutes;

    public Quiz_Attempt() {
    }

    public Quiz_Attempt(int attemptId, int userId, int quizId, Date attemptDate, int score, int completionTimeMinutes) {
        this.attemptId = attemptId;
        this.userId = userId;
        this.quizId = quizId;
        this.attemptDate = attemptDate;
        this.score = score;
        this.completionTimeMinutes = completionTimeMinutes;
    }

    public int getAttemptId() {
        return attemptId;
    }

    public void setAttemptId(int attemptId) {
        this.attemptId = attemptId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getQuizId() {
        return quizId;
    }

    public void setQuizId(int quizId) {
        this.quizId = quizId;
    }

    public Date getAttemptDate() {
        return attemptDate;
    }

    public void setAttemptDate(Date attemptDate) {
        this.attemptDate = attemptDate;
    }

    public int getScore() {
        return score;
    }

    public void setScore(int score) {
        this.score = score;
    }

    public int getCompletionTimeMinutes() {
        return completionTimeMinutes;
    }

    public void setCompletionTimeMinutes(int completionTimeMinutes) {
        this.completionTimeMinutes = completionTimeMinutes;
    }

    @Override
    public String toString() {
        return "Quiz_Attempt{" + "attemptId=" + attemptId + ", userId=" + userId + ", quizId=" + quizId + ", attemptDate=" + attemptDate + ", score=" + score + ", completionTimeMinutes=" + completionTimeMinutes + '}';
    }
    
    
}
