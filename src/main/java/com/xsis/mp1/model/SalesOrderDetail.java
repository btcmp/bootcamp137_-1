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
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.validation.constraints.NotNull;

@Entity
@Table(name="pos_t_so_detail" )
public class SalesOrderDetail {
	
	public SalesOrderDetail() {
		this.createdOn = new Date(); 
		this.modifiedOn = new Date(); 
	}
	@Id
	@NotNull
	@GeneratedValue(strategy=GenerationType.SEQUENCE, generator = "idtsod")
	@SequenceGenerator(initialValue = 484848, name = "idtsod", sequenceName = "idtsod")
	private long id; 
	
	@Column(nullable = false)
	private int qty; 
	
	@NotNull
	@Column(name="unit_price", nullable = false)
	private float unitPrice;
	
	@Column(name="sub_total")
	private float subTotal;
	
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
	
	@ManyToOne
	private SalesOrder salesOrder; 
	
	@ManyToOne
	private Variant variant;

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public int getQty() {
		return qty;
	}

	public void setQty(int qty) {
		this.qty = qty;
	}

	public float getUnitPrice() {
		return unitPrice;
	}

	public void setUnitPrice(float unitPrice) {
		this.unitPrice = unitPrice;
	}

	public float getSubTotal() {
		return subTotal;
	}

	public void setSubTotal(float subTotal) {
		this.subTotal = subTotal;
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

	public SalesOrder getSalesOrder() {
		return salesOrder;
	}

	public void setSalesOrder(SalesOrder salesOrder) {
		this.salesOrder = salesOrder;
	}

	public Variant getVariant() {
		return variant;
	}

	public void setVariant(Variant variant) {
		this.variant = variant;
	} 
	
}
