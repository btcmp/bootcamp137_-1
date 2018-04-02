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

import com.sun.istack.NotNull;

@Entity
@Table(name="pos_item_inventory")
public class Inventory {
	
	@Id
	@GeneratedValue(strategy=GenerationType.SEQUENCE, generator = "idinv")
	@SequenceGenerator(initialValue = 2020201, name = "idinv", sequenceName = "idinv")
	@Column(nullable=false)
	@NotNull
	private Long id;
	 
	@ManyToOne
	private Variant variant;
	
	@ManyToOne
	private Outlet outlet;
	 
	@Column(nullable=false)
	@NotNull
	private int beginning;
	
	@Column(name="purchase_qty")
	private int purchaseQty;
	
	@Column(name="sales_order_qty")
	private int salesOrderQty;
	
	@Column(name="transfer_stock_qty")
	private int transferStockQty;
	
	@Column(name="adjusment_qty")
	private int adjustementqty;
	
	@Column(name="ending_qty", nullable=false)
	private int endingQty;
	
	@Column(name="alert_at_qty", nullable=false)
	private int alertAtQty;
	
	@Column(name= "created_by")
	private long createdBy; 
	
	@Temporal(TemporalType.DATE)
	@Column(name="created_on")
	private Date createdOn; 
	
	@Column(name="modified_by")
	private long modifiedBy; 
	
	@Temporal(TemporalType.DATE)
	@Column(name="modified_on")
	private Date modifiedOn;

	public Inventory() {
		this.createdOn=new Date();
		this.modifiedOn=new Date();
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public Variant getVariant() {
		return variant;
	}

	public void setVariant(Variant variant) {
		this.variant = variant;
	}

	public Outlet getOutlet() {
		return outlet;
	}

	public void setOutlet(Outlet outlet) {
		this.outlet = outlet;
	}

	public int getBeginning() {
		return beginning;
	}

	public void setBeginning(int beginning) {
		this.beginning = beginning;
	}

	public int getPurchaseQty() {
		return purchaseQty;
	}

	public void setPurchaseQty(int purchaseQty) {
		this.purchaseQty = purchaseQty;
	}

	public int getSalesOrderQty() {
		return salesOrderQty;
	}

	public void setSalesOrderQty(int salesOrderQty) {
		this.salesOrderQty = salesOrderQty;
	}

	public int getTransferStockQty() {
		return transferStockQty;
	}

	public void setTransferStockQty(int transferStockQty) {
		this.transferStockQty = transferStockQty;
	}

	public int getAdjustementqty() {
		return adjustementqty;
	}

	public void setAdjustementqty(int adjustementqty) {
		this.adjustementqty = adjustementqty;
	}

	public int getEndingQty() {
		return endingQty;
	}

	public void setEndingQty(int endingQty) {
		this.endingQty = endingQty;
	}

	public int getAlertAtQty() {
		return alertAtQty;
	}

	public void setAlertAtQty(int alertAtQty) {
		this.alertAtQty = alertAtQty;
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

	
	
		
}
