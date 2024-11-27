<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ include file="/WEB-INF/jsp/sidebar.jsp" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" type="text/css" href="/css/edit-user.css">
    <title>Inventory Management System</title>
</head>
<body>
    <h1 id="title">Edit User</h1>
    
    <!-- Use form:form for Spring form binding with pre-populated values -->
    <form:form action="/maintenance/edit/${user.id}" method="post" id="form" modelAttribute="user">
        
        <!-- Username Field -->
        <label for="username">Username</label>
        <form:input type="text" path="username" id="username" placeholder="Type username here" required="true" readonly="true"/>
        <form:errors path="username" cssClass="error" />

        <!-- Password Field -->
        <label for="password">Password</label>
        <form:input type="password" path="password" id="password" placeholder="Type new password here" required="false"/>
        <form:errors path="password" cssClass="error" />

        <!-- Role Field -->
        <label for="role">Role</label>
        <form:select path="role" id="role">
            <form:option value="user" label="User" />
            <form:option value="admin" label="Admin" />
        </form:select>
        <form:errors path="role" cssClass="error" />

        <button type="submit" id="submit">Update</button>
    </form:form>

    <footer class="footer">
        <p>&copy; 2024 Inventory Management System | Version 1.0</p>
    </footer>
</body>
</html>
