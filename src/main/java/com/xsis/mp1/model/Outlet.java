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
@Table(name="pos_mst_outlet")
public class Outlet {
	
	public Outlet() {
		this.createdOn = new Date();
		this.modifiedOn = new Date(); 
	}
	
	@Id
	@NotNull
	@GeneratedValue(strategy=GenerationType.SEQUENCE, generator = "idtout")
	@SequenceGenerator(initialValue = 2121, name = "idtout", sequenceName = "idtout")
	private long id;
	
	@Column(nullable= false, length = 50 )
	private String name; 
	
	@Column(length= 255)
	private String address; 
	
	@Column(length=16)
	private String phone;
	
	@Column(length=50)
	private String email; 
	
	@Column(name ="postal_code",length= 6)
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
	
	@OneToMany(fetch=FetchType.LAZY, mappedBy="outletId", cascade=CascadeType.ALL, orphanRemoval=true)
	private  List<PurchaseOrder> purchaseOrders;
	
	@OneToMany(fetch=FetchType.LAZY, mappedBy="outletId", cascade=CascadeType.ALL, orphanRemoval=true)
	private List<PurchaseRequest> purchaseRequests;
	
	@OneToMany(fetch=FetchType.LAZY, mappedBy="outlet", cascade=CascadeType.ALL, orphanRemoval=true)
	private  List<Item> items;
	
	@ManyToOne
	private Province province;
	
	@ManyToOne
	private Region region; 
	
	@ManyToOne
	private District district;
	
	@OneToMany(fetch=FetchType.LAZY, mappedBy="outlet", cascade=CascadeType.ALL, orphanRemoval=true)
	private List<EmployeeOutlet> empouts;
	
	@OneToMany(fetch=FetchType.LAZY, mappedBy="outlet", cascade=CascadeType.ALL, orphanRemoval=true)
	private List<Inventory> inventories;

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

	public List<PurchaseRequest> getPurchaseRequests() {
		return purchaseRequests;
	}

	public void setPurchaseRequests(List<PurchaseRequest> purchaseRequests) {
		this.purchaseRequests = purchaseRequests;
	}

	public List<Item> getItems() {
		return items;
	}

	public void setItems(List<Item> items) {
		this.items = items;
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

	public List<EmployeeOutlet> getEmpouts() {
		return empouts;
	}

	public void setEmpouts(List<EmployeeOutlet> empouts) {
		this.empouts = empouts;
	}

	public List<Inventory> getInventories() {
		return inventories;
	}

	public void setInventories(List<Inventory> inventories) {
		this.inventories = inventories;
	}
	
	
}
