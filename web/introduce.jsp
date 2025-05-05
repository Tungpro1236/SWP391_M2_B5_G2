<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Giới thiệu - Online Learning</title>
        <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap">
        <style>
            body {
                margin: 0;
                font-family: 'Roboto', sans-serif; /* Sử dụng font Roboto */
            }

            header {
                background-color: #1e293b;
                padding: 15px 30px;
                color: white;
            }

            nav {
                display: flex;
                justify-content: space-between;
                align-items: center;
            }

            .logo {
                font-size: 24px;
                font-weight: bold;
            }

            .menu {
                list-style: none;
                display: flex;
                gap: 20px;
            }

            .menu li a {
                color: white;
                text-decoration: none;
            }

            footer {
                background-color: #0f172a;
                color: #cbd5e1;
                padding: 20px 30px;
                text-align: center;
            }

            main {
                padding: 40px 30px;
                line-height: 1.6;
            }

            h1 {
                color: #1e293b;
            }
        </style>
    </head>
    <body>

        <%@ include file="/layout/header.jsp" %>

        <main>
            <h1>Introduction to Online Learning</h1>
            <p>
                <strong>Online Learning</strong> is a modern online learning platform designed to support students in the field of <strong>Information Technology</strong> in studying, practicing, and developing professional skills.
            </p>
            <p>
                With rich learning content, the system provides lectures, videos, and materials related to many core subjects in the university program such as:
            </p>
            <ul>
                <li>C/C++, Java, Python Programming</li>
                <li>Data Structures & Algorithms</li>
                <li>Database Management Systems (SQL Server, MySQL, PostgreSQL)</li>
                <li>Web Development (HTML, CSS, JavaScript, JSP/Servlets)</li>
                <li>Object-Oriented Programming</li>
                <li>Basic Artificial Intelligence and Machine Learning</li>
                <li>Information Security</li>
                <li>Operating Systems and Computer Networks</li>
            </ul>
            <p>
                The platform enables students to learn anytime, anywhere with a user-friendly interface that is continuously updated by a team of professional lecturers and developers.
            </p>
            <p>
                We believe that effective online learning helps students take a proactive role in their journey to acquire knowledge and build a successful future career.
            </p>
        </main>


        <%@ include file="/layout/footer.jsp" %>

    </body>
</html>
