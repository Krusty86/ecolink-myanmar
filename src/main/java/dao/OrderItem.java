package dao;

import entity.Order;
import entity.Product;

public class OrderItem {
	private Long id;
	private Order order; //order_id
	private Product product; // product_id
	private Long quantity;
	public OrderItem() {
		// TODO Auto-generated constructor stub
	}
	public OrderItem(Long id, Order order, Product product, Long quantity) {
		this.id = id;
		this.order = order;
		this.product = product;
		this.quantity = quantity;
	}
	public OrderItem(Order order, Product product, Long quantity) {
		this.order = order;
		this.product = product;
		this.quantity = quantity;
	}
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public Order getOrder() {
		return order;
	}
	public void setOrder(Order order) {
		this.order = order;
	}
	public Product getProduct() {
		return product;
	}
	public void setProduct(Product product) {
		this.product = product;
	}
	public Long getQuantity() {
		return quantity;
	}
	public void setQuantity(Long quantity) {
		this.quantity = quantity;
	}
	
	
}
