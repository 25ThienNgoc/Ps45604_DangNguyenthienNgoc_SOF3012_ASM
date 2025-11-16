<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Quên Mật Khẩu</title>
</head>
<body>
    <jsp:include page="<%= com.poly.util.PageConstants.VIEW_LAYOUT_MENU %>" /> 

    <div class="container account-page">
        <form action="${pageContext.request.contextPath}${FORGOT_PASSWORD_URL}" method="post">
            <div class="account-box">
                <h2 class="header-account">FORGOT PASSWORD</h2>
                
                <c:if test="${not empty message}">
                    <div class="alert ${messageType == 'success' ? 'alert-success' : 'alert-error'}">${message}</div>
                </c:if>
                
                <div class="form-group">
                    <label for="username">USERNAME?</label>
                    <input type="text" id="username" name="username" required placeholder="Tên đăng nhập" />
                </div>
                
                <div class="form-group">
                    <label for="email">EMAIL?</label>
                    <input type="email" id="email" name="email" required placeholder="Địa chỉ email" />
                </div>

                <div class="form-actions">
                    <%-- [Retrieve].Click: Kiểm tra dữ liệu và gửi mật khẩu qua email --%>
                    <button type="submit" class="btn btn-retrieve">Retrieve</button>
                </div>
            </div>
        </form>
    </div>
</body>
</html>