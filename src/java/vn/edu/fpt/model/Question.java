/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package vn.edu.fpt.model;

import java.util.List;

/**
 *
 * @author ASUS
 */
public class Question {
    private int questionId;
    private int quizId;
    private String text;
    private List<Answer_Option> answerOptions; 

    public Question() {
    }

    public Question(int questionId, int quizId, String text) {
        this.questionId = questionId;
        this.quizId = quizId;
        this.text = text;
    }

    public int getQuestionId() {
        return questionId;
    }

    public void setQuestionId(int questionId) {
        this.questionId = questionId;
    }

    public int getQuizId() {
        return quizId;
    }

    public void setQuizId(int quizId) {
        this.quizId = quizId;
    }

    public String getText() {
        return text;
    }

    public void setText(String text) {
        this.text = text;
    }

    

    public void setAnswerOptions(List<Answer_Option> answerOptions) {
        this.answerOptions = answerOptions;
    }

    public List<Answer_Option> getAnswerOptions() {
        return answerOptions;
    }
}

