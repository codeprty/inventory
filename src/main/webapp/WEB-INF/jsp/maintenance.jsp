<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %> <!-- Set page language and encoding -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> <!-- Import JSTL core library for conditional rendering and iteration -->
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> <!-- Import JSTL formatting library (not used here but included for completeness) -->
<%@ include file="/WEB-INF/jsp/sidebar.jsp" %> <!-- Include sidebar.jsp for the navigation menu -->

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"> <!-- Set character encoding to UTF-8 for proper text rendering -->
    <meta name="viewport" content="width=device-width, initial-scale=1.0"> <!-- Ensure responsive design -->
    <link rel="stylesheet" type="text/css" href="/css/maintenance.css"> <!-- Link to external CSS for styling the maintenance page -->
    <title>User Account List</title> <!-- Set the title of the page -->
</head>
<body>
    <h1 id="title">User Account List</h1> <!-- Title for the maintenance page -->

    <!-- Search Form: Allows admins to search for users by username -->
    <form id="search-form" method="get" action="${pageContext.request.contextPath}/maintenance">
        <input 
            type="text" 
            id="search-bar" 
            name="search" 
            placeholder="Search by username" 
            value="${search}" /> <!-- Input field for entering the search term -->
        
        <input type="hidden" name="action" value="${isSearchActive ? 'clear' : 'search'}" /> <!-- Hidden input to distinguish between search and clear actions -->

        <!-- Search/Clear Button: Dynamically changes text based on whether a search is active -->
        <button type="submit" id="search-clear-btn">
            ${isSearchActive ? 'Clear' : 'Search'}
        </button>
    </form>

    <!-- List of Users: Displays a table of user accounts -->
    <div id="list-container">
        <table>
            <thead>
                <tr>
                    <th>ID</th> <!-- Table header for user ID -->
                    <th>Username</th> <!-- Table header for username -->
                    <th>Role</th> <!-- Table header for user role -->
                    <th>Actions</th> <!-- Table header for actions (Edit/Delete) -->
                </tr>
            </thead>
            <tbody>
                <!-- Iterates over the users list and displays each user's details -->
                <c:forEach var="user" items="${users}">
                    <tr>
                        <td>${user.id}</td> <!-- Display user ID -->
                        <td>${user.username}</td> <!-- Display username -->
                        <td>${user.role}</td> <!-- Display user role -->
                        <td>
                            <!-- Edit Link: Navigates to the edit page for the selected user -->
                            <a href="${pageContext.request.contextPath}/maintenance/edit/${user.id}" class="action-btn" id="edit-btn">Edit</a>
                            <!-- Delete Link: Navigates to the delete confirmation page for the selected user -->
                            <a href="${pageContext.request.contextPath}/maintenance/confirmDelete/${user.id}" class="action-btn" id="delete-btn">Delete</a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>

        <!-- Display a message if no users are found -->
        <c:if test="${empty users}">
            <p>No users found.</p> <!-- Display a message when there are no users to show -->
        </c:if>
    </div>

    <footer class="footer">
        <p>&copy; 2024 Inventory Management System | Version 1.0</p> <!-- Footer information -->
    </footer>
</body>
</html>