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
        <h1>Giới thiệu về Online Learning</h1>
        <p>
            <strong>Online Learning</strong> là nền tảng học tập trực tuyến hiện đại, được thiết kế nhằm hỗ trợ sinh viên ngành <strong>Công nghệ Thông tin</strong> trong việc học tập, ôn luyện và phát triển kỹ năng chuyên môn.
        </p>
        <p>
            Với nội dung học phong phú, hệ thống cung cấp các bài giảng, video, và tài liệu liên quan đến nhiều môn học cốt lõi trong chương trình đại học như:
        </p>
        <ul>
            <li>Lập trình C/C++, Java, Python</li>
            <li>Cấu trúc dữ liệu & giải thuật</li>
            <li>Hệ quản trị cơ sở dữ liệu (SQL Server, MySQL, PostgreSQL)</li>
            <li>Phát triển Web (HTML, CSS, JavaScript, JSP/Servlets)</li>
            <li>Lập trình hướng đối tượng</li>
            <li>Trí tuệ nhân tạo và Machine Learning cơ bản</li>
            <li>An toàn thông tin</li>
            <li>Hệ điều hành và mạng máy tính</li>
        </ul>
        <p>
            Nền tảng giúp sinh viên học mọi lúc, mọi nơi với giao diện thân thiện, dễ sử dụng và được cập nhật liên tục bởi đội ngũ giảng viên, lập trình viên chuyên nghiệp.
        </p>
        <p>
            Chúng tôi tin rằng việc học trực tuyến hiệu quả sẽ giúp sinh viên chủ động hơn trong hành trình tiếp cận tri thức, phát triển nghề nghiệp tương lai.
        </p>
    </main>

    <%@ include file="/layout/footer.jsp" %>

</body>
</html>
