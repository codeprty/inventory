<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/jsp/sidebar.jsp" %> <!-- Include the sidebar for navigation -->

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0"> <!-- Responsive meta tag -->
    <link rel="stylesheet" type="text/css" href="/css/home.css"> <!-- Link to the CSS file for styling -->
    <title>Home - Inventory Management</title> <!-- Page title -->
</head>
<body>
    <!-- Main container for the home page content -->
    <div class="container">
        <h1>Welcome to the Inventory Management System</h1> <!-- Main heading -->
        <p>This web application allows you to manage items in your inventory. You can:</p>
        <ul>
            <li><strong>View all items</strong> in the inventory.</li> <!-- Feature description -->
            <li><strong>Add new items</strong> to your inventory.</li> <!-- Feature description -->
            <li><strong>Edit</strong> or <strong>delete</strong> existing items.</li> <!-- Feature description -->
        </ul>
        <p>Use the navigation menu to get started.</p> <!-- Instruction for navigation -->
    </div>

    <!-- Footer section -->
    <footer class="footer">
        <p>&copy; 2024 Inventory Management System | Version 1.0</p> <!-- Footer text -->
    </footer>
</body>
</html>
