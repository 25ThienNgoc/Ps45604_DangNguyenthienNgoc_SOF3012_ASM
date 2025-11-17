<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib uri="http://java.sun.com/jsp/jstl/core"
prefix="c" %>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>Online Entertainment - Trang Chủ</title>
  </head>
  <body>
    <%-- 1. Nhúng Menu (đã tạo ở bước trước) --%>
    <jsp:include page="<%= com.poly.util.PageConstants.VIEW_LAYOUT_MENU %>" />

    <%-- 2. Nội dung chính: Danh sách Video --%>
    <div class="container" style="padding: 20px">
      <h2>Khám Phá Video Mới Nhất</h2>

      <%-- Lưới Video (3x2) --%>
      <div class="video-grid">
        <%-- Giả định có một danh sách video (videoList) từ Servlet được đặt
        trong request scope --%>
        <c:forEach var="video" items="${videoList}" varStatus="loop">
          <div class="video-item">
            <a
              href="${pageContext.request.contextPath}/views/user/video-detail.jsp?id=${video.id}"
            >
              <div class="poster-box">
                <img
                  src="${video.posterUrl}"
                  alt="${video.title}"
                  class="poster-image"
                />
                <div class="poster-text">POSTER</div>
              </div>
            </a>
            <p class="video-title">${video.title}</p>
            <div class="action-buttons">
              <%-- Logic [Like].Click: Ghi nhận yêu thích của người dùng. Cần
              Login. --%>
              <a
                href="${pageContext.request.contextPath}/views/user/favorite.jsp?id=${video.id}"
                class="btn btn-like"
                >Like</a
              >
              <%-- Logic [Share].Click: Trang chia sẻ. Cần Login. --%>
              <a
                href="${pageContext.request.contextPath}/views/user/video-share.jsp?id=${video.id}"
                class="btn btn-share"
                >Share</a
              >
            </div>
          </div>
        </c:forEach>

        <%-- Điền vào 6 ô nếu danh sách videoList chưa đủ 6 item --%>
        <c:set var="totalItems" value="${videoList.size()}" />
        <c:forEach begin="${totalItems}" end="5" step="1">
          <div class="video-item placeholder">
            <div class="poster-box"><div class="poster-text">POSTER</div></div>
            <p class="video-title">VIDEO TITLE</p>
            <div class="action-buttons">
              <span class="btn btn-like">Like</span>
              <span class="btn btn-share">Share</span>
            </div>
          </div>
        </c:forEach>
      </div>

      <%-- Thanh Phân Trang --%>
      <div class="pagination-controls">
        <%-- Giả định các biến page, totalPages, maxItemsPerPage được đặt trong
        request scope --%>
        <c:set
          var="currentPage"
          value="${param.page != null ? param.page : 1}"
        />

        <%-- [|<] Trang đầu --%>
        <a
          href="/home?page=1"
          class="page-link ${currentPage == 1 ? 'disabled' : ''}"
          >|&lt;</a
        >

        <%-- [<<] Trang trước --%>
        <c:set
          var="prevPage"
          value="${currentPage - 1 > 0 ? currentPage - 1 : 1}"
        />
        <a
          href="/home?page=${prevPage}"
          class="page-link ${currentPage == 1 ? 'disabled' : ''}"
          >&lt;&lt;</a
        >

        <%-- [>>] Trang sau --%>
        <c:set
          var="nextPage"
          value="${currentPage + 1 <= totalPages ? currentPage + 1 : totalPages}"
        />
        <a
          href="/home?page=${nextPage}"
          class="page-link ${currentPage == totalPages ? 'disabled' : ''}"
          >&gt;&gt;</a
        >

        <%-- [>|] Trang cuối --%>
        <a
          href="/home?page=${totalPages}"
          class="page-link ${currentPage == totalPages ? 'disabled' : ''}"
          >&gt;|</a
        >
      </div>
    </div>

    <style>
      /* CSS cho lưới video và phân trang */
      .container {
        max-width: 1000px;
        margin: 0 auto;
        text-align: center;
      }
      .video-grid {
        display: grid;
        grid-template-columns: repeat(3, 1fr);
        gap: 20px;
        margin-bottom: 30px;
      }
      .video-item {
        border: 1px solid #ddd;
        padding: 10px;
        border-radius: 5px;
      }
      .poster-box {
        background-color: #ffc107; /* Màu cam vàng */
        height: 150px;
        display: flex;
        justify-content: center;
        align-items: center;
        margin-bottom: 10px;
        border: 3px solid #f87d0f;
      }
      .poster-text {
        font-weight: bold;
        color: white;
        font-size: 1.2em;
      }
      .video-title {
        font-weight: bold;
        color: #333;
        margin: 5px 0;
      }
      .action-buttons a,
      .action-buttons span {
        padding: 5px 15px;
        margin: 0 5px;
        border-radius: 3px;
        text-decoration: none;
        cursor: pointer;
        font-weight: bold;
        display: inline-block;
      }
      .btn-like {
        background-color: #5cb85c; /* Màu xanh lá cây */
        color: white;
      }
      .btn-share {
        background-color: #f0ad4e; /* Màu cam */
        color: white;
      }

      /* Phân trang */
      .pagination-controls {
        display: inline-block;
        padding: 10px;
        border: 1px solid #ccc;
        border-radius: 5px;
        background-color: #eee;
      }
      .page-link {
        padding: 5px 10px;
        margin: 0 2px;
        text-decoration: none;
        color: #333;
        border: 1px solid #aaa;
        background-color: white;
        border-radius: 3px;
      }
      .page-link.disabled {
        opacity: 0.5;
        pointer-events: none;
        background-color: #f1f1f1;
      }
    </style>
  </body>
</html>
