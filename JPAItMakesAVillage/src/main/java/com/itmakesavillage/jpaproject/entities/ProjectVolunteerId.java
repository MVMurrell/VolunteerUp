package com.itmakesavillage.jpaproject.entities;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Embeddable;

@Embeddable
public class ProjectVolunteerId implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	
	@Column(name = "project_id")
    private int projectId;
    
    @Column(name = "volunteer_id")
    private int volunteerId;

	public int getProjectId() {
		return projectId;
	}

	public void setProjectId(int projectId) {
		this.projectId = projectId;
	}

	public int getVolunteerId() {
		return volunteerId;
	}

	public void setVolunteerId(int volunteerId) {
		this.volunteerId = volunteerId;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + projectId;
		result = prime * result + volunteerId;
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
		ProjectVolunteerId other = (ProjectVolunteerId) obj;
		if (projectId != other.projectId)
			return false;
		if (volunteerId != other.volunteerId)
			return false;
		return true;
	}

	public ProjectVolunteerId(Integer projectId, Integer volunteerId) {
		super();
		this.projectId = projectId;
		this.volunteerId = volunteerId;
	}

	public ProjectVolunteerId() {
		super();
	}

	@Override
	public String toString() {
		return "ProjectVolunteerId [projectId=" + projectId + ", volunteerId=" + volunteerId + "]";
	}
    
    
}
