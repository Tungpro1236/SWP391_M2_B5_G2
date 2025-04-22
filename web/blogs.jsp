<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="vn.edu.fpt.model.Blog, vn.edu.fpt.dao.BlogDAO, java.util.List, vn.edu.fpt.dao.DBContext"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.LinkedHashMap"%>
<%@page import="java.util.ArrayList"%>
<%
// Xử lý tham số tìm kiếm
String searchQuery = request.getParameter("search");
DBContext dbContext = new DBContext();
BlogDAO blogDAO = new BlogDAO(dbContext.getConnection());
List<Blog> blogList;

if (searchQuery != null && !searchQuery.trim().isEmpty()) {
    blogList = blogDAO.searchBlogs(searchQuery);
} else {
    blogList = blogDAO.getAllPublishedBlogs();
}
%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <title>Blogs | OnlineLearning</title>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=5.0, minimum-scale=0.86">
        <meta name="author" content="4user.net" />
        <meta name="keywords" content="4user,4user academy,4user.net,foruser.net,foruser"/>
        <meta name="description" content="We're a leading marketplace platform for learning and teaching online. Explore some of our most popular content and learn something new." />

        <!-- Favicon -->
        <link rel="shortcut icon" href="https://img.freepik.com/free-vector/e-learning-global-community_24877-60109.jpg">
        <link rel="apple-touch-icon" href="https://img.freepik.com/free-vector/e-learning-global-community_24877-60109.jpg">

        <!-- CSS -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
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

            /* Hero Banner */
            .hero-banner {
                background-image: linear-gradient(rgba(0, 0, 0, 0.7), rgba(0, 0, 0, 0.7)),
                    url('https://images.unsplash.com/photo-1522202176988-66273c2fd55f?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1471&q=80');
                background-size: cover;
                background-position: center;
                padding: 100px 0;
                color: white;
            }

            .hero-title {
                font-size: 2.8rem;
                font-weight: 700;
                margin-bottom: 20px;
                line-height: 1.2;
            }

            .hero-subtitle {
                font-size: 1.2rem;
                opacity: 0.9;
                max-width: 600px;
            }

            /* Blog Cards */
            .blog-card {
                border: none;
                border-radius: var(--border-radius);
                overflow: hidden;
                box-shadow: var(--box-shadow);
                transition: var(--transition);
                height: 100%;
                background-color: white;
            }

            .blog-card:hover {
                transform: translateY(-5px);
                box-shadow: 0 10px 30px rgba(0, 0, 0, 0.12);
            }

            .blog-thumbnail {
                width: 100%;
                height: 200px;
                object-fit: cover;
            }

            .blog-meta {
                font-size: 0.85rem;
                color: var(--gray-color);
            }

            .blog-title {
                font-size: 1.25rem;
                font-weight: 600;
                margin: 12px 0;
                color: var(--dark-color);
            }

            .blog-title a {
                color: inherit;
                text-decoration: none;
                transition: var(--transition);
            }

            .blog-title a:hover {
                color: var(--primary-color);
            }

            .blog-excerpt {
                color: var(--gray-color);
                display: -webkit-box;
                -webkit-line-clamp: 3;
                -webkit-box-orient: vertical;
                overflow: hidden;
                margin-bottom: 15px;
            }

            .read-more {
                color: var(--primary-color);
                font-weight: 500;
                text-decoration: none;
                display: inline-flex;
                align-items: center;
                transition: var(--transition);
            }

            .read-more:hover {
                color: var(--primary-hover);
            }

            .read-more i {
                margin-left: 5px;
                transition: var(--transition);
            }

            .read-more:hover i {
                transform: translateX(3px);
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
                .hero-title {
                    font-size: 2.2rem;
                }

                .sidebar {
                    margin-top: 40px;
                }
            }

            @media (max-width: 767.98px) {
                .hero-banner {
                    padding: 70px 0;
                }

                .hero-title {
                    font-size: 1.8rem;
                }

                .footer {
                    text-align: center;
                }

                .footer h5::after {
                    left: 50%;
                    transform: translateX(-50%);
                }

                .footer-bottom .text-md-start,
                .footer-bottom .text-md-end {
                    text-align: center !important;
                    margin: 10px 0;
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



        <!-- Main Content -->
        <section class="py-5">
            <div class="container">
                <div class="row">
                    <!-- Blog List -->
                    <div class="col-lg-8">
                        <div class="d-flex justify-content-between align-items-center mb-4">
                            <h2 class="h4 mb-0">
                                <% if (searchQuery != null && !searchQuery.isEmpty()) { %>
                                Kết quả tìm kiếm cho "<%= searchQuery %>"
                                <% } else { %>
                                Bài Viết Mới Nhất
                                <% } %>
                            </h2>
                            <div class="text-muted">
                                Hiển Thị <%= blogList.size() %> Bài Viết
                            </div>
                        </div>

                        <% if (blogList.isEmpty()) { %>
                        <div class="alert alert-info mt-4">
                            <% if (searchQuery != null && !searchQuery.isEmpty()) { %>
                            Không có bài viết nào được tìm thấy phù hợp với tiêu chí tìm kiếm của bạn
                            <% } else { %>
                            Không có bài viết nào được tìm thấy phù hợp với tiêu chí tìm kiếm của bạn.                            <% } %>
                        </div>
                        <% } else { %>
                        <div class="row g-4">
                            <%
                            int index = 1;
                            for (Blog blog : blogList) {
                            %>
                            <div class="col-md-6">
                                <div class="blog-card h-100">
                                    <% if (blog.getThumbnailUrl() != null && !blog.getThumbnailUrl().isEmpty()) { %>
                                    <img src="<%= blog.getThumbnailUrl() %>" class="blog-thumbnail" alt="<%= blog.getTitle() %>">
                                    <% } else { %>
                                    <img src="https://images.unsplash.com/photo-1499750310107-5fef28a66643?..." class="blog-thumbnail" alt="Default thumbnail">
                                    <% } %>
                                    <div class="p-4">
                                        <div class="d-flex justify-content-between mb-2">
                                            <span class="blog-meta"><i class="far fa-user me-1"></i> 4User Team</span>
                                            <span class="blog-meta"><i class="far fa-calendar-alt me-1"></i> <%= blog.getFormattedPublishDate() %></span>
                                        </div>
                                        <h3 class="blog-title">
                                            <a href="blog-details<%= index %>.jsp?id=<%= blog.getId() %>"><%= blog.getTitle() %></a>
                                        </h3>
                                        <p class="blog-excerpt">
                                            <%= blog.getShortDescription() %>
                                        </p>
                                        <a href="blog-details<%= index %>.jsp?id=<%= blog.getId() %>" class="read-more">
                                            Read more <i class="fas fa-arrow-right"></i>
                                        </a>
                                    </div>
                                </div>
                            </div>
                            <%
                                    index++; // tăng chỉ số sau mỗi blog
                                }
                            %>
                        </div>
                        <% } %>

                        <!-- Pagination -->
                        <nav class="mt-5">
                            <ul class="pagination justify-content-center">
                                <li class="page-item disabled">
                                    <a class="page-link" href="#" tabindex="-1" aria-disabled="true">Previous</a>
                                </li>
                                <li class="page-item active"><a class="page-link" href="blogs.jsp">1</a></li>
                                <li class="page-item"><a class="page-link" href="blogs.jsp">2</a></li>
                                <li class="page-item"><a class="page-link" href="blogs.jsp">3</a></li>
                                <li class="page-item">
                                    <a class="page-link" href="#">Next</a>
                                </li>
                            </ul>
                        </nav>
                    </div>

                    <!-- Sidebar -->
                    <div class="col-lg-4">
                        <div class="sidebar">
                            <div class="search-box mb-4">
                                <h3 class="sidebar-title">Tìm kiếm</h3>
                                <form action="blogs.jsp" method="get">
                                    <div class="input-group">
                                        <input type="text" class="form-control" placeholder="Search articles..." 
                                               name="search" value="<%= (searchQuery != null) ? searchQuery : "" %>">
                                        <button class="btn" type="submit"><i class="fas fa-search"></i></button>
                                    </div>
                                </form>
                            </div>
                            <div class="mb-5">
                                <h3 class="sidebar-title">Danh mục phổ biến</h3>
                                <div class="list-group">
                                    <%
                                    Map<String, Integer> categories = new LinkedHashMap<>();
                                    // Tạm thời dùng dữ liệu mẫu
                                    categories.put("Thể thao", 5);
                                    categories.put("Lối sống", 3);
                                    categories.put("Cá nhân", 5);
                                    categories.put("Công nghệ", 7);
                                    categories.put("Giáo dục", 7);
        
                                    for (Map.Entry<String, Integer> entry : categories.entrySet()) {
                                        String category = entry.getKey();
                                        int count = entry.getValue();
                                        String iconClass = "";
            
                                        // Xác định icon cho từng category
                                        switch(category.toLowerCase()) {
                                            case "Thể thao": iconClass = "fas fa-running"; break;
                                            case "Lối sống": iconClass = "fas fa-heart"; break;
                                            case "Cá nhân": iconClass = "fas fa-user"; break;
                                            case "Công nghệ": iconClass = "fas fa-laptop-code"; break;
                                            case "Giáo dục": iconClass = "fas fa-book"; break;
                                            default: iconClass = "fas fa-tag";
                                        }
                                    %>
                                    <div class="category-item">
                                        <a href="blogs.jsp">
                                            <span><i class="<%= iconClass %> me-2"></i> <%= category %></span>
                                            <span class="badge category-badge rounded-pill"><%= count %></span>
                                        </a>
                                    </div>
                                    <% } %>
                                    <a href="blogs.jsp" class="view-all">Xem tất cả danh mục</a>
                                </div>
                            </div>

                            <div>
                                <h3 class="sidebar-title">Bài viết mới nhất</h3>
                                <%
                                    // Lấy 3 bài viết mới nhất
                                    List<Blog> recentPosts;
                                    if (blogList.isEmpty()) {
                                        recentPosts = new ArrayList<Blog>();
                                    } else {
                                        recentPosts = blogList.subList(0, Math.min(blogList.size(), 3));
                                    }
        
                                    for (int i = 0; i < recentPosts.size(); i++) {
                                    Blog recentBlog = recentPosts.get(i);
                                %>
                                <div class="d-flex mb-3">
                                    <% if (recentBlog.getThumbnailUrl() != null && !recentBlog.getThumbnailUrl().isEmpty()) { %>
                                    <img src="<%= recentBlog.getThumbnailUrl() %>" width="80" height="60" class="rounded me-3" style="object-fit: cover;" alt="<%= recentBlog.getTitle() %>">
                                    <% } else { %>
                                    <img src="https://images.unsplash.com/photo-1499750310107-5fef28a66643?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1470&q=80" 
                                         width="80" height="60" class="rounded me-3" style="object-fit: cover;" alt="Default thumbnail">
                                    <% } %>
                                    <div>
                                        <h6 class="mb-1" style="font-size: 0.95rem;">
                                          <a href="blog-details<%= (i + 1) %>.jsp" style="color: var(--dark-color); text-decoration: none;"><%= recentBlog.getTitle() %></a>
                                        </h6>
                                        <small class="text-muted"><%= recentBlog.getFormattedPublishDate() %></small>
                                    </div>
                                </div>
                                <% } %>
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
                            &copy; 2025 Online Learning. All rights reserved.
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
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script>
            // Function to handle search
            function show_submit_button(e) {
                var search_string = e.value;
                if (search_string) {
                    document.getElementById('blog_search_button').style.display = 'block';
                } else {
                    document.getElementById('blog_search_button').style.display = 'none';
                }
            }

            // Initialize tooltips
            var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'))
            var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
                return new bootstrap.Tooltip(tooltipTriggerEl)
            });
        </script>
    </body>
</html>