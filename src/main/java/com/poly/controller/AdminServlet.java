package com.poly.controller;

import com.poly.dao.UserDAO;
import com.poly.dao.VideoDAO;
import com.poly.dao.ReportDAO;
import com.poly.dao.impl.UserDAOImpl;
import com.poly.dao.impl.VideoDAOImpl;
import com.poly.dao.impl.ReportDAOImpl;
import com.poly.dto.VideoFavoriteReport;
import com.poly.entity.User;
import com.poly.entity.Video;
import com.poly.entity.Share;
import com.poly.util.PageConstants;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

// Map tất cả các URL bắt đầu bằng /admin/*
@WebServlet(urlPatterns = "/admin/*")
public class AdminServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final UserDAO userDao = new UserDAOImpl();
    private final VideoDAO videoDao = new VideoDAOImpl();
    private final ReportDAO reportDao = new ReportDAOImpl(); // Sử dụng cho báo cáo

    private static final int ITEMS_PER_PAGE = 10; // Giả định phân trang 10 mục

    /**
     * Phương thức bảo mật chung: Kiểm tra trạng thái đăng nhập và vai trò Admin.
     * Áp dụng cho MỌI request đến /admin/*.
     * 
     * TODO: Uncomment phần kiểm tra user khi triển khai bảo mật.
     * Hiện tại disable để cho phép test giao diện admin mà không cần login.
     */
    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // DISABLE kiểm tra user để test giao diện - COMMENT OUT khi production
        /*
         * // 1. Kiểm tra trạng thái Đăng nhập
         * User loggedInUser = (User) request.getSession().getAttribute("user");
         * if (loggedInUser == null) {
         * // Lưu URL Admin đang cố truy cập (tùy chọn) và chuyển hướng đến Login
         * response.sendRedirect(request.getContextPath() + PageConstants.URL_LOGIN);
         * return;
         * }
         * 
         * // 2. Kiểm tra vai trò Admin
         * if (!loggedInUser.isAdmin()) {
         * // Nếu không phải Admin, từ chối truy cập
         * response.sendError(HttpServletResponse.SC_FORBIDDEN,
         * "Bạn không có quyền truy cập trang Quản trị.");
         * return;
         * }
         */

        // 3. Nếu đã đăng nhập và là Admin, tiếp tục xử lý GET/POST
        super.service(request, response);
    }

    // ===================================================
    // XỬ LÝ GET REQUESTS (Điều hướng trang)
    // ===================================================
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Lấy đường dẫn phụ sau /admin
        String path = request.getPathInfo();

        if (path == null) {
            path = "/home"; // Mặc định
        }

        switch (path) {
            case "/home":
                // Trang chủ Admin (Dashboard)
                handleHome(request, response);
                break;

            case "/videos":
                // Trang quản lý tiểu phẩm
                handleVideos(request, response);
                break;

            case "/users":
                // Trang quản lý người sử dụng
                handleUsers(request, response);
                break;

            case "/reports":
                // Trang báo cáo, thống kê
                handleReports(request, response);
                break;

            default:
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
                break;
        }
    }

    // ===================================================
    // XỬ LÝ POST REQUESTS (Cho các form Admin)
    // ===================================================
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String path = request.getPathInfo();

        if (path == null)
            path = "/home";

        // Đây là nơi bạn sẽ gọi các phương thức xử lý POST cho CRUD
        switch (path) {
            case "/videos":
                // Xử lý Create/Update/Delete Video
                // handleVideoPost(request, response);
                response.getWriter().println("Xử lý POST cho Videos...");
                break;
            case "/users":
                // Xử lý Update/Delete User
                // handleUserPost(request, response);
                response.getWriter().println("Xử lý POST cho Users...");
                break;
            default:
                response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED);
                break;
        }
    }

    // ===================================================
    // ADMIN HANDLERS
    // ===================================================

    private void handleHome(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Lấy thống kê cơ bản cho Dashboard
        long videoCountAdmin = videoDao.countAll();
        long userCountAdmin = userDao.findAll().size(); // Hoặc dùng count nếu có trong DAO

        request.setAttribute("videoCountAdmin", videoCountAdmin);
        request.setAttribute("userCountAdmin", userCountAdmin);

        request.getRequestDispatcher(PageConstants.VIEW_ADMIN_HOME).forward(request, response);
    }

    private void handleVideos(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Giả định logic phân trang/CRUD được xử lý ở đây.
        // Hiện tại chỉ tải tất cả hoặc một trang đầu tiên cho giao diện.

        List<Video> videos = videoDao.findAll(); // Lấy tất cả video
        long totalVideos = videos.size();

        request.setAttribute("videos", videos);
        request.setAttribute("videoCount", totalVideos);

        // TODO: Thêm logic tìm kiếm Video theo ID nếu có param "action=edit"

        request.getRequestDispatcher(PageConstants.VIEW_ADMIN_VIDEOS).forward(request, response);
    }

    private void handleUsers(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Giả định logic phân trang/CRUD được xử lý ở đây.

        List<User> users = userDao.findAll(); // Lấy tất cả người dùng
        long totalUsers = users.size();

        request.setAttribute("users", users);
        request.setAttribute("userCount", totalUsers);

        // TODO: Thêm logic tìm kiếm User theo ID nếu có param "action=edit"

        request.getRequestDispatcher(PageConstants.VIEW_ADMIN_USERS).forward(request, response);
    }

    private void handleReports(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1. Tải dữ liệu cho Tab FAVORITES (4.4.1)
        List<VideoFavoriteReport> reportFavorites = reportDao.reportVideoFavorites();
        request.setAttribute("reportFavorites", reportFavorites);

        // 2. Tải dữ liệu cho Select Box Filter (4.4.3)
        List<String> sharedVideoIds = reportDao.findSharedVideoIds();

        // Chuyển từ List ID sang List<Video> để hiển thị tiêu đề trong Select Box
        List<Video> sharedVideos = new ArrayList<>();
        for (String id : sharedVideoIds) {
            Video v = videoDao.findById(id);
            if (v != null)
                sharedVideos.add(v);
        }
        request.setAttribute("sharedVideos", sharedVideos);

        // 3. Xử lý Lọc theo Video ID (Tab SHARED FRIENDS)
        String selectedVideoId = request.getParameter("videoId");
        List<Share> reportShares = new ArrayList<>();

        if (selectedVideoId != null && !selectedVideoId.isEmpty()) {
            reportShares = reportDao.findSharedUsersByVideoId(selectedVideoId);
        } else if (!sharedVideos.isEmpty()) {
            // Mặc định hiển thị video đầu tiên nếu chưa chọn và có dữ liệu
            reportShares = reportDao.findSharedUsersByVideoId(sharedVideos.get(0).getId());
            selectedVideoId = sharedVideos.get(0).getId();
        }

        request.setAttribute("reportShares", reportShares);

        request.getRequestDispatcher(PageConstants.VIEW_ADMIN_REPORTS).forward(request, response);
    }
}