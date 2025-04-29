<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Comment Section for Shoes ABC</title>

        <style>
            * {
                box-sizing: border-box;
                font-family: Arial, sans-serif;
            }
            body {
                padding: 20px;
                background-color: #f5f5f5;
            }
            .container {
                max-width: 800px;
                margin: 0 auto;
            }
            h2 {
                color: #555;
                margin-bottom: 20px;
            }
            .comment-container {
                margin-bottom: 20px;
                border: 1px solid #ddd;
                border-radius: 4px;
                overflow: hidden;
                background-color: white;
            }
            .comment-header {
                display: flex;
                justify-content: space-between;
                padding: 12px 15px;
                background-color: #f9f9f9;
                border-bottom: 1px solid #eee;
            }
            .user-name {
                font-weight: bold;
                color: #333;
            }
            .comment-body {
                padding: 15px;
                min-height: 80px;
            }
            .comment-actions {
                position: relative;
                display: inline-block;
            }
            .comment-dots {
                cursor: pointer;
                font-weight: bold;
                color: #555;
                font-size: 20px;
                line-height: 0.5;
            }
            .dropdown-content {
                display: none;
                position: absolute;
                right: 0;
                background-color: white;
                min-width: 120px;
                box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
                z-index: 1;
                border-radius: 4px;
                overflow: hidden;
            }
            .dropdown-content a {
                color: #333;
                padding: 12px 16px;
                text-decoration: none;
                display: block;
                font-size: 14px;
            }
            .dropdown-content a:hover {
                background-color: #f1f1f1;
            }
            .show {
                display: block;
            }
            .edit-form {
                padding: 15px;
            }
            .edit-textarea {
                width: 100%;
                min-height: 80px;
                padding: 10px;
                margin-bottom: 10px;
                border: 1px solid #ddd;
                border-radius: 4px;
                resize: vertical;
            }
            .btn-container {
                text-align: right;
            }
            .btn {
                padding: 8px 16px;
                border: none;
                border-radius: 4px;
                cursor: pointer;
                font-size: 14px;
                margin-left: 10px;
            }
            .btn-save {
                background-color: #4CAF50;
                color: white;
            }
            .btn-cancel {
                background-color: #f1f1f1;
                color: #333;
            }
            .star-rating {
                display: flex;
            }

            .star {
                font-size: 30px;
                color: grey; /* default color for unselected stars */
                cursor: pointer;
            }

            .star.selected {
                color: gold; /* color for selected (lit) stars */
            }

            .star:hover {
                color: lightyellow; /* color when hovering over a star */
            }

        </style>
        <!-- Bootstrap 4 CSS -->
        <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
        <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
        <!-- Bootstrap 4 JS -->
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    </head>
    <body>


        <script>
            document.addEventListener("DOMContentLoaded", function () {
                // Lặp qua tất cả các feedback và set rating cho mỗi cái
                var feedbacks = document.querySelectorAll('.comment-container'); // Chọn tất cả comment container
                feedbacks.forEach(function (feedback) {
                    // Lấy rating từ data-rating của mỗi comment container
                    var rating = parseInt(feedback.getAttribute('data-rating')); // Lấy giá trị rating từ data-rating

                    // Gọi hàm setRating để đánh dấu các sao đã chọn
                    setRating(feedback.id, rating);
                });
            });

// Hàm setRating để đánh dấu các sao đã chọn
            function setRating(feedbackId, rating) {
                var feedbackElement = document.getElementById(feedbackId); // Chọn comment container bằng feedbackId
                var stars = feedbackElement.getElementsByClassName('star'); // Lấy tất cả các sao trong phần tử đó

                Array.from(stars).forEach(function (star) {
                    var starValue = parseInt(star.getAttribute('data-value'));

                    if (starValue <= rating) {
                        star.classList.add('selected');
                    } else {
                        star.classList.remove('selected');
                    }
                });
            }

        </script>
        <c:if test="${not empty sessionScope.feedbackMessage}">
            <div class="alert alert-success">
                ${sessionScope.feedbackMessage}
            </div>
            <!-- Xóa thông báo sau khi đã hiển thị -->
            <c:remove var="feedbackMessage" scope="session"/>
        </c:if>
        <div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <form method="post" action="feedback">
                    <input type="hidden" value="add" name="action">
                    <input type="hidden" value="${courseD.id}" name="courseid">
                    <input type="hidden" value="${sessionScope.user.id}" name="studentid">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="exampleModalLabel">Đánh giá</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <!-- Textarea for comment -->
                            <div class="form-group">
                                <label for="commentInput">Đánh giá của bạn:</label>
                                <textarea class="form-control" id="commentInput" rows="4" 
                                          name="textinput" placeholder="Nhập đánh giá của bạn..." required=""></textarea>
                            </div>

                            <!-- Dropdown for rating -->
                            <div class="form-group">
                                <label for="ratingSelect">Chọn Rating (1 - 5 sao):</label>
                                <select class="form-control" id="ratingSelect" name="rating">
                                    <option value="1">1 - ★☆☆☆☆</option>
                                    <option value="2">2 - ★★☆☆☆</option>
                                    <option value="3">3 - ★★★☆☆</option>
                                    <option value="4">4 - ★★★★☆</option>
                                    <option value="5">5 - ★★★★★</option>
                                </select>
                            </div>
                        </div>

                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Đóng</button>
                            <button type="submit" class="btn btn-primary">Đánh giá</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
        <div class="container">
            <div style="display: flex">
                <h2>Đánh giá cho khóa học ${courseD.title}</h2>
                <form action="addfeedback">
                    <input type="hidden" value="${courseD.id}" name="coID">
                    <button type="submit" class="btn btn-primary" >Đánh giá</button>

                    </button></form>


            </div>
            <c:forEach var="feedback" items="${feedback}">
                <div class="comment-container" id="comment${feedback.id}" data-rating="${feedback.rating}">
                    <div class="comment-header">
                        <c:forEach var="user" items="${userList}">
                            <c:if test="${user.id == feedback.student_id}">
                                <div class="user-name">${user.firstName} ${user.lastName}</div>
                            </c:if>
                        </c:forEach>
                        <c:if test="${sessionScope.user.id == feedback.student_id}">
                            <div class="comment-actions">
                                <div class="comment-dots" onclick="toggleDropdown('dropdown${feedback.id}')">&#8226;&#8226;&#8226;</div>
                                <div id="dropdown${feedback.id}" class="dropdown-content">
                                    <a href="editfeedback?coID=${courseD.id}&&commentId=${feedback.id}" >Edit</a>
                                    <a href="#" onclick="deleteComment('comment${feedback.id}')">Delete</a>
                                </div>
                            </div>
                        </c:if>

                    </div>

                    <div class="comment-body" id="comment${feedback.id}-content">
                        ${feedback.content}
                    </div>

                    <div class="star-rating" style="margin-top: -30px; margin-left: 10px">
                        <span class="star" data-value="1">★</span>
                        <span class="star" data-value="2">★</span>
                        <span class="star" data-value="3">★</span>
                        <span class="star" data-value="4">★</span>
                        <span class="star" data-value="5">★</span>
                    </div>
                </div>
            </c:forEach>

        </div>

        <script>
            // Close all dropdowns when clicking elsewhere
            window.onclick = function (event) {
                if (!event.target.matches('.comment-dots')) {
                    let dropdowns = document.getElementsByClassName("dropdown-content");
                    for (let i = 0; i < dropdowns.length; i++) {
                        let openDropdown = dropdowns[i];
                        if (openDropdown.classList.contains('show')) {
                            openDropdown.classList.remove('show');
                        }
                    }
                }
            }

            // Toggle dropdown visibility
            function toggleDropdown(dropdownId) {
                // Close all dropdowns first
                let dropdowns = document.getElementsByClassName("dropdown-content");
                for (let i = 0; i < dropdowns.length; i++) {
                    let openDropdown = dropdowns[i];
                    if (openDropdown.id !== dropdownId && openDropdown.classList.contains('show')) {
                        openDropdown.classList.remove('show');
                    }
                }
                // Then toggle the clicked dropdown
                document.getElementById(dropdownId).classList.toggle("show");
            }

            // Delete comment
            function deleteComment(commentId) {
                // Lấy phần tử comment
                let comment = document.getElementById(commentId);
                const courseId = ${courseD.id}  // Lấy giá trị courseD.id từ nơi bạn đã định nghĩa

                // Thêm hiệu ứng mờ dần (fade out) cho comment
                comment.style.opacity = '0.5';

                // Tạo một form ẩn để gửi yêu cầu POST
                let form = document.createElement('form');
                form.method = 'POST';  // Phương thức POST
                form.action = 'feedback';  // Địa chỉ servlet cần gửi yêu cầu đến (cập nhật với URL của bạn)

                const inputCourseID = document.createElement('input');
                inputCourseID.type = 'hidden';
                inputCourseID.name = 'courseid';
                inputCourseID.value = courseId;
                form.appendChild(inputCourseID)
                // Tạo input ẩn cho action
                let inputAction = document.createElement('input');
                inputAction.type = 'hidden';
                inputAction.name = 'action';
                inputAction.value = 'delete';  // Đặt action là 'delete'
                form.appendChild(inputAction);

                // Tạo input ẩn cho commentId
                let inputCommentId = document.createElement('input');
                inputCommentId.type = 'hidden';
                inputCommentId.name = 'commentId';
                inputCommentId.value = commentId;  // Gửi commentId để xóa đúng comment
                form.appendChild(inputCommentId);

                // Thêm form vào body và gửi form
                document.body.appendChild(form);
                form.submit();  // Gửi form

                // Xóa comment khỏi DOM sau 300ms (hiệu ứng mờ dần)
                setTimeout(function () {
                    comment.remove();
                }, 300);
            }

            // Edit comment
            function editComment(commentId) {
                let commentContent = document.getElementById(commentId + '-content');
                if (!commentContent)
                    return;

                let originalContent = commentContent.textContent.trim();
                commentContent.innerHTML = ''; // Clear nội dung cũ

                // Tạo textarea bằng DOM (tránh lỗi khi có ký tự đặc biệt)
                let textarea = document.createElement('textarea');
                textarea.className = 'edit-textarea';
                textarea.id = `${commentId}-textarea`;
                textarea.value = originalContent;
                textarea.setAttribute('data-original', originalContent);

                let ratingSelect = document.createElement('select');
                ratingSelect.className = 'edit-rating-select';
                ratingSelect.id = `${commentId}-rating`;

                for (let i = 1; i <= 5; i++) {
                    let option = document.createElement('option');
                    option.value = i;
                    option.textContent = i + " ★";
                    ratingSelect.appendChild(option);
                }

                // Lấy rating hiện tại từ data-rating gán vào selected
                let parentComment = document.getElementById(commentId);
                if (parentComment) {
                    let currentRating = parentComment.getAttribute('data-rating');
                    if (currentRating) {
                        ratingSelect.value = currentRating;
                    }
                }

                // Tạo nút Cancel
                let cancelBtn = document.createElement('button');
                cancelBtn.className = 'btn btn-cancel';
                cancelBtn.textContent = 'Cancel';
                cancelBtn.onclick = function () {
                    cancelEdit(commentId);
                };

                // Tạo nút Save
                let saveBtn = document.createElement('button');
                saveBtn.className = 'btn btn-save';
                saveBtn.textContent = 'Save';
                saveBtn.onclick = function () {
                    saveEdit(commentId);
                };

                // Tạo container chứa nút
                let btnContainer = document.createElement('div');
                btnContainer.className = 'btn-container';
                btnContainer.appendChild(cancelBtn);
                btnContainer.appendChild(saveBtn);

                // Tạo form
                let editForm = document.createElement('div');
                editForm.className = 'edit-form';
                editForm.appendChild(textarea);
                editForm.appendChild(btnContainer);

                // Gắn vào DOM
                commentContent.appendChild(editForm);

                textarea.focus();

                // Ẩn dropdown nếu có
                let dropdowns = document.getElementsByClassName("dropdown-content");
                for (let i = 0; i < dropdowns.length; i++) {
                    dropdowns[i].classList.remove('show');
                }
            }

            function cancelEdit(commentId) {
                let commentContent = document.getElementById(commentId + '-content');
                let textarea = document.getElementById(`${commentId}-textarea`);

                if (!commentContent || !textarea) {
                    console.error("Không tìm thấy textarea hoặc commentContent để cancel.");
                    return;
                }

                let originalContent = textarea.getAttribute('data-original');
                commentContent.textContent = originalContent;
            }

            // Save edit
            function saveEdit(commentId) {
                const textarea = document.getElementById(`${commentId}-textarea`);
                if (!textarea) {
                    console.error("Không tìm thấy textarea để lưu.");
                    return;
                }

                const updatedContent = textarea.value; // Lấy giá trị từ textarea

                // Đảm bảo rằng courseD.id đã được xác định trước
                const courseId = ${courseD.id}  // Lấy giá trị courseD.id từ nơi bạn đã định nghĩa

                // Tạo form ẩn để gửi dữ liệu
                const inputAction = document.createElement('input');
                inputAction.type = 'hidden';
                inputAction.name = 'action'; // Tên tham số trong request
                inputAction.value = 'update'; // Đặt giá trị cho action là 'update'

                const inputCourseID = document.createElement('input');
                inputCourseID.type = 'hidden';
                inputCourseID.name = 'courseid';
                inputCourseID.value = courseId; // Đảm bảo rằng courseId có giá trị

                const inputCommentID = document.createElement('input');
                inputCommentID.type = 'hidden';
                inputCommentID.name = 'commentId';
                inputCommentID.value = commentId; // Đảm bảo commentId có giá trị

                const inputNewContent = document.createElement('input');
                inputNewContent.type = 'hidden';
                inputNewContent.name = 'newContent';
                inputNewContent.value = updatedContent; // Gửi giá trị updatedContent lấy từ textarea

                // Tạo form ẩn để gửi dữ liệu
                const form = document.createElement('form');
                form.method = 'POST'; // Phương thức gửi là POST
                form.action = 'feedback'; // Địa chỉ servlet cần gửi request đến
                form.style.display = 'none'; // Ẩn form đi

                // Thêm các input vào form
                form.appendChild(inputAction);
                form.appendChild(inputCourseID);
                form.appendChild(inputCommentID);
                form.appendChild(inputNewContent);

                // Thêm form vào body và gửi form
                document.body.appendChild(form);
                form.submit();
            }
        </script>
    </body>
    <!-- Nút quay lại -->
        
            <a href="CourseController" class="btn btn-link">Quay lại danh sách khóa học</a>
    </body>
</html>
