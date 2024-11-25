<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> <!-- Added JSTL taglib declaration -->

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" type="text/css" href="/css/login.css">
    <title>Login</title>
</head>
<body>
    <h1 id="title">Login</h1>

    <form:form action="/login" method="post" modelAttribute="user" id="form">

        <label for="username">Username</label>
        <form:input type="text" path="username" id="username" placeholder="Type your username here" required="true"/>
        <form:errors path="username" cssClass="error" />

        <label for="password">Password</label>
        <form:input type="password" path="password" id="password" placeholder="Type your password here" required="true"/>
        <form:errors path="password" cssClass="error" />

        <!-- Displaying the success message passed from the controller -->
        <c:if test="${not empty message}">
            <div class="alert alert-success">
                ${message}
            </div>
        </c:if>

        <button type="submit" id="submit">Login</button>
    </form:form>

    <!-- Registration prompt -->
    <div id="register-prompt">
        <p>Don't have an account? <a href="/register">Register here</a></p>
    </div>

    <footer class="footer">
        <p>&copy; 2024 Inventory Management System | Version 1.0</p>
    </footer>
</body>
</html>
