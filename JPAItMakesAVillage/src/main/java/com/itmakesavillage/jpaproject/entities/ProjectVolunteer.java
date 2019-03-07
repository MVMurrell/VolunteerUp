package com.itmakesavillage.jpaproject.entities;

import java.util.ArrayList;
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
import javax.persistence.Table;

@Entity
@Table(name = "project_volunteer")
public class ProjectVolunteer {


	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;

	@Column(name = "hours_pledged")
	private int hoursPledged;

	@Column(name = "hours_actual")
	private int hoursActual;

	@ManyToOne
	@JoinColumn(name = "project_id")
	private Project project;

	@ManyToOne
	@JoinColumn(name = "volunteer_id")
	private Volunteer volunteer;
	
	@ManyToOne
	@JoinColumn(name="company_id")
	private Company company;
	
	@OneToMany(mappedBy="projectVolunteer", fetch=FetchType.EAGER, cascade=CascadeType.REMOVE)
	private List<ItemsCommitted> itemsCommitted;
	
	
	
	public List<ItemsCommitted> getItemsCommitted() {
		return itemsCommitted;
	}


	public void setItemsCommitted(List<ItemsCommitted> itemscommitted) {
		this.itemsCommitted = itemscommitted;
	}


	public Volunteer getVolunteer() {
		return volunteer;
	}
	

	public Company getCompany() {
		return company;
	}


	public void setCompany(Company companies) {
		this.company = companies;
	}


	public void setVolunteer(Volunteer volunteer) {
		this.volunteer = volunteer;
	}

	public Project getProject() {
		return project;
	}

	public void setProject(Project project) {
		this.project = project;
	}
	public int getId() {
		return id;
	}
	
	public void setId(int id) {
		this.id = id;
	}

	public int getHoursPledged() {
		return hoursPledged;
	}

	public int getHoursActual() {
		return hoursActual;
	}


	public void setHoursPledged(int hoursPledged) {
		this.hoursPledged = hoursPledged;
	}

	public void setHoursActual(int hoursActual) {
		this.hoursActual = hoursActual;
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
		ProjectVolunteer other = (ProjectVolunteer) obj;
		if (id != other.id)
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "ProjectVolunteer [id=" + id + ", hoursPledged=" + hoursPledged + ", hoursActual=" + hoursActual + "]";
	}

	public ProjectVolunteer(int id, int hoursPledged, int hoursActual) {
		super();
		this.id = id;
		this.hoursPledged = hoursPledged;
		this.hoursActual = hoursActual;
	}

	public ProjectVolunteer() {
		super();
	}
	
	public void addItemsCommitted(ItemsCommitted itemcommitted) {
		if(itemsCommitted == null) {
			itemsCommitted = new ArrayList<>();
		}
		if(!itemsCommitted.contains(itemcommitted)) {
			itemsCommitted.add(itemcommitted);
		}
		
	}
	public void removeItemsCommitted(ItemsCommitted itemcommitted) {
		if(itemsCommitted !=null && itemsCommitted.contains(itemcommitted)) {
			itemsCommitted.remove(itemcommitted);
		}
	}

	

}
