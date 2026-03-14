package entity;

public class Category {
	private Long id;
	private String name, description;
	public Category() {
		// TODO Auto-generated constructor stub
	}
	public Category(Long id, String name, String description) {
		this.id = id;
		this.name = name;
		this.description = description;
	}
	public Category(String name, String description) {
		this.name = name;
		this.description = description;
	}
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	
	
}
