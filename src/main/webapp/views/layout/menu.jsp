<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" import="com.poly.util.PageConstants" %> <%@ taglib
uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> <%-- Lấy đường dẫn gốc của
ứng dụng và các URL --%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<header class="main-header">
  <nav class="navbar-user">
    <%-- 1. Logo/Trang Chủ (ONLINE ENTERTAINMENT) --%>
    <div class="navbar-brand-user">
      <%-- Liên kết đến index (dùng PageConstants để đảm bảo URL chính xác) --%>
      <a href="${pageContext.request.contextPath}/home" class="logo-user"
        >ONLINE ENTERTAINMENT</a
      >
    </div>

    <%-- 2. Các mục điều hướng --%>
    <ul class="nav-links-user">
      <%-- My Favorites --%>
      <li>
        <a href="${pageContext.request.contextPath}/views/user/favorite.jsp"
          >MY FAVORITES</a
        >
      </li>

      <%-- My Account (Dropdown) --%>
      <li class="dropdown">
        <a href="#" class="dropbtn">MY ACCOUNT</a>
        <div class="dropdown-content">
          <%-- 1. Login --%>
          <a href="${pageContext.request.contextPath}/views/account/login.jsp"
            >Login</a
          >

          <%-- 2. Registration --%>
          <a
            href="${pageContext.request.contextPath}/views/account/registration.jsp"
            >Registration</a
          >

          <%-- 3. Forgot Password --%>
          <a
            href="${pageContext.request.contextPath}/views/account/forgot-password.jsp"
            >Forgot Password</a
          >

          <%-- 4. Change Password --%>
          <a
            href="${pageContext.request.contextPath}/views/account/change-password.jsp"
            >Change Password</a
          >

          <%-- 5. Edit Profile --%>
          <a
            href="${pageContext.request.contextPath}/views/account/edit-profile.jsp"
            >Edit Profile</a
          >
        </div>
      </li>
    </ul>
  </nav>
</header>

<style>
  /* CSS để tạo layout y hệt ảnh */

  /* Reset và Header chính */
  .main-header {
    background: linear-gradient(
      to bottom,
      #ffc107 0%,
      #ff9800 100%
    ); /* Tạo hiệu ứng gradient vàng/cam */
    padding: 10px 0;
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
  }

  .navbar-user {
    display: flex;
    justify-content: space-between;
    align-items: center;
    max-width: 1200px;
    margin: 0 auto;
    padding: 0 20px;
  }

  /* Logo */
  .navbar-brand-user .logo-user {
    color: #333; /* Chữ đen đậm */
    font-size: 1.8em;
    font-weight: 900;
    text-decoration: none;
    letter-spacing: 0.5px;
    text-shadow: 1px 1px 0 rgba(255, 255, 255, 0.4);
  }

  /* Danh sách liên kết */
  .nav-links-user {
    list-style: none;
    display: flex;
    gap: 0; /* Không cần gap, dùng padding */
    padding: 0;
    margin: 0;
    align-items: center;
  }

  .nav-links-user > li {
    padding: 0 10px;
  }

  .nav-links-user > li > a {
    color: #333;
    text-decoration: none;
    padding: 10px 15px;
    font-weight: 900; /* Dùng đậm để giống layout */
    transition: background-color 0.3s;
  }

  .nav-links-user > li > a:hover {
    color: white;
    background-color: rgba(0, 0, 0, 0.2);
  }

  /* Dropdown Container */
  .dropdown {
    position: relative;
    display: inline-block;
  }

  /* Dropdown Button (My Account) */
  .dropbtn {
    background-color: transparent;
    color: #333 !important;
    padding: 10px 15px;
    font-size: 1em;
    border: none;
    cursor: pointer;
    text-decoration: none;
    font-weight: 900 !important;
  }

  /* Dropdown Content (Menu thả xuống) */
  .dropdown-content {
    display: none;
    position: absolute;
    right: 0;
    background-color: white;
    min-width: 200px;
    box-shadow: 0px 8px 16px 0px rgba(0, 0, 0, 0.2);
    z-index: 100;
    border: 1px solid #ddd;
    border-top: 2px solid #ff9800; /* Viền trên màu cam */
  }

  .dropdown-content a {
    color: #333;
    padding: 10px 15px;
    text-decoration: none;
    display: block;
    font-weight: normal;
    transition: background-color 0.1s;
    /* Tạo đường viền đỏ mờ giữa các mục menu theo mẫu */
    border-bottom: 1px solid #ffdddd;
  }
  .dropdown-content a:last-child {
    border-bottom: none;
  }

  .dropdown-content a:hover {
    background-color: #f1f1f1;
    color: #ff9800; /* Hover màu cam */
  }

  /* Hiển thị dropdown khi hover */
  .dropdown:hover .dropdown-content {
    display: block;
  }
</style>
