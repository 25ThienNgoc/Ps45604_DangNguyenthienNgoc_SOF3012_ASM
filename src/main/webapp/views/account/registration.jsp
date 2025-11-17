<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Đăng Ký Tài Khoản</title>
</head>
<body>
    <jsp:include page="<%= com.poly.util.PageConstants.VIEW_LAYOUT_MENU %>" /> 

    <div class="container account-page">
        <form action="${pageContext.request.contextPath}${REGISTRATION_URL}" method="post">
            <div class="account-box registration-box">
                <h2 class="header-account">REGISTRATION</h2>
                
                <%-- Hiển thị thông báo (nếu có) --%>
                <c:if test="${not empty message}">
                    <div class="alert ${messageType == 'success' ? 'alert-success' : 'alert-error'}">${message}</div>
                </c:if>
                
                <div class="form-grid">
                    <div class="form-group">
                        <label for="username">USERNAME?</label>
                        <input type="text" id="username" name="username" required placeholder="Tên đăng nhập" value="${param.username}" />
                    </div>
                    <div class="form-group">
                        <label for="password">PASSWORD?</label>
                        <input type="password" id="password" name="password" required placeholder="Mật khẩu" />
                    </div>
                    <div class="form-group">
                        <label for="fullname">FULLNAME?</label>
                        <input type="text" id="fullname" name="fullname" required placeholder="Họ và tên" value="${param.fullname}" />
                    </div>
                    <div class="form-group">
                        <label for="email">EMAIL ADDRESS?</label>
                        <input type="email" id="email" name="email" required placeholder="Địa chỉ email" value="${param.email}" />
                    </div>
                </div>

                <div class="form-actions">
                    <%-- [Sign Up].Click: Xử lý đăng ký --%>
                    <button type="submit" class="btn btn-signup">Sign Up</button>
                </div>
            </div>
        </form>
    </div>
    
    <style>
        .registration-box { max-width: 600px; margin: 0 auto; }
        .form-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 15px; }
        .alert-success { background-color: #d4edda; color: #155724; border: 1px solid #c3e6cb; padding: 10px; border-radius: 4px; margin-bottom: 15px; }
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