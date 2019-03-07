package com.itmakesavillage.jpaproject.entities;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;

@Entity
public class Company {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	private String name;
	@OneToMany(mappedBy="company")
	private List<ProjectVolunteer> projectVolunteers;
	
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	
	public List<ProjectVolunteer> getProjectVolunteer() {
		return projectVolunteers;
	}
	public void setProjectVolunteer(List<ProjectVolunteer> projectVolunteer) {
		this.projectVolunteers = projectVolunteer;
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
		Company other = (Company) obj;
		if (id != other.id)
			return false;
		return true;
	}
	@Override
	public String toString() {
		return "Company [id=" + id + ", name=" + name + "]";
	}
	public Company(int id, String name, List<ProjectVolunteer> projectVolunteer) {
		super();
		this.id = id;
		this.name = name;
		this.projectVolunteers = projectVolunteer;
	}
	public Company() {
		super();
	}
	public void addProjectVolunteer(ProjectVolunteer projectVolunteer) {
		if(projectVolunteers == null) {
			projectVolunteers = new ArrayList<ProjectVolunteer>();
		}
		if(!projectVolunteers.contains(projectVolunteer)) {
			projectVolunteers.add(projectVolunteer);
		}
	}
	public void removeProjectVolunteer(ProjectVolunteer projectVolunteer) {
		if(projectVolunteers !=null && projectVolunteers.contains(projectVolunteer)) {
			projectVolunteers.remove(projectVolunteer);
		}
	}
	
	

}
