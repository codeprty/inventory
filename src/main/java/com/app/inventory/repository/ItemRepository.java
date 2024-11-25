package com.app.inventory.repository;

import com.app.inventory.model.Item;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

public interface ItemRepository extends JpaRepository<Item, Long> {

    // Custom method to search for items by name (case-insensitive)
    List<Item> findByNameContainingIgnoreCase(String name);
}
