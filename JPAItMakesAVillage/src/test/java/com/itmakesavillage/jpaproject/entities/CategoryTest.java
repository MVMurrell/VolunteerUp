package com.itmakesavillage.jpaproject.entities;

import static org.junit.jupiter.api.Assertions.*;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

class CategoryTest {
	private Category category;
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
		category = em.find(Category.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		category = null;
	}

	@Test
	void test_category_field_mappings() {
		assertEquals("Clean Up", category.getName());
		assertEquals("Clean Up Stuff", category.getDescription());
	}
	
	@Test
	void test_project_list_mapping() {
		Project project = category.getProjects().get(0);
		assertNotNull(category.getProjects());
		assertFalse(category.getProjects().isEmpty());
		assertEquals(2, project.getId());
		
	}

}
