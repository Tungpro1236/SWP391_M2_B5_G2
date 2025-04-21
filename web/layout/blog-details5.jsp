<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="vn.edu.fpt.model.Blog, vn.edu.fpt.dao.BlogDAO, java.util.List, vn.edu.fpt.dao.DBContext"%>
<!DOCTYPE html>
<html lang="vi">
     <head>
        <title>Blogs Details | OnlineLearning</title>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=5.0, minimum-scale=0.86">
        <meta name="author" content="4user.net" />
        <meta name="keywords" content="4user,4user academy,4user.net,foruser.net,foruser"/>
        <meta name="description" content="We're a leading marketplace platform for learning and teaching online. Explore some of our most popular content and learn something new." />

        <!-- Favicon -->
        <link rel="shortcut icon" href="https://img.freepik.com/free-vector/e-learning-global-community_24877-60109.jpg">
        <link rel="apple-touch-icon" href="https://img.freepik.com/free-vector/e-learning-global-community_24877-60109.jpg">

    
    <!-- CSS links -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@300;400;500;600;700;800&family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">
    
    <style>
        :root {
            --primary-color: #4361ee;
            --primary-hover: #3a56d4;
            --secondary-color: #3f37c9;
            --accent-color: #f72585;
            --light-color: #f8f9fa;
            --dark-color: #212529;
            --gray-color: #6c757d;
            --light-gray: #f1f3f5;
            --border-radius: 8px;
            --box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
            --transition: all 0.3s ease;
        }
        
        body {
            font-family: 'Poppins', 'Open Sans', sans-serif;
            color: var(--dark-color);
            background-color: var(--light-gray);
            line-height: 1.6;
        }
        
        /* Header Styles */
        .top-header {
            background-color: var(--dark-color);
            color: white;
            font-size: 0.9rem;
            padding: 8px 0;
        }
        
        .top-header a {
            color: rgba(255,255,255,0.8);
            text-decoration: none;
            transition: var(--transition);
        }
        
        .top-header a:hover {
            color: white;
        }
        
        .divider {
            width: 1px;
            height: 20px;
            background-color: rgba(255,255,255,0.2);
            margin: 0 15px;
        }
        
        /* Navigation */
        .navbar {
            padding: 15px 0;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
        }
        
        .navbar-brand img {
            height: 50px;
            transition: var(--transition);
        }
        
        .navbar-brand:hover img {
            transform: scale(1.05);
        }
        
        .nav-link {
            font-weight: 500;
            padding: 8px 15px;
            color: var(--dark-color);
        }
        
        .nav-link:hover {
            color: var(--primary-color);
        }
        
        .btn-primary {
            background-color: var(--primary-color);
            border-color: var(--primary-color);
            font-weight: 500;
            padding: 8px 20px;
            transition: var(--transition);
        }
        
        .btn-primary:hover {
            background-color: var(--primary-hover);
            border-color: var(--primary-hover);
            transform: translateY(-2px);
        }
        
        .btn-outline-primary {
            color: var(--primary-color);
            border-color: var(--primary-color);
            font-weight: 500;
        }
        
        .btn-outline-primary:hover {
            background-color: var(--primary-color);
            border-color: var(--primary-color);
        }
        
        /* Blog Content */
        .blog-banner {
            width: 100%;
            height: 400px;
            object-fit: cover;
            border-radius: var(--border-radius);
            margin-bottom: 30px;
        }
        
        .blog-title {
            font-size: 2.2rem;
            font-weight: 700;
            margin-bottom: 20px;
            line-height: 1.3;
        }
        
        .blog-meta {
            font-size: 0.9rem;
            color: var(--gray-color);
            margin-bottom: 20px;
        }
        
        .blog-content {
            font-size: 1.05rem;
            line-height: 1.8;
        }
        
        .blog-content img {
            max-width: 100%;
            height: auto;
            border-radius: var(--border-radius);
            margin: 20px 0;
        }
        
        .author-card {
            background-color: white;
            border-radius: var(--border-radius);
            padding: 25px;
            box-shadow: var(--box-shadow);
            margin: 40px 0;
        }
        
        .author-img {
            width: 120px;
            height: 120px;
            border-radius: 50%;
            object-fit: cover;
            border: 3px solid var(--light-gray);
        }
        
        .comment-section {
            background-color: white;
            border-radius: var(--border-radius);
            padding: 25px;
            box-shadow: var(--box-shadow);
            margin-top: 40px;
        }
        
        /* Sidebar */
        .sidebar {
            background: white;
            border-radius: var(--border-radius);
            padding: 25px;
            box-shadow: var(--box-shadow);
            position: sticky;
            top: 20px;
        }
        
        .sidebar-title {
            font-size: 1.1rem;
            font-weight: 600;
            padding-bottom: 12px;
            border-bottom: 2px solid var(--light-gray);
            margin-bottom: 20px;
            color: var(--dark-color);
        }
        
        .search-box {
            position: relative;
            margin-bottom: 25px;
        }
        
        .search-box .form-control {
            border-radius: 50px;
            padding: 10px 20px;
            border-color: #e0e0e0;
        }
        
        .search-box button {
            position: absolute;
            right: 5px;
            top: 5px;
            width: 36px;
            height: 36px;
            border-radius: 50%;
            background-color: var(--primary-color);
            color: white;
            border: none;
            display: flex;
            align-items: center;
            justify-content: center;
            transition: var(--transition);
        }
        
        .search-box button:hover {
            background-color: var(--primary-hover);
        }
        
        .category-item {
            padding: 12px 0;
            border-bottom: 1px solid var(--light-gray);
            transition: var(--transition);
        }
        
        .category-item:hover {
            background-color: rgba(67, 97, 238, 0.05);
        }
        
        .category-item a {
            display: flex;
            justify-content: space-between;
            align-items: center;
            color: var(--dark-color);
            text-decoration: none;
            font-weight: 500;
        }
        
        .category-item a:hover {
            color: var(--primary-color);
        }
        
        .category-badge {
            background-color: var(--primary-color);
            font-size: 0.75rem;
        }
        
        .view-all {
            display: inline-block;
            margin-top: 10px;
            color: var(--primary-color);
            font-weight: 500;
            text-decoration: none;
            transition: var(--transition);
        }
        
        .view-all:hover {
            color: var(--primary-hover);
            text-decoration: underline;
        }
        
        /* Footer */
        .footer {
            background-color: var(--dark-color);
            color: white;
            padding: 60px 0 0;
            margin-top: 80px;
        }
        
        .footer h5 {
            font-size: 1.1rem;
            font-weight: 600;
            margin-bottom: 20px;
            position: relative;
            padding-bottom: 10px;
        }
        
        .footer h5::after {
            content: '';
            position: absolute;
            left: 0;
            bottom: 0;
            width: 40px;
            height: 2px;
            background-color: var(--primary-color);
        }
        
        .footer a {
            color: rgba(255,255,255,0.7);
            text-decoration: none;
            transition: var(--transition);
            display: inline-block;
            margin-bottom: 10px;
        }
        
        .footer a:hover {
            color: white;
            transform: translateX(5px);
        }
        
        .footer-bottom {
            border-top: 1px solid rgba(255,255,255,0.1);
            padding: 20px 0;
            margin-top: 40px;
        }
        
        .social-links a {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            width: 36px;
            height: 36px;
            border-radius: 50%;
            background-color: rgba(255,255,255,0.1);
            color: white;
            margin-right: 10px;
            transition: var(--transition);
        }
        
        .social-links a:hover {
            background-color: var(--primary-color);
            transform: translateY(-3px);
        }
        
        /* Responsive Adjustments */
        @media (max-width: 991.98px) {
            .blog-title {
                font-size: 1.8rem;
            }
            
            .blog-banner {
                height: 300px;
            }
        }
        
        @media (max-width: 767.98px) {
            .blog-title {
                font-size: 1.5rem;
            }
            
            .blog-banner {
                height: 200px;
            }
            
            .footer {
                text-align: center;
            }
            
            .footer h5::after {
                left: 50%;
                transform: translateX(-50%);
            }
        }
    </style>
</head>
<body>
    <!-- Top Header -->
    <div class="top-header">
        <div class="container">
            <div class="d-flex justify-content-between align-items-center">
                <div class="d-flex align-items-center">
                    <a href="tel:+84339827017"><i class="fas fa-phone-alt me-2"></i> +84339827017</a>
                    <div class="divider"></div>
                    <a href="mailto:academy@example.com"><i class="fas fa-envelope me-2"></i> vietnhhe161420@fpt.edu.vn</a>
                </div>
                <div class="d-none d-lg-block">
                    <select class="form-select form-select-sm bg-dark text-white border-dark">
                        <option value="english">English</option>
                        <option value="vietnamese" selected>Tiếng Việt</option>
                    </select>
                </div>
            </div>
        </div>
    </div>

    <!-- Navigation -->
    <nav class="navbar navbar-expand-lg navbar-light bg-white sticky-top">
        <div class="container">
            <a class="navbar-brand" href="index.jsp">
                <img src="https://img.freepik.com/free-vector/e-learning-global-community_24877-60109.jpg" alt="4User Academy" height="50">
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarContent">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarContent">
                <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                    <li class="nav-item">
                        <a class="nav-link" href="index.jsp"><i class="fas fa-book-open me-1"></i> Khóa học</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#"><i class="fas fa-tasks me-1"></i> Bài tập</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#"><i class="fas fa-store me-1"></i> Cửa hàng</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" href="blogs.jsp"><i class="fas fa-blog me-1"></i> Blog</a>
                    </li>
                </ul>
                <form class="d-flex me-3">
                    <div class="input-group search-box">
                        <input type="text" class="form-control" placeholder="Tìm kiếm...">
                        <button type="submit"><i class="fas fa-search"></i></button>
                    </div>
                </form>
                <div class="d-flex">
                    <a href="login.jsp" class="btn btn-outline-primary me-2"><i class="fas fa-sign-in-alt me-1"></i> Đăng nhập</a>
                    <a href="register.jsp" class="btn btn-primary"><i class="fas fa-user-plus me-1"></i> Đăng ký</a>
                </div>
            </div>
        </div>
    </nav>

    <!-- Main Content -->
    <section class="py-5">
        <div class="container">
            <div class="row">
                <!-- Blog Content -->
                <div class="col-lg-8">
                    <article class="blog-post">
                        <img src="https://www.gyrus.com/wp-content/uploads/2024/03/AI-Based-learning-1-1024x576.webp" 
                             class="blog-banner" alt="Blog banner">
                        
                        <div class="blog-meta">
                            <span class="me-3"><i class="far fa-calendar-alt me-1"></i> Được phát hành - Tue, 26 Sep 2023</span>
                            <span><i class="far fa-eye me-1"></i> 1.2K lượt xem</span>
                        </div>
                        
                        <h1 class="blog-title">AI-Based learning is the future of Corporate Training</h1>
                        
                        <div class="blog-content">
                            The corporate world is slowly stepping into the dimension of Artificial Intelligence. This technology is transforming their training at an accelerated pace. To leverage this technology for improved employee performance, the industry needs to understand its benefits and drawbacks. AI-Based Learning is not just about skill development as it adds to the context, relevance, and personalization of the learning experience. It does have the potential to make a high-risk environment safe. With the cooperation of an online employee training system, this technology can be very well served in the corporate sector.

Investment in AI-Based Learning will exponentially increase in the coming years. Learning is not just about instruction, but it’s about the flow. Artificial Intelligence allows your employees to learn at their pace, most productively. Gyrus’s employee training management system makes sure that AI technology is taken into account for better efficacy. It allows the workforce to handle more complex tasks with this advanced technology.

How is AI-Based learning making a change in employee skill management systems?
Artificial Intelligence is one of the innovative techniques that customize the learner’s experience. It’s transforming the way of learning and teaching, making its way into the corporate sector. The environment that exists in the industry today is way more diverse, uncertain, and demanding as compared to previous times. Approaching this technology has become a need rather than a want for professionals. Gyrus understands the urgent need for AI-Based Learning in corporations and makes this available in the online employee training system.

Here know why AI-Based Learning is the future of Corporate Training:

Personalized Learning: Imparts right content to the right person at the right time
Artificial Intelligence is such a potent technology as it helps to find out the learner’s skills and creates a personalized study schedule considering the knowledge gap. Personalized or adaptive learning is the need of every employee. The data-driven approach continuously tracks their performance to analyze results. After this step, it formulates content depending upon their expertise and preferences. It is so easy for the workforce to master a new skill with AI-Based Learning. This technology will continue to adapt the resources and difficulty levels till they have not mastered the concept. When the employees are equipped with relevant topics, it improves their time efficiency and motivation levels.

Also, the process is not the same for each learner. One student may find it easier to grasp the content and implement it in their work process, while another finds it hard to follow the same procedure and may be good in other skills. Onboarding AI on the online employee training system is a step forward to effective corporate development. It is a dynamic, flexible, and personalized training approach that adapts to the needs of employees, enabling them to be the leader of their learning.

Improved Engagement Rate: Learners Support with Advanced Features
What makes an e-learning program show its desired results? When employees’ grievances and their queries are handled on time in their learning process. Since AI makes learning content more concise, personalized, and relevant with its advanced features like chatbots, virtual assistants, and much more, it leads to better completion rates. The learners will go ahead with an online course only when it interests them and provides the resources or knowledge as per their skills and demands. Gyrus AI-Based learning in employee training management system identifies the current obstacles and delivers guided walkthroughs to save time for the employees. It can be integrated into an LMS to track how they are engaging with the in-app guidance.

Create E-Learning Programs: In less time
Leveraging Artificial Intelligence is the best thing for corporations as it creates courses in a much simpler, faster, and more agile way without sacrificing the quality of the content. The automatic translation and localization feature in AI offers more speed and efficiency to the learners while they upskill themselves in this platform.

It is challenging to create useful content in multiple countries or companies working with remote areas that carry different languages. Fortunately, AI has made it possible to develop multi-language content or create courses as per the need and abilities of the user. Gyrus integrates different sources to automatically deliver the best content to our learners where they don’t have to search for it.

Facilitate Better Decision Making: With Advanced Analytic Features
AI-Based Learning enables the company’s instructors, the learning and development department to get detailed information about employees’ performance, strengths, improvement areas, and other specific issues. It becomes comparatively easier for the management to make informed decisions and take an on-time action before the employee stops getting motivated to leave the course. Now, Corporate leaders can create and manage their e-Learning content to get updates about student progress with the help of powerful data analytics.

The top focus point of AI is it helps Learning and Development leaders to gain access to key insights such as how and when employees learn effectively. It also provides valuable feedback and guidance to increase learning productivity.

In the future, many processes that today rely on people will be held on artificial intelligence. It creates the possibility to pursue the up-skilling objectives no matter where the learners are present in the world. There is no need to worry about the restrictions that arise in the learning process. AI has no limit to intelligence. The same can also be created in the employees for better productivity and self-confidence.

Harness the power of Artificial Intelligence with Gyrus employee training management system that offers the companies personalized learning to save both instructors and employees time, allowing them to work on key tasks. It can solve general, undefined problems far better than a human being as it is the primary contributor in making systems more agile, automatic, and reliable. Although strong AI will only be possible after years of development, it is very potent even now. The above-mentioned functionalities are the proof. Take a smart step and approach AI-based learning in your training mechanisms now.
                        </div>
                    </article>
                    
                    <!-- Author Info -->
                    <div class="author-card">
                        <div class="row align-items-center">
                            <div class="col-md-3 text-center">
                                <img src="https://img.freepik.com/free-vector/e-learning-global-community_24877-60109.jpg" 
                                     class="author-img" alt="Author">
                            </div>
                            <div class="col-md-9">
                                <h4 class="mb-2">4 User</h4>
                                <p class="text-muted mb-3">Chuyên gia về giáo dục và phát triển bản thân</p>
                                <p class="mb-0">Tác giả với hơn 10 năm kinh nghiệm trong lĩnh vực giáo dục và đào tạo. Chia sẻ những kiến thức hữu ích giúp học sinh, sinh viên phát triển bản thân.</p>
                                <a href="#" class="btn btn-outline-primary mt-3">Xem tất cả bài viết</a>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Comments Section -->
                    <div class="comment-section">
                        <div class="d-flex justify-content-between align-items-center mb-4">
                            <h3 class="mb-0"><i class="far fa-comments me-2"></i> Bình luận (0)</h3>
                            <button class="btn btn-primary" onclick="toggleCommentForm()">
                                <i class="fas fa-plus me-1"></i> Thêm bình luận
                            </button>
                        </div>
                        
                        <div class="comment-form d-none" id="commentForm">
                            <form>
                                <div class="mb-3">
                                    <textarea class="form-control" rows="4" placeholder="Nhập bình luận của bạn..."></textarea>
                                </div>
                                <button type="submit" class="btn btn-primary">Gửi bình luận</button>
                            </form>
                        </div>
                        
                        <div class="no-comments text-center py-5">
                            <i class="far fa-comment-dots fa-3x text-muted mb-3"></i>
                            <h5>Chưa có bình luận nào</h5>
                            <p class="text-muted">Hãy là người đầu tiên bình luận về bài viết này</p>
                        </div>
                    </div>
                </div>
                
                <!-- Sidebar -->
                <div class="col-lg-4">
                    <div class="sidebar">
                        <div class="search-box mb-4">
                            <h3 class="sidebar-title">Tìm kiếm</h3>
                            <form action="blogs.jsp" method="get">
                                <div class="input-group">
                                    <input type="text" class="form-control" placeholder="Tìm kiếm bài viết..." name="search">
                                    <button class="btn" type="submit"><i class="fas fa-search"></i></button>
                                </div>
                            </form>
                        </div>
                        
                        <div class="mb-5">
                            <h3 class="sidebar-title">Danh mục phổ biến</h3>
                            <div class="list-group">
                                <div class="category-item">
                                    <a href="#">
                                        <span><i class="fas fa-running me-2"></i> Thể thao</span>
                                        <span class="badge bg-primary rounded-pill">12</span>
                                    </a>
                                </div>
                                <div class="category-item">
                                    <a href="#">
                                        <span><i class="fas fa-heart me-2"></i> Lối sống</span>
                                        <span class="badge bg-primary rounded-pill">8</span>
                                    </a>
                                </div>
                                <div class="category-item">
                                    <a href="#">
                                        <span><i class="fas fa-user me-2"></i> Cá nhân</span>
                                        <span class="badge bg-primary rounded-pill">5</span>
                                    </a>
                                </div>
                                <div class="category-item">
                                    <a href="#">
                                        <span><i class="fas fa-laptop-code me-2"></i> Công nghệ</span>
                                        <span class="badge bg-primary rounded-pill">14</span>
                                    </a>
                                </div>
                                <div class="category-item">
                                    <a href="#">
                                        <span><i class="fas fa-book me-2"></i> Giáo dục</span>
                                        <span class="badge bg-primary rounded-pill">23</span>
                                    </a>
                                </div>
                                <a href="#" class="view-all">Xem tất cả danh mục</a>
                            </div>
                        </div>
                        
                        <div>
                            <h3 class="sidebar-title">Bài viết mới nhất</h3>
                            <div class="list-group">
                                <a href="#" class="d-flex mb-3 text-decoration-none">
                                    <img src="https://4user.net/uploads/blog/banner/baf534a139d7bf04fe4e967399aa5571.png" 
                                         width="80" height="60" class="rounded me-3" style="object-fit: cover;" alt="Recent post">
                                    <div>
                                        <h6 class="mb-1">As the semester progresses, keep track of key dates</h6>
                                        <small class="text-muted">Tue, 26 Sep 2023</small>
                                    </div>
                                </a>
                                <a href="#" class="d-flex mb-3 text-decoration-none">
                                    <img src="https://4user.net/uploads/blog/banner/bc26f1592e226dbb8abc8b93ff3fa962.png" 
                                         width="80" height="60" class="rounded me-3" style="object-fit: cover;" alt="Recent post">
                                    <div>
                                        <h6 class="mb-1">Parent Power: Will We Choose Pitchforks or Partnerships?</h6>
                                        <small class="text-muted">Tue, 19 Sep 2023</small>
                                    </div>
                                </a>
                                <a href="#" class="d-flex mb-3 text-decoration-none">
                                    <img src="https://4user.net/uploads/blog/banner/9e9e4d2a5a2a7a3a9e4d2a5a2a7a3a9e.png" 
                                         width="80" height="60" class="rounded me-3" style="object-fit: cover;" alt="Recent post">
                                    <div>
                                        <h6 class="mb-1">The Future of Education in a Digital World</h6>
                                        <small class="text-muted">Sep 12, 2023</small>
                                    </div>
                                </a>
                            </div>
                            <a href="blogs.jsp" class="view-all">Xem tất cả bài viết</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Footer -->
    <footer class="footer">
        <div class="container">
            <div class="row g-4">
                <div class="col-lg-4">
                    <img src="https://img.freepik.com/free-vector/e-learning-global-community_24877-60109.jpg" alt="4User Academy" height="50" class="mb-3">
                    <p class="text-muted">Empowering learners worldwide with quality education resources and innovative learning solutions.</p>
                    <div class="social-links mt-4">
                        <a href="#"><i class="fab fa-facebook-f"></i></a>
                        <a href="#"><i class="fab fa-twitter"></i></a>
                        <a href="#"><i class="fab fa-linkedin-in"></i></a>
                        <a href="#"><i class="fab fa-instagram"></i></a>
                        <a href="#"><i class="fab fa-youtube"></i></a>
                    </div>
                </div>
                <div class="col-lg-2 col-md-4">
                    <h5>Quick Links</h5>
                    <ul class="list-unstyled">
                        <li><a href="#">Home</a></li>
                        <li><a href="#">About Us</a></li>
                        <li><a href="#">Courses</a></li>
                        <li><a href="#">Blog</a></li>
                        <li><a href="#">Contact</a></li>
                    </ul>
                </div>
                <div class="col-lg-2 col-md-4">
                    <h5>Categories</h5>
                    <ul class="list-unstyled">
                        <li><a href="#">Technology</a></li>
                        <li><a href="#">Business</a></li>
                        <li><a href="#">Design</a></li>
                        <li><a href="#">Development</a></li>
                        <li><a href="#">Marketing</a></li>
                    </ul>
                </div>
                <div class="col-lg-4 col-md-4">
                    <h5>Newsletter</h5>
                    <p class="text-muted">Subscribe to our newsletter to get updates on new courses and articles.</p>
                    <form class="mt-3">
                        <div class="input-group mb-3">
                            <input type="email" class="form-control" placeholder="Your email" required>
                            <button class="btn btn-primary" type="submit">Subscribe</button>
                        </div>
                    </form>
                </div>
            </div>
            
            <div class="footer-bottom">
                <div class="row align-items-center">
                    <div class="col-md-6 text-center text-md-start">
                        &copy; 2023 4User Academy. All rights reserved.
                    </div>
                    <div class="col-md-6 text-center text-md-end">
                        <a href="#" class="text-muted me-3">Privacy Policy</a>
                        <a href="#" class="text-muted me-3">Terms of Service</a>
                        <a href="#" class="text-muted">Cookie Policy</a>
                    </div>
                </div>
            </div>
        </div>
    </footer>

    <!-- JavaScript -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function toggleCommentForm() {
            $('#commentForm').toggleClass('d-none');
        }
        
        // Initialize tooltips
        var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'))
        var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
            return new bootstrap.Tooltip(tooltipTriggerEl)
        });
    </script>
</body>
</html>