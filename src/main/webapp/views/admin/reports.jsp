<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Báo Cáo Thống Kê</title>
</head>
<body>
    <%-- 1. Nhúng Menu Admin --%>
    <jsp:include page="<%= com.poly.util.PageConstants.VIEW_ADMIN_MENU %>" /> 

    <div class="container admin-content">
        <h2>BÁO CÁO, THỐNG KÊ</h2>
        
        <div class="report-tabs">
            <%-- Các Tab Báo cáo --%>
            <button class="tab-button" onclick="showReportTab('favoritesReport')">FAVORITES</button> 
            <button class="tab-button" onclick="showReportTab('favoriteUsersReport')">FAVORITE USERS</button>
            <button class="tab-button active" onclick="showReportTab('sharedFriendsReport')">SHARED FRIENDS</button>
        </div>

        <%-- A. Tab FAVORITES (Thống kê số người yêu thích từng tiểu phẩm) --%>
        <div id="favoritesReport" class="tab-content" style="display: none;">
            
            <table class="data-grid">
                <thead>
                    <tr>
                        <th>VIDEO TITLE</th>
                        <th>FAVORITE COUNT</th>
                        <th>LATEST DATE</th>
                        <th>OLDEST DATE</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="report" items="${reportFavorites}">
                    <tr>
                        <td>${report.videoTitle}</td>
                        <td>${report.favoriteCount}</td>
                        <td><fmt:formatDate value="${report.latestDate}" pattern="dd/MM/yyyy"/></td>
                        <td><fmt:formatDate value="${report.oldestDate}" pattern="dd/MM/yyyy"/></td>
                    </tr>
                    </c:forEach>
                    <c:if test="${empty reportFavorites}">
                        <tr><td colspan="4" style="text-align: center;">Không có dữ liệu báo cáo yêu thích.</td></tr>
                    </c:if>
                </tbody>
            </table>
        </div>

        <%-- B. Tab FAVORITE USERS (Nội dung trống, chỉ để giữ cấu trúc) --%>
        <div id="favoriteUsersReport" class="tab-content" style="display: none;">
             <p>Nội dung đang được phát triển...</p>
        </div>

        <%-- C. Tab SHARED FRIENDS (Lọc người gửi & người nhận) --%>
        <div id="sharedFriendsReport" class="tab-content active">
            
            <%-- Form Filter theo Video Title --%>
            <form action="${pageContext.request.contextPath}${URL_ADMIN_REPORTS}" method="get" class="filter-form">
                <input type="hidden" name="tab" value="shared" />
                
                <label for="videoTitleFilter">VIDEO TITLE?</label>
                <%-- Select box chứa các video đã được chia sẻ --%>
                <select id="videoTitleFilter" name="videoId" onchange="this.form.submit()">
                    <option value="">-- Chọn video để lọc --</option>
                    <c:forEach var="video" items="${sharedVideos}">
                        <%-- Giả định sharedVideos là List<Video> đã được chia sẻ, lấy từ Servlet --%>
                        <option value="${video.id}" ${param.videoId == video.id ? 'selected' : ''}>${video.title}</option>
                    </c:forEach>
                </select>
            </form>

            <table class="data-grid">
                <thead>
                    <tr>
                        <th>SENDER NAME</th>
                        <th>SENDER EMAIL</th>
                        <th>RECEIVER EMAIL</th>
                        <th>SENT DATE</th>
                    </tr>
                </thead>
                <tbody>
                    <%-- reportShares là List<com.poly.entity.Share> (Share entity).
                         Use share.user to get sender info and share.emails for receiver list. --%>
                    <c:forEach var="share" items="${reportShares}">
                    <tr>
                        <td>${share.user.fullname}</td>
                        <td>${share.user.email}</td>
                        <td>${share.emails}</td>
                        <td><fmt:formatDate value="${share.shareDate}" pattern="dd/MM/yyyy"/></td>
                    </tr>
                    </c:forEach>
                    <c:if test="${empty reportShares}">
                        <tr><td colspan="4" style="text-align: center;">Không có dữ liệu chia sẻ cho video này.</td></tr>
                    </c:if>
                </tbody>
            </table>
        </div>
    </div>

<style>
/* Đảm bảo CSS cho tab vẫn hoạt động */
.report-tabs { margin-bottom: 0; }
.report-tabs button {
    background: #ff9800;
    color: white;
    border: 1px solid #ff9800;
    border-bottom: none;
    border-radius: 5px 5px 0 0;
    padding: 8px 15px;
    font-weight: normal;
}
.report-tabs button.active {
    background: #f0ad4e;
    border-color: #f0ad4e;
}
.filter-form { 
    margin-bottom: 20px; 
    padding: 10px;
    border: 1px solid #eee;
}
.filter-form label {
    font-weight: bold;
    margin-right: 10px;
}
.filter-form select {
    padding: 8px;
    border-radius: 5px;
    border: 1px solid #ccc;
    font-size: 1em;
}
</style>
<script>
    function showReportTab(tabId) {
        document.querySelectorAll('.tab-content').forEach(content => {
            content.classList.remove('active');
            content.style.display = 'none';
        });
        document.querySelectorAll('.tab-button').forEach(button => {
            button.classList.remove('active');
        });

        document.getElementById(tabId).style.display = 'block';
        document.querySelector(`.report-tabs button[onclick*='${tabId}']`).classList.add('active');
    }
    document.addEventListener('DOMContentLoaded', () => {
        // Mặc định hiển thị tab SHARED FRIENDS (vì là phần mới nhất)
        const activeTabId = '${param.tab}' || 'sharedFriendsReport'; 
        showReportTab(activeTabId);
    });
</script>
</body>
</html>