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
    </style>
</body>
</html>