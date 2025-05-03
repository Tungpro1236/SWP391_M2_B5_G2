/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package vn.edu.fpt.model;

/**
 *
 * @author ASUS
 */
public class User_Answer {
    private int userAnswerId;
    private int attemptId;
    private int questionId;
    private int optionId;

    public User_Answer() {
    }

    public User_Answer(int userAnswerId, int attemptId, int questionId, int optionId) {
        this.userAnswerId = userAnswerId;
        this.attemptId = attemptId;
        this.questionId = questionId;
        this.optionId = optionId;
    }

    public int getUserAnswerId() {
        return userAnswerId;
    }

    public void setUserAnswerId(int userAnswerId) {
        this.userAnswerId = userAnswerId;
    }

    public int getAttemptId() {
        return attemptId;
    }

    public void setAttemptId(int attemptId) {
        this.attemptId = attemptId;
    }

    public int getQuestionId() {
        return questionId;
    }

    public void setQuestionId(int questionId) {
        this.questionId = questionId;
    }

    public int getOptionId() {
        return optionId;
    }

    public void setOptionId(int optionId) {
        this.optionId = optionId;
    }

    @Override
    public String toString() {
        return "User_Answer{" + "userAnswerId=" + userAnswerId + ", attemptId=" + attemptId + ", questionId=" + questionId + ", optionId=" + optionId + '}';
    }
    
    
}
