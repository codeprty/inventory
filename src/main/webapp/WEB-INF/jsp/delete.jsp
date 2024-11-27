<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500&display=swap" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/delete.css">
    <title>Confirm Deletion</title>
</head>
<body>
    <div id="confirmation-container">
        <h1>Confirm Deletion</h1>
        
        <!-- Display name based on the context (item or user) -->
        <c:choose>
            <c:when test="${not empty item}">
                <p>Are you sure you want to delete the item: <strong>${item.name}</strong>?</p>
            </c:when>
            <c:otherwise>
                <p>Are you sure you want to delete the user: <strong>${user.username}</strong>?</p>
            </c:otherwise>
        </c:choose>

        <!-- Confirm Deletion Form -->
        <form method="post" 
              action="<c:choose>
                        <c:when test='${not empty item}'>
                            ${pageContext.request.contextPath}/items/delete/${item.id}
                        </c:when>
                        <c:otherwise>
                            ${pageContext.request.contextPath}/maintenance/delete/${user.id}
                        </c:otherwise>
                    </c:choose>">
            <div class="action-buttons">
                <button type="submit" id="confirm-delete-btn">Yes, Delete</button>
                <!-- Cancel Button redirects back to the appropriate list page -->
                <a href="<c:choose>
                            <c:when test='${not empty item}'>
                                ${pageContext.request.contextPath}/items
                            </c:when>
                            <c:otherwise>
                                ${pageContext.request.contextPath}/maintenance
                            </c:otherwise>
                          </c:choose>" 
                   id="cancel-btn">No, Cancel</a>
            </div>
        </form>
    </div>
</body>
</html>
