package entity;

import enums.AddressType;

public class Address {
	private Long id;
	private User user;
	private String label, street, township, city;
	private Boolean is_default;
	private AddressType address_type;
	public Address() {
		// TODO Auto-generated constructor stub
	}
	public Address(Long id, User user, String label, String street, String township, String city, Boolean is_default,
			AddressType address_type) {
		this.id = id;
		this.user = user;
		this.label = label;
		this.street = street;
		this.township = township;
		this.city = city;
		this.is_default = is_default;
		this.address_type = address_type;
	}
	public Address(User user, String label, String street, String township, String city, Boolean is_default,
			AddressType address_type) {
		this.user = user;
		this.label = label;
		this.street = street;
		this.township = township;
		this.city = city;
		this.is_default = is_default;
		this.address_type = address_type;
	}
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public User getUser() {
		return user;
	}
	public void setUser(User user) {
		this.user = user;
	}
	public String getLabel() {
		return label;
	}
	public void setLabel(String label) {
		this.label = label;
	}
	public String getStreet() {
		return street;
	}
	public void setStreet(String street) {
		this.street = street;
	}
	public String getTownship() {
		return township;
	}
	public void setTownship(String township) {
		this.township = township;
	}
	public String getCity() {
		return city;
	}
	public void setCity(String city) {
		this.city = city;
	}
	public Boolean getIs_default() {
		return is_default;
	}
	public void setIs_default(Boolean is_default) {
		this.is_default = is_default;
	}
	public AddressType getAddress_type() {
		return address_type;
	}
	public void setAddress_type(AddressType address_type) {
		this.address_type = address_type;
	}
}
