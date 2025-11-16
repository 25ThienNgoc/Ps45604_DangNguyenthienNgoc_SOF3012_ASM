<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Video Yêu Thích Của Tôi</title>
</head>
<body>
    <%-- 1. Nhúng Menu --%>
    <jsp:include page="<%= com.poly.util.PageConstants.VIEW_LAYOUT_MENU %>" /> 

    <%-- 2. Nội dung chính: Danh sách Video Yêu Thích --%>
    <div class="container" style="padding: 20px;">
        <h2><span class="favorite-icon">❤️</span> Danh Sách Yêu Thích Của Tôi</h2>
        
        <%-- Kiểm tra nếu danh sách rỗng --%>
        <c:if test="${empty favoriteVideos}">
            <div class="alert-info">
                Bạn chưa có video yêu thích nào. Hãy khám phá và nhấn Like!
            </div>
        </c:if>

        <%-- Lưới Video (3xN) --%>
        <div class="video-grid">
            <%-- Giả định có một danh sách video yêu thích (favoriteVideos) từ Servlet --%>
            <c:forEach var="video" items="${favoriteVideos}" varStatus="loop">
                <div class="video-item">
                    <%-- [Poster].Click: Trang chi tiết --%>
                    <a href="/detail?id=${video.id}">
                        <div class="poster-box">
                            <%-- Sử dụng thuộc tính 'poster' của Entity Video --%>
                            <img src="${video.poster}" alt="${video.title}" class="poster-image" style="display: none;"/> 
                            <div class="poster-text">POSTER</div>
                        </div>
                    </a>
                    <p class="video-title">${video.title}</p>
                    <div class="action-buttons">
                        <%-- [Unlike].Click: Bỏ yêu thích. Cần Login. --%>
                        <a href="/unlike?id=${video.id}" class="btn btn-unlike">Unlike</a>
                        <%-- [Share].Click: Trang chia sẻ. Cần Login. --%>
                        <a href="/share?id=${video.id}" class="btn btn-share">Share</a>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
    
<style>
/* CSS cho lưới video yêu thích */
.container {
    max-width: 1000px;
    margin: 0 auto;
    text-align: center;
}
h2 {
    color: #FF0077; /* Màu hồng cho tiêu đề yêu thích */
    margin-bottom: 30px;
}
.favorite-icon {
    font-size: 1.2em;
    margin-right: 10px;
}
.video-grid {
    display: grid;
    grid-template-columns: repeat(3, 1fr);
    gap: 20px;
}
.video-item {
    border: 1px solid #ddd;
    padding: 10px;
    border-radius: 5px;
}
.poster-box {
    background-color: #ffc107;
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
    padding: 5px;
    background-color: #e6ffe6; /* Nền xanh nhạt như mẫu */
}
.action-buttons a {
    padding: 5px 15px;
    margin: 0 5px;
    border-radius: 3px;
    text-decoration: none;
    cursor: pointer;
    font-weight: bold;
    display: inline-block;
}
.btn-unlike {
    background-color: #007bff; /* Màu xanh dương (tương phản với Like xanh lá) */
    color: white;
}
.btn-share {
    background-color: #f0ad4e; /* Màu cam */
    color: white;
}
.alert-info {
    padding: 20px;
    background-color: #e0f7fa;
    color: #00796b;
    border: 1px solid #b2ebf2;
    border-radius: 5px;
    margin-top: 20px;
}
</style>
</body>
</html>