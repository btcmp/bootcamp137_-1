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

import org.hibernate.annotations.GenericGenerator;
import org.hibernate.validator.constraints.Email;

@Entity
@Table(name="pos_mst_supplier")
public class Supplier {
	
	public Supplier() {
		this.createdOn = new Date();
		this.modifiedOn = new Date();
	}
	
	@Id
	@NotNull
	@GeneratedValue(strategy=GenerationType.SEQUENCE, generator = "idtsup")
	@SequenceGenerator(initialValue = 1212, name = "idtsup", sequenceName = "idtsup")
	private long id;
	 
	@Column(nullable= false, length = 50 )
	@NotNull
	private String name; 
	@Column(length = 255 )
	private String address;
	@Column(length = 16 )
	private String phone;
	@Column(length = 50 )
	@Email
	private String email; 
	@Column(name ="postal_code", nullable= false, length= 6)
	private String postalCode; 
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
	@Column(nullable=false)
	private boolean active;
	
	@OneToMany(fetch=FetchType.LAZY, mappedBy="supplierId", cascade=CascadeType.ALL, orphanRemoval=true)
	private  List<PurchaseOrder> purchaseOrders;
	
	
	@ManyToOne
	private Province province; 
	
	@ManyToOne
	private Region region; 
	
	@ManyToOne
	private District district;

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPostalCode() {
		return postalCode;
	}

	public void setPostalCode(String postalCode) {
		this.postalCode = postalCode;
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

	public boolean isActive() {
		return active;
	}

	public void setActive(boolean active) {
		this.active = active;
	}

	public List<PurchaseOrder> getPurchaseOrders() {
		return purchaseOrders;
	}

	public void setPurchaseOrders(List<PurchaseOrder> purchaseOrders) {
		this.purchaseOrders = purchaseOrders;
	}

	public Province getProvince() {
		return province;
	}

	public void setProvince(Province province) {
		this.province = province;
	}

	public Region getRegion() {
		return region;
	}

	public void setRegion(Region region) {
		this.region = region;
	}

	public District getDistrict() {
		return district;
	}

	public void setDistrict(District district) {
		this.district = district;
	}

	
	
}
