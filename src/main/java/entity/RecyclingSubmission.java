package entity;

import java.math.BigDecimal;
import java.util.Date;

import enums.SubmissionStatus;

public class RecyclingSubmission {
	private Long id;
	User user;
	private String waste_type;
	private BigDecimal weight_kg;
	private Long points_earned;
	private SubmissionStatus status;
	private Date submitted_at;
	public RecyclingSubmission() {
		// TODO Auto-generated constructor stub
	}
	public RecyclingSubmission(Long id, User user, String waste_type, BigDecimal weight_kg, Long points_earned,
			SubmissionStatus status, Date submitted_at) {
		this.id = id;
		this.user = user;
		this.waste_type = waste_type;
		this.weight_kg = weight_kg;
		this.points_earned = points_earned;
		this.status = status;
		this.submitted_at = submitted_at;
	}
	public RecyclingSubmission(User user, String waste_type, BigDecimal weight_kg, Long points_earned,
			SubmissionStatus status, Date submitted_at) {
		this.user = user;
		this.waste_type = waste_type;
		this.weight_kg = weight_kg;
		this.points_earned = points_earned;
		this.status = status;
		this.submitted_at = submitted_at;
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
	public String getWaste_type() {
		return waste_type;
	}
	public void setWaste_type(String waste_type) {
		this.waste_type = waste_type;
	}
	public BigDecimal getWeight_kg() {
		return weight_kg;
	}
	public void setWeight_kg(BigDecimal weight_kg) {
		this.weight_kg = weight_kg;
	}
	public Long getPoints_earned() {
		return points_earned;
	}
	public void setPoints_earned(Long points_earned) {
		this.points_earned = points_earned;
	}
	public SubmissionStatus getStatus() {
		return status;
	}
	public void setStatus(SubmissionStatus status) {
		this.status = status;
	}
	public Date getSubmitted_at() {
		return submitted_at;
	}
	public void setSubmitted_at(Date submitted_at) {
		this.submitted_at = submitted_at;
	}
	
	
}
