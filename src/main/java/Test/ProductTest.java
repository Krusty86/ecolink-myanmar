package Test;

import java.math.BigDecimal;

import dao.*;
import entity.*;
import enums.ProductStatus;

public class ProductTest {
	public static void main(String[] args) {
		// Supplier IDs from your request
        long[] supplierIds = {4L, 6L};
        
        // Corrected Category IDs: 1: Drinkware, 2: Tableware, 3: Food Storage, 4: Utensils, 5: Accessories
        long[] categoryIds = {1, 2, 3, 4, 5};
        
        String[] materials = {"Bamboo", "Rice Husk", "Wheat Straw", "Recycled Steel", "Coconut Shell"};
        
        // 20 Unique Eco-friendly products
        String[] productNames = {
            "Travel Coffee Mug", "Dinner Plate", "Bento Lunch Box", "Bamboo Straw Set", "Cotton Mesh Bag",
            "Insulated Cup", "Soup Bowl", "Stackable Tiffin", "Steel Spork", "Straw Cleaning Brush",
            "Smoothie Tumbler", "Salad Plate", "Glass Meal Prep Jar", "Chopsticks Set", "Eco Pouch",
            "Wine Goblet", "Noodle Bowl", "Sealed Food Container", "Dessert Spoon", "Reusable Bottle Bag"
        };

        System.out.println("Initializing EcoLink Product Seeding...");

        for (long supplierId : supplierIds) {
            User supplier = new User();
            supplier.setId(supplierId);

            for (int i = 0; i < 20; i++) {
                Product p = new Product();
                p.setUser(supplier);
                
                // Set Category based on your ID mapping
                Category cat = new Category();
                cat.setId(categoryIds[i % categoryIds.length]);
                p.setCategory(cat);

                // Set Product Details
                p.setName(productNames[i]);
                p.setMaterial_type(materials[i % materials.length]);
                
                // Impact: Random values between 0.15kg and 0.55kg plastic saved
                p.setPlastic_saved_per_unit(new BigDecimal("0." + (15 + i)));
                
                p.setStatus(ProductStatus.ACTIVE);
                p.setQty(50L); // Fixed stock as requested

                // Price: Range from 4,500 to 14,000 MMK
                p.setPrice(new BigDecimal(4500 + (i * 500)));

                // Call your Transactional Save Method
                Product result = ProductDAO.save(p);

                if (result != null) {
                    System.out.println("[SUCCESS] ID: " + result.getId() + " | " + result.getName() + " (Supplier " + supplierId + ")");
                } else {
                    System.err.println("[ERROR] Failed to save product at index " + i + " for User " + supplierId);
                }
            }
        }
        System.out.println("Seeding finished. 40 products added with initial pricing.");
    }
	
}
