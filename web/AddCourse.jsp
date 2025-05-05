<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.util.List" %>
<%@ page import="vn.edu.fpt.model.Category" %> 
<%@ page import="vn.edu.fpt.dao.CourseDAO" %> 

<%
    CourseDAO courseDAO = new CourseDAO();
    List<Category> categoryList = courseDAO.getAllCategories();
%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Add Course</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </head>
    <body>
        <div class="container py-5">
            <h1 class="text-center mb-5">Add New Course</h1>
            <div class="row justify-content-center">
                <div class="col-md-10">
                    <form action="CourseController" method="post">
                        <!-- Title -->
                        <div class="mb-3">
                            <label for="title" class="form-label">Course Title</label>
                            <input type="text" class="form-control" id="title" name="title" placeholder="Enter course title" required>
                        </div>

                        <!-- Thumbnail URL -->
                        <div class="mb-3">
                            <label for="thumbnailUrl" class="form-label">Thumbnail URL</label>
                            <input type="url" class="form-control" id="thumbnailUrl" name="thumbnailUrl" placeholder="Enter image URL" required>
                        </div>

                        <!-- Description -->
                        <div class="mb-3">
                            <label for="description" class="form-label">Description</label>
                            <textarea class="form-control" id="description" name="description" rows="4" placeholder="Short description of the course" required></textarea>
                        </div>

                        <!-- Category Select -->
                        <div class="mb-3">
                            <label for="categoryId" class="form-label">Semester</label>
                            <select class="form-select" id="categoryId" name="categoryId" required>
                                <option value="">-- Select semester --</option>
                                <% for (Category category : categoryList) { %>
                                <option value="<%= category.getId() %>"><%= category.getSemester() %></option>
                                <% } %>
                            </select>
                        </div>

                        <!-- Status -->
                        <div class="mb-3">
                            <label for="status" class="form-label">Status</label>
                            <select class="form-select" id="status" name="status" required>
                                <option value="active">Active</option>
                                <option value="inactive">Inactive</option>
                            </select>
                        </div>

                        <!-- Price -->
                        <div class="mb-3">
                            <label for="price" class="form-label">Price (USD)</label>
                            <input type="number" class="form-control" id="price" name="price" placeholder="Enter course price" min="0" required>
                        </div>

                        <input type="hidden" name="action" value="add">
                        <div class="d-grid gap-2">
                            <button type="submit" class="btn btn-success btn-lg">Save Course</button>
                        </div>
                    </form>
                    <a href="CourseController?action=manageCourse" class="d-block mt-3">Back to Course List</a>
                </div>
            </div>
        </div>
    </body>

</html>

