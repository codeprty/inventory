<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" type="text/css" href="/css/sidebar.css">
    <title>Inventory Management</title>
</head>
<body>
    <div id="navbar">
        <button class="toggle-btn" id="toggle-btn">
            &#9776; <!-- Hamburger Icon -->
        </button>
        <nav id="sidebar">
            <ul>
                <li><a href="${pageContext.request.contextPath}/home">Home</a></li>
                <li><a href="${pageContext.request.contextPath}/items">All Items</a></li>
                <li><a href="${pageContext.request.contextPath}/items/add">New Item</a></li>
            </ul>
        </nav>
    </div>
    <script>
    	document.getElementById('toggle-btn').addEventListener('click', function() {
        var sidebar = document.getElementById('sidebar');
        var body = document.body;
        
        sidebar.classList.toggle('active');  // Toggle sidebar visibility
        body.classList.toggle('sidebar-active');  // Toggle body padding for active sidebar
    	});
	</script>  
</body>
</html>

