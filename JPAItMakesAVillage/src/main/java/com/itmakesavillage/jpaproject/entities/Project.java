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
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;

@Entity
public class Project {
	
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Id
	private int id;
	
	private String title;
	
	private boolean active;
	
	@ManyToOne
	@JoinColumn(name="owner_id")
	private Volunteer owner;
	
	
	@Column(name = "start_date")
	private String startDate;
	
	
	@Column(name = "end_date")
	private String endDate;
	
	private String description;
	
	@ManyToOne
	@JoinColumn(name="address_id")
	private Address address;
	
	@Column(name="start_time")
	private String time;

	@Column(name = "hours_needed")
	private int hoursNeeded;
	
	@Column(name = "volunteers_needed")
	private int volunteersNeeded;

	@ManyToMany(fetch=FetchType.EAGER)
	@JoinTable(name="project_volunteer", joinColumns=@JoinColumn(name="project_id"),
	                              inverseJoinColumns=@JoinColumn(name="volunteer_id"))
	private List<Volunteer> volunteers;
	
	@ManyToMany
	@JoinTable(name="category_project", joinColumns=@JoinColumn(name="project_id"), inverseJoinColumns=@JoinColumn(name="category_id"))
	private List<Category> categories;

	@OneToMany(mappedBy="project"/*, cascade = {CascadeType.ALL}*/)
	private List<ProjectVolunteer> projectVolunteer;

	@OneToMany(mappedBy="project", cascade = {CascadeType.ALL})
	private List<Comments> comments;
	
	@OneToMany(mappedBy="project"/*, cascade = {CascadeType.ALL}*/)
	private List<ItemsNeeded> itemsNeeded;
	
	
	
	
	public List<ItemsNeeded> getItemsNeeded() {
		return itemsNeeded;
	}

	public void setItemsNeeded(List<ItemsNeeded> itemsNeeded) {
		this.itemsNeeded = itemsNeeded;
	}

	public List<Comments> getComments() {
		return comments;
	}

	public void setComments(List<Comments> comments) {
		this.comments = comments;
	}

	public Project() {
	}

	public Project(int id, String title, boolean active, String startDate, String endDate, String description,
			Address address, String time, int hoursNeeded, int volunteersNeeded, List<Volunteer> volunteers,
			List<Category> categories, List<ProjectVolunteer> projectVolunteer) {
		super();
		this.id = id;
		this.title = title;
		this.active = active;
		this.startDate = startDate;
		this.endDate = endDate;
		this.description = description;
		this.address = address;
		this.time = time;
		this.hoursNeeded = hoursNeeded;
		this.volunteersNeeded = volunteersNeeded;
		this.volunteers = volunteers;
		this.categories = categories;
		this.projectVolunteer = projectVolunteer;
	}

	@Override
	public String toString() {
		return "Project [id=" + id + ", title=" + title + ", active=" + active + ", startDate="
				+ startDate + ", endDate=" + endDate + ", description=" + description + ", address=" + address
				+ ", time=" + time + ", hoursNeeded=" + hoursNeeded + ", volunteersNeeded=" + volunteersNeeded + "]";
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
		Project other = (Project) obj;
		if (id != other.id)
			return false;
		return true;
	}

	public List<ProjectVolunteer> getProjectVolunteer() {
		return projectVolunteer;
	}

	public void setProjectVolunteer(List<ProjectVolunteer> projectVolunteer) {
		this.projectVolunteer = projectVolunteer;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public boolean isActive() {
		return active;
	}

	public void setActive(boolean active) {
		this.active = active;
	}

	public Volunteer getOwner() {
		return owner;
	}

	public void setOwner(Volunteer owner) {
		this.owner = owner;
	}

	public String getStartDate() {
		return startDate;
	}

	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}

	public String getEndDate() {
		return endDate;
	}

	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public Address getAddress() {
		return address;
	}

	public void setAddress(Address address) {
		this.address = address;
	}

	public String getTime() {
		return time;
	}

	public void setTime(String time) {
		this.time = time;
	}

	public int getHoursNeeded() {
		return hoursNeeded;
	}

	public void setHoursNeeded(int hoursNeeded) {
		this.hoursNeeded = hoursNeeded;
	}

	public int getVolunteersNeeded() {
		return volunteersNeeded;
	}

	public void setVolunteersNeeded(int volunteersNeeded) {
		this.volunteersNeeded = volunteersNeeded;
	}

	public List<Volunteer> getVolunteers() {
		return volunteers;
	}

	public void setVolunteers(List<Volunteer> volunteers) {
		this.volunteers = volunteers;
	}

	public List<Category> getCategories() {
		return categories;
	}

	public void setCategories(List<Category> categories) {
		this.categories = categories;
	}
	
	public void addComment(Comments comment) {
		if(comments == null) {
			comments = new ArrayList<Comments>();
		}
		if(!comments.contains(comment)) {
			comments.add(comment);
		}
		
	}

	public void addVolunteer(Volunteer volunteer) {
		if (volunteers == null) {
			volunteers = new ArrayList<Volunteer>();
		}
		if (!volunteers.contains(volunteer)) {
			volunteers.add(volunteer);
			volunteer.addProject(this);
		}

	}

	public void removeVolunteer(Volunteer volunteer) {
		if (volunteers != null && volunteers.contains(volunteer)) {
			volunteers.remove(volunteer);
			volunteer.removeProject(this);
		}
	}

	public void addProjectVolunteer(ProjectVolunteer pv) {
		if (projectVolunteer == null) {
			volunteers = new ArrayList<Volunteer>();
		}
		if (!projectVolunteer.contains(pv)) {
			projectVolunteer.add(pv);
			pv.setProject(this);
		}
		
	}
	
	public void removeProjectVolunteer(ProjectVolunteer pv) {
		if (projectVolunteer != null && projectVolunteer.contains(pv)) {
			projectVolunteer.remove(pv);
//			pv.setProject(null);
		}
	}
	
	public void addItemsNeeded(ItemsNeeded itemNeeded) {
		if(itemsNeeded == null) {
			itemsNeeded = new ArrayList<>();
		}
		if(!itemsNeeded.contains(itemNeeded)) {
			itemsNeeded.add(itemNeeded);
		}
		
	}
	public void removeItemsNeeded(ItemsNeeded itemNeeded) {
		if(itemsNeeded !=null && itemsNeeded.contains(itemNeeded)) {
			itemsNeeded.remove(itemNeeded);
		}
	}

}
