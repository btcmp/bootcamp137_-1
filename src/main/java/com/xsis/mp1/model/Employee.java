package com.xsis.mp1.model;

import java.util.Date;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.PrimaryKeyJoinColumn;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.validation.constraints.NotNull;

import com.fasterxml.jackson.annotation.JsonManagedReference;

@Entity
@Table(name="pos_mst_employee")
public class Employee {

	public Employee() {
		this.createdOn = new Date();
		this.modifiedOn = new Date();
	}

	@Id
	@NotNull
	@GeneratedValue(strategy=GenerationType.SEQUENCE, generator = "idemp")
	@SequenceGenerator(initialValue = 101, name = "idemp", sequenceName = "idemp")
	private long id;
	
	@NotNull
	@Column(name="first_name", length=50, nullable = false)
	private String firstName;
	
	@NotNull
	@Column(name="last_name", length=50, nullable = false)
	private String lastName;
	
	@Column(name="email", length=50)
	private String email;
	
	@Column(length=50)
	private String title;
	
	@NotNull
	@Column(name="have_account", nullable = false)
	private boolean haveAccount;
	
	@Column(name="created_by")
	private int createdBy;
	
	@Temporal(TemporalType.DATE)
	@Column(name="created_on")
	private Date createdOn;
	
	@Column(name="modified_by")
	private int modifiedBy;
	
	@Temporal(TemporalType.DATE)
	@Column(name="modified_on")
	private Date modifiedOn;
	
	@NotNull
	@Column(nullable = false)
	private boolean active;
	
	@OneToOne(fetch = FetchType.LAZY, mappedBy="employee", cascade = CascadeType.ALL)
	@JsonManagedReference
	private User user;
	
	@OneToMany(fetch=FetchType.LAZY, mappedBy="employee", cascade = CascadeType.ALL)
	private List<EmployeeOutlet> empouts;

	public List<EmployeeOutlet> getEmpouts() {
		return empouts;
	}

	public void setEmpouts(List<EmployeeOutlet> empouts) {
		this.empouts = empouts;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public String getFirstName() {
		return firstName;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public String getLastName() {
		return lastName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public boolean isHaveAccount() {
		return haveAccount;
	}

	public void setHaveAccount(boolean haveAccount) {
		this.haveAccount = haveAccount;
	}

	public int getCreatedBy() {
		return createdBy;
	}

	public void setCreatedBy(int createdBy) {
		this.createdBy = createdBy;
	}

	public Date getCreatedOn() {
		return createdOn;
	}

	public void setCreatedOn(Date createdOn) {
		this.createdOn = createdOn;
	}

	public int getModifiedBy() {
		return modifiedBy;
	}

	public void setModifiedBy(int modifiedBy) {
		this.modifiedBy = modifiedBy;
	}

	public Date getModifiedOn() {
		return modifiedOn;
	}

	public void setModifiedOn(Date modifiedOn) {
		this.modifiedOn = modifiedOn;
	}

	public boolean isActive() {
		return active;
	}

	public void setActive(boolean active) {
		this.active = active;
	}
	
}
