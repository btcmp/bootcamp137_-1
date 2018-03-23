package com.xsis.mp1.model;

import java.util.Date;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.validation.constraints.NotNull;

@Entity
@Table(name="pos_mst_district")
public class District {
	
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
	private Region region;
	
	@OneToMany(fetch=FetchType.LAZY, mappedBy="district", cascade=CascadeType.ALL, orphanRemoval=true)
	private List<Supplier> suppliers; 
	
	@OneToMany(fetch=FetchType.LAZY, mappedBy="district", cascade=CascadeType.ALL, orphanRemoval=true)
	private List<Outlet> outlets; 
	
	@OneToMany(fetch=FetchType.LAZY, mappedBy="district", cascade=CascadeType.ALL, orphanRemoval=true)
	private List<Customer> customers; 
	
	public List<Outlet> getOutlets() {
		return outlets;
	}

	public void setOutlets(List<Outlet> outlets) {
		this.outlets = outlets;
	}

	public List<Supplier> getSuppliers() {
		return suppliers;
	}

	public void setSuppliers(List<Supplier> suppliers) {
		this.suppliers = suppliers;
	}

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

	public Region getRegion() {
		return region;
	}

	public void setRegion(Region region) {
		this.region = region;
	} 
	
	
}
