package entity;

import java.util.Date;

public class User {
	private Long id;
	private String username, email, password, role, business_name;
	private Boolean status;
	private Long loyalty_points;
	private Date joined_date;
	public Date getJoined_date() {
		return joined_date;
	}
	public void setJoined_date(Date joined_date) {
		this.joined_date = joined_date;
	}
	public User(Long id, String username, String email, String password, String role, String business_name,
			Boolean status, Long loyalty_points, Date joined_date) {
		this.id = id;
		this.username = username;
		this.email = email;
		this.password = password;
		this.role = role;
		this.business_name = business_name;
		this.status = status;
		this.loyalty_points = loyalty_points;
		this.joined_date = joined_date;
	}
	public User(String username, String email, String password, String role, String business_name, Boolean status,
			Long loyalty_points, Date joined_date) {
		this.username = username;
		this.email = email;
		this.password = password;
		this.role = role;
		this.business_name = business_name;
		this.status = status;
		this.loyalty_points = loyalty_points;
		this.joined_date = joined_date;
	}
	public User() {

	}
	public User(Long id, String username, String email, String password, String role, String business_name,
			Boolean status, Long loyalty_points) {
		this.id = id;
		this.username = username;
		this.email = email;
		this.password = password;
		this.role = role;
		this.business_name = business_name;
		this.status = status;
		this.loyalty_points = loyalty_points;
	}
	public User(String username, String email, String password, String role, String business_name, Boolean status,
			Long loyalty_points) {
		this.username = username;
		this.email = email;
		this.password = password;
		this.role = role;
		this.business_name = business_name;
		this.status = status;
		this.loyalty_points = loyalty_points;
	}
	public User(String username, String email, String password, String role, String business_name, Boolean status,
			Date joined_date) {
		super();
		this.username = username;
		this.email = email;
		this.password = password;
		this.role = role;
		this.business_name = business_name;
		this.status = status;
		this.joined_date = joined_date;
	}
	public User(Long id, String username, String email, String password, String role, String business_name) {
		this.id = id;
		this.username = username;
		this.email = email;
		this.password = password;
		this.role = role;
		this.business_name = business_name;
	}
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getRole() {
		return role;
	}
	public void setRole(String role) {
		this.role = role;
	}
	public String getBusiness_name() {
		return business_name;
	}
	public void setBusiness_name(String business_name) {
		this.business_name = business_name;
	}
	public Boolean getStatus() {
		return status;
	}
	public void setStatus(Boolean status) {
		this.status = status;
	}
	public Long getLoyalty_points() {
		return loyalty_points;
	}
	public void setLoyalty_points(Long loyalty_points) {
		this.loyalty_points = loyalty_points;
	}
	
}
