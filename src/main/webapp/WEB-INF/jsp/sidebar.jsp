<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> <!-- Import JSTL core library for conditional rendering -->
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> <!-- Import JSTL formatting library (though not used in this snippet) -->
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"> <!-- Set character encoding to UTF-8 for proper text rendering -->
    <meta name="viewport" content="width=device-width, initial-scale=1.0"> <!-- Make the page responsive on all devices -->
    <link rel="stylesheet" type="text/css" href="/css/sidebar.css"> <!-- Link to external CSS for styling the sidebar -->
    <title>Inventory Management</title> <!-- Set the title of the page for the browser tab -->
</head>
<body>
    <!-- Navbar Section -->
    <div id="navbar">
        <!-- Hamburger Icon Button: Used for toggling the sidebar visibility on small screens -->
        <button class="toggle-btn" id="toggle-btn">
            &#9776; <!-- Unicode character for the hamburger icon (three horizontal lines) -->
        </button>

        <!-- Sidebar Navigation Menu -->
        <nav id="sidebar">
            <ul>
                <!-- Navigation Links -->
                <li><a href="${pageContext.request.contextPath}/home">Home</a></li> <!-- Link to the Home page -->
                <li><a href="${pageContext.request.contextPath}/items">All Items</a></li> <!-- Link to the Items list page -->
                <li><a href="${pageContext.request.contextPath}/items/add">New Item</a></li> <!-- Link to add a new item -->
                
                <!-- Admin-only Maintenance Link: This will be rendered only if the session role is 'admin' -->
                <c:if test="${sessionScope.role == 'admin'}">
                    <li><a href="${pageContext.request.contextPath}/maintenance">Maintenance</a></li> <!-- Link to the maintenance page -->
                </c:if>

                <li><a href="${pageContext.request.contextPath}/items/logout">Logout</a></li> <!-- Link to logout -->
            </ul>
        </nav>
    </div>

    <!-- JavaScript to handle sidebar toggle behavior -->
    <script>
        // Add event listener to the hamburger menu button
        document.getElementById('toggle-btn').addEventListener('click', function() {
            var sidebar = document.getElementById('sidebar');  // Get the sidebar element
            var body = document.body;  // Get the body element
            
            // Toggle 'active' class on the sidebar to show/hide it
            sidebar.classList.toggle('active');
            // Toggle 'sidebar-active' class on the body to adjust content padding when the sidebar is active
            body.classList.toggle('sidebar-active');
        });
    </script>  
</body>
</html>
