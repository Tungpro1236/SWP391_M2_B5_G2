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
        <form action="addfeedback" method="post">
            <input type="hidden" name="courseid" value="${courseD.id}"> 
            <input type="hidden" value="${sessionScope.user.id}" name="studentid">
            <div class="form-group">

                <label for="commentInput">Your feedback:</label>
                <textarea class="form-control" id="commentInput" rows="4" 
                          name="textinput" placeholder="Input your feadback..." required=""></textarea>
            </div>
            <div class="form-group">
                <label for="ratingSelect">Choose Rating (1 - 5 stars):</label>


                <select class="form-control" id="ratingSelect" name="rating">
                    <option value="1">1 - ★☆☆☆☆</option>
                    <option value="2">2 - ★★☆☆☆</option>
                    <option value="3">3 - ★★★☆☆</option>
                    <option value="4">4 - ★★★★☆</option>
                    <option value="5">5 - ★★★★★</option>
                </select>
            </div>

            <button type="submit" class="btn btn-primary">Add feedback</button>

        </form>
    </body>
    
</html>