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
@Table(name="pos_t_adjustment")
public class Adjustment {
	@Id
	@GeneratedValue(strategy=GenerationType.SEQUENCE, generator = "idadj")
	@SequenceGenerator(initialValue = 10101, name = "idadj", sequenceName = "idadj")
	@Column(nullable=false)
	@NotNull
	private long id;
	
	@ManyToOne
	//@Column(nullable=false)
	private Outlet outlet;
	
	@OneToMany(fetch=FetchType.LAZY, mappedBy="adjustment", cascade=CascadeType.ALL, orphanRemoval=true)
	private List<AdjustmentDetail> adjustmentDetails;
	
	@OneToMany(fetch=FetchType.LAZY, mappedBy="adjustment", cascade=CascadeType.ALL, orphanRemoval=true)
	private List<AdjustmentHistory> adjustmentHistory;
	
	private String notes;
	
	private String status;
	 
	@Column(name="created_by")
	private long createdBy;
	
	@Column(name="created_on")
	private Date createdOn;
	
	@Column(name="modified_by")
	private long modifiedBy;
	
	@Column(name="modified_on")
	private Date modifiedOn;
	
	public Adjustment() {
		this.createdOn=new Date();
		this.modifiedOn=new Date();
	}

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public Outlet getOutlet() {
		return outlet;
	}

	public void setOutlet(Outlet outlet) {
		this.outlet = outlet;
	}

	public List<AdjustmentDetail> getAdjustmentDetails() {
		return adjustmentDetails;
	}

	public void setAdjustmentDetails(List<AdjustmentDetail> adjustmentDetails) {
		this.adjustmentDetails = adjustmentDetails;
	}

	public List<AdjustmentHistory> getAdjustmentHistory() {
		return adjustmentHistory;
	}

	public void setAdjustmentHistory(List<AdjustmentHistory> adjustmentHistory) {
		this.adjustmentHistory = adjustmentHistory;
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
