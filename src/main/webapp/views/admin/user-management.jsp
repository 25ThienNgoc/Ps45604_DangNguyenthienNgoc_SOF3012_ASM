<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib uri="http://java.sun.com/jsp/jstl/core"
prefix="c" %>

<jsp:include page="<%= com.poly.util.PageConstants.VIEW_ADMIN_MENU %>" />

<div class="container admin-content">
  <h2>QUẢN LÝ NGƯỜI DÙNG</h2>

  <div class="admin-tabs">
    <button class="tab-button tab-button-active" onclick="showTab('edit')">
      USER EDITION
    </button>
    <button class="tab-button" onclick="showTab('list')">USER LIST</button>
  </div>

  <!-- Edit Form -->
  <div id="edit" class="tab-content active">
    <form
      action="${pageContext.request.contextPath}${PageConstants.URL_ADMIN_USERS}"
      method="post"
      class="form-video-edit"
    >
      <div class="form-row">
        <div class="form-group poster-col">
          <div class="poster-box-admin">AVATAR</div>
          <input type="hidden" name="avatar" value="${user.avatar}" />
        </div>

        <div class="form-group input-col">
          <label for="id">USERNAME?</label>
          <input type="text" id="id" name="id" required value="${user.id}"
          ${user.id != null ? 'readonly' : ''} />

          <label for="password">PASSWORD?</label>
          <input type="password" id="password" name="password" value="" />

          <label for="fullname">FULLNAME?</label>
          <input
            type="text"
            id="fullname"
            name="fullname"
            value="${user.fullname}"
          />

          <label for="email">EMAIL ADDRESS?</label>
          <input type="email" id="email" name="email" value="${user.email}" />
        </div>
      </div>

      <div class="form-row status-row">
        <label>ROLE:</label>
        <input type="radio" id="isAdmin" name="admin" value="true"
        ${user.isAdmin() ? 'checked' : ''}/>
        <label for="isAdmin">Admin</label> <input type="radio" id="isUser"
        name="admin" value="false" ${!user.isAdmin() ? 'checked' : ''}/>
        <label for="isUser">User</label>
      </div>

      <div class="form-actions-admin">
        <button
          type="submit"
          name="action"
          value="create"
          class="btn btn-create"
        >
          Create
        </button>
        <button
          type="submit"
          name="action"
          value="update"
          class="btn btn-update"
        >
          Update
        </button>
        <button
          type="submit"
          name="action"
          value="delete"
          class="btn btn-delete"
        >
          Delete
        </button>
        <button type="submit" name="action" value="reset" class="btn btn-reset">
          Reset
        </button>
      </div>
    </form>
  </div>

  <!-- List -->
  <div id="list" class="tab-content" style="display: none">
    <p><strong>${userCount == null ? 0 : userCount} users</strong></p>
    <table class="data-grid">
      <thead>
        <tr>
          <th>Username</th>
          <th>Fullname</th>
          <th>Email</th>
          <th>Role</th>
          <th></th>
        </tr>
      </thead>
      <tbody>
        <c:forEach var="u" items="${users}">
          <tr>
            <td>${u.id}</td>
            <td>${u.fullname}</td>
            <td>${u.email}</td>
            <td>${u.isAdmin() ? 'Admin' : 'User'}</td>
            <td>
              <a
                href="${pageContext.request.contextPath}${PageConstants.URL_ADMIN_USERS}?action=edit&id=${u.id}"
                class="btn-grid-edit"
                >Edit</a
              >
            </td>
          </tr>
        </c:forEach>
      </tbody>
    </table>

    <div class="pagination-controls">
      <!-- pagination controls here -->
    </div>
  </div>
</div>

<style>
  /* Admin styles adapted from video-management */
  .admin-content {
    max-width: 900px;
    margin: 20px auto;
    background: white;
    padding: 20px;
    border-radius: 8px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
  }
  .admin-tabs {
    margin-bottom: 0;
  }
  .tab-button {
    padding: 10px 20px;
    border: none;
    background: #eee;
    cursor: pointer;
    border-radius: 5px 5px 0 0;
    margin-right: 5px;
    font-weight: bold;
  }
  .tab-button-active,
  .tab-button.active {
    background: #ff9800;
    color: white;
  }
  .tab-content {
    border: 1px solid #ddd;
    padding: 20px;
    border-top: none;
  }
  .form-row {
    display: flex;
    gap: 20px;
    margin-bottom: 15px;
  }
  .poster-col {
    flex-basis: 30%;
  }
  .input-col {
    flex-basis: 70%;
  }
  .poster-box-admin {
    width: 100%;
    height: 150px;
    background-color: #ffc107;
    display: flex;
    justify-content: center;
    align-items: center;
    color: white;
    font-weight: bold;
    margin-bottom: 10px;
  }
  .form-group label {
    display: block;
    font-weight: bold;
    margin-bottom: 5px;
    color: #555;
  }
  .form-group input[type="text"],
  .form-group input[type="email"],
  .form-group input[type="password"] {
    width: 100%;
    padding: 8px;
    border: 1px solid #ccc;
    box-sizing: border-box;
    margin-bottom: 10px;
  }
  .form-actions-admin button {
    padding: 10px 15px;
    margin-left: 10px;
    border: none;
    border-radius: 5px;
    color: white;
    cursor: pointer;
    font-weight: bold;
  }
  .btn-create {
    background-color: #5cb85c;
  }
  .btn-update {
    background-color: #007bff;
  }
  .btn-delete {
    background-color: #d9534f;
  }
  .btn-reset {
    background-color: #f0ad4e;
  }
  .data-grid {
    width: 100%;
    border-collapse: collapse;
    margin-top: 15px;
  }
  .data-grid th,
  .data-grid td {
    border: 1px solid #ddd;
    padding: 8px;
    text-align: left;
  }
  .data-grid th {
    background-color: #f2f2f2;
  }
  .btn-grid-edit {
    background-color: #007bff;
    color: white;
    padding: 4px 8px;
    text-decoration: none;
    border-radius: 3px;
  }
  .pagination-controls {
    text-align: center;
    margin-top: 12px;
  }
</style>

<script>
  function showTab(tabId) {
    document.querySelectorAll(".tab-content").forEach((content) => {
      content.classList.remove("active");
      content.style.display = "none";
    });
    document.querySelectorAll(".tab-button").forEach((button) => {
      button.classList.remove("active");
    });

    document.getElementById(tabId).style.display = "block";
    document
      .querySelector(`.tab-button[onclick*='${tabId}']`)
      .classList.add("active");
  }
  document.addEventListener("DOMContentLoaded", () => {
    showTab("edit");
  });
</script>
