package com.xsis.mp1.model;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

import com.sun.istack.NotNull;

@Entity
@Table(name="pos_mst_item_variant")
public class Varian {
	@Id
	@GeneratedValue(strategy=GenerationType.SEQUENCE, generator = "id")
	@SequenceGenerator(initialValue = 1010101, name = "id", sequenceName = "id")
	@Column(nullable=false)
	@NotNull
	private int id;
	@NotNull
	@Column(nullable=false)
	private int item;
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
	private int createdBy;
	@Column(name="created_on")
	@NotNull
	private Date createdOn;
	@Column(name="modified_by")
	@NotNull
	private int modifiedBy;
	@Column(name="modified_on")
	@NotNull
	private Date modifiedOn;
	@NotNull
	@Column(nullable=false)
	private int active;
	
	public Varian() {
		this.createdOn=new Date();
		this.modifiedOn=new Date();
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}
	

	public int getItem() {
		return item;
	}

	public void setItem(int item) {
		this.item = item;
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

	public int getActive() {
		return active;
	}

	public void setActive(int active) {
		this.active = active;
	}	
}
