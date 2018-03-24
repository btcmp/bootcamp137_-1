package com.xsis.mp1.model;

import java.util.Date;
import java.util.List;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToMany;
import javax.persistence.OneToMany;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;

@Entity
@Table(name="pos_mst_role")
public class Role {
	
	public Role() {
		this.createdOn = new Date();
		this.modifiedOn = new Date();
	}

	@Id
	@NotNull
	@GeneratedValue(strategy=GenerationType.SEQUENCE, generator = "idrole")
	@SequenceGenerator(initialValue = 2121, name = "idrole", sequenceName = "idrole")
	private long id;
	
	@Column(length=50)
	private String name;
	
	@Column(length=255)
	private String description;
	
	@Column(name="created_by")
	private long createdBy;
	
	@Column(name="created_on")
	private Date createdOn;
	
	@Column(name="modified_by")
	private long modifiedBy;
	
	@Column(name="modified_on")
	private Date modifiedOn;
	
	@NotNull
	@Column(nullable=false)
	private boolean active;
	
	@OneToMany(fetch=FetchType.LAZY, mappedBy="role", cascade=CascadeType.ALL, orphanRemoval=true)
	private List<User> users;
	
	/*@ManyToMany
	private Set<User> userRoles;*/

	public List<User> getUsers() {
		return users;
	}

	public void setUsers(List<User> users) {
		this.users = users;
	}

	/*public Set<User> getUserRoles() {
		return userRoles;
	}

	public void setUserRoles(Set<User> userRoles) {
		this.userRoles = userRoles;
	}*/

	public long getId() {
		return id;
	}

	public void setId(long id) {
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

	public long getCreatedBy() {
		return createdBy;
	}

	public void setCreatedBy(long createdBy) {
		this.createdBy = createdBy;
	}

	public Date getCreatedOn() {
		return createdOn;
	}

	public void setCreatedOn(Date createdOn) {
		this.createdOn = createdOn;
	}

	public long getModifiedBy() {
		return modifiedBy;
	}

	public void setModifiedBy(long modifiedBy) {
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
