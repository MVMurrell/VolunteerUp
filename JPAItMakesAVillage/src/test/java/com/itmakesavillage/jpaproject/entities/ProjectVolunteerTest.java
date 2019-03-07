package com.itmakesavillage.jpaproject.entities;

import static org.junit.Assert.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertEquals;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

class ProjectVolunteerTest {

	private static EntityManagerFactory emf;
	private EntityManager em;
	private Project project;
	private Volunteer volunteer;

	@BeforeAll
	static void setUpBeforeClass() throws Exception {
		emf = Persistence.createEntityManagerFactory("villagedb");
	}

	@AfterAll
	static void tearDownAfterClass() throws Exception {
		emf.close();
	}

	@BeforeEach
	void setUp() throws Exception {
		em = emf.createEntityManager();
		project = em.find(Project.class, 1);
		volunteer = em.find(Volunteer.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		project = null;
		volunteer= null;
	}

	@Test
	void test_mapping_to_volunteer() {
		List<Project> projects = volunteer.getProjects();
		List<Volunteer> volunteers = project.getVolunteers();
		
		assertNotNull(projects);
		assertEquals("Clean up a Park", projects.get(1).getTitle());
		assert(projects.size()>0);
		assertEquals("456-677-3332",volunteers.get(2).getPhone());
		assert(volunteers.size()>0);
		
	}

}
