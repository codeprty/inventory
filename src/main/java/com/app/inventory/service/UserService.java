package com.app.inventory.service;

import com.app.inventory.model.User;
import com.app.inventory.repository.UserRepository;
import com.app.inventory.utils.PasswordUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class UserService {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private PasswordUtil passwordUtil;

    // Validate and register a new user
    public String registerUser(String username, String password) {
        if (username == null || username.trim().isEmpty()) {
            return "Username cannot be empty!";
        }

        if (password == null || password.isEmpty()) {
            return "Password cannot be empty!";
        }

        // Check if username already exists
        if (userRepository.usernameExists(username)) {
            return "Username already exists!";
        }

        // Check if password is at least 8 characters
        if (password.length() < 8) {
            return "Password must be at least 8 characters long!";
        }

        // Hash the password
        String encodedPassword = passwordUtil.encodePassword(password);

        // Determine role (admin for the first user, user for others)
        String role = userRepository.getUserCount() == 0 ? "admin" : "user"; // Inline role assignment

        // Create the new user
        User newUser = new User();
        newUser.setUsername(username);
        newUser.setPassword(encodedPassword);
        newUser.setRole(role);

        // Save the user to the database
        userRepository.saveUser(newUser);

        return "Registration successful!";
    }

    // Authenticate user (for login)
    public boolean authenticate(String username, String password) {
        if (username == null || username.trim().isEmpty() || password == null || password.isEmpty()) {
            return false; // Handle invalid inputs
        }

        User user = userRepository.findByUsername(username);
        return user != null && passwordUtil.matches(password, user.getPassword());
    }
}
