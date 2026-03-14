package entity;

import java.math.BigDecimal;
import java.util.Date;

public class ProductPrice {
	private Long id;
	private Product product;
	private BigDecimal price;
	private Date effective_date;
	private Boolean is_current;
	public ProductPrice() {
		// TODO Auto-generated constructor stub
	}
	public ProductPrice(Long id, Product product, BigDecimal price, Date effective_date, Boolean is_current) {
		this.id = id;
		this.product = product;
		this.price = price;
		this.effective_date = effective_date;
		this.is_current = is_current;
	}
	public ProductPrice(Product product, BigDecimal price, Date effective_date, Boolean is_current) {
		this.product = product;
		this.price = price;
		this.effective_date = effective_date;
		this.is_current = is_current;
	}
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public Product getProduct() {
		return product;
	}
	public void setProduct(Product product) {
		this.product = product;
	}
	public BigDecimal getPrice() {
		return price;
	}
	public void setPrice(BigDecimal price) {
		this.price = price;
	}
	public Date getEffective_date() {
		return effective_date;
	}
	public void setEffective_date(Date effective_date) {
		this.effective_date = effective_date;
	}
	public Boolean getIs_current() {
		return is_current;
	}
	public void setIs_current(Boolean is_current) {
		this.is_current = is_current;
	}
	
	
}
