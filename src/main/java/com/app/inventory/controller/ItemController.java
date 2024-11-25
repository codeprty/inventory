package com.app.inventory.controller;

import com.app.inventory.model.Item;
import com.app.inventory.service.ItemService;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.PathVariable;

import java.util.List;

@Controller
public class ItemController {

    @Autowired
    private ItemService itemService;

    // Home page (not necessary for item management, but may be part of the application)
    @GetMapping("/home")
    public String home(Model model) {
        return "home";
    }

    // Show list of items, with search functionality
    @GetMapping("/items")
    public String getItems(
        @RequestParam(value = "search", required = false) String search,
        @RequestParam(value = "action", required = false, defaultValue = "search") String action,
        Model model) {

        List<Item> items;

        if ("clear".equals(action)) {
            // Reset search and show all items
            items = itemService.getAllItems();
            model.addAttribute("search", "");          // Clear search box
            model.addAttribute("isSearchActive", false); // Revert to "Search" button
        } else if (search != null && !search.trim().isEmpty()) {
            // Perform search
            items = itemService.getItemsByName(search);
            model.addAttribute("search", search);       // Retain search term
            model.addAttribute("isSearchActive", true);  // Display "Clear" button
        } else {
            // Default state: show all items
            items = itemService.getAllItems();
            model.addAttribute("search", "");          // Clear search box
            model.addAttribute("isSearchActive", false); // Revert to "Search" button
        }

        model.addAttribute("items", items);
        return "list"; // Return the JSP view
    }

    // Show form to add a new item
    @GetMapping("/items/add")
    public String showAddItemForm(Model model) {
        model.addAttribute("item", new Item()); // Provide an empty Item object for the form
        return "add"; // Ensure there's an add.jsp to display the form
    }

    // Add new item with validation
    @PostMapping("/items/add")
    public String addItem(@Valid Item item, BindingResult bindingResult, Model model) {
        if (bindingResult.hasErrors()) {
            // If validation errors exist, return to the "add" page with errors
            return "add"; // You may need to return the same "add.jsp" form with validation error messages
        }
        itemService.addItem(item); // Add the item to the database
        return "redirect:/items"; // Redirect to items list page after adding
    }

    // Show form to edit an existing item
    @GetMapping("/items/edit/{id}")
    public String showEditItemForm(@PathVariable Long id, Model model) {
        Item item = itemService.getItemById(id).orElse(null); // Fetch the item by id
        model.addAttribute("item", item); // Add the item to the model
        return "edit"; // edit.jsp to edit item
    }

    // Handle updating an existing item
    @PostMapping("/items/edit/{id}")
    public String editItem(@PathVariable Long id, @Valid Item item, BindingResult bindingResult) {
        if (bindingResult.hasErrors()) {
            // If validation errors exist, return to the "edit" page with errors
            return "edit"; // This would need an edit.jsp to handle errors
        }
        itemService.updateItem(id, item); // Update item
        return "redirect:/items"; // Redirect to list page after updating
    }

 // GET request to show confirmation page
    @GetMapping("/items/confirmDelete/{id}")
    public String confirmDelete(@PathVariable Long id, Model model) {
        Item item = itemService.getItemById(id).orElse(null); // Fetch the item by id
        if (item == null) {
            return "redirect:/items"; // Redirect if item is not found
        }
        model.addAttribute("item", item); // Add item to the model for confirmation page
        return "delete"; // Return confirmation page (delete.jsp)
    }

    // POST request to actually delete the item
    @PostMapping("/items/delete/{id}")
    public String deleteItem(@PathVariable Long id) {
        itemService.deleteItem(id); // Delete the item by id
        return "redirect:/items"; // Redirect to items list after deletion
    }
}
