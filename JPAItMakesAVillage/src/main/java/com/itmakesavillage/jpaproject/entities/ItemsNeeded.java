package com.itmakesavillage.jpaproject.entities;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToOne;
import javax.persistence.Table;

@Entity
@Table(name="items_project")
public class ItemsNeeded {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	
	@ManyToOne
	@JoinColumn(name="project_id")
	private Project project;
	@OneToOne
	@JoinColumn(name="item_id")
	private Item item;
	@Column(name="quantity_needed")
	private int quantity;
	
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public Project getProject() {
		return project;
	}
	public void setProject(Project project) {
		this.project = project;
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
	public void setQuantity(int quantiy) {
		this.quantity = quantiy;
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
		ItemsNeeded other = (ItemsNeeded) obj;
		if (id != other.id)
			return false;
		return true;
	}
	@Override
	public String toString() {
		return "ItemsNeeded [id=" + id + ", project=" + project + ", item=" + item + ", quantiy=" + quantity + "]";
	}
	public ItemsNeeded(int id, Project project, Item item, int quantiy) {
		super();
		this.id = id;
		this.project = project;
		this.item = item;
		this.quantity = quantiy;
	}
	public ItemsNeeded() {
		super();
	}
	
	

}
