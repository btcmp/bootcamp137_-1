package com.xsis.mp1.model;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.validation.constraints.NotNull;

@Entity
@Table(name="pos_mst_region")
public class Region {
	
	@Id
	@NotNull
	private long id; 
	@Column(nullable=false, length=50)
	private String name; 
	@Column(name="created_by")
	private long createdBy; 
	@Temporal(TemporalType.DATE)
	@Column(name="created_on")
	private Date createdOn; 
	@Column(name="modified_by")
	private long modifiedBy; 
	@Temporal(TemporalType.DATE)
	@Column(name="modified_on")
	private Date modifiedOn; 
	@Column(nullable=false)
	private boolean active;
	
	@ManyToOne
	private Province province;

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

	public Province getProvince() {
		return province;
	}

	public void setProvince(Province province) {
		this.province = province;
	} 
	
	
}
