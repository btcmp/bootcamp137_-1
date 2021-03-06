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
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.Transient;
import javax.validation.constraints.NotNull;

@Entity
@Table(name="pos_mst_category")
public class Category {
	
	public Category() {
		this.createdOn=new Date();
	}

	
	@Id
	@NotNull
	@GeneratedValue(strategy=GenerationType.SEQUENCE, generator = "idcat")
	@SequenceGenerator(initialValue = 181818, name = "idcat", sequenceName = "idcat")
	private long id; 
	
	@NotNull
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
	
	@OneToMany(fetch=FetchType.LAZY, mappedBy="categoryId", cascade=CascadeType.ALL, orphanRemoval=true)
	private List<Item> items;
	
	//membuat properti yang tidak di inputkan ke dalam database
	@Transient
	private int itemStock ; 
	
	
	public int getItemStock() {
		return itemStock;
	}

	public void setItemStock(int itemStock) {
		this.itemStock = itemStock;
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

	public List<Item> getItems() {
		return items;
	}

	public void setItems(List<Item> items) {
		this.items = items;
	}

}
