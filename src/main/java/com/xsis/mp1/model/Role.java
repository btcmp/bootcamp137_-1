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
@Table(name="pos_mst_role")
public class Role {

	@Id
	@NotNull
	@GeneratedValue(strategy=GenerationType.SEQUENCE, generator = "idrole")
	@SequenceGenerator(initialValue = 2121, name = "idrole", sequenceName = "idrole")
	private int id;
	
	@Column(length=50)
	private String name;
	
	@Column(length=255)
	private String description;
	
	@Column(name="created_by")
	private int createdBy;
	
	@Column(name="created_on")
	private Date createdOn;
	
	@Column(name="modified_by")
	private int modifiedBy;
	
	@Column(name="modified_on")
	private Date modifiedOn;
	
	@NotNull
	private boolean active;
}
