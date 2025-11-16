<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Quản Lý Video</title>
</head>
<body>
    <%-- 1. Nhúng Menu Admin --%>
    <jsp:include page="<%= com.poly.util.PageConstants.VIEW_ADMIN_MENU %>" /> 

    <div class="container admin-content">
        <h2>QUẢN LÝ VIDEO</h2>
        
        <div class="admin-tabs">
            <button class="tab-button active" onclick="showTab('edit')">VIDEO EDITION</button>
            <button class="tab-button" onclick="showTab('list')">VIDEO LIST</button>
        </div>

        <%-- A. Tab VIDEO EDITION (Form) --%>
        <div id="edit" class="tab-content active">
            <form action="${pageContext.request.contextPath}${URL_ADMIN_VIDEOS}" method="post" class="form-video-edit">
                
                <div class="form-row">
                    <div class="form-group poster-col">
                        <div class="poster-box-admin">POSTER</div>
                        <%-- Giả định có trường ẩn để lưu poster URL --%>
                        <input type="hidden" name="poster" value="${form.poster}" />
                    </div>
                    <div class="form-group input-col">
                        <label for="id">YOUTUBE ID?</label>
                        <input type="text" id="id" name="id" required value="${form.id}" ${editMode ? 'readonly' : ''} />
                        
                        <label for="title">VIDEO TITLE?</label>
                        <input type="text" id="title" name="title" required value="${form.title}" />
                        
                        <label for="viewCount">VIEW COUNT?</label>
                        <input type="number" id="viewCount" name="viewCount" readonly value="${form.views == null ? 0 : form.views}" />
                    </div>
                </div>
                
                <div class="form-row status-row">
                    <input type="checkbox" id="active" name="active" ${form.active == null || form.active ? 'checked' : ''}/>
                    <label for="active">ACTIVE</label>
                    <input type="checkbox" id="inactive" name="inactive" ${form.active != null && !form.active ? 'checked' : ''}/>
                    <label for="inactive">INACTIVE</label>
                </div>
                
                <div class="form-group">
                    <label for="description">DESCRIPTION?</label>
                    <textarea id="description" name="description" rows="3">${form.description}</textarea>
                </div>

                <div class="form-actions-admin">
                    <%-- [Create].Click: Kiểm tra, Thêm mới (Vô hiệu hóa khi Edit) --%>
                    <button type="submit" name="action" value="create" class="btn btn-create" ${editMode ? 'disabled' : ''}>Create</button>
                    <%-- [Update].Click: Cập nhật (Vô hiệu hóa khi Create/Reset) --%>
                    <button type="submit" name="action" value="update" class="btn btn-update" ${!editMode ? 'disabled' : ''}>Update</button>
                    <%-- [Delete].Click: Xóa (Vô hiệu hóa khi Create/Reset) --%>
                    <button type="submit" name="action" value="delete" class="btn btn-delete" ${!editMode ? 'disabled' : ''}>Delete</button>
                    <%-- [Reset].Click: Hiển thị form trống --%>
                    <button type="submit" name="action" value="reset" class="btn btn-reset">Reset</button>
                </div>
            </form>
        </div>

        <%-- B. Tab VIDEO LIST (Grid) --%>
        <div id="list" class="tab-content">
            <p><strong>${videoCount} videos</strong></p>
            <table class="data-grid">
                <thead>
                    <tr>
                        <th>Youtube Id</th>
                        <th>Video Title</th>
                        <th>View Count</th>
                        <th>Status</th>
                        <th></th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="video" items="${videos}" varStatus="loop">
                    <tr>
                        <td>${video.id}</td>
                        <td>${video.title}</td>
                        <td>${video.views}</td>
                        <td>${video.active ? 'Active' : 'Inactive'}</td>
                        <%-- [Edit].Click: Hiển thị tiểu phẩm lên form --%>
                        <td><a href="${pageContext.request.contextPath}${URL_ADMIN_VIDEOS}?action=edit&id=${video.id}" class="btn-grid-edit">Edit</a></td>
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
/* CSS cho Admin */
.admin-content { max-width: 900px; margin: 20px auto; background: white; padding: 20px; border-radius: 8px; box-shadow: 0 0 10px rgba(0,0,0,0.1); }
.admin-tabs button { padding: 10px 20px; border: none; background: #eee; cursor: pointer; border-radius: 5px 5px 0 0; margin-right: 5px; font-weight: bold; }
.admin-tabs button.active { background: #ff9800; color: white; }
.tab-content { border: 1px solid #ddd; padding: 20px; border-top: none; }
.form-video-edit { padding: 15px; }
.form-row { display: flex; gap: 20px; margin-bottom: 15px; }
.poster-col { flex-basis: 30%; }
.input-col { flex-basis: 70%; }
.poster-box-admin { width: 100%; height: 150px; background-color: #ffc107; display: flex; justify-content: center; align-items: center; color: white; font-weight: bold; margin-bottom: 10px; }
.form-group label { display: block; font-weight: bold; margin-bottom: 5px; color: #555; }
.form-group input[type="text"], .form-group input[type="number"], .form-group textarea { width: 100%; padding: 8px; border: 1px solid #ccc; box-sizing: border-box; margin-bottom: 10px; }
.status-row input[type="checkbox"] { width: auto; margin-right: 5px; }
.form-actions-admin button { padding: 10px 15px; margin-left: 10px; border: none; border-radius: 5px; color: white; cursor: pointer; font-weight: bold; }
.btn-create { background-color: #5cb85c; }
.btn-update { background-color: #007bff; }
.btn-delete { background-color: #d9534f; }
.btn-reset { background-color: #f0ad4e; }
.data-grid { width: 100%; border-collapse: collapse; margin-top: 15px; }
.data-grid th, .data-grid td { border: 1px solid #ddd; padding: 8px; text-align: left; }
.data-grid th { background-color: #f2f2f2; }
.btn-grid-edit { background-color: #007bff; color: white; padding: 4px 8px; text-decoration: none; border-radius: 3px; }

/* Script đơn giản để chuyển tab */
<script>
    function showTab(tabId) {
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
    // Hiển thị tab đầu tiên khi load
    document.addEventListener('DOMContentLoaded', () => {
        showTab('edit');
    });
</script>
</style>
</body>
</html>