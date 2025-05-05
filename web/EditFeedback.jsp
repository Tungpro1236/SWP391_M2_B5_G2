<%-- 
    Document   : AddComment.jsp
    Created on : Apr 28, 2025, 10:31:40 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <!-- Bootstrap 4 CSS -->
        <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
        <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
        <!-- Bootstrap 4 JS -->
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <style>
            body {
                background-color: #f8f9fa; /* màu nền nhẹ nhàng */
                font-family: Arial, sans-serif;
                padding: 20px;
            }

            form {
                max-width: 600px;
                margin: auto;
                background: white;
                padding: 30px;
                border-radius: 8px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            }

            .form-group,
            .form-check {
                margin-bottom: 15px;
            }

            label {
                font-weight: 600;
            }

            .btn-primary {
                width: 100%;
            }
        </style>
    </head>
    <body>
        <form action="editfeedback" method="post">
            <input type="hidden" name="courseid" value="${courseD.id}"> 
            <input type="hidden" value="${feedback.id}" name="commentId">
            <div class="form-group">
                <label for="commentInput">Your Feedback:</label>
                <textarea class="form-control" id="commentInput" rows="4" 
                          name="textinput" placeholder="Enter Your Feedback..." required="">${feedback.content}</textarea>
            </div>
            <div class="form-group">
                <label for="ratingSelect">Choice Rating (1 - 5 ):</label>
                <select class="form-control" id="ratingSelect" name="rating">
                    <option value="1" ${feedback.rating == 1 ? "selected" : ""}>1 - ★☆☆☆☆</option>
                    <option value="2" ${feedback.rating == 2 ? "selected" : ""}>2 - ★★☆☆☆</option>
                    <option value="3" ${feedback.rating == 3 ? "selected" : ""}>3 - ★★★☆☆</option>
                    <option value="4" ${feedback.rating == 4 ? "selected" : ""}>4 - ★★★★☆</option>
                    <option value="5" ${feedback.rating == 5 ? "selected" : ""}>5 - ★★★★★</option>
                </select>
            </div>
            <button type="submit" class="btn btn-primary">Edit</button>
        </form>
    </body>
</html>