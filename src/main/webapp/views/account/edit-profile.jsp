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
</body>
</html>