package entity;

import java.math.BigDecimal;
import java.util.Date;

import enums.DiscountTargetType;
import enums.DiscountType;

public class Discount {
	private Long id;
	private User user; // supplier id
	private String title;
	private DiscountType type;
	private BigDecimal value;
	private Date start_date, end_date;
	private BigDecimal min_order_amount;
	private DiscountTargetType target_type;
	private Long target_id;
	private Boolean is_active;
	public Discount() {
		// TODO Auto-generated constructor stub
	}
	public Discount(Long id, User user, String title, DiscountType type, BigDecimal value, Date start_date,
			Date end_date, BigDecimal min_order_amount, DiscountTargetType target_type, Long target_id,
			Boolean is_active) {
		this.id = id;
		this.user = user;
		this.title = title;
		this.type = type;
		this.value = value;
		this.start_date = start_date;
		this.end_date = end_date;
		this.min_order_amount = min_order_amount;
		this.target_type = target_type;
		this.target_id = target_id;
		this.is_active = is_active;
	}
	public Discount(User user, String title, DiscountType type, BigDecimal value, Date start_date,
			Date end_date, BigDecimal min_order_amount, DiscountTargetType target_type, Long target_id,
			Boolean is_active) {
		this.user = user;
		this.title = title;
		this.type = type;
		this.value = value;
		this.start_date = start_date;
		this.end_date = end_date;
		this.min_order_amount = min_order_amount;
		this.target_type = target_type;
		this.target_id = target_id;
		this.is_active = is_active;
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
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public DiscountType getType() {
		return type;
	}
	public void setType(DiscountType type) {
		this.type = type;
	}
	public BigDecimal getValue() {
		return value;
	}
	public void setValue(BigDecimal value) {
		this.value = value;
	}
	public Date getStart_date() {
		return start_date;
	}
	public void setStart_date(Date start_date) {
		this.start_date = start_date;
	}
	public Date getEnd_date() {
		return end_date;
	}
	public void setEnd_date(Date end_date) {
		this.end_date = end_date;
	}
	public BigDecimal getMin_order_amount() {
		return min_order_amount;
	}
	public void setMin_order_amount(BigDecimal min_order_amount) {
		this.min_order_amount = min_order_amount;
	}
	public DiscountTargetType getTarget_type() {
		return target_type;
	}
	public void setTarget_type(DiscountTargetType target_type) {
		this.target_type = target_type;
	}
	public Long getTarget_id() {
		return target_id;
	}
	public void setTarget_id(Long target_id) {
		this.target_id = target_id;
	}
	public Boolean getIs_active() {
		return is_active;
	}
	public void setIs_active(Boolean is_active) {
		this.is_active = is_active;
	}
	
}
