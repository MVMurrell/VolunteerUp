package com.itmakesavillage.bootproject.data;

import java.util.List;

import com.itmakesavillage.jpaproject.entities.ItemsCommitted;
import com.itmakesavillage.jpaproject.entities.Project;
import com.itmakesavillage.jpaproject.entities.ProjectVolunteer;

public interface ProjectVolunteerDAO {
	
//	public ProjectVolunteer addPV();
//	public ProjectVolunteer removePV();
	public ProjectVolunteer updatePV(ProjectVolunteer pv);
	public ProjectVolunteer findPV(int projectId, int volunteerId);
	public List<ProjectVolunteer> findPVbyProjectId(int projectId);
	public ProjectVolunteer createPV(ProjectVolunteer pv);
	List<ProjectVolunteer> getAllProjectVolunteers();
	ProjectVolunteer findPVById(int id);
	ItemsCommitted findItemsCommittedById(int id);
	ItemsCommitted createItemsCommitted(ItemsCommitted itemsCommitted);
	ItemsCommitted deleteItemsCommitted(ItemsCommitted itemsCommitted);
	ProjectVolunteer deletePV(ProjectVolunteer pv);
	ProjectVolunteer deleteallItemsforPV(ProjectVolunteer pv);
	ProjectVolunteer deleteProject(ProjectVolunteer pv, Project project);

}
