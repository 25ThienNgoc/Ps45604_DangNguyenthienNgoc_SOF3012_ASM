<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Đổi Mật Khẩu</title>
</head>
<body>
    <jsp:include page="<%= com.poly.util.PageConstants.VIEW_LAYOUT_MENU %>" /> 

    <div class="container account-page">
        <%-- Trang này yêu cầu Login --%>
        <c:set var="user" value="${sessionScope.user}" /> 
        
        <form action="${pageContext.request.contextPath}${CHANGE_PASSWORD_URL}" method="post">
            <div class="account-box registration-box">
                <h2 class="header-account">CHANGE PASSWORD</h2>
                
                <c:if test="${not empty message}">
                    <div class="alert ${messageType == 'success' ? 'alert-success' : 'alert-error'}">${message}</div>
                </c:if>
                
                <div class="form-grid">
                    <div class="form-group">
                        <label for="username">USERNAME?</label>
                        <%-- Thường được điền sẵn từ session --%>
                        <input type="text" id="username" name="username" readonly value="${user.id}" /> 
                    </div>
                    <div class="form-group">
                        <label for="currentPassword">CURRENT PASSWORD?</label>
                        <input type="password" id="currentPassword" name="currentPassword" required placeholder="Mật khẩu hiện tại" />
                    </div>
                    <div class="form-group">
                        <label for="newPassword">NEW PASSWORD?</label>
                        <input type="password" id="newPassword" name="newPassword" required placeholder="Mật khẩu mới" />
                    </div>
                    <div class="form-group">
                        <label for="confirmNewPassword">CONFIRM NEW PASSWORD?</label>
                        <input type="password" id="confirmNewPassword" name="confirmNewPassword" required placeholder="Xác nhận mật khẩu mới" />
                    </div>
                </div>

                <div class="form-actions">
                    <%-- [Change].Click: Kiểm tra dữ liệu, cập nhật mật khẩu, cập nhật session --%>
                    <button type="submit" class="btn btn-change">Change</button>
                </div>
            </div>
        </form>
    </div>
</body>
</html>