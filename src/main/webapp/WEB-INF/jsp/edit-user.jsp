<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %> <!-- Set page language and encoding -->
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %> <!-- Import Spring Form tag library for form binding -->
<%@ include file="/WEB-INF/jsp/sidebar.jsp" %> <!-- Include sidebar.jsp for the navigation menu -->

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"> <!-- Set character encoding to UTF-8 for proper text rendering -->
    <meta name="viewport" content="width=device-width, initial-scale=1.0"> <!-- Ensure responsive design -->
    <link rel="stylesheet" type="text/css" href="/css/edit-user.css"> <!-- Link to external CSS for styling the edit user page -->
    <title>Inventory Management System</title> <!-- Set the title of the page -->
    
    <script>
    // Function to generate and display a temporary password
    function resetPassword() {
        var temporaryPassword = generateTemporaryPassword(); // Generate the password
        var passwordField = document.getElementById('password');
        passwordField.value = temporaryPassword; // Set the temporary password in the password field
        passwordField.type = 'text'; // Change the input field type to 'text' to show the password

        // Make the password field read-only to prevent editing
        passwordField.readOnly = true;

        // Store the temporary password in a hidden field for form submission
        document.getElementById('temporaryPassword').value = temporaryPassword;

        // Disable the reset password button and apply grayed-out styling
        var resetButton = document.getElementById('resetPasswordBtn');
        resetButton.disabled = true; // Disable the button
        resetButton.style.backgroundColor = 'gray'; // Change background color to gray
        resetButton.style.cursor = 'not-allowed'; // Change cursor to indicate disabled
        resetButton.style.opacity = '0.6'; // Reduce opacity for a disabled look
    }

    // Function to generate a random temporary password
    function generateTemporaryPassword() {
        const upperCase = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
        const lowerCase = 'abcdefghijklmnopqrstuvwxyz';
        const digits = '0123456789';
        const symbols = '@$!%*?&';

        const allCharacters = upperCase + lowerCase + digits + symbols;
        let password = '';
        password += upperCase[Math.floor(Math.random() * upperCase.length)];
        password += lowerCase[Math.floor(Math.random() * lowerCase.length)];
        password += digits[Math.floor(Math.random() * digits.length)];
        password += symbols[Math.floor(Math.random() * symbols.length)];

        while (password.length < 8) {
            password += allCharacters[Math.floor(Math.random() * allCharacters.length)];
        }

        password = password.split('').sort(() => Math.random() - 0.5).join('');  // Shuffle password characters
        return password; // Return the generated password
    }
    </script>
</head>
<body>
    <h1 id="title">Edit User</h1> <!-- Page title -->

    <!-- Spring form binding to edit the user's details -->
    <form:form action="/maintenance/edit/${user.id}" method="post" id="form" modelAttribute="user">
        
        <!-- Username Field (Read-only) -->
        <label for="username">Username</label>
        <form:input type="text" path="username" id="username" placeholder="Username" class="readonly-input" readonly="true" />
        <form:errors path="username" cssClass="error" /> <!-- Display any validation errors for the username field -->

        <!-- Password Field (Read-only) -->
        <label for="password">Password</label>
        <form:input type="password" path="password" id="password" placeholder="Temporary password" class="readonly-input" readonly="true"/>
        <!-- Hidden input to store the temporary password for backend processing -->
        <form:hidden path="temporaryPassword" id="temporaryPassword" />
        <form:errors path="password" cssClass="error" /> <!-- Display any validation errors for the password field -->
        
        <!-- Role Field (Editable) -->
        <label for="role">Role</label>
        <form:select path="role" id="role">
            <form:option value="user" label="User" /> <!-- Option for regular user role -->
            <form:option value="admin" label="Admin" /> <!-- Option for admin role -->
        </form:select>
        <form:errors path="role" cssClass="error" /> <!-- Display any validation errors for the role field -->
        
        <!-- Reset Password Button (Generates a temporary password) -->
        <button type="button" id="resetPasswordBtn" onclick="resetPassword()">Generate Temporary Password</button>
        
        <!-- Submit Button to save the changes -->
        <button type="submit" id="submit">Save</button>
    </form:form>

    <footer class="footer">
        <p>&copy; 2024 Inventory Management System | Version 1.0</p> <!-- Footer information -->
    </footer>
</body>
</html>
