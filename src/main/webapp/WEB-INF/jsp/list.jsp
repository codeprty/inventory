<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> <!-- JSTL Core Tag Library -->
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> <!-- JSTL Formatting Tag Library -->
<%@ include file="/WEB-INF/jsp/sidebar.jsp" %> <!-- Include the sidebar for navigation -->

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0"> <!-- Responsive meta tag -->
    <link rel="stylesheet" type="text/css" href="/css/list.css"> <!-- Link to CSS for styling the list -->
    <title>Inventory Management System</title> <!-- Page title -->
</head>
<body>
    <h1 id="title">Item List</h1> <!-- Page heading -->

    <!-- Search Form -->
    <form id="search-form" method="get" action="${pageContext.request.contextPath}/items">
        <!-- Input for searching items by name -->
        <input 
            type="text" 
            id="search-bar" 
            name="search" 
            placeholder="Search by item name" 
            value="${search}" 
        />

        <!-- Hidden input to toggle between search and clear actions -->
        <input type="hidden" name="action" value="${isSearchActive ? 'clear' : 'search'}" />

        <!-- Button to search or clear the search -->
        <button type="submit" id="search-clear-btn">
            ${isSearchActive ? 'Clear' : 'Search'} <!-- Dynamically displays 'Clear' or 'Search' -->
        </button>
    </form>

    <!-- Table for listing items -->
    <div id="list-container">
        <table>
            <thead>
                <!-- Table header defining the columns -->
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
                <!-- Loop through the list of items and display them in rows -->
                <c:forEach var="item" items="${items}">
                    <tr>
                        <td>${item.id}</td> <!-- Display item ID -->
                        <td>${item.name}</td> <!-- Display item name -->
                        <td>${item.description}</td> <!-- Display item description -->
                        <td>${item.price}</td> <!-- Display item price -->
                        <td>${item.quantity}</td> <!-- Display item quantity -->
                        <td>
                            <!-- Edit button linking to the edit page for the item -->
                            <a href="${pageContext.request.contextPath}/items/edit/${item.id}" class="action-btn" id="edit-btn">Edit</a>
                            <!-- Delete button linking to the delete confirmation page for the item -->
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

    <!-- Footer section -->
    <footer class="footer">
        <p>&copy; 2024 Inventory Management System | Version 1.0</p> <!-- Footer text -->
    </footer>
</body>
</html>
