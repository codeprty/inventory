<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="/WEB-INF/jsp/sidebar.jsp" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" type="text/css" href="/css/maintenance.css">
    <title>User Account List</title>
</head>
<body>
    <h1 id="title">User Account List</h1>

    <!-- Search Form -->
    <form id="search-form" method="get" action="${pageContext.request.contextPath}/maintenance">
        <!-- Search Input Box -->
        <input 
            type="text" 
            id="search-bar" 
            name="search" 
            placeholder="Search by username" 
            value="${search}" 
        />

        <!-- Hidden Input to Pass Action -->
        <input type="hidden" name="action" value="${isSearchActive ? 'clear' : 'search'}" />

        <!-- Dynamic Button -->
        <button type="submit" id="search-clear-btn">
            ${isSearchActive ? 'Clear' : 'Search'}
        </button>
    </form>

    <!-- List of Users -->
    <div id="list-container">
        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Username</th>
                    <th>Role</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="user" items="${users}">
                    <tr>
                        <td>${user.id}</td>
                        <td>${user.username}</td>
                        <td>${user.role}</td>
                        <td>
                            <a href="${pageContext.request.contextPath}/maintenance/edit/${user.id}" class="action-btn" id="edit-btn">Edit</a>
                            <a href="${pageContext.request.contextPath}/maintenance/confirmDelete/${user.id}" class="action-btn" id="delete-btn">Delete</a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>

        <!-- Display message if no users are found -->
        <c:if test="${empty users}">
            <p>No users found.</p>
        </c:if>
    </div>

    <footer class="footer">
        <p>&copy; 2024 Inventory Management System | Version 1.0</p>
    </footer>
</body>
</html>
