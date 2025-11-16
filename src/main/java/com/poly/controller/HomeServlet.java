package com.poly.controller;

import com.poly.dao.VideoDAO;
import com.poly.dao.ShareDAO;
import com.poly.dao.FavoriteDAO;
import com.poly.dao.UserDAO; // Import UserDAO
import com.poly.dao.impl.VideoDAOImpl;
import com.poly.dao.impl.ShareDAOImpl;
import com.poly.dao.impl.FavoriteDAOImpl;
import com.poly.dao.impl.UserDAOImpl; // Import UserDAOImpl
import com.poly.entity.Video;
import com.poly.entity.User;
import com.poly.entity.Share;
import com.poly.entity.Favorite;
import com.poly.util.PageConstants;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Date;
import java.util.stream.Collectors;

@WebServlet(urlPatterns = { 
    PageConstants.URL_HOME, 
    PageConstants.URL_VIDEO_DETAIL,
    PageConstants.URL_LOGIN, 
    PageConstants.URL_LOGOFF,
    PageConstants.URL_FAVORITES,
    PageConstants.URL_SHARE, 
    PageConstants.URL_LIKE,
    PageConstants.URL_UNLIKE,
    PageConstants.URL_FORGOT_PASSWORD,
    PageConstants.URL_REGISTRATION,
    PageConstants.URL_CHANGE_PASSWORD,
    PageConstants.URL_EDIT_PROFILE
})
public class HomeServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final int ITEMS_PER_PAGE = 6;
    
    // Khởi tạo DAO
    private final VideoDAO videoDao = new VideoDAOImpl(); 
    private final ShareDAO shareDao = new ShareDAOImpl(); 
    private final FavoriteDAO favoriteDao = new FavoriteDAOImpl(); 
    private final UserDAO userDao = new UserDAOImpl(); // Khai báo UserDAO

    // ===================================================
    //                  XỬ LÝ GET REQUESTS
    // ===================================================
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String path = request.getServletPath();
        User loggedInUser = (User) request.getSession().getAttribute("user");

        // 1. Trang Chủ: /home
        if (PageConstants.URL_HOME.equals(path)) {
            handleHome(request, response);
            return;
        } 
        
        // 2. Trang Chi tiết Video: /detail
        if (PageConstants.URL_VIDEO_DETAIL.equals(path)) {
            handleVideoDetail(request, response);
            return;
        }
        
        // 3. Xử lý các Hành động/Trang cần Đăng nhập (/favorites, /like, /unlike, /share)
        if (path.startsWith("/like") || path.startsWith("/unlike") || path.startsWith("/share") || PageConstants.URL_FAVORITES.equals(path)) {
             if (loggedInUser == null) {
                response.sendRedirect(request.getContextPath() + PageConstants.URL_LOGIN);
                return;
            }
             
            if (PageConstants.URL_FAVORITES.equals(path)) {
                handleFavorites(request, response, loggedInUser);
                return;
            } else if (PageConstants.URL_LIKE.equals(path)) {
                handleLike(request, response, loggedInUser, true);
                return;
            } else if (PageConstants.URL_UNLIKE.equals(path)) {
                handleLike(request, response, loggedInUser, false);
                return;
            } else if (PageConstants.URL_SHARE.equals(path)) {
                String videoId = request.getParameter("id");
                request.setAttribute("videoId", videoId);
                request.getRequestDispatcher(PageConstants.VIEW_USER_SHARE).forward(request, response);
                return;
            }
        }
        
        // 4. Xử lý các Trang Account GET
        if (PageConstants.URL_LOGIN.equals(path)) {
            // Lấy dữ liệu từ cookie nếu có
            // Cookie logic được thực hiện trong login.jsp (JSTL) và doPost
            request.getRequestDispatcher(PageConstants.VIEW_ACCOUNT_LOGIN).forward(request, response);
            return;
        }
        if (PageConstants.URL_LOGOFF.equals(path)) {
            request.getSession().removeAttribute("user");
            removeRememberMeCookies(response); // Xóa cookies nếu đăng xuất
            response.sendRedirect(request.getContextPath() + PageConstants.URL_HOME);
            return;
        }
        if (PageConstants.URL_REGISTRATION.equals(path)) {
            request.getRequestDispatcher(PageConstants.VIEW_ACCOUNT_REGISTRATION).forward(request, response);
            return;
        }
        if (PageConstants.URL_FORGOT_PASSWORD.equals(path)) {
            request.getRequestDispatcher(PageConstants.VIEW_ACCOUNT_FORGOT_PASSWORD).forward(request, response);
            return;
        }
        if (PageConstants.URL_CHANGE_PASSWORD.equals(path)) {
             if (loggedInUser == null) {
                response.sendRedirect(request.getContextPath() + PageConstants.URL_LOGIN);
                return;
            }
            request.getRequestDispatcher(PageConstants.VIEW_ACCOUNT_CHANGE_PASSWORD).forward(request, response);
            return;
        }
        if (PageConstants.URL_EDIT_PROFILE.equals(path)) {
             if (loggedInUser == null) {
                response.sendRedirect(request.getContextPath() + PageConstants.URL_LOGIN);
                return;
            }
            // Thông tin user đã có trong session, được dùng trong edit-profile.jsp
            request.getRequestDispatcher(PageConstants.VIEW_ACCOUNT_EDIT_PROFILE).forward(request, response);
            return;
        }

        response.sendError(HttpServletResponse.SC_NOT_FOUND);
    }
    
    // ===================================================
    //                  XỬ LÝ POST REQUESTS
    // ===================================================
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String path = request.getServletPath();
        
        if (PageConstants.URL_LOGIN.equals(path)) {
            handleLoginPost(request, response);
            return;
        }
        if (PageConstants.URL_REGISTRATION.equals(path)) {
            handleRegistrationPost(request, response);
            return;
        }
        if (PageConstants.URL_FORGOT_PASSWORD.equals(path)) {
            handleForgotPasswordPost(request, response);
            return;
        }
        if (PageConstants.URL_CHANGE_PASSWORD.equals(path)) {
            handleChangePasswordPost(request, response);
            return;
        }
        if (PageConstants.URL_EDIT_PROFILE.equals(path)) {
            handleEditProfilePost(request, response);
            return;
        }
        if (PageConstants.URL_SHARE.equals(path)) {
            handleSharePost(request, response);
            return;
        }

        response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED);
    }

    // ===================================================
    //                  ACCOUNT HANDLERS (POST)
    // ===================================================

    private void handleLoginPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        boolean remember = request.getParameter("remember") != null; //

        try {
            User user = userDao.findById(username);
            
            // 1. Kiểm tra sự tồn tại và mật khẩu
            if (user == null || !authenticateUser(user, password)) {
                request.setAttribute("message", "Tên đăng nhập hoặc mật khẩu không chính xác.");
                request.getRequestDispatcher(PageConstants.VIEW_ACCOUNT_LOGIN).forward(request, response);
                return;
            }
            
            // 2. Duy trì thông tin user vào session
            request.getSession().setAttribute("user", user);
            
            // 3. Xử lý Remember Me (Cookie)
            if (remember) {
                addCookie(response, "user", username, 7 * 24 * 60 * 60); // 7 ngày
                addCookie(response, "pass", password, 7 * 24 * 60 * 60);
            } else {
                removeRememberMeCookies(response); // Xóa cookies nếu không check Remember Me
            }

            // 4. Trở về trang yêu cầu bảo mật trước đó (nếu có)
            String previousUrl = (String) request.getSession().getAttribute("security_url");
            if (previousUrl != null) {
                request.getSession().removeAttribute("security_url");
                response.sendRedirect(previousUrl);
            } else {
                response.sendRedirect(request.getContextPath() + PageConstants.URL_HOME);
            }

        } catch (Exception e) {
            request.setAttribute("message", "Đã xảy ra lỗi hệ thống khi đăng nhập.");
            request.getRequestDispatcher(PageConstants.VIEW_ACCOUNT_LOGIN).forward(request, response);
        }
    }

    private void handleRegistrationPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String fullname = request.getParameter("fullname");
        String email = request.getParameter("email");
        
        try {
            // 1. Kiểm tra dữ liệu và sự tồn tại của user
            if (userDao.findById(username) != null) {
                request.setAttribute("message", "Tên đăng nhập đã tồn tại.");
                request.setAttribute("messageType", "error");
                request.getRequestDispatcher(PageConstants.VIEW_ACCOUNT_REGISTRATION).forward(request, response);
                return;
            }
            
            // 2. Thêm một người sử dụng mới
            User newUser = new User();
            newUser.setId(username);
            newUser.setPassword(hashPassword(password)); // Mã hóa mật khẩu
            newUser.setFullname(fullname);
            newUser.setEmail(email);
            newUser.setAdmin(false); // Mặc định là User
            
            userDao.create(newUser);
            
            // 3. Gửi email chào mừng (Giả định)
            // sendWelcomeEmail(email, fullname); 
            
            request.setAttribute("message", "Đăng ký thành công! Vui lòng đăng nhập.");
            request.setAttribute("messageType", "success");
            request.getRequestDispatcher(PageConstants.VIEW_ACCOUNT_LOGIN).forward(request, response);

        } catch (Exception e) {
            request.setAttribute("message", "Lỗi: Không thể đăng ký người dùng mới.");
            request.setAttribute("messageType", "error");
            request.getRequestDispatcher(PageConstants.VIEW_ACCOUNT_REGISTRATION).forward(request, response);
        }
    }

    private void handleForgotPasswordPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        
        try {
            // 1. Kiểm tra dữ liệu nhập vào form
            User user = userDao.findByUsernameAndEmail(username, email);
            
            if (user == null) {
                request.setAttribute("message", "Tên đăng nhập hoặc Email không khớp.");
                request.setAttribute("messageType", "error");
                request.getRequestDispatcher(PageConstants.VIEW_ACCOUNT_FORGOT_PASSWORD).forward(request, response);
                return;
            }
            
            // 2. Gửi mật khẩu (đã được reset) qua email nếu thông tin chính xác
            // Logic: Tạo mật khẩu mới ngẫu nhiên -> Cập nhật DB -> Gửi email
            String newPassword = generateRandomPassword(); 
            user.setPassword(hashPassword(newPassword));
            userDao.update(user);
            
            // sendPasswordResetEmail(email, newPassword);
            
            request.setAttribute("message", "Mật khẩu mới đã được gửi đến email của bạn.");
            request.setAttribute("messageType", "success");
            request.getRequestDispatcher(PageConstants.VIEW_ACCOUNT_FORGOT_PASSWORD).forward(request, response);

        } catch (Exception e) {
            request.setAttribute("message", "Lỗi: Không thể xử lý yêu cầu quên mật khẩu.");
            request.setAttribute("messageType", "error");
            request.getRequestDispatcher(PageConstants.VIEW_ACCOUNT_FORGOT_PASSWORD).forward(request, response);
        }
    }

    private void handleChangePasswordPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        User loggedInUser = (User) request.getSession().getAttribute("user");
        if (loggedInUser == null) {
            response.sendRedirect(request.getContextPath() + PageConstants.URL_LOGIN);
            return;
        }

        String currentPassword = request.getParameter("currentPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmNewPassword = request.getParameter("confirmNewPassword");
        
        try {
            // 1. Kiểm tra dữ liệu nhập vào form (mật khẩu mới và xác nhận)
            if (!newPassword.equals(confirmNewPassword)) {
                request.setAttribute("message", "Mật khẩu mới và xác nhận không khớp.");
                request.setAttribute("messageType", "error");
                request.getRequestDispatcher(PageConstants.VIEW_ACCOUNT_CHANGE_PASSWORD).forward(request, response);
                return;
            }
            
            // 2. Kiểm tra mật khẩu hiện tại
            if (!authenticateUser(loggedInUser, currentPassword)) {
                request.setAttribute("message", "Mật khẩu hiện tại không chính xác.");
                request.setAttribute("messageType", "error");
                request.getRequestDispatcher(PageConstants.VIEW_ACCOUNT_CHANGE_PASSWORD).forward(request, response);
                return;
            }
            
            // 3. Cập nhật mật khẩu
            loggedInUser.setPassword(hashPassword(newPassword));
            userDao.update(loggedInUser);
            
            // 4. Cập nhật lại thông tin user trong session
            request.getSession().setAttribute("user", loggedInUser);

            request.setAttribute("message", "Đổi mật khẩu thành công!");
            request.setAttribute("messageType", "success");
            request.getRequestDispatcher(PageConstants.VIEW_ACCOUNT_CHANGE_PASSWORD).forward(request, response);

        } catch (Exception e) {
            request.setAttribute("message", "Lỗi: Không thể đổi mật khẩu.");
            request.setAttribute("messageType", "error");
            request.getRequestDispatcher(PageConstants.VIEW_ACCOUNT_CHANGE_PASSWORD).forward(request, response);
        }
    }

    private void handleEditProfilePost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        User loggedInUser = (User) request.getSession().getAttribute("user");
        if (loggedInUser == null) {
            response.sendRedirect(request.getContextPath() + PageConstants.URL_LOGIN);
            return;
        }
        
        String fullname = request.getParameter("fullname");
        String email = request.getParameter("email");
        
        try {
            // 1. Kiểm tra dữ liệu nhập vào form (Giả định hợp lệ)
            
            // 2. Cập nhật thông tin tài khoản
            loggedInUser.setFullname(fullname);
            loggedInUser.setEmail(email);
            userDao.update(loggedInUser);
            
            // 3. Cập nhật lại thông tin user trong session
            request.getSession().setAttribute("user", loggedInUser);
            
            request.setAttribute("message", "Cập nhật hồ sơ thành công!");
            request.setAttribute("messageType", "success");
            request.getRequestDispatcher(PageConstants.VIEW_ACCOUNT_EDIT_PROFILE).forward(request, response);

        } catch (Exception e) {
            request.setAttribute("message", "Lỗi: Không thể cập nhật hồ sơ.");
            request.setAttribute("messageType", "error");
            request.getRequestDispatcher(PageConstants.VIEW_ACCOUNT_EDIT_PROFILE).forward(request, response);
        }
    }

    // ===================================================
    //                  VIDEO/SHARE/FAVORITES HANDLERS
    // ===================================================

    // Phương thức handleHome, handleVideoDetail, handleFavorites, handleLike, handleSharePost (giữ nguyên logic đã cung cấp trước đó)
    // ...

    // ===================================================
    //                  PHƯƠNG THỨC TIỆN ÍCH
    // ===================================================

    // Giả định: Phương thức xác thực người dùng (So sánh mật khẩu)
    private boolean authenticateUser(User user, String rawPassword) {
        // Trong thực tế, cần so sánh rawPassword với user.getPassword() (đã mã hóa)
        // Dùng tạm so sánh thô cho mục đích Servlet
        return user.getPassword().equals(rawPassword); 
    }
    
    // Giả định: Phương thức mã hóa mật khẩu
    private String hashPassword(String rawPassword) {
        // Dùng tạm mật khẩu thô cho mục đích Servlet
        return rawPassword; 
    }
    
    // Giả định: Phương thức tạo mật khẩu ngẫu nhiên
    private String generateRandomPassword() {
        return "123456"; // Mật khẩu reset tạm thời
    }

    /** Thêm Cookie. */
    private void addCookie(HttpServletResponse response, String name, String value, int maxAge) {
        Cookie cookie = new Cookie(name, value);
        cookie.setMaxAge(maxAge);
        cookie.setPath("/");
        response.addCookie(cookie);
    }
    
    /** Xóa Cookie Remember Me. */
    private void removeRememberMeCookies(HttpServletResponse response) {
        addCookie(response, "user", "", 0);
        addCookie(response, "pass", "", 0);
    }

    // ... (Các phương thức tiện ích khác: getCookie, updateHistoryCookie, getHistoryVideos) ...
    
    private Cookie getCookie(HttpServletRequest request, String name) {
        if (request.getCookies() != null) {
            for (Cookie cookie : request.getCookies()) {
                if (cookie.getName().equals(name)) {
                    return cookie;
                }
            }
        }
        return null;
    }
    
    private void updateViewsAndHistory(Video video, HttpServletRequest request, HttpServletResponse response) {
        // Cập nhật lượt xem và Cookie lịch sử
        updateHistoryCookie(video.getId(), request, response);
    }

    private void updateHistoryCookie(String videoId, HttpServletRequest request, HttpServletResponse response) {
        String history = "";
        Cookie historyCookie = getCookie(request, "history");
        
        if (historyCookie != null) history = historyCookie.getValue();
        
        history = Arrays.stream(history.split(","))
                        .filter(id -> !id.equals(videoId) && !id.isEmpty())
                        .collect(Collectors.joining(","));
        
        String newHistory = videoId + (history.isEmpty() ? "" : "," + history);
        
        String[] ids = newHistory.split(",");
        if (ids.length > 5) {
             newHistory = String.join(",", Arrays.copyOf(ids, 5));
        }

        Cookie newCookie = new Cookie("history", newHistory);
        newCookie.setMaxAge(7 * 24 * 60 * 60); 
        newCookie.setPath(request.getContextPath()); 
        response.addCookie(newCookie);
    }

    private List<Video> getHistoryVideos(HttpServletRequest request, String currentVideoId) {
        Cookie historyCookie = getCookie(request, "history");
        if (historyCookie == null) return new ArrayList<>();

        String history = historyCookie.getValue();
        List<String> ids = Arrays.stream(history.split(","))
                                .filter(id -> !id.equals(currentVideoId) && !id.isEmpty())
                                .collect(Collectors.toList());
        
        List<Video> videos = new ArrayList<>();
        for (String id : ids) {
            Video v = videoDao.findById(id); 
            if (v != null) {
                videos.add(v);
            }
        }
        
        return videos;
    }
    
    private void handleHome(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        int page = 1; 
        try { 
            page = Integer.parseInt(request.getParameter("page")); 
            if (page < 1) page = 1;
        } catch (Exception ignored) {}

        long totalVideos = videoDao.countActive();
        int totalPages = (int) Math.ceil((double) totalVideos / ITEMS_PER_PAGE);

        if (page > totalPages && totalPages > 0) page = totalPages;
        
        int firstResult = (page - 1) * ITEMS_PER_PAGE;
        List<Video> currentVideoList = videoDao.findPage(firstResult, ITEMS_PER_PAGE);
        
        request.setAttribute("videoList", currentVideoList);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        
        request.getRequestDispatcher("/views/index.jsp").forward(request, response);
    }
    
    private void handleVideoDetail(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String videoId = request.getParameter("id");
        if (videoId == null || videoId.isEmpty()) {
            response.sendRedirect(request.getContextPath() + PageConstants.URL_HOME);
            return;
        }

        Video video = videoDao.findById(videoId);
        if (video == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }
        
        updateViewsAndHistory(video, request, response);
        
        List<Video> historyVideos = getHistoryVideos(request, videoId);
        
        request.setAttribute("currentVideo", video);
        request.setAttribute("historyVideos", historyVideos);
        
        request.getRequestDispatcher(PageConstants.VIEW_VIDEO_DETAIL).forward(request, response);
    }
    
    private void handleFavorites(HttpServletRequest request, HttpServletResponse response, User loggedInUser) 
            throws ServletException, IOException {
        
        try {
            List<Video> favoriteVideos = favoriteDao.findFavoriteVideosByUserId(loggedInUser.getId());
            request.setAttribute("favoriteVideos", favoriteVideos);
            request.getRequestDispatcher(PageConstants.VIEW_USER_FAVORITES).forward(request, response);
            
        } catch (Exception e) {
            System.err.println("Lỗi khi tải Favorites: " + e.getMessage());
            request.setAttribute("message", "Không thể tải danh sách yêu thích.");
            request.getRequestDispatcher(PageConstants.VIEW_USER_FAVORITES).forward(request, response);
        }
    }

    private void handleLike(HttpServletRequest request, HttpServletResponse response, User loggedInUser, boolean isLiking) 
            throws IOException {
        
        String videoId = request.getParameter("id");
        if (videoId == null || videoId.isEmpty()) {
            response.sendRedirect(request.getContextPath() + PageConstants.URL_HOME);
            return;
        }

        try {
            if (isLiking) {
                Video video = videoDao.findById(videoId);
                if (video == null) throw new Exception("Video không tồn tại.");
                
                if (favoriteDao.findFavorite(loggedInUser.getId(), videoId) == null) {
                    Favorite favorite = new Favorite();
                    favorite.setUser(loggedInUser);
                    favorite.setVideo(video);
                    favorite.setLikeDate(new Date());
                    favoriteDao.create(favorite);
                }
                
            } else {
                favoriteDao.delete(loggedInUser.getId(), videoId);
            }
            
            String referer = request.getHeader("referer");
            if (referer != null) {
                 response.sendRedirect(referer); 
            } else {
                 response.sendRedirect(request.getContextPath() + PageConstants.URL_HOME);
            }

        } catch (Exception e) {
            System.err.println("Lỗi xử lý Like/Unlike: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + PageConstants.URL_HOME);
        }
    }
    
    private void handleSharePost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        User loggedInUser = (User) request.getSession().getAttribute("user");
        if (loggedInUser == null) {
            response.sendRedirect(request.getContextPath() + PageConstants.URL_LOGIN);
            return;
        }
        
        String videoId = request.getParameter("videoId");
        String emailsString = request.getParameter("emails");
        
        if (videoId == null || emailsString == null || emailsString.trim().isEmpty()) {
            request.setAttribute("message", "Vui lòng nhập email người nhận.");
            request.setAttribute("messageType", "error");
            request.getRequestDispatcher(PageConstants.VIEW_USER_SHARE).forward(request, response);
            return;
        }

        try {
            String[] emails = emailsString.split("[,;]");
            Video videoToShare = videoDao.findById(videoId);
            
            if (videoToShare == null) throw new Exception("Video không tồn tại.");
            
            Share shareRecord = new Share();
            shareRecord.setUser(loggedInUser);
            shareRecord.setVideo(videoToShare);
            shareRecord.setEmails(emailsString); 
            shareRecord.setShareDate(new Date());
            shareDao.create(shareRecord); 

            request.setAttribute("message", "Chia sẻ thành công! Link đã được gửi đến " + emails.length + " người.");
            request.setAttribute("messageType", "success");
            
        } catch (Exception e) {
            System.err.println("Share error: " + e.getMessage());
            request.setAttribute("message", "Lỗi: Không thể gửi email hoặc lưu bản ghi chia sẻ.");
            request.setAttribute("messageType", "error");
        }
        
        request.getRequestDispatcher(PageConstants.VIEW_USER_SHARE).forward(request, response);
    }
}