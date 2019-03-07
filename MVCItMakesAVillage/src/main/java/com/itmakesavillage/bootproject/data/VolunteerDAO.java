package com.itmakesavillage.bootproject.data;

import java.util.List;
import java.util.Set;

import com.itmakesavillage.jpaproject.entities.Project;
import com.itmakesavillage.jpaproject.entities.Volunteer;


public interface VolunteerDAO {
	
	
	public Volunteer findVolunteer(int id);
	public List<Project> findProjects(int id);
	public List<Project> findOwnedProjects(int id);
	public Volunteer createVolunteer(Volunteer volunteer);
	public Volunteer updateVolunteer(int id, Volunteer volunteer);
	public Volunteer updateVolunteer(int id, Volunteer volunteer, int projectId);
	public Set<Volunteer> searchVolunteer(String keyword);
	public List<Volunteer> getAllVolunteer();

}
