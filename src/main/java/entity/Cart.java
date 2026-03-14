package entity;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

public class Cart {
	private List<CartItem> items = new ArrayList<>();
	public Cart() {
		
	}
	public List<CartItem> getItems() {
		return items;
	}
	public void setItems(List<CartItem> items) {
		this.items = items;
	}
	public void addItem(Product product, int quantity) {
		for(CartItem item: items) {
			if(item.getProduct().getId().equals(product.getId())) {
				item.setQuantity(item.getQuantity() + quantity);
				return;
			}
		}
		items.add(new CartItem(product, quantity));
	}
	
	public void removeItem(Long productId) {
		items.removeIf(item ->
			item.getProduct().getId().equals(productId)
		); // arrow function - short codes
	}
	// jsp user.id -> getId()
	// jsp cart.total -> getTotal()
	public BigDecimal getTotal() {
	    // 1. Initialize with ZERO
	    BigDecimal total = BigDecimal.ZERO;

	    for (CartItem item : items) {
	        BigDecimal price = item.getProduct().getPrice();
	        BigDecimal quantity = new BigDecimal(item.getQuantity());
	        BigDecimal subtotal = price.multiply(quantity);
	        total = total.add(subtotal);
	    }
	    
	    return total;
	}
	public void clear() {
		items.clear();
	}
}
