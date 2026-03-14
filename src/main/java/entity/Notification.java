package entity;

import java.util.Date;

import enums.NotificationType;

public class Notification {
	private Long id;
	private User user;
	private String title, message;
	private NotificationType type;
	private Boolean is_read;
	private Date created_at;
	public Notification() {
		// TODO Auto-generated constructor stub
	}
	public Notification(Long id, User user, String title, String message, NotificationType type, Boolean is_read,
			Date created_at) {
		this.id = id;
		this.user = user;
		this.title = title;
		this.message = message;
		this.type = type;
		this.is_read = is_read;
		this.created_at = created_at;
	}
	public Notification(User user, String title, String message, NotificationType type, Boolean is_read,
			Date created_at) {
		this.user = user;
		this.title = title;
		this.message = message;
		this.type = type;
		this.is_read = is_read;
		this.created_at = created_at;
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
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	public NotificationType getType() {
		return type;
	}
	public void setType(NotificationType type) {
		this.type = type;
	}
	public Boolean getIs_read() {
		return is_read;
	}
	public void setIs_read(Boolean is_read) {
		this.is_read = is_read;
	}
	public Date getCreated_at() {
		return created_at;
	}
	public void setCreated_at(Date created_at) {
		this.created_at = created_at;
	}
	
}
