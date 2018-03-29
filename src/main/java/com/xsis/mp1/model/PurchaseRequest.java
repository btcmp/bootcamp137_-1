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
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;

@Entity
@Table(name="pos_t_pr")
public class PurchaseRequest {
	
	public PurchaseRequest() {
		this.createdOn = new Date();
		this.modifiedOn = new Date();
	}
	
	@Id
	@NotNull
	@GeneratedValue(strategy=GenerationType.SEQUENCE, generator = "idtpr")
	@SequenceGenerator(initialValue = 9191, name = "idtpr", sequenceName = "idtpr")
	private long id;
	
	@ManyToOne
	private Outlet outletId;	
	
	@Column(name="ready_time")
	private Date readyTime;
	
	@NotNull
	@Column(name="pr_no", length=50, nullable=false)
	private String prNo;
	
	@Column(length=255)
	private String notes;
	
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

	@OneToMany(fetch=FetchType.LAZY, mappedBy="prId", cascade=CascadeType.ALL, orphanRemoval=true)
	private List<PurchaseOrder> purchaseOrders;
	
	@OneToMany(fetch=FetchType.LAZY, mappedBy="pr", cascade=CascadeType.ALL, orphanRemoval=true)
	private List<PurchaseRequestHistory> prHistories;

	public List<PurchaseRequestHistory> getPrHistories() {
		return prHistories;
	}

	public void setPrHistories(List<PurchaseRequestHistory> prHistories) {
		this.prHistories = prHistories;
	}

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public Outlet getOutletId() {
		return outletId;
	}

	public void setOutletId(Outlet outletId) {
		this.outletId = outletId;
	}
	
	public Date getReadyTime() {
		return readyTime;
	}

	public void setReadyTime(Date readyTime) {
		this.readyTime = readyTime;
	}

	public String getPrNo() {
		return prNo;
	}

	public void setPrNo(String prNo) {
		this.prNo = prNo;
	}

	public String getNotes() {
		return notes;
	}

	public void setNotes(String notes) {
		this.notes = notes;
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

	public List<PurchaseOrder> getPurchaseOrders() {
		return purchaseOrders;
	}

	public void setPurchaseOrders(List<PurchaseOrder> purchaseOrders) {
		this.purchaseOrders = purchaseOrders;
	}
	
	
}
