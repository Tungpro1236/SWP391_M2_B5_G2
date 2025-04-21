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
                        <img src="https://www.shutterstock.com/image-photo/parents-one-child-holding-hands-260nw-2077402042.jpg" 
                             class="blog-banner" alt="Blog banner">
                        
                        <div class="blog-meta">
                            <span class="me-3"><i class="far fa-calendar-alt me-1"></i> Được phát hành - Tue, 26 Sep 2023</span>
                            <span><i class="far fa-eye me-1"></i> 1.2K lượt xem</span>
                        </div>
                        
                        <h1 class="blog-title">Parents and Schools: Bridging the Gap for Student Success</h1>
                        
                        <div class="blog-content">
                            <p>The relationship between parents and educators has never been more crucial.
In a time of rapid educational reform and shifting expectations, building partnerships—not conflict—can pave the way for a stronger, more resilient future for our children. Education is no longer confined to the four walls of a classroom. Learning happens everywhere — at home, online, in the community — and it takes a village to nurture each child’s potential.

When parents and teachers work together as allies, not adversaries, students benefit most. Open communication builds trust. Shared goals lead to consistency. And mutual respect fosters an environment where every child feels supported, both emotionally and academically.

But building these partnerships takes intention. It starts with listening — not just to problems, but to hopes, concerns, and perspectives from both sides. Educators need to acknowledge the expertise parents bring about their own children, while parents must also respect the professional insight and dedication teachers provide.

Transparency is key. Schools must create space for regular dialogue, not just during report cards or parent-teacher conferences. Likewise, parents should feel welcomed and empowered to be part of the learning journey, not just passive observers.

Today’s educational landscape is complex — with changes in curriculum, technology integration, mental health concerns, and post-pandemic challenges. It’s easy for misunderstandings to arise, but it’s even more important now to stay united in our shared purpose: giving every child the opportunity to thrive.

Together, parents and educators can model the very lessons we want students to learn — empathy, collaboration, resilience, and problem-solving. When we bridge the gap between home and school, we don’t just improve academic outcomes; we build stronger communities and a brighter future.
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
                                <a href="blogs.jsp" class="view-all">Xem tất cả danh mục</a>
                            </div>
                        </div>
                        
                        <div>
                            <h3 class="sidebar-title">Bài viết mới nhất</h3>
                            <div class="list-group">
                                <a href="blogs.jsp" class="d-flex mb-3 text-decoration-none">
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