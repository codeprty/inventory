<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ include file="/WEB-INF/jsp/sidebar.jsp" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" type="text/css" href="/css/item.css">
    <title>Inventory Management System</title>
</head>
<body>
    <h1 id="title">Edit Item</h1>
    
    <!-- Use form:form for Spring form binding with pre-populated values -->
    <form:form action="/items/edit/${item.id}" method="post" id="form" modelAttribute="item">
        
        <label for="name">Name</label>
        <form:input type="text" path="name" id="name" placeholder="Type item name here" required="true"/>
        <form:errors path="name" cssClass="error" />

        <label for="description">Description</label>
        <form:textarea path="description" id="description" rows="3" cols="21" placeholder="Type item description here" required="true"/>
        <form:errors path="description" cssClass="error" />

        <label for="price">Price</label>
        <form:input type="number" step="0.01" path="price" id="price" placeholder="Type item price here" required="true"/>
        <form:errors path="price" cssClass="error" />

        <label for="quantity">Quantity</label>
        <form:input type="number" path="quantity" id="quantity" placeholder="Type item quantity here" required="true"/>
        <form:errors path="quantity" cssClass="error" />

        <button type="submit" id="submit">Update</button>
    </form:form>

    <footer class="footer">
        <p>&copy; 2024 Inventory Management System | Version 1.0</p>
    </footer>
</body>
</html>
