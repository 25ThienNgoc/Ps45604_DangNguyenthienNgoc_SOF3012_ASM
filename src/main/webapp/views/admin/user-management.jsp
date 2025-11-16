<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Quản Lý Người Dùng</title>
</head>
<body>
    <%-- 1. Nhúng Menu Admin --%>
    <jsp:include page="<%= com.poly.util.PageConstants.VIEW_ADMIN_MENU %>" /> 

    <div class="container admin-content">
        <h2>QUẢN LÝ NGƯỜI SỬ DỤNG</h2>
        
        <div class="admin-tabs">
            <button class="tab-button active" onclick="showUserTab('editUser')">USER EDITION</button>
            <button class="tab-button" onclick="showUserTab('listUser')">USER LIST</button>
        </div>

        <%-- A. Tab USER EDITION (Form) --%>
        <div id="editUser" class="tab-content active">
            <form action="${pageContext.request.contextPath}${URL_ADMIN_USERS}" method="post" class="form-user-edit">
                
                <div class="form-row">
                    <div class="form-group half-col">
                        <label for="userId">USERNAME?</label>
                        <input type="text" id="userId" name="id" required value="${form.id}" ${editMode ? 'readonly' : ''} />
                    </div>
                    <div class="form-group half-col">
                        <label for="password">PASSWORD?</label>
                        <%-- Không hiển thị mật khẩu thực tế, chỉ hiển thị ***** --%>
                        <input type="password" id="password" name="password" placeholder="******" ${editMode ? 'readonly' : ''} />
                    </div>
                </div>
                
                <div class="form-row">
                    <div class="form-group half-col">
                        <label for="fullname">FULLNAME?</label>
                        <input type="text" id="fullname" name="fullname" required value="${form.fullname}" />
                    </div>
                    <div class="form-group half-col">
                        <label for="email">EMAIL ADDRESS?</label>
                        <input type="email" id="email" name="email" required value="${form.email}" />
                    </div>
                </div>
                
                <div class="form-actions-admin">
                    <%-- [Update].Click: Cập nhật người sử dụng --%>
                    <button type="submit" name="action" value="update" class="btn btn-update" ${!editMode ? 'disabled' : ''}>Update</button>
                    <%-- [Delete].Click: Xóa người sử dụng --%>
                    <button type="submit" name="action" value="delete" class="btn btn-delete" ${!editMode ? 'disabled' : ''}>Delete</button>
                    <%-- [Vô hiệu hóa] Create/Reset không được hiển thị theo mẫu --%>
                </div>
            </form>
        </div>

        <%-- B. Tab USER LIST (Grid) --%>
        <div id="listUser" class="tab-content" style="display: none;">
            <p><strong>${userCount} users</strong></p>
            <table class="data-grid">
                <thead>
                    <tr>
                        <th>Username</th>
                        <th>Password</th>
                        <th>Fullname</th>
                        <th>Email</th>
                        <th>Role</th>
                        <th></th>
                    </tr>
                </thead>
                <tbody>
                    <%-- Hiển thị 10 người sử dụng/trang --%>
                    <c:forEach var="user" items="${users}">
                    <tr>
                        <td>${user.id}</td>
                        <%-- Hiển thị ẩn mật khẩu --%>
                        <td><c:choose><c:when test="${user.password != null}">******</c:when><c:otherwise>N/A</c:otherwise></c:choose></td>
                        <td>${user.fullname}</td>
                        <td>${user.email}</td>
                        <td>${user.admin ? 'Admin' : 'User'}</td>
                        <%-- [Edit].Click: Hiển thị người dùng lên form --%>
                        <td><a href="${pageContext.request.contextPath}${URL_ADMIN_USERS}?action=edit&id=${user.id}" class="btn-grid-edit">Edit</a></td>
                    </tr>
                    </c:forEach>
                </tbody>
            </table>
            
            <%-- Phân trang --%>
            <div class="pagination-controls">
                <%-- ... (Logic phân trang tương tự index.jsp) ... --%>
            </div>
        </div>
    </div>
    
<style>
/* CSS bổ sung cho User Management */
.form-row .half-col { flex-basis: 50%; }
.form-user-edit input[type="password"] { font-family: monospace; } 
</style>
<script>
    function showUserTab(tabId) {
        document.querySelectorAll('.tab-content').forEach(content => {
            content.classList.remove('active');
            content.style.display = 'none';
        });
        document.querySelectorAll('.tab-button').forEach(button => {
            button.classList.remove('active');
        });

        document.getElementById(tabId).style.display = 'block';
        document.querySelector(`.tab-button[onclick*='${tabId}']`).classList.add('active');
    }
    document.addEventListener('DOMContentLoaded', () => {
        showUserTab('editUser');
    });
</script>
</body>
</html>