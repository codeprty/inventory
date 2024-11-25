<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" type="text/css" href="/css/register.css">
    <title>Register</title>
</head>
<body>
    <h1 id="title">Register</h1>

    <!-- Use the correct modelAttribute, i.e., 'user' -->
    <form:form action="/register" method="post" id="form" modelAttribute="user">
        <label for="username">Username</label>
        <form:input type="text" path="username" id="username" placeholder="Type your username here" required="true"/>
        <form:errors path="username" cssClass="error" />

        <label for="password">Password</label>
        <form:input type="password" path="password" id="password" placeholder="Type your password here" required="true"/>
        <form:errors path="password" cssClass="error" />

        <button type="submit" id="submit">Register</button>
    </form:form>

    <footer class="footer">
        <p>&copy; 2024 Inventory Management System | Version 1.0</p>
    </footer>
</body>
</html>
