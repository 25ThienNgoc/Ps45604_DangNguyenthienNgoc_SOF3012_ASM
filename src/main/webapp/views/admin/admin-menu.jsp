<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%-- Lấy đường dẫn gốc của ứng dụng --%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<c:set var="user" value="${sessionScope.user}" />

<header class="admin-header">
    <nav class="navbar">
        <div class="navbar-brand">
            <a href="${contextPath}/" class="logo">ADMINISTRATION TOOL</a>
        </div>
        <ul class="nav-links">
            <%-- 1. Home --%>
            <li><a href="${contextPath}${URL_ADMIN_HOME}">HOME</a></li>
            
            <%-- 2. Videos (Yêu cầu bảo mật: Admin) --%>
            <c:if test="${user != null && user.admin}">
                <li><a href="${contextPath}${URL_ADMIN_VIDEOS}">VIDEOS</a></li>
            </c:if>
            
            <%-- 3. Users (Yêu cầu bảo mật: Admin) --%>
            <c:if test="${user != null && user.admin}">
                <li><a href="${contextPath}${URL_ADMIN_USERS}">USERS</a></li>
            </c:if>
            
            <%-- 4. Reports (Yêu cầu bảo mật: Admin) --%>
            <c:if test="${user != null && user.admin}">
                <li><a href="${contextPath}${URL_ADMIN_REPORTS}">REPORTS</a></li>
            </c:if>

            <%-- Hiển thị tên Admin và Logoff --%>
            <li class="user-info">
                <c:choose>
                    <c:when test="${user != null && user.admin}">
                        <span>Xin chào, **${user.id}** (Admin)</span> | 
                        <a href="${contextPath}${URL_LOGOFF}">Logoff</a>
                    </c:when>
                    <c:otherwise>
                         <a href="${contextPath}${URL_LOGOFF}">Logoff</a>
                    </c:otherwise>
                </c:choose>
            </li>
        </ul>
    </nav>
</header>

<style>
/* CSS cho Menu Admin */
.admin-header {
    background-color: #000; /* Nền đen */
    color: white;
    padding: 10px 0;
    border-bottom: 3px solid #ffcc00; /* Viền vàng đậm */
}

.navbar {
    display: flex;
    justify-content: space-between;
    align-items: center;
    max-width: 1200px;
    margin: 0 auto;
    padding: 0 20px;
}

.navbar-brand .logo {
    color: #ffcc00; /* Màu vàng */
    font-size: 1.5em;
    font-weight: bold;
    text-decoration: none;
    padding: 5px 10px;
    background-color: #333; /* Nền xám đậm cho chữ ADMIN */
    border-radius: 3px;
    letter-spacing: 1px;
}

.nav-links {
    list-style: none;
    display: flex;
    gap: 20px;
    padding: 0;
    margin: 0;
    align-items: center;
}

.nav-links a {
    color: white;
    text-decoration: none;
    padding: 8px 12px;
    border-radius: 4px;
    transition: background-color 0.3s;
    font-weight: bold;
}

.nav-links a:hover {
    background-color: #555;
}

.user-info {
    color: #ccc;
    font-size: 0.9em;
    padding-left: 20px;
}

.user-info a {
    color: #ffcc00;
    font-weight: normal;
}
</style>