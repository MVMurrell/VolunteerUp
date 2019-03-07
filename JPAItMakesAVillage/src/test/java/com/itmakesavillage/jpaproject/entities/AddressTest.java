package com.itmakesavillage.jpaproject.entities;

import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.fail;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;


class AddressTest {
	private static EntityManagerFactory emf;
	private EntityManager em;
	private Address address;

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
		address = em.find(Address.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		address = null;
	}

	@Test
	void test_address_fields_mapping() {
		assertEquals("42 Wallaby Way", address.getStreet());
		assertEquals(null, address.getStreet2());
		assertEquals("Denver", address.getCity());
		assertEquals("Colorado", address.getState());
		assertEquals("80222", address.getZip());
		
	}
	
	@Test
	void test_list_mapping() {
		Project project = address.getProjects().get(0);
		assertNotNull(address.getProjects());
		assertFalse(address.getProjects().isEmpty());
		assertEquals(2,project.getId());
	}

}
