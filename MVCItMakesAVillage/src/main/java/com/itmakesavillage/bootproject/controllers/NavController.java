package com.itmakesavillage.bootproject.controllers;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.itmakesavillage.bootproject.data.ProjectDAO;
import com.itmakesavillage.bootproject.data.ProjectVolunteerDAO;
import com.itmakesavillage.bootproject.data.VolunteerDAO;
import com.itmakesavillage.jpaproject.entities.Category;
import com.itmakesavillage.jpaproject.entities.Project;
import com.itmakesavillage.jpaproject.entities.ProjectVolunteer;
import com.itmakesavillage.jpaproject.entities.User;
import com.itmakesavillage.jpaproject.entities.Volunteer;

@Controller
public class NavController {
	
	@Autowired
	ProjectDAO pDAO;
	@Autowired
	VolunteerDAO vDAO;
	@Autowired
	ProjectVolunteerDAO pvDAO;
	
	@RequestMapping(path = "home.do", method = RequestMethod.GET)
	public String goHome(HttpSession session) {
		
		List<Category> catList = pDAO.getAllCategories();
		List<Project> projectList = pDAO.getAllProject();
		int hoursContributed = 0, hoursPledged = 0, projects=0, volunteers = 0;
		for (Project project : projectList) {
			projects++;
			volunteers += project.getVolunteers().size();
		}
		List<ProjectVolunteer> pvList = pvDAO.getAllProjectVolunteers();
		for (ProjectVolunteer projectVolunteer : pvList) {
			hoursContributed += projectVolunteer.getHoursActual();
			hoursPledged += projectVolunteer.getHoursPledged();
		}
		
		session.setAttribute("catList", catList);
		session.setAttribute("hoursPledged", hoursPledged);
		session.setAttribute("hoursContributed", hoursContributed);
		session.setAttribute("projects", projects);
		session.setAttribute("volunteers", volunteers);
		
		System.out.println(catList);
		
		return "index";
	}
	@RequestMapping(path = "", method = RequestMethod.GET)
	public String gobasicpath(HttpSession session) {
		
		List<Category> catList = pDAO.getAllCategories();
		List<Project> projectList = pDAO.getAllProject();
		int hoursContributed = 0, hoursPledged = 0, projects=0, volunteers = 0;
		for (Project project : projectList) {
			projects++;
			volunteers += project.getVolunteers().size();
		}
		List<ProjectVolunteer> pvList = pvDAO.getAllProjectVolunteers();
		for (ProjectVolunteer projectVolunteer : pvList) {
			hoursContributed += projectVolunteer.getHoursActual();
			hoursPledged += projectVolunteer.getHoursPledged();
		}
		
		session.setAttribute("catList", catList);
		session.setAttribute("hoursPledged", hoursPledged);
		session.setAttribute("hoursContributed", hoursContributed);
		session.setAttribute("projects", projects);
		session.setAttribute("volunteers", volunteers);
		
		System.out.println(catList);
		
		return "index";
	}

	@RequestMapping(path = "account.do", method = RequestMethod.GET)
	public String account(HttpSession session) {
		User user = (User) session.getAttribute("user");
		
		if (user == null) {
			
			return "index";
		}
		System.out.println("USerID= "+user.getId());
		
		Volunteer volunteer = vDAO.findVolunteer(user.getId());
		if(volunteer != null) {
				
			volunteer.setProjects(vDAO.findProjects(user.getId()));
			volunteer.setOwnedProjects(vDAO.findOwnedProjects(user.getId()));
			user.setVolunteer(volunteer);
		}
		session.setAttribute("user", user);
		
		
		
		
		return "profile";
	}

	@RequestMapping(path = "admin.do", method = RequestMethod.GET)
	public String adminPage(HttpSession session) {
		User user = (User) session.getAttribute("user");
		if (!user.getRole().equals("admin")) {
			return "index";
		}
		return "admin";
	}
	
	@RequestMapping(path = "about.do", method = RequestMethod.GET)
	public String aboutPage() {
		return "about";
	}

}
