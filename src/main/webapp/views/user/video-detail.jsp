<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Chi tiết Video: ${currentVideo.title}</title>
</head>
<body>
    <%-- 1. Nhúng Menu --%>
    <jsp:include page="/views/layout/menu.jsp" /> 

    <%-- 2. Nội dung chính --%>
    <div class="container detail-page">
        
        <div class="main-content">
            <%-- Khu vực Video (Lấy từ thuộc tính video entity) --%>
            <div class="video-player-area">
                <div class="video-box">
                    <%-- Giả sử poster/video link được đặt trong currentVideo.link --%>
                    <iframe width="100%" height="400" 
                            src="${currentVideo.link}" 
                            frameborder="0" allowfullscreen>
                        [VIDEO]
                    </iframe>
                </div>
            </div>
            
            <%-- Tiêu đề và Mô tả --%>
            <div class="video-info">
                <h2 class="video-title">${currentVideo.title}</h2>
                <p class="video-description">${currentVideo.description}</p>
            </div>
            
            <%-- Hành động (Like/Share) --%>
            <div class="action-buttons-detail">
                <%-- [Like].Click: Ghi nhận yêu thích. Cần Login. --%>
                <a href="/like?id=${currentVideo.id}" class="btn btn-like-detail">Like</a>
                <%-- [Share].Click: Trang chia sẻ. Cần Login. --%>
                <a href="/share?id=${currentVideo.id}" class="btn btn-share-detail">Share</a>
            </div>
        </div>

        <%-- Danh sách video đã xem (Lấy từ cookie) --%>
        <div class="sidebar">
            <h3 class="sidebar-title">Đã Xem Gần Đây</h3>
            <%-- Giả sử đã có một danh sách video (historyVideos) từ Servlet --%>
            <c:forEach var="video" items="${historyVideos}" varStatus="loop">
                <div class="history-item">
                    <%-- [Poster].Click: Trang chi tiết --%>
                    <a href="/detail?id=${video.id}" class="history-link">
                        <div class="poster-small">POSTER</div>
                        <p class="video-title-small">${video.title}</p>
                    </a>
                </div>
            </c:forEach>
            
            <%-- Hiển thị các ô trống nếu danh sách chưa đủ 5 --%>
            <c:set var="historyCount" value="${historyVideos.size()}" />
            <c:forEach begin="${historyCount}" end="4" step="1">
                <div class="history-item placeholder">
                    <a href="#" class="history-link">
                        <div class="poster-small">POSTER</div>
                        <p class="video-title-small">VIDEO TITLE</p>
                    </a>
                </div>
            </c:forEach>
        </div>
    </div>
    
<style>
/* CSS cho Trang Chi tiết */
.container {
    max-width: 1200px;
    margin: 20px auto;
    display: flex;
    gap: 20px;
}
.main-content {
    flex: 3; /* Chiếm khoảng 60-70% chiều rộng */
    padding-right: 20px;
    border-right: 1px solid #eee;
}
.sidebar {
    flex: 1; /* Chiếm khoảng 30-40% chiều rộng */
    padding-left: 20px;
}
.video-box {
    border: 3px solid #ff9800;
    padding: 10px;
    background-color: #fcfcfc;
}
.video-info {
    padding: 15px 0;
    border-bottom: 1px solid #ddd;
}
.video-title {
    color: #333;
    font-size: 1.8em;
    margin-bottom: 5px;
}
.video-description {
    color: #666;
    line-height: 1.6;
}
.action-buttons-detail {
    padding: 15px 0;
}
.btn-like-detail, .btn-share-detail {
    padding: 8px 25px;
    margin-right: 10px;
    border-radius: 5px;
    text-decoration: none;
    font-weight: bold;
    display: inline-block;
}
.btn-like-detail {
    background-color: #4CAF50; /* Xanh lá */
    color: white;
}
.btn-share-detail {
    background-color: #FFC107; /* Vàng */
    color: black;
}

/* Sidebar - Video đã xem */
.sidebar-title {
    border-bottom: 2px solid #ff9800;
    padding-bottom: 5px;
    margin-bottom: 15px;
}
.history-item {
    border: 1px solid #ccc;
    margin-bottom: 10px;
    padding: 5px;
}
.history-link {
    display: flex;
    align-items: center;
    text-decoration: none;
    color: #333;
}
.poster-small {
    background-color: #f0f0f0;
    width: 60px;
    height: 60px;
    display: flex;
    justify-content: center;
    align-items: center;
    font-size: 0.7em;
    margin-right: 10px;
    border: 1px solid #ff9800;
}
.video-title-small {
    flex-grow: 1;
    font-size: 0.9em;
    margin: 0;
}
</style>
</body>
</html>