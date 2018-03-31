package com.xsis.mp1.model;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;

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
	@Column(name="from_outlet", nullable=false)
	private long fromOutlet;
	
	@NotNull
	@Column(name="to_outlet", nullable=false)
	private long toOutlet;
	
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

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public long getFromOutlet() {
		return fromOutlet;
	}

	public void setFromOutlet(long fromOutlet) {
		this.fromOutlet = fromOutlet;
	}

	public long getToOutlet() {
		return toOutlet;
	}

	public void setToOutlet(long toOutlet) {
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
