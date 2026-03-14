package entity;

import java.math.BigDecimal;
import java.util.Date;

import enums.OrderStatus;

public class Order {
	private Long id;
	private User user;	// buyer id
	private Address address; // shipping address id
	private Integer total_amount;
	private OrderStatus status;
	private Date order_date;
	private Long points_spent;
	private BigDecimal discount_amount_from_points;
	public Order() {
		// TODO Auto-generated constructor stub
	}
	public Order(Long id, User user, Address address, Integer total_amount, OrderStatus status,
			Date order_date, Long points_spent, BigDecimal discount_amount_from_points) {
		this.id = id;
		this.user = user;
		this.address = address;
		this.total_amount = total_amount;
		this.status = status;
		this.order_date = order_date;
		this.points_spent = points_spent;
		this.discount_amount_from_points = discount_amount_from_points;
	}
	public Order(User user, Address address, Integer total_amount, OrderStatus status, Date order_date,
			Long points_spent, BigDecimal discount_amount_from_points) {
		this.user = user;
		this.address = address;
		this.total_amount = total_amount;
		this.status = status;
		this.order_date = order_date;
		this.points_spent = points_spent;
		this.discount_amount_from_points = discount_amount_from_points;
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
	public Address getAddress() {
		return address;
	}
	public void setAddress(Address address) {
		this.address = address;
	}
	public Integer getTotal_amount() {
		return total_amount;
	}
	public void setTotal_amount(Integer total_amount) {
		this.total_amount = total_amount;
	}
	public OrderStatus getStatus() {
		return status;
	}
	public void setStatus(OrderStatus status) {
		this.status = status;
	}
	public Date getOrder_date() {
		return order_date;
	}
	public void setOrder_date(Date order_date) {
		this.order_date = order_date;
	}
	public Long getPoints_spent() {
		return points_spent;
	}
	public void setPoints_spent(Long points_spent) {
		this.points_spent = points_spent;
	}
	public BigDecimal getDiscount_amount_from_points() {
		return discount_amount_from_points;
	}
	public void setDiscount_amount_from_points(BigDecimal discount_amount_from_points) {
		this.discount_amount_from_points = discount_amount_from_points;
	}
	
}
