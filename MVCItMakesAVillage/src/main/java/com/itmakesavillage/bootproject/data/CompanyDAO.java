package com.itmakesavillage.bootproject.data;

import java.util.List;

import com.itmakesavillage.jpaproject.entities.Company;

public interface CompanyDAO {
	
	
	
	public Company createCompany(Company company);
	public List<Company> getAllCompanies();
	public Company findCompany(int id);
		

}
