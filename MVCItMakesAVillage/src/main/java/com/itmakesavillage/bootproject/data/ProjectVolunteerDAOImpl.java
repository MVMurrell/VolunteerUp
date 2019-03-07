package com.itmakesavillage.bootproject.data;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.transaction.Transactional;

import org.springframework.stereotype.Service;

import com.itmakesavillage.jpaproject.entities.ItemsCommitted;
import com.itmakesavillage.jpaproject.entities.Project;
import com.itmakesavillage.jpaproject.entities.ProjectVolunteer;
import com.itmakesavillage.jpaproject.entities.Volunteer;

@Transactional
@Service
public class ProjectVolunteerDAOImpl implements ProjectVolunteerDAO {

	@PersistenceContext
	EntityManager em;

	@Override
	public ProjectVolunteer updatePV(ProjectVolunteer pv) {
		ProjectVolunteer managed = em.find(ProjectVolunteer.class, pv.getId());
		managed.setHoursActual(pv.getHoursActual());
		managed.setHoursPledged(pv.getHoursPledged());
		managed.setProject(pv.getProject());
		managed.setVolunteer(pv.getVolunteer());
		managed.setItemsCommitted(pv.getItemsCommitted());
		return managed;
	}

	@Override
	public ProjectVolunteer findPV(int projectId, int volunteerId) {
		
		List<ProjectVolunteer> pvList = null;
		List<ProjectVolunteer> pvVolunteerList = new ArrayList<ProjectVolunteer>();
		String query = "SELECT pv FROM ProjectVolunteer pv";
		pvList = em.createQuery(query, ProjectVolunteer.class).getResultList();
		
		for (ProjectVolunteer pv : pvList) {
			if(pv.getVolunteer().getUserid() == volunteerId) {
				pvVolunteerList.add(pv);
			}
		}
		for (ProjectVolunteer pv : pvVolunteerList) {
			if(pv.getProject().getId() == projectId) {
				return pv;
			}
		}
//		ProjectVolunteer managed = em.find(ProjectVolunteer.class, 1 );
		return null;
	}

	@Override
	public List<ProjectVolunteer> findPVbyProjectId(int projectId) {
		
		List<ProjectVolunteer> pvList = new ArrayList<ProjectVolunteer>();
		List<ProjectVolunteer> pvListProject = new ArrayList<ProjectVolunteer>();
		String query = "select pv from ProjectVolunteer pv";
		pvList = em.createQuery(query, ProjectVolunteer.class).getResultList();
		for (ProjectVolunteer pv : pvList) {
			if(pv.getProject().getId() == projectId) {
				pvListProject.add(pv);
			}
		}
		
		System.out.println(pvList);
		return pvList;
	}

	@Override
	public ProjectVolunteer createPV(ProjectVolunteer pv) {
		em.persist(pv);
		
		return pv;
	}

	@Override
	public List<ProjectVolunteer> getAllProjectVolunteers() {
		List<ProjectVolunteer> pvList = new ArrayList<ProjectVolunteer>();
		String query = "select pv from ProjectVolunteer pv";
		pvList = em.createQuery(query, ProjectVolunteer.class).getResultList();
		return pvList;
	}
	@Override
	public ProjectVolunteer findPVById(int id) {
		
		return em.find(ProjectVolunteer.class, id);
	}
	@Override
	public ItemsCommitted findItemsCommittedById(int id) {
		
		return em.find(ItemsCommitted.class, id);
	}
	@Override
	public ItemsCommitted createItemsCommitted(ItemsCommitted itemsCommitted) {
		em.persist(itemsCommitted);
		return itemsCommitted;
	}
	@Override
	public ItemsCommitted deleteItemsCommitted(ItemsCommitted itemsCommitted) {
		em.remove(itemsCommitted);
		return itemsCommitted;
	}
	
	@Override
	public ProjectVolunteer deletePV(ProjectVolunteer pv) {
		em.remove(pv);
		return pv;
	}
	@Override
	public ProjectVolunteer deleteallItemsforPV(ProjectVolunteer pv) {
		String query = "delete from ItemsCommitted i where  i.projectVolunteer.id = :id";
			em.createQuery(query).setParameter("id", pv.getId()).executeUpdate();
		
		return pv;
	}
	@Override
	public ProjectVolunteer deleteProject(ProjectVolunteer pv, Project project) {
		pv = em.find(ProjectVolunteer.class, pv.getId());
		
		this.deleteallItemsforPV(pv);
		em.flush();
		Volunteer vol = pv.getVolunteer();
//		vol.removeProjectVolunteer(pv);
//		vol.removeProject(project);
		Project p = new Project();
		p.setId(p.getId());
		vol.removeProject(p);
		vol.removeProjectVolunteer(pv);
		project.removeProjectVolunteer(pv);
//		pv.getVolunteer().removeProject(project);
//		project.removeVolunteer(vol);
		
		String query = "delete from ProjectVolunteer pv where  pv.id = :id";
		em.createQuery(query).setParameter("id", pv.getId()).executeUpdate();
	
		return pv;
	}
	
	
	
	
	
}
