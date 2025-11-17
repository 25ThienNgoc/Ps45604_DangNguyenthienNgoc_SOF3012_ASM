<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" import="com.poly.util.PageConstants"%> <%@ taglib
uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>Trang Chủ Admin</title>
  </head>
  <body>
    <%-- 1. Nhúng Menu Admin --%>
    <jsp:include page="<%= PageConstants.VIEW_ADMIN_MENU %>" />

    <div class="container admin-content">
      <h2>ADMINISTRATION DASHBOARD</h2>
      <div class="alert-success" style="padding: 20px; text-align: center">
        <p>
          Chào mừng Admin ${sessionScope.user.id}! Bạn có thể bắt đầu quản lý hệ
          thống từ menu trên.
        </p>
      </div>

      <div class="stats-grid">
        <div class="stat-box">
          <h3>Tổng Video</h3>
          <p>${videoCountAdmin == null ? 'N/A' : videoCountAdmin}</p>
          <a
            href="${pageContext.request.contextPath}<%= PageConstants.URL_ADMIN_VIDEOS %>"
            >Quản lý Videos</a
          >
        </div>
        <div class="stat-box">
          <h3>Tổng Người dùng</h3>
          <p>${userCountAdmin == null ? 'N/A' : userCountAdmin}</p>
          <a
            href="${pageContext.request.contextPath}<%= PageConstants.URL_ADMIN_USERS %>"
            >Quản lý Users</a
          >
        </div>
      </div>
    </div>

    <style>
      .stats-grid {
        display: grid;
        grid-template-columns: repeat(2, 1fr);
        gap: 20px;
        margin-top: 30px;
      }
      .stat-box {
        border: 1px solid #ddd;
        padding: 20px;
        text-align: center;
        border-radius: 8px;
        background-color: #f9f9f9;
      }
      .stat-box h3 {
        color: #ff9800;
      }
      .stat-box p {
        font-size: 2em;
        font-weight: bold;
        margin: 5px 0 15px 0;
      }
      .stat-box a {
        color: #007bff;
        text-decoration: none;
      }
    </style>
  </body>
</html>
