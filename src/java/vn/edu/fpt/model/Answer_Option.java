/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package vn.edu.fpt.model;

/**
 *
 * @author ASUS
 */
public class Answer_Option {
    private int optionId;
    private int questionId;
    private String text;
    private boolean isCorrect;

    public Answer_Option() {
    }

    public Answer_Option(int optionId, int questionId, String text, boolean isCorrect) {
        this.optionId = optionId;
        this.questionId = questionId;
        this.text = text;
        this.isCorrect = isCorrect;
    }

    public int getOptionId() {
        return optionId;
    }

    public void setOptionId(int optionId) {
        this.optionId = optionId;
    }

    public int getQuestionId() {
        return questionId;
    }

    public void setQuestionId(int questionId) {
        this.questionId = questionId;
    }

    public String getText() {
        return text;
    }

    public void setText(String text) {
        this.text = text;
    }

    public boolean isIsCorrect() {
        return isCorrect;
    }

    public void setIsCorrect(boolean isCorrect) {
        this.isCorrect = isCorrect;
    }

    @Override
    public String toString() {
        return "Answer_Option{" + "optionId=" + optionId + ", questionId=" + questionId + ", text=" + text + ", isCorrect=" + isCorrect + '}';
    }
    
    
}
