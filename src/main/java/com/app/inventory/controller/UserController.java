package com.app.inventory.controller;

import com.app.inventory.service.UserService;
import com.app.inventory.model.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.validation.BindingResult;

@Controller
public class UserController {

    @Autowired
    private UserService userService;

    // Registration form
    @GetMapping("/register")
    public String showRegistrationForm(Model model) {
        model.addAttribute("user", new User()); // Add an empty User object to the model for binding
        return "register";
    }

    // Handle registration
    @PostMapping("/register")
    public String registerUser(@ModelAttribute("user") User user, BindingResult result, Model model) {
        // Validate username
        if (user.getUsername() == null || user.getUsername().trim().isEmpty() || user.getUsername().contains(" ") || user.getUsername().length() < 3) {
            result.rejectValue("username", "error.username", "Username must be at least 3 characters and cannot contain spaces!");
        }

        // Validate password (at least 8 characters, mix of uppercase, lowercase, numbers, symbols)
        String passwordPattern = "^(?=.*[A-Z])(?=.*[a-z])(?=.*\\d)(?=.*[@$!%*?&])[A-Za-z\\d@$!%*?&]{8,}$";
        if (user.getPassword() == null || !user.getPassword().matches(passwordPattern)) {
            result.rejectValue("password", "error.password", "Password must be at least 8 characters long and include a mix of uppercase, lowercase, numbers, and symbols.");
        }

        // If errors found, return to the form
        if (result.hasErrors()) {
            return "register";
        }

        // Register the user
        String resultMessage = userService.registerUser(user.getUsername(), user.getPassword());
        if (resultMessage.equals("Registration successful!")) {
            model.addAttribute("message", "Account registration successful. You may now log in.");
            return "login"; // Redirect to login page after successful registration
        } else {
            model.addAttribute("error", resultMessage);
            return "register"; // Stay on the registration page if there was an error
        }
    }

    // Login form
    @GetMapping("/login")
    public String showLoginForm(Model model) {
        model.addAttribute("user", new User()); // Add an empty User object to the model for binding
        return "login";
    }

    // Handle login
    @PostMapping("/login")
    public String loginUser(@ModelAttribute("user") User user, BindingResult result, Model model) {
        if (user.getUsername() == null || user.getUsername().trim().isEmpty() || user.getPassword() == null || user.getPassword().isEmpty()) {
            result.reject("login.error", "Invalid username or password!");
            return "login";
        }

        boolean isAuthenticated = userService.authenticate(user.getUsername(), user.getPassword());
        if (isAuthenticated) {
            return "home"; // Redirect to home.jsp upon successful login
        } else {
            result.reject("login.error", "Invalid username or password!");
            return "login"; // Stay on the login page with error message
        }
    }
}
