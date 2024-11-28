package com.app.inventory.service;

import com.app.inventory.model.User;
import com.app.inventory.repository.UserRepository;
import com.app.inventory.utils.PasswordUtil;

import java.util.List;
import java.util.Optional;

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
		if (userRepository.existsByUsername(username)) {
			return "Username already exists!";
		}

		// Check if password is at least 8 characters
		if (password.length() < 8) {
			return "Password must be at least 8 characters long!";
		}

		// Hash the password using PasswordUtil
		String encodedPassword = passwordUtil.encodePassword(password);

		// Determine role (admin for the first user, user for others)
		String role = userRepository.count() == 0 ? "admin" : "user"; // Inline role assignment for first user

		// Create the new user
		User newUser = new User();
		newUser.setUsername(username);
		newUser.setPassword(encodedPassword);
		newUser.setRole(role);

		// Save the user to the database
		userRepository.save(newUser);

		return "Registration successful!";
	}

	// Find user by username
	public User findByUsername(String username) {
		Optional<User> userOptional = userRepository.findByUsername(username);
		return userOptional.orElse(null); // Safely return null if user not found
	}

	// Authenticate user (for login)
	public boolean authenticate(String username, String password) {
		if (username == null || username.trim().isEmpty() || password == null || password.isEmpty()) {
			return false; // Invalid username or password
		}

		User user = findByUsername(username); // Get user by username
		return user != null && passwordUtil.matches(password, user.getPassword()); // Check if password matches
	}

	// Convert temporary password to hashed password upon login
	public void convertToHashedPassword(User user) {
		// Hash the temporary password and update the user's password
		String hashedPassword = passwordUtil.encodePassword(user.getPassword());
		user.setPassword(hashedPassword); // Save the hashed password
		userRepository.save(user); // Update the user in the database
	}

	// Get a list of users (searchable by username)
	public List<User> getAllUsers(String search) {
		if (search != null && !search.trim().isEmpty()) {
			return userRepository.findByUsernameContaining(search); // Search by username
		}
		return userRepository.findAll(); // No search term, fetch all users
	}

	// Fetch user by ID
	public Optional<User> getUserById(Long id) {
		return userRepository.findById(id); // Fetch user by ID using JPA's built-in method
	}

	// Save or update user
	public void saveUser(User user) {
		userRepository.save(user); // Save or update the user
	}

	// Delete user by ID
	public void deleteUser(Long id) {
		userRepository.deleteById(id); // Delete the user by ID
	}

	// Find user by ID
	public User findById(Long id) {
		return userRepository.findById(id).orElse(null); // Handle user not found scenario
	}

	// Get all users for maintenance
	public List<User> getAllUsersForMaintenance(String search) {
		return getAllUsers(search); // Reuse the getAllUsers method for the maintenance page
	}

	public String resetPassword(Long id, String temporaryPassword) {
		Optional<User> userOptional = userRepository.findById(id);
		if (userOptional.isEmpty()) {
			return "User not found!";
		}

		User user = userOptional.get();

		// Hash the temporary password before saving it
		String hashedPassword = passwordUtil.encodePassword(temporaryPassword);
		user.setPassword(hashedPassword); // Save the hashed password

		userRepository.save(user); // Save the updated user
		return temporaryPassword; // Return the plain text temporary password for display (for admin only)
	}

}