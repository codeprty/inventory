<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="/WEB-INF/jsp/sidebar.jsp" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" type="text/css" href="/css/list.css">
    <title>Inventory Management System</title>
</head>
<body>
    <h1 id="title">Item List</h1>

   <!-- Search Form -->
<form id="search-form" method="get" action="${pageContext.request.contextPath}/items">
    <!-- Search Input Box -->
    <input 
        type="text" 
        id="search-bar" 
        name="search" 
        placeholder="Search by item name" 
        value="${search}" 
    />

    <!-- Hidden Input to Pass Action -->
    <input type="hidden" name="action" value="${isSearchActive ? 'clear' : 'search'}" />

    <!-- Dynamic Button -->
    <button type="submit" id="search-clear-btn">
        ${isSearchActive ? 'Clear' : 'Search'}
    </button>
</form>

<!-- List of Items -->
<div id="list-container">
    <table>
        <thead>
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Description</th>
                <th>Price</th>
                <th>Quantity</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="item" items="${items}">
                <tr>
                    <td>${item.id}</td>
                    <td>${item.name}</td>
                    <td>${item.description}</td>
                    <td>${item.price}</td>
                    <td>${item.quantity}</td>
                    <td>
                        <a href="${pageContext.request.contextPath}/items/edit/${item.id}" class="action-btn" id="edit-btn">Edit</a>
                        <a href="${pageContext.request.contextPath}/items/confirmDelete/${item.id}" class="action-btn" id="delete-btn">Delete</a>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>

    <!-- Display message if no items are found -->
    <c:if test="${empty items}">
        <p>No items found.</p>
    </c:if>
</div>
<footer class="footer">
  		<p>&copy; 2024 Inventory Management System | Version 1.0</p>
	</footer>
</body>
</html>
