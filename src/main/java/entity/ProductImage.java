package entity;

public class ProductImage {
	private Long id;
	private Product product;
	private String image_path;
	public ProductImage() {
		// TODO Auto-generated constructor stub
	}
	public ProductImage(Long id, Product product, String image_path) {
		
		this.id = id;
		this.product = product;
		this.image_path = image_path;
	}
	public ProductImage(Product product, String image_path) {
		this.product = product;
		this.image_path = image_path;
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
	public String getImage_path() {
		return image_path;
	}
	public void setImage_path(String image_path) {
		this.image_path = image_path;
	}
	
	
}
