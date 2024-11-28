package com.app.inventory.utils;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Component;

@Component
public class PasswordUtil {

	private final BCryptPasswordEncoder passwordEncoder;

	public PasswordUtil() {
		this.passwordEncoder = new BCryptPasswordEncoder(); // Default strength
	}

	// Encode password
	public String encodePassword(String password) {
		return passwordEncoder.encode(password); // Hash the password
	}

	// Match plain text password with encoded password
	public boolean matches(String rawPassword, String encodedPassword) {
		return passwordEncoder.matches(rawPassword, encodedPassword); // Check password match
	}
}