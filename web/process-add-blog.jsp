<%-- 
    Document   : process-add-blog.jsp
    Created on : Apr 23, 2025, 3:11:21 AM
    Author     : ACER
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="vn.edu.fpt.model.Blog, vn.edu.fpt.dao.BlogDAO, vn.edu.fpt.dao.DBContext, java.io.File"%>
<%@page import="java.nio.file.Paths, java.nio.file.Files"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>

<%
    // Kiểm tra đăng nhập
    if (session.getAttribute("user") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    // Xử lý upload ảnh
    String uploadPath = getServletContext().getRealPath("") + File.separator + "uploads";
    File uploadDir = new File(uploadPath);
    if (!uploadDir.exists()) uploadDir.mkdir();

    String thumbnailUrl = null;
    Part filePart = request.getPart("thumbnail");
    if (filePart != null && filePart.getSize() > 0) {
        String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
        String fileExtension = fileName.substring(fileName.lastIndexOf("."));
        String newFileName = "thumbnail_" + System.currentTimeMillis() + fileExtension;
        String filePath = uploadPath + File.separator + newFileName;
        filePart.write(filePath);
        thumbnailUrl = "uploads/" + newFileName;
    }

    // Tạo đối tượng Blog
    Blog blog = new Blog();
    blog.setTitle(request.getParameter("title"));
    blog.setContent(request.getParameter("content"));
    blog.setAuthorId(Integer.parseInt(request.getParameter("authorId")));
    blog.setShortDescription(request.getParameter("shortDescription"));
    blog.setThumbnailUrl(thumbnailUrl);

    // Thêm vào database
    DBContext dbContext = new DBContext();
    BlogDAO blogDAO = new BlogDAO(dbContext.getConnection());
    boolean success = blogDAO.addBlog(blog);
    dbContext.closeConnection();

    if (success) {
        response.sendRedirect("blogs.jsp?success=true");
    } else {
        response.sendRedirect("add-blog.jsp?error=true");
    }
%>