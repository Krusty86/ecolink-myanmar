package entity;

import java.math.BigDecimal;

import enums.ProductStatus;

public class Product {
	private Long id;
	private Category category;
	private String name, material_type;
	private BigDecimal plastic_saved_per_unit;
	private ProductStatus status;
	private Long qty;
	private BigDecimal price;
	
	public Product(Category category, String name, String material_type, BigDecimal plastic_saved_per_unit,
			ProductStatus status, Long qty, BigDecimal price) {
		
		this.category = category;
		this.name = name;
		this.material_type = material_type;
		this.plastic_saved_per_unit = plastic_saved_per_unit;
		this.status = status;
		this.qty = qty;
		this.price = price;
	}

	public Product(Long id, String name, String material_type, BigDecimal plastic_saved_per_unit, Long qty,
			BigDecimal price) {
	
		this.id = id;
		this.name = name;
		this.material_type = material_type;
		this.plastic_saved_per_unit = plastic_saved_per_unit;
		this.qty = qty;
		this.price = price;
	}

	public Product(Long id, Category category, String name, String material_type,
			BigDecimal plastic_saved_per_unit, ProductStatus status, Long qty, BigDecimal price) {
		super();
		this.id = id;
		this.category = category;
		this.name = name;
		this.material_type = material_type;
		this.plastic_saved_per_unit = plastic_saved_per_unit;
		this.status = status;
		this.qty = qty;
		this.price = price;
	}

	public BigDecimal getPrice() {
		return price;
	}

	public void setPrice(BigDecimal price) {
		this.price = price;
	}

	public Product() {
		// TODO Auto-generated constructor stub
	}
	
	public Product(Category category, String name, String material_type, BigDecimal plastic_saved_per_unit,
			ProductStatus status, Long qty) {
	
		this.category = category;
		this.name = name;
		this.material_type = material_type;
		this.plastic_saved_per_unit = plastic_saved_per_unit;
		this.status = status;
		this.qty = qty;
	}

	public Product(Long id, Category category, String name, String material_type,
			BigDecimal plastic_saved_per_unit, ProductStatus status, Long qty) {
	
		this.id = id;
		this.category = category;
		this.name = name;
		this.material_type = material_type;
		this.plastic_saved_per_unit = plastic_saved_per_unit;
		this.status = status;
		this.qty = qty;
	}

	public Long getQty() {
		return qty;
	}

	public void setQty(Long qty) {
		this.qty = qty;
	}

	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	
	public Category getCategory() {
		return category;
	}
	public void setCategory(Category category) {
		this.category = category;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getMaterial_type() {
		return material_type;
	}
	public void setMaterial_type(String material_type) {
		this.material_type = material_type;
	}
	public BigDecimal getPlastic_saved_per_unit() {
		return plastic_saved_per_unit;
	}
	public void setPlastic_saved_per_unit(BigDecimal plastic_saved_per_unit) {
		this.plastic_saved_per_unit = plastic_saved_per_unit;
	}
	public ProductStatus getStatus() {
		return status;
	}
	public void setStatus(ProductStatus status) {
		this.status = status;
	}
	
}
