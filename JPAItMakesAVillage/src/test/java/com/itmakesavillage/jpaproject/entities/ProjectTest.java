package com.itmakesavillage.jpaproject.entities;

import static org.junit.Assert.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertEquals;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

class ProjectTest {
	private Project project;
	private static EntityManagerFactory emf;
	private EntityManager em;
	
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
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		project = null;
	}

	@Test
	void test_project_field_mappings() {
		assertEquals("TP Steves House", project.getTitle());
//		assertEquals(1, project.getOwnerId());
//		assertEquals(1, project.getOwnerId());
		assertEquals("2019-01-18", project.getStartDate().toString());
		assertEquals("2019-01-18", project.getEndDate().toString());
		assertEquals("TP Everywhere on and around Steves house.", project.getDescription());
		assertEquals(5, project.getAddress().getId());
		assertEquals("20:00:00", project.getTime().toString());
		assertEquals(6, project.getHoursNeeded());
		assertEquals(6, project.getHoursNeeded());
	}
	
	@Test
	void test_many_to_many_mapping() {
		assertNotNull(project.getCategories());
		assertNotNull(project.getProjectVolunteer());
		assertNotNull(project.getVolunteers());
	}

}
