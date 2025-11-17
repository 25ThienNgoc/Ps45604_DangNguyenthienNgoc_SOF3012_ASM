<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Cập Nhật Tài Khoản</title>
</head>
<body>
    <jsp:include page="<%= com.poly.util.PageConstants.VIEW_LAYOUT_MENU %>" /> 

    <div class="container account-page">
        <%-- Trang này yêu cầu Login --%>
        <c:set var="user" value="${sessionScope.user}" /> 

        <form action="${pageContext.request.contextPath}${EDIT_PROFILE_URL}" method="post">
            <div class="account-box registration-box">
                <h2 class="header-account">EDIT PROFILE</h2>
                
                <c:if test="${not empty message}">
                    <div class="alert ${messageType == 'success' ? 'alert-success' : 'alert-error'}">${message}</div>
                </c:if>

                <div class="form-grid">
                    <div class="form-group">
                        <label for="username">USERNAME?</label>
                        <%-- Username thường là khóa chính, không được sửa --%>
                        <input type="text" id="username" name="username" readonly value="${user.id}" /> 
                    </div>
                    <div class="form-group">
                        <label for="password">PASSWORD?</label>
                        <%-- Hiển thị ẩn/placeholder để người dùng biết không thay đổi ở đây --%>
                        <input type="password" id="password" name="password" placeholder="******" /> 
                    </div>
                    <div class="form-group">
                        <label for="fullname">FULLNAME?</label>
                        <%-- Hiển thị thông tin lấy từ session lên form --%>
                        <input type="text" id="fullname" name="fullname" required value="${user.fullname}" />
                    </div>
                    <div class="form-group">
                        <label for="email">EMAIL ADDRESS?</label>
                        <input type="email" id="email" name="email" required value="${user.email}" />
                    </div>
                </div>

                <div class="form-actions">
                    <%-- [Update].Click: Kiểm tra dữ liệu, cập nhật tài khoản, cập nhật session --%>
                    <button type="submit" class="btn btn-update">Update</button>
                </div>
            </div>
        </form>
    </div>
    <style>
        /* CSS Cơ bản cho các trang Account (có thể đặt trong file CSS riêng) */
        .account-page { max-width: 400px; margin: 50px auto; }
        .account-box { border: 1px solid #ddd; padding: 30px; background-color: white; border-radius: 8px; box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); }
        .header-account { background-color: #5cb85c; color: white; padding: 15px; margin: -30px -30px 20px -30px; text-align: center; font-size: 1.5em; }
        .form-group label { display: block; font-weight: bold; color: #f87d0f; margin-bottom: 8px; }
        .form-group input { width: 100%; padding: 10px; border: 2px solid #ccc; box-sizing: border-box; border-radius: 4px; margin-bottom: 15px; }
        .remember-me { text-align: left; }
        .remember-me input[type="checkbox"] { width: auto; margin-right: 5px; vertical-align: middle; }
        .btn-login, .btn-signup, .btn-retrieve, .btn-change, .btn-update { background-color: #ff9800; color: white; border: none; padding: 10px 30px; border-radius: 5px; font-size: 1.1em; cursor: pointer; box-shadow: 0 3px #e68a00; float: right; }
        .form-actions { overflow: auto; padding-top: 10px; }
        .link-actions { margin-top: 20px; text-align: center; }
        .link-actions a { display: block; margin-top: 5px; color: #007bff; text-decoration: none; }
        .alert-error { background-color: #f8d7da; color: #721c24; border: 1px solid #f5c6cb; padding: 10px; border-radius: 4px; margin-bottom: 15px; }
    </style>
</body>
</html>