package com.app.inventory.service;

import com.app.inventory.model.Item;
import com.app.inventory.repository.ItemRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class ItemService {

	@Autowired
	private ItemRepository itemRepository;

	// Get all items
	public List<Item> getAllItems() {
		return itemRepository.findAll();
	}

	// Get an item by ID
	public Optional<Item> getItemById(Long id) {
		return itemRepository.findById(id);
	}

	// Add an item
	public Item addItem(Item item) {
		return itemRepository.save(item);
	}

	// Update an item
	public Item updateItem(Long id, Item item) {
		if (itemRepository.existsById(id)) {
			item.setId(id);
			return itemRepository.save(item);
		}
		return null; // Return null if the item doesn't exist
	}

	// Delete an item
	public void deleteItem(Long id) {
		itemRepository.deleteById(id);
	}

	// Get items by name (for search functionality)
	public List<Item> getItemsByName(String name) {
		return itemRepository.findByNameContainingIgnoreCase(name); // Custom method to search by name
	}
}