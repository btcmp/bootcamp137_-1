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
@Table(name="pos_t_transfer_stock_detail")
public class TransferStockDetail {

	public TransferStockDetail() {
		this.createdOn = new Date();
		this.modifiedOn = new Date();
	}
	
	@Id
	@NotNull
	@GeneratedValue(strategy=GenerationType.SEQUENCE, generator = "idtts_d")
	@SequenceGenerator(initialValue = 89181, name = "idtts_d", sequenceName = "idtts_d")
	private long id;
	
	@Column(name="in_stock")
	private int inStock;
	
	@NotNull
	@Column(name="transfer_qty", nullable=false)
	private int transferQty;
	
	@Column(name="created_by")
	private long createdBy;
	
	@Column(name="created_on")
	private Date createdOn;
	
	@Column(name="modified_by")
	private long modifiedBy;
	
	@Column(name="modified_on")
	private Date modifiedOn;
	
	@ManyToOne
	private TransferStock transfer;

	public TransferStock getTransfer() {
		return transfer;
	}

	public void setTransfer(TransferStock transfer) {
		this.transfer = transfer;
	}

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public int getInStock() {
		return inStock;
	}

	public void setInStock(int inStock) {
		this.inStock = inStock;
	}

	public int getTransferQty() {
		return transferQty;
	}

	public void setTransferQty(int transferQty) {
		this.transferQty = transferQty;
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
