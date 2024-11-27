package com.app.inventory.controller;

import com.app.inventory.service.UserService;
import jakarta.servlet.http.HttpServletRequest;
import com.app.inventory.model.User;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
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
    public String registerUser(@ModelAttribute("user") User user, BindingResult result, Model model, RedirectAttributes redirectAttributes) {
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
            // Use RedirectAttributes to pass message on redirect
            redirectAttributes.addFlashAttribute("message", "Account registration successful. You may now log in.");
            return "redirect:/login"; // Redirect to login page after successful registration
        } else {
            // Check if the error is "Username already exists!" and reject the value
            if (resultMessage.equals("Username already exists!")) {
                result.rejectValue("username", "error.username", "Username already exists!");
            }
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
    public String loginUser(@ModelAttribute("user") User user, BindingResult result, Model model, HttpServletRequest request) {
        if (user.getUsername() == null || user.getUsername().trim().isEmpty() || user.getPassword() == null || user.getPassword().isEmpty()) {
            result.reject("login.error", "Invalid username or password!");
            return "login"; // BindingResult will carry the error to the view
        }

        boolean isAuthenticated = userService.authenticate(user.getUsername(), user.getPassword());
        if (isAuthenticated) {
            // Get user role and set it in the session
            User loggedInUser = userService.findByUsername(user.getUsername()); // Fetch user details from DB
            if (loggedInUser != null) {
                System.out.println("User authenticated: " + loggedInUser.getUsername() + " Role: " + loggedInUser.getRole());
                request.getSession().setAttribute("role", loggedInUser.getRole()); // Directly set role in session
            }

            return "redirect:/home"; // Ensure to redirect with the correct path
        } else {
            result.reject("login.error", "Invalid username or password!");
            return "login"; // Stay on the login page with the error
        }
    }


    @GetMapping("/maintenance")
    public String getUsers(
        @RequestParam(value = "search", required = false) String search,
        @RequestParam(value = "action", required = false, defaultValue = "search") String action,
        Model model) {

        List<User> users;

        if ("clear".equals(action)) {
            // Reset search and show all users
            users = userService.getAllUsers(null);
            model.addAttribute("search", "");          // Clear search box
            model.addAttribute("isSearchActive", false); // Revert to "Search" button
        } else if (search != null && !search.trim().isEmpty()) {
            // Perform search
            users = userService.getAllUsers(search);
            model.addAttribute("search", search);       // Retain search term
            model.addAttribute("isSearchActive", true);  // Display "Clear" button
        } else {
            // Default state: show all users
            users = userService.getAllUsers(null);
            model.addAttribute("search", "");          // Clear search box
            model.addAttribute("isSearchActive", false); // Revert to "Search" button
        }

        model.addAttribute("users", users);  // Add list of users to the model
        return "maintenance"; // Return the maintenance page view
    }
    
    // GET request to show confirmation page for user deletion
    @GetMapping("/maintenance/confirmDelete/{id}")
    public String confirmDelete(@PathVariable Long id, Model model) {
        // Fetch the user by id
        User user = userService.getUserById(id).orElse(null);
        
        if (user == null) {
            return "redirect:/maintenance"; // Redirect if user is not found
        }
        
        model.addAttribute("user", user); // Add user to the model for confirmation page
        return "delete"; // Return confirmation page (delete.jsp)
    }

    // POST request to delete the user
    @PostMapping("/maintenance/delete/{id}")
    public String deleteUser(@PathVariable Long id) {
        userService.deleteUser(id); // Delete the user by id
        return "redirect:/maintenance"; // Redirect to user maintenance page after deletion
    }

    // Logout method (corrected)
    @GetMapping("/items/logout")
    public String logout(HttpServletRequest request) {
        // Invalidate the session to log the user out
        request.getSession().invalidate();

        // Redirect to the login page
        return "redirect:/login";
    }
    
    // Edit User (GET method to show the form)
    @GetMapping("/maintenance/edit/{id}")
    public String showEditUserForm(@PathVariable Long id, Model model) {
        User user = userService.findById(id);
        if (user == null) {
            // Handle user not found
            return "redirect:/maintenance"; // Or show an error page
        }
        model.addAttribute("user", user);  // Add user to the model for the form
        return "edit-user";  // Ensure this corresponds to your JSP
    }

    // Update User (POST method to save the changes)
    @PostMapping("/maintenance/edit/{id}")
    public String editUser(@PathVariable Long id, @ModelAttribute("user") User user, BindingResult result) {
        if (result.hasErrors()) {
            return "edit-user";  // Return to form if there are validation errors
        }

        // Save the updated user
        User existingUser = userService.findById(id);
        if (existingUser != null) {
            existingUser.setUsername(user.getUsername());
            existingUser.setPassword(user.getPassword()); // Hash this password as necessary
            existingUser.setRole(user.getRole());

            // Update user in the database
            userService.saveUser(existingUser);
        }

        return "redirect:/maintenance";  // Redirect after successful update
    }
}
