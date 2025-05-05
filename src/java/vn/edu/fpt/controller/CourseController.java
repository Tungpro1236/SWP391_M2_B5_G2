/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package vn.edu.fpt.controller;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import vn.edu.fpt.dao.CourseDAO;
import vn.edu.fpt.dao.TeacherRequestDAO;
import vn.edu.fpt.model.Category;
import vn.edu.fpt.model.Course;
import vn.edu.fpt.model.UserModel;

@WebServlet(name = "CourseController", urlPatterns = {"/CourseController"})
public class CourseController extends HttpServlet {

    private static final int PAGE_SIZE = 6; // Số lượng khóa học trên mỗi trang

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        CourseDAO courseDAO = new CourseDAO();
        if (action != null) {
            HttpSession session = request.getSession();
            UserModel user = (UserModel) session.getAttribute("user");

            if (user.getRoleId() == 2) {
                if ("manageCourse".equals(action)) {
                    List<Course> courseList = courseDAO.getAllCourses();
                    request.setAttribute("courseList", courseList);
                    request.getRequestDispatcher("ManageCourse.jsp").forward(request, response);
                } else if ("editCourse".equals(action)) {
                    int courseId = Integer.parseInt(request.getParameter("courseId"));
                    CourseDAO dao = new CourseDAO();
                    Course course = dao.getCourseById(courseId);
                    List<Category> categoryList = dao.getAllCategories();
                    request.setAttribute("course", course);
                    request.setAttribute("categoryList", categoryList);
                    request.getRequestDispatcher("EditCourse.jsp").forward(request, response);
                }
            } else if ("myCourse".equals(action) && user.getRoleId() == 3) {
                if (user == null) {
                    // Nếu chưa đăng nhập, chuyển hướng đến trang đăng nhập
                    response.sendRedirect("login.jsp");
                    return;
                }
                List<Course> myCourses = courseDAO.listCoursesByUserId(user.getId());
                request.setAttribute("myCourses", myCourses);
                request.getRequestDispatcher("MyCourses.jsp").forward(request, response);
            }
        } else {
            // Lấy tất cả các danh mục 
            List<Category> categoryList = courseDAO.getAllCategories();
            request.setAttribute("categoryList", categoryList);
            // Xử lý lọc theo danh mục và phân trang
            String categoryIdParam = request.getParameter("categoryId");
            String pageParam = request.getParameter("page");
            int categoryId = 0;
            int page = 1;
            try {
                if (categoryIdParam != null && !categoryIdParam.isEmpty()) {
                    categoryId = Integer.parseInt(categoryIdParam);
                }
                if (pageParam != null && !pageParam.isEmpty()) {
                    page = Integer.parseInt(pageParam);
                }
            } catch (NumberFormatException e) {
                // Xử lý nếu categoryId hoặc page không phải là số
                page = 1;
            }

            List<Course> courseList;
            int totalCourses;

            if (categoryId > 0) {
                courseList = courseDAO.getCoursesByCategory(categoryId, page);
                totalCourses = courseDAO.getTotalCoursesByCategory(categoryId);

                // Tìm tên danh mục đã chọn
                for (Category c : categoryList) {
                    if (c.getId() == categoryId) {
                        page = 1;
                        request.setAttribute("selectedCategory", c);
                        break;
                    }
                }
            } else {
                courseList = courseDAO.getAllCoursesActive(page);
                totalCourses = courseDAO.getTotalCourses();
            }

            int totalPages = (int) Math.ceil((double) totalCourses / PAGE_SIZE);

            request.setAttribute("courseList", courseList);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("currentPage", page);
            request.setAttribute("categoryId", categoryId); // Truyền lại categoryId để giữ trạng thái
            request.getRequestDispatcher("ListCourse.jsp").forward(request, response);
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();
        UserModel user = (UserModel) session.getAttribute("user");

        String action = request.getParameter("action");
        if (user.isStatus() == true && user.getRoleId() == 2) {
            TeacherRequestDAO teacherRequestDAO = new TeacherRequestDAO();
            if (!teacherRequestDAO.isApprovedTeacher(user.getId())) {
                session.setAttribute("message", "Teacher's request has not been accepted!");
                response.sendRedirect("success.jsp"); // Chuyển hướng đến trang success.jsp
                return;
            }
            if ("edit".equals(action)) {
                // Xử lý cập nhật khóa học
                try {
                    int courseId = Integer.parseInt(request.getParameter("courseId"));
                    String title = request.getParameter("title");
                    String thumbnailUrl = request.getParameter("thumbnailUrl");
                    String description = request.getParameter("description");
                    int categoryId = Integer.parseInt(request.getParameter("categoryId"));
                    String status = request.getParameter("status");
                    double price = Double.parseDouble(request.getParameter("price"));

                    CourseDAO dao = new CourseDAO();
                    dao.updateCourse(courseId, title, thumbnailUrl, description, categoryId, status, price);
                    session.setAttribute("message", "Cập nhật khóa học thành công!");
                    response.sendRedirect("success.jsp"); // Chuyển hướng đến trang success.jsp
                    return;

                } catch (NumberFormatException e) {
                    session.setAttribute("message", "Giá hoặc ID danh mục không hợp lệ.");
                    response.sendRedirect("success.jsp");
                    return;
                } catch (Exception e) {
                    session.setAttribute("message", "Cập nhật khóa học không thành công!");
                    response.sendRedirect("success.jsp"); // Chuyển hướng đến trang success.jsp
                    return;
                }
            } else { //add
                // Xử lý thêm khóa học
                // 1. Lấy thông tin cơ bản của course để add course
                String title = request.getParameter("title");
                String thumbnailUrl = request.getParameter("thumbnailUrl");
                String description = request.getParameter("description");
                String categoryIdStr = request.getParameter("categoryId");
                String status = request.getParameter("status");
                String priceStr = request.getParameter("price");

                // Kiểm tra xem các tham số bắt buộc có bị thiếu không
                if (title == null || thumbnailUrl == null || description == null || categoryIdStr == null || status == null || priceStr == null) {
                    session.setAttribute("message", "Vui lòng điền đầy đủ thông tin khóa học.");
                    response.sendRedirect("success.jsp");
                    return; // Dừng xử lý nếu có lỗi
                }

                try {
                    int categoryId = Integer.parseInt(categoryIdStr);
                    double price = Double.parseDouble(priceStr);

                    // 2. Tạo course mới
                    Course course = new Course();
                    course.setTitle(title);
                    course.setThumbnailUrl(thumbnailUrl);
                    course.setDescription(description);
                    course.setCategoryId(categoryId);
                    course.setStatus(status);
                    course.setPrice((int) price);
                    course.setTeacherId(1);

                    CourseDAO courseDAO = new CourseDAO(); // Tạo instance của CourseDAO
                    int courseId = 0;
                    if (courseDAO.isCourseTitleAvailable(title)) {
                        courseId = courseDAO.addCourse(course, user.getId()); // Gọi phương thức addCourse thông qua instance
                        if (courseId > 0) {
                            session.setAttribute("message", "Thêm thành công khóa học");
                            response.sendRedirect("success.jsp");
                        } else {
                            session.setAttribute("message", "Không thể thêm khóa học vào cơ sở dữ liệu.");
                            response.sendRedirect("success.jsp");
                        }
                    } else {
                        session.setAttribute("message", "Đã tồn tại title này.");
                        response.sendRedirect("success.jsp");
                    }

                } catch (NumberFormatException e) {
                    session.setAttribute("message", "Giá khóa học không hợp lệ.");
                    response.sendRedirect("success.jsp");
                } catch (Exception e) {
                    session.setAttribute("message", "Đã xảy ra lỗi: " + e.getMessage());
                    response.sendRedirect("success.jsp");
                }
            }
        } else {
            session.setAttribute("message", "tài khoản chưa được kích hoạt");
            response.sendRedirect("success.jsp");
        }

    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
