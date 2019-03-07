package com.itmakesavillage.jpaproject.entities;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToOne;
import javax.persistence.Table;

@Entity
@Table(name="items_pv")
public class ItemsCommitted {
	

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	
	@ManyToOne
	@JoinColumn(name="items_id")
	private Item item;
	
	private int quantity;
	@ManyToOne
	@JoinColumn(name="pv_id")
	private ProjectVolunteer projectVolunteer;
	
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public Item getItem() {
		return item;
	}
	public void setItem(Item item) {
		this.item = item;
	}
	public int getQuantity() {
		return quantity;
	}
	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}
	public ProjectVolunteer getProjectVolunteer() {
		return projectVolunteer;
	}
	public void setProjectVolunteer(ProjectVolunteer projectVolunteer) {
		this.projectVolunteer = projectVolunteer;
	}
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + id;
		return result;
	}
	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		ItemsCommitted other = (ItemsCommitted) obj;
		if (id != other.id)
			return false;
		return true;
	}
	@Override
	public String toString() {
		return "ItemsCommitted [id=" + id + ", item=" + item + ", quantity=" + quantity + ", projectVolunteer="
				+ projectVolunteer + "]";
	}
	public ItemsCommitted(int id, Item item, int quantity, ProjectVolunteer projectVolunteer) {
		super();
		this.id = id;
		this.item = item;
		this.quantity = quantity;
		this.projectVolunteer = projectVolunteer;
	}
	public ItemsCommitted() {
		super();
	}

	
}
