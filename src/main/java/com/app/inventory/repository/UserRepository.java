package com.app.inventory.repository;

import com.app.inventory.model.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

// Repository interface that extends JpaRepository for CRUD operations
@Repository
public interface UserRepository extends JpaRepository<User, Long> {

    // Check if a username already exists (Spring Data JPA provides this)
    boolean existsByUsername(String username);

    // Search for users by a partial username match
    List<User> findByUsernameContaining(String search);

    // Find a user by their username (Spring Data JPA provides this)
    Optional<User> findByUsername(String username);

    // Count the total number of users (Spring Data JPA provides this as well)
    long count();
}
