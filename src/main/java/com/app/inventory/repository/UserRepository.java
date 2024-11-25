package com.app.inventory.repository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.stereotype.Repository;
import com.app.inventory.model.User;

@Repository
public class UserRepository {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    // Method to check if username already exists
    public boolean usernameExists(String username) {
        String query = "SELECT COUNT(*) FROM user WHERE username = ?";
        Integer count = jdbcTemplate.queryForObject(query, Integer.class, username);
        return count != null && count > 0;
    }

    // Method to save a new user
    public void saveUser(User user) {
        String query = "INSERT INTO user (username, password, role) VALUES (?, ?, ?)";
        jdbcTemplate.update(query, user.getUsername(), user.getPassword(), user.getRole());
    }

    // Method to get a user by username
    public User findByUsername(String username) {
        String query = "SELECT * FROM user WHERE username = ?";
        try {
            return jdbcTemplate.queryForObject(query, (rs, rowNum) -> 
                new User(
                    rs.getLong("id"),
                    rs.getString("username"),
                    rs.getString("password"),
                    rs.getString("role")
                ), username);
        } catch (EmptyResultDataAccessException e) {
            return null; // Return null if no result is found
        }
    }

    // Method to count total users in the database
    public int getUserCount() {
        String query = "SELECT COUNT(*) FROM user";
        Integer count = jdbcTemplate.queryForObject(query, Integer.class);
        return count != null ? count : 0;
    }
}
