package vn.edu.fpt.model;

import java.util.Date;

public class Lesson {
    private int lessonId;
    private int courseId;
    private String title;
    private String Content;
    private String vidURL;
    private Date createdAt;

    public Lesson() {
    }

    public Lesson(int lessonId, int courseId, String title, String Content, String vidURL, Date createdAt) {
        this.lessonId = lessonId;
        this.courseId = courseId;
        this.title = title;
        this.Content = Content;
        this.vidURL = vidURL;
        this.createdAt = createdAt;
    }

    public int getLessonId() {
        return lessonId;
    }

    public void setLessonId(int lessonId) {
        this.lessonId = lessonId;
    }

    public int getCourseId() {
        return courseId;
    }

    public void setCourseId(int courseId) {
        this.courseId = courseId;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getContent() {
        return Content;
    }

    public void setContent(String Content) {
        this.Content = Content;
    }

    public String getVidURL() {
        return vidURL;
    }

    public void setVidURL(String vidURL) {
        this.vidURL = vidURL;
    }

    public Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }

    @Override
    public String toString() {
        return "Lesson{" + "lessonId=" + lessonId + ", courseId=" + courseId + ", title=" + title + ", Content=" + Content + ", vidURL=" + vidURL + ", createdAt=" + createdAt + '}';
    } 
}