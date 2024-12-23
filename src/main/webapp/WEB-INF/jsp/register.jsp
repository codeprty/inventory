<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" type="text/css" href="/css/register.css"> <!-- Linking external stylesheet -->
    <title>Register</title>
</head>
<body>
    <h1 id="title">Register</h1>
    
    <!-- Success message displayed if there's any -->
    <c:if test="${not empty message}">
        <div class="success-message">
            ${message} <!-- Display message passed from controller -->
        </div>
    </c:if>

    <!-- Registration form to capture user details -->
    <form:form action="/register" method="post" id="form" modelAttribute="user">
        
        <label for="username">Username</label>
        <form:input type="text" path="username" id="username" placeholder="Type your username here" required="true"/>
        <form:errors path="username" cssClass="error" /> <!-- Display username validation errors -->

        <label for="password">Password</label>
        <form:input type="password" path="password" id="password" placeholder="Type your password here" required="true"/>
        <form:errors path="password" cssClass="error" /> <!-- Display password validation errors -->

        <button type="submit" id="submit">Register</button> <!-- Register button -->

    </form:form>

    <footer class="footer">
        <p>&copy; 2024 Inventory Management System | Version 1.0</p>
    </footer>
</body>
</html>
