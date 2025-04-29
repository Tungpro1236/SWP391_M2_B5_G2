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
public class Quiz {
    private int quizId;
    private int lessonId;
    private String title;
    private int durationMinutes;
    private List<Question> questions;

    public Quiz() {
    }

    public Quiz(int quizId, int lessonId, String title, int durationMinutes) {
        this.quizId = quizId;
        this.lessonId = lessonId;
        this.title = title;
        this.durationMinutes = durationMinutes;
    }

    public int getQuizId() {
        return quizId;
    }

    public void setQuizId(int quizId) {
        this.quizId = quizId;
    }

    public int getLessonId() {
        return lessonId;
    }

    public void setLessonId(int lessonId) {
        this.lessonId = lessonId;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public int getDurationMinutes() {
        return durationMinutes;
    }

    public void setDurationMinutes(int durationMinutes) {
        this.durationMinutes = durationMinutes;
    }
    
    public void setQuestions(List<Question> questions) {
        this.questions = questions;
    }

    public List<Question> getQuestions() {
        return questions;
    }

    @Override
    public String toString() {
        return "Quiz{" + "quizId=" + quizId + ", lessonId=" + lessonId + ", title=" + title + ", durationMinutes=" + durationMinutes + '}';
    }
    
}

