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
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;

import com.fasterxml.jackson.annotation.JsonManagedReference;

@Entity
@Table(name="pos_t_transfer_stock")
public class TransferStock {

	public TransferStock() {
		this.createdOn = new Date();
		this.modifiedOn = new Date();
	}
	
	@Id
	@NotNull
	@GeneratedValue(strategy=GenerationType.SEQUENCE, generator = "idtts")
	@SequenceGenerator(initialValue = 88181, name = "idtts", sequenceName = "idtts")
	private long id;
	
	@NotNull
	@ManyToOne
	@JoinColumn(name="from_outlet")
	//@Column(name="from_outlet")
	private Outlet fromOutlet;
	
	@NotNull
	@ManyToOne
	@JoinColumn(name="to_outlet")
	//@Column(name="to_outlet")
	private Outlet toOutlet;
	
	@Column(length=255)
	private String notes;
	
	@NotNull
	@Column(length=20, nullable=false)
	private String status;
	
	@Column(name="created_by")
	private long createdBy;
	
	@Column(name="created_on")
	private Date createdOn;
	
	@Column(name="modified_by")
	private long modifiedBy;
	
	@Column(name="modified_on")
	private Date modifiedOn;
	
	@OneToMany(fetch=FetchType.LAZY, mappedBy="transfer", cascade=CascadeType.ALL)
	@JsonManagedReference
	private List<TransferStockDetail> tsDetails;

	@OneToMany(fetch=FetchType.LAZY, mappedBy="transfer", cascade=CascadeType.ALL)
	@JsonManagedReference
	private List<TransferStockHistory> tsHistories;
	
	public List<TransferStockDetail> getTsDetails() {
		return tsDetails;
	}

	public void setTsDetails(List<TransferStockDetail> tsDetails) {
		this.tsDetails = tsDetails;
	}

	public List<TransferStockHistory> getTsHistories() {
		return tsHistories;
	}

	public void setTsHistories(List<TransferStockHistory> tsHistories) {
		this.tsHistories = tsHistories;
	}

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public Outlet getFromOutlet() {
		return fromOutlet;
	}

	public void setFromOutlet(Outlet fromOutlet) {
		this.fromOutlet = fromOutlet;
	}

	public Outlet getToOutlet() {
		return toOutlet;
	}

	public void setToOutlet(Outlet toOutlet) {
		this.toOutlet = toOutlet;
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
}
