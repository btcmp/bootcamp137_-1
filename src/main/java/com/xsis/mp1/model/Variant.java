package com.xsis.mp1.model;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToOne;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

import com.sun.istack.NotNull;

@Entity
@Table(name="pos_mst_item_variant")
public class Variant {
	@Id
	@GeneratedValue(strategy=GenerationType.SEQUENCE, generator = "idvar")
	@SequenceGenerator(initialValue = 1010101, name = "idvar", sequenceName = "idvar")
	@Column(nullable=false)
	@NotNull
	private long id;
	
	@NotNull
	@Column(nullable=false)
	private String name;
	
	@NotNull
	@Column(nullable=false)
	private String sku;
	
	@NotNull
	@Column(nullable=false)
	private float price;
	
	@Column(name="created_by")
	@NotNull
	private long createdBy;
	
	@Column(name="created_on")
	@NotNull
	private Date createdOn;
	
	@Column(name="modified_by")
	@NotNull
	private long modifiedBy;
	
	@Column(name="modified_on")
	@NotNull
	private Date modifiedOn;
	
	@NotNull
	@Column(nullable=false)
	private boolean active;
	
	@ManyToOne
	private Item item;
	
	public Variant() {
		this.createdOn=new Date();
		this.modifiedOn=new Date();
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

	public String getSku() {
		return sku;
	}

	public void setSku(String sku) {
		this.sku = sku;
	}

	public float getPrice() {
		return price;
	}

	public void setPrice(float price) {
		this.price = price;
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

	public Item getItem() {
		return item;
	}

	public void setItem(Item item) {
		this.item = item;
	}

	
}
