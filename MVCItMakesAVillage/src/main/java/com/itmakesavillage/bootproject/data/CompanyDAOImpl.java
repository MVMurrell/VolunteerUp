package com.itmakesavillage.bootproject.data;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.transaction.Transactional;

import org.springframework.stereotype.Service;

import com.itmakesavillage.jpaproject.entities.Company;

@Transactional
@Service
public class CompanyDAOImpl implements CompanyDAO {

	
	@PersistenceContext
	EntityManager em;
	
	@Override
	public Company createCompany(Company company) {

		em.persist(company);
		
		return company;
	}

	@Override
	public List<Company> getAllCompanies() {
		List<Company> companyList = new ArrayList<>();
		String query = "select c from Company c";
		companyList = em.createQuery(query, Company.class).getResultList();
		return companyList;
	}

	@Override
	public Company findCompany(int id) {
		return em.find(Company.class, id);
	}

}
