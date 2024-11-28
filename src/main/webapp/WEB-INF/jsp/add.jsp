<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %> <!-- Spring Form Tag Library -->
<%@ include file="/WEB-INF/jsp/sidebar.jsp" %> <!-- Include the sidebar for navigation -->

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0"> <!-- Responsive meta tag -->
    <link rel="stylesheet" type="text/css" href="/css/item.css"> <!-- Link to CSS for styling the form -->
    <title>New Item - Inventory Management</title>
</head>
<body>
    <h1 id="title">New Item</h1> <!-- Page heading -->

    <!-- Form to add a new item -->
    <form:form action="/items/add" method="post" id="form" modelAttribute="item">
        <!-- Name field -->
        <label for="name">Name</label>
        <form:input 
            type="text" 
            path="name" 
            id="name" 
            placeholder="Type item name here" 
            required="true"
        />
        <form:errors path="name" cssClass="error" /> <!-- Validation errors for name -->

        <!-- Description field -->
        <label for="description">Description</label>
        <form:textarea 
            path="description" 
            id="description" 
            rows="3" 
            cols="21" 
            placeholder="Type item description here" 
            required="true"
        />
        <form:errors path="description" cssClass="error" /> <!-- Validation errors for description -->

        <!-- Price field -->
        <label for="price">Price</label>
        <form:input 
            type="number" 
            step="0.01" 
            path="price" 
            id="price" 
            placeholder="Type item price here" 
            required="true"
        />
        <form:errors path="price" cssClass="error" /> <!-- Validation errors for price -->

        <!-- Quantity field -->
        <label for="quantity">Quantity</label>
        <form:input 
            type="number" 
            path="quantity" 
            id="quantity" 
            placeholder="Type item quantity here" 
            required="true"
        />
        <form:errors path="quantity" cssClass="error" /> <!-- Validation errors for quantity -->

        <!-- Submit button -->
        <button type="submit" id="submit">Add</button>
    </form:form>

    <!-- Footer section -->
    <footer class="footer">
        <p>&copy; 2024 Inventory Management System | Version 1.0</p> <!-- Footer text -->
    </footer>
</body>
</html>
