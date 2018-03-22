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
import javax.validation.constraints.NotNull;

@Entity
@Table(name="pos_t_po")
public class PurchaseOrder {
	
	public PurchaseOrder() {
		this.createdOn = new Date();
		this.modifiedOn = new Date();
	}

	@Id
	@NotNull
	@GeneratedValue(strategy=GenerationType.SEQUENCE, generator = "idtpo")
	@SequenceGenerator(initialValue = 91919191, name = "idtpo", sequenceName = "idtpo")
	private long id;
	

	@ManyToOne
	private PurchaseRequest prId;
	
	
	@ManyToOne
	private Outlet outletId;

	@ManyToOne
	private Supplier supplierId;
	
	@NotNull
	@Column(name="po_no", length=50, nullable=false)
	private String poNo;
	
	@Column(length=255)
	private String notes;
	
	@NotNull
	@Column(name="grand_total")
	private float grandTotal;
	
	@NotNull
	@Column(length=50, nullable=false)
	private String status;
	
	@Column(name="created_by")
	private long createdBy;
	
	@Column(name="created_on")
	private Date createdOn;
	
	@Column(name="modified_by")
	private long modifiedBy;
	
	@Column(name="modified_on")
	private Date modifiedOn;

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public PurchaseRequest getPrId() {
		return prId;
	}

	public void setPrId(PurchaseRequest prId) {
		this.prId = prId;
	}

	public Outlet getOutletId() {
		return outletId;
	}

	public void setOutletId(Outlet outletId) {
		this.outletId = outletId;
	}

	public Supplier getSupplierId() {
		return supplierId;
	}

	public void setSupplierId(Supplier supplierId) {
		this.supplierId = supplierId;
	}

	public String getPoNo() {
		return poNo;
	}

	public void setPoNo(String poNo) {
		this.poNo = poNo;
	}

	public String getNotes() {
		return notes;
	}

	public void setNotes(String notes) {
		this.notes = notes;
	}

	public float getGrandTotal() {
		return grandTotal;
	}

	public void setGrandTotal(float grandTotal) {
		this.grandTotal = grandTotal;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
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
