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
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.validation.constraints.NotNull;

@Entity
@Table(name="pos_t_so")
public class SalesOrder {
	
	public SalesOrder() {
		this.createdOn = new Date(); 
		this.modifiedOn = new Date(); 
	}
	
	@Id
	@NotNull
	@GeneratedValue(strategy=GenerationType.SEQUENCE, generator = "idtso")
	@SequenceGenerator(initialValue = 383838, name = "idtso", sequenceName = "idtso")
	private long id; 
	
	@Column(name="grand_total", nullable = false)
	private float grandTotal; 
	
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
	
	@ManyToOne
	private Customer customer;
	
	@OneToMany(fetch=FetchType.LAZY, mappedBy="salesOrder", cascade=CascadeType.ALL, orphanRemoval=true)
	private List<SalesOrderDetail> salesOrderDetails; 
	
	public List<SalesOrderDetail> getSalesOrderDetails() {
		return salesOrderDetails;
	}

	public void setSalesOrderDetails(List<SalesOrderDetail> salesOrderDetails) {
		this.salesOrderDetails = salesOrderDetails;
	}

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public float getGrandTotal() {
		return grandTotal;
	}

	public void setGrandTotal(float grandTotal) {
		this.grandTotal = grandTotal;
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

	public Customer getCustomer() {
		return customer;
	}

	public void setCustomer(Customer customer) {
		this.customer = customer;
	} 
	
	
}
