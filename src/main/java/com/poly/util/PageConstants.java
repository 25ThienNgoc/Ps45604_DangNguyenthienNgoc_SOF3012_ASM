package com.poly.util;

public class PageConstants {
    // Tên các trang JSP (Views)
    public static final String VIEW_LAYOUT_MENU = "/views/layout/menu.jsp";
    public static final String VIEW_VIDEO_DETAIL = "/views/user/video-detail.jsp"; // <-- MỚI
    public static final String VIEW_USER_SHARE = "/views/user/video-share.jsp"; // <-- MỚI
    public static final String VIEW_USER_FAVORITES = "/views/user/favorite.jsp"; // <-- MỚI
    public static final String VIEW_ACCOUNT_LOGIN = "/views/account/login.jsp"; // <-- MỚI
    public static final String VIEW_ACCOUNT_REGISTRATION = "/views/account/registration.jsp"; // <-- MỚI
    public static final String VIEW_ACCOUNT_FORGOT_PASSWORD = "/views/account/forgot-password.jsp"; // <-- MỚI
    public static final String VIEW_ACCOUNT_CHANGE_PASSWORD = "/views/account/change-password.jsp"; // <-- MỚI
    public static final String VIEW_ACCOUNT_EDIT_PROFILE = "/views/account/edit-profile.jsp"; // <-- MỚI    
    
    // Tên các Servlet (URLs)
    public static final String URL_HOME = "/home";
    public static final String URL_FAVORITES = "/favorites";
    public static final String URL_UNLIKE = "/unlike"; // <-- MỚI
    public static final String URL_LOGIN = "/login";
    public static final String URL_FORGOT_PASSWORD = "/forgot-password";
    public static final String URL_REGISTRATION = "/registration";
    public static final String URL_LOGOFF = "/logoff";
    public static final String URL_CHANGE_PASSWORD = "/change-password";
    public static final String URL_EDIT_PROFILE = "/edit-profile";
    public static final String URL_VIDEO_DETAIL = "/detail";
    public static final String URL_SHARE = "/share"; 
    
 // VIEWs cho Admin
    public static final String VIEW_ADMIN_MENU = "/views/admin/admin-menu.jsp"; // <-- MỚI
    public static final String VIEW_ADMIN_HOME = "/views/admin/admin-home.jsp"; 
    public static final String VIEW_ADMIN_VIDEOS = "/views/admin/video-management.jsp"; 
    public static final String VIEW_ADMIN_USERS = "/views/admin/user-management.jsp"; 
    public static final String VIEW_ADMIN_REPORTS = "/views/admin/reports.jsp"; 

    // Tên các Servlet (URLs)
    public static final String URL_ADMIN_HOME = "/admin/home"; // <-- MỚI
    public static final String URL_ADMIN_VIDEOS = "/admin/videos"; // <-- MỚI
    public static final String URL_ADMIN_USERS = "/admin/users"; // <-- MỚI
    public static final String URL_ADMIN_REPORTS = "/admin/reports"; // <-- MỚI
    
}