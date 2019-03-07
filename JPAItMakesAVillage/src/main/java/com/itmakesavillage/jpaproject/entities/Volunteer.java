package com.itmakesavillage.jpaproject.entities;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;

@Entity
public class Volunteer {

	@Id
	@Column(name="user_id")
	private int userid;
	@Column(name="phone_number")
	private String phone;
	private String dob;
	@OneToOne
	@JoinColumn(name="address_id")
	private Address address;
	@Column(name="first_name")
	private String firstName;
	@Column(name="last_name")
	private String lastName;
	@Column(name="picture_url")
	private String  pictureURL;
	private String about;
	@OneToOne
	@JoinColumn(name="user_id")
	private User user;
	@ManyToMany(fetch=FetchType.EAGER)
	@JoinTable(name="project_volunteer", joinColumns=@JoinColumn(name="volunteer_id"),
	                              inverseJoinColumns=@JoinColumn(name="project_id"))
	private List<Project> projects;
	
	@OneToMany(mappedBy="volunteer")
	private List<ProjectVolunteer> projectVolunteers;
	
	@OneToMany(mappedBy="owner")
	private List<Project> ownedProjects;
	
	
	public List<Project> getOwnedProjects() {
		return ownedProjects;
	}

	public void setOwnedProjects(List<Project> ownedProjects) {
		this.ownedProjects = ownedProjects;
	}

	public User getUser() {
		return user;
	}
	
	public void setUser(User user) {
		this.user = user;
	}
	
	public List<Project> getProjects() {
		return projects;
	}

	public void setProjects(List<Project> projects) {
		this.projects = projects;
	}

	public List<ProjectVolunteer> getProjectVolunteers() {
		return projectVolunteers;
	}

	public void setProjectVolunteers(List<ProjectVolunteer> projectVolunteers) {
		this.projectVolunteers = projectVolunteers;
	}

	public Volunteer() {
		super();
	}

	public Volunteer(int userid, String phone, String dob, Address addressId, String firstName, String lastName,
			String pictureURL, String about) {
		super();
		this.userid = userid;
		this.phone = phone;
		this.dob = dob;
		this.address = addressId;
		this.firstName = firstName;
		this.lastName = lastName;
		this.pictureURL = pictureURL;
		this.about = about;
	}

	@Override
	public String toString() {
		return "Volunteer [userid=" + userid + ", phone=" + phone + ", dob=" + dob + ", address=" + address
				+ ", firstName=" + firstName + ", lastName=" + lastName + ", pictureURL=" + pictureURL + ", about="
				+ about + "]";
	}


	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + userid;
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
		Volunteer other = (Volunteer) obj;
		if (userid != other.userid)
			return false;
		return true;
	}

	public int getUserid() {
		return userid;
	}

	public void setUserid(int userid) {
		this.userid = userid;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getDob() {
		return dob;
	}

	public void setDob(String dob) {
		this.dob = dob;
	}


	public Address getAddress() {
		return address;
	}

	public void setAddress(Address address) {
		this.address = address;
	}

	public String getFirstName() {
		return firstName;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public String getLastName() {
		return lastName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	public String getPictureURL() {
		return pictureURL;
	}

	public void setPictureURL(String pictureURL) {
		this.pictureURL = pictureURL;
	}

	public String getAbout() {
		return about;
	}

	public void setAbout(String about) {
		this.about = about;
	}
	
	public void addProjectVolunteer(ProjectVolunteer pv) {
		if(projectVolunteers == null) {
			projectVolunteers = new ArrayList<ProjectVolunteer>();
		}
		if(!projectVolunteers.contains(pv)) {
			projectVolunteers.add(pv);
			pv.setVolunteer(this);
		}
	}
	public void removeProjectVolunteer(ProjectVolunteer pv) {
		if(projectVolunteers != null && projectVolunteers.contains(pv)) {
			projectVolunteers.remove(pv);
//			pv.setVolunteer(null);
		}
	}
	
	public void addProject(Project project) {
		if(projects == null) {
			projects = new ArrayList<Project>();
		}
		if(!projects.contains(project)) {
			projects.add(project);
			project.addVolunteer(this);
		}
	}
	public void removeProject(Project project) {
		if(projects != null && projects.contains(project)) {
			projects.remove(project);
			project.removeVolunteer(this);
		}
	}
}
