package entity;

import java.util.Date;

public class ImpactLog {
	private Long id;
	private User user;
	private Integer total_plastic_saved, total_orders;
	private Date last_updated;
	public ImpactLog() {
		// TODO Auto-generated constructor stub
	}
	public ImpactLog(Long id, User user, Integer total_plastic_saved, Integer total_orders,
			Date last_updated) {
		this.id = id;
		this.user = user;
		this.total_plastic_saved = total_plastic_saved;
		this.total_orders = total_orders;
		this.last_updated = last_updated;
	}
	public ImpactLog(User user, Integer total_plastic_saved, Integer total_orders, Date last_updated) {
		this.user = user;
		this.total_plastic_saved = total_plastic_saved;
		this.total_orders = total_orders;
		this.last_updated = last_updated;
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
	public Integer getTotal_plastic_saved() {
		return total_plastic_saved;
	}
	public void setTotal_plastic_saved(Integer total_plastic_saved) {
		this.total_plastic_saved = total_plastic_saved;
	}
	public Integer getTotal_orders() {
		return total_orders;
	}
	public void setTotal_orders(Integer total_orders) {
		this.total_orders = total_orders;
	}
	public Date getLast_updated() {
		return last_updated;
	}
	public void setLast_updated(Date last_updated) {
		this.last_updated = last_updated;
	}
	
}
