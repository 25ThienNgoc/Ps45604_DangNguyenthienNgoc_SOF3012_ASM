<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Chia sẻ Video</title>
</head>
<body>
    <%-- 1. Nhúng Menu --%>
    <jsp:include page="<%= com.poly.util.PageConstants.VIEW_LAYOUT_MENU %>" /> 

    <%-- 2. Nội dung chính - Form chia sẻ --%>
    <div class="container share-page">
        <form action="${pageContext.request.contextPath}${SHARE_URL}" method="post">
            
            <%-- Giả định videoId cần chia sẻ được truyền vào request scope --%>
            <input type="hidden" name="videoId" value="${param.id}" /> 
            
            <div class="share-box">
                <h2 class="header-share">SEND VIDEO TO YOUR FRIEND</h2>
                
                <div class="form-group">
                    <label for="emails">YOUR FRIEND'S EMAIL?</label>
                    <%-- Email có thể nhập nhiều, cách nhau bằng dấu phẩy hoặc chấm phẩy --%>
                    <input type="text" id="emails" name="emails" required 
                           placeholder=" " />
                </div>
                
                <%-- Hiển thị thông báo (nếu có) --%>
                <c:if test="${not empty message}">
                    <div class="alert ${messageType == 'success' ? 'alert-success' : 'alert-error'}">
                        ${message}
                    </div>
                </c:if>

                <div class="form-actions">
                    <%-- [Send].Click: Gửi link video đến các email nhập vào (cần Login) --%>
                    <button type="submit" class="btn btn-send">Send</button>
                </div>
            </div>
        </form>
    </div>
    
<style>
/* CSS cho Trang Chia sẻ */
.container {
    max-width: 600px;
    margin: 50px auto;
    padding: 20px;
    background-color: #f9f9f9;
    border-radius: 8px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}
.share-box {
    border: 1px solid #ddd;
    padding: 30px;
    background-color: white;
}
.header-share {
    background-color: #5cb85c; /* Màu xanh lá */
    color: white;
    padding: 15px;
    margin: -30px -30px 20px -30px; /* Mở rộng header ra cạnh box */
    text-align: center;
    font-size: 1.5em;
}
.form-group {
    margin-bottom: 25px;
}
.form-group label {
    display: block;
    font-weight: bold;
    color: #f87d0f; /* Màu cam */
    margin-bottom: 8px;
}
.form-group input {
    width: 100%;
    padding: 10px;
    border: 2px solid #ccc;
    box-sizing: border-box;
    border-radius: 4px;
    font-size: 1em;
}
.form-actions {
    text-align: right;
}
.btn-send {
    background-color: #ff9800; /* Màu cam */
    color: white;
    border: none;
    padding: 10px 30px;
    border-radius: 5px;
    font-size: 1.1em;
    cursor: pointer;
    box-shadow: 0 3px #e68a00;
    transition: background-color 0.2s;
}
.btn-send:hover {
    background-color: #e68a00;
}
/* Thông báo */
.alert {
    padding: 10px;
    margin-bottom: 15px;
    border-radius: 4px;
    font-weight: bold;
}
.alert-success {
    background-color: #d4edda;
    color: #155724;
    border: 1px solid #c3e6cb;
}
.alert-error {
    background-color: #f8d7da;
    color: #721c24;
    border: 1px solid #f5c6cb;
}
</style>
</body>
</html>