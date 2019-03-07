package com.itmakesavillage.bootproject.controllers;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.itmakesavillage.bootproject.data.CompanyDAO;
import com.itmakesavillage.bootproject.data.ProjectDAO;
import com.itmakesavillage.bootproject.data.ProjectVolunteerDAO;
import com.itmakesavillage.bootproject.data.UserDAO;
import com.itmakesavillage.bootproject.data.VolunteerDAO;
import com.itmakesavillage.jpaproject.entities.Address;
import com.itmakesavillage.jpaproject.entities.Category;
import com.itmakesavillage.jpaproject.entities.Comments;
import com.itmakesavillage.jpaproject.entities.Company;
import com.itmakesavillage.jpaproject.entities.Item;
import com.itmakesavillage.jpaproject.entities.ItemsCommitted;
import com.itmakesavillage.jpaproject.entities.ItemsNeeded;
import com.itmakesavillage.jpaproject.entities.Project;
import com.itmakesavillage.jpaproject.entities.ProjectVolunteer;
import com.itmakesavillage.jpaproject.entities.User;
import com.itmakesavillage.jpaproject.entities.Volunteer;
@Controller
public class ProjectController {
    @Autowired
    private ProjectDAO projectDAO;
    @Autowired
    private VolunteerDAO volunteerDAO;
    @Autowired
    private ProjectVolunteerDAO pvDAO;
    @Autowired
    private UserDAO userDAO;
    @Autowired
    private CompanyDAO companyDAO;
    
    @RequestMapping(path = "searchLocal.do", method = RequestMethod.GET)
    public String searchLocal(Model model, HttpSession session) {
    	 User user = (User) session.getAttribute("user");
         if (user == null) {
             return "login";
         }
         
    	List<Project> projectList = projectDAO.getAllProject();
    	List<Project> localProjects = new ArrayList<>();
    	
    	for (Project project : projectList) {
			if(project.getAddress().getState().equals(user.getVolunteer().getAddress().getState())) {
				localProjects.add(project);
			}
		}
    	
    	boolean notFound = false;
    	if (projectList.isEmpty()) {
    		notFound = true;
    		model.addAttribute("notFound", notFound);
    		return "index";
    	}
    	
    	model.addAttribute("projectList", localProjects);
    	return "index";
    }
    @RequestMapping(path = "searchKW.do", method = RequestMethod.GET)
    public String searchKW(String keyword, Model model) {
        Set<Project> projectList = projectDAO.searchProject(keyword);
        boolean notFound = false;
        if (projectList.isEmpty()) {
            notFound = true;
            model.addAttribute("notFound", notFound);
            return "index";
        }
        model.addAttribute("projectList", projectList);
        return "index";
    }
    @RequestMapping(path = "searchCat.do", method = RequestMethod.GET)
    public String searchCat(String[] keyword, Model model) {
        Set<Project> projectList = new HashSet<Project>();
        boolean needCategory = false;
        if (keyword == null) {
            needCategory = true;
            model.addAttribute("needCategory", needCategory);
            return "index";
        }
        for (String word : keyword) {
            projectList.addAll(projectDAO.searchProject(word));
        }
        boolean notFound = false;
        if (projectList.isEmpty() || projectList == null) {
            notFound = true;
            model.addAttribute("notFound", notFound);
            return "index";
        }
        model.addAttribute("projectList", projectList);
        return "index";
    }
    @RequestMapping(path = "viewProject.do", method = RequestMethod.GET)
    public String goToViewProject(Integer projectId, Model model, RedirectAttributes redir, HttpSession session) {
        System.out.println(projectId);
        if(projectId == null) {
            Map<String, Object> projectIdKey = redir.asMap();
            System.out.println(projectIdKey);
            projectId= (Integer) projectIdKey.remove("projectId");
            System.out.println(projectId);
        }
        
        List<Company> companyList = companyDAO.getAllCompanies();
        
        Project project = projectDAO.findProject(projectId);
        User user = (User)session.getAttribute("user");
        boolean inList = false;
        if(user != null) {
            
            inList = project.getVolunteers().contains(user.getVolunteer());
        }
        System.out.println("******"+project.getProjectVolunteer());
        
        model.addAttribute("companyList", companyList);
        model.addAttribute("inList", inList);
        model.addAttribute("pvList", project.getProjectVolunteer());
        model.addAttribute("project", project);
        return "viewProject";
    }
    @RequestMapping(path = "createProject.do", method = RequestMethod.GET)
    public String goToCreateProject(Model model, HttpSession session) {
        if (session.getAttribute("user") == null) {
            return "login";
        }
        model.addAttribute("itemList", projectDAO.getAllItems());
        model.addAttribute("catList", projectDAO.getAllCategories());
        model.addAttribute("stateList", projectDAO.getAllStates());
        return "createProject";
    }
    @RequestMapping(path = "createProject.do", method = RequestMethod.POST)
    public String createProject(HttpSession session, Project project, RedirectAttributes redir,
            @RequestParam("sTime") String[] sTime, @RequestParam("sDate") String[] sDate,
            @RequestParam("eDate") String[] eDate, @RequestParam(required=false, name = "cat") Integer[] cat, @RequestParam(required=false, name = "itemid") Integer itemId,
            @RequestParam(required=false, name = "itemQuantity") Integer itemQuantity,  @RequestParam(name="ownerId") Integer ownerId,
            Address address, @RequestParam(name="stateId") Integer stateId) {
        
    	if(itemId != null) {
	    		
	    		ItemsNeeded needed = new ItemsNeeded();
	    		Item item = projectDAO.getItem(itemId);
	    		needed.setItem(item);
	    		needed.setProject(project);
	    		needed.setQuantity(itemQuantity);
	    		needed = projectDAO.createItemsNeeded(needed);
	    		project.addItemsNeeded(needed);
			
    	}
    	
        address.setState(projectDAO.getStateById(stateId));
        address = projectDAO.createAddress(address);
        project.setAddress(address);
        project.setTime(sTime[0]);
        project.setStartDate(sDate[0]);
        project.setEndDate(eDate[0]);
        project.setOwner(volunteerDAO.findVolunteer(ownerId));
        if (session.getAttribute("user") == null) {
            return "login";
        }
        List<Category> catList = new ArrayList<>();
        
        if (cat != null && cat.length > 0) {
            for (Integer catId : cat) {
                catList.add(projectDAO.findCategoryById(catId));
            }
            project.setCategories(null);
            project.setCategories(catList);
        } else {
            List<Category> catList2 = new ArrayList<>();
            catList2.add(projectDAO.findCategoryById(6));
            project.setCategories(catList2);
        }
        project = projectDAO.createProject(project);
        redir.addAttribute("projectId", project.getId());
        return "redirect:viewProject.do";
    }
    //TODO
    @RequestMapping(path = "joinProject.do", method = RequestMethod.POST)
    public String joinProject(HttpSession session, Integer projectId, Integer hours, 
    		Integer companyId, Model model, RedirectAttributes redir,
    		@RequestParam(required=false, name = "itemid") Integer itemId,
            @RequestParam(required=false, name = "itemQuantity") Integer itemQuantity) {
       
    	User user = (User) session.getAttribute("user");
        if (user == null) {
            model.addAttribute("projectId", projectId);
            return "loginToProject";
        }
        Project project = projectDAO.findProject(projectId);
        Volunteer volunteer = volunteerDAO.findVolunteer(user.getId());
        ProjectVolunteer pv = new ProjectVolunteer();
        if(companyId != 0) {
        	
	        Company company = companyDAO.findCompany(companyId);
	        pv.setCompany(company);
        
        }
        
        
        pv.setVolunteer(volunteer);
        pv.setProject(project);
        pv.setHoursPledged(hours);
        pvDAO.createPV(pv);
        
        
        ItemsCommitted itemC = new ItemsCommitted();
        if(itemId != null) {
        		Item item = projectDAO.getItem(itemId);
        		itemC.setItem(item);
        		itemC.setProjectVolunteer(pv);
        		itemC.setQuantity(itemQuantity);
        		itemC = pvDAO.createItemsCommitted(itemC);
        		pv.addItemsCommitted(itemC);
        }
        	
        	List<ItemsNeeded> neededList = project.getItemsNeeded();
        	List<ItemsNeeded> remainingList = new ArrayList<>();
        	int remainingQ =0;
				for (ItemsNeeded needed : neededList) {
					if(needed.getItem().equals(itemC.getItem())) {
						remainingQ = needed.getQuantity() - itemC.getQuantity();
						if(remainingQ >0) {
							needed.setQuantity(remainingQ);
							remainingList.add(needed);
						}
						else {
							needed.setQuantity(0);
							remainingList.add(needed);
						}
						break;
					}
				}
					
        	for (ItemsNeeded item : remainingList) {
				//item has a .equals on id only. so by doing this 
        		//then adding it back in will set the new fields
        		project.getItemsNeeded().remove(item);
        		project.getItemsNeeded().add(item);
        	}
        	
        	project = projectDAO.updateProject(project.getId(), project);
        	pv = pvDAO.updatePV(pv);
        
//      volunteer = volunteerDAO.updateVolunteer(
//              volunteer.getUserid(),
//              volunteer, projectId);
        redir.addAttribute("projectId", project.getId());
        return "redirect:viewProject.do";
        
        
    }
    @RequestMapping(path = "editProject.do", method = RequestMethod.GET)
    public String goToEditProject(@RequestParam("projectId") Integer projectId, HttpSession session, Model model) {
       
    	User user = (User) session.getAttribute("user");
        
        Project project = projectDAO.findProject(projectId);
        if (user == null) {
            return "login";
        }
        List<Category> projectCategories = projectDAO.findProject(projectId).getCategories();
        List<Category> allCategories = projectDAO.getAllCategories();
        if (projectCategories != null) {
            allCategories.removeAll(projectCategories);
        }
        List<Item> allItems = projectDAO.getAllItems();
        List<ItemsNeeded> projectItemsNeeded = project.getItemsNeeded();
        if (projectItemsNeeded != null) {
        	for (ItemsNeeded itemsNeeded : projectItemsNeeded) {
				
        		allItems.remove(itemsNeeded.getItem());
			}
        }
        model.addAttribute("remainingItems", allItems);
        model.addAttribute("currentItemsNeeded", projectItemsNeeded);
        
        model.addAttribute("rCatList", allCategories);
        model.addAttribute("pCatList", projectCategories);
        model.addAttribute("stateList", projectDAO.getAllStates());
        model.addAttribute("project", project);
        return "editProject";
    }
    @RequestMapping(path = "editProject.do", method = RequestMethod.POST)
    public String editProject(HttpSession session, RedirectAttributes redir, Project project,
            @RequestParam("sTime") String[] sTime, @RequestParam("sDate") String[] sDate,
            @RequestParam("eDate") String[] eDate, @RequestParam(required=false, name="cat") Integer[] cat,
            Address address, @RequestParam(name="stateId") Integer stateId) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "login";
        }
        
        address.setState(projectDAO.getStateById(stateId));
        address = projectDAO.updateAddress(address);
        
        project.setAddress(address);
        project.setTime(sTime[0]);
        project.setStartDate(sDate[0]);
        project.setEndDate(eDate[0]);
        List<Category> catList = new ArrayList<>();
        System.out.println("catList arr" + cat);
        if (cat != null && cat.length > 0) {
            for (Integer catId : cat) {
                catList.add(projectDAO.findCategoryById(catId));
            }
            project.setCategories(null);
            project.setCategories(catList);
        } else {
            List<Category> catList2 = new ArrayList<>();
            catList2.add(projectDAO.findCategoryById(6));
            project.setCategories(catList2);
        }
        System.out.println(project);
        project = projectDAO.updateProject(project.getId(), project);
        redir.addAttribute("projectId", project.getId());
        return "redirect:viewProject.do";
    }
    @RequestMapping(path = "adminFindProject.do", method = RequestMethod.GET)
    public String adminFindProject(String keyword, HttpSession session, Model model) {
        Set<Project> projectList = projectDAO.searchProject(keyword);
        boolean notFound = false;
        if (projectList.isEmpty()) {
            notFound = true;
            model.addAttribute("projectNotFound", notFound);
            return "admin";
        }
        model.addAttribute("projectList", projectList);
        return "admin";
    }
    @RequestMapping(path = "addComment.do", method = RequestMethod.POST)
    public String addComment(@RequestParam(name="comment") String commentText,
            @RequestParam(name="userId") Integer userId,
            @RequestParam(name="projectId") Integer projectId, HttpSession session, Model model, RedirectAttributes redir) {
        Date now = new Date();
        Date rightNow = new Date();
        
        String datePattern = "yyyy-MM-dd";
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat(datePattern);
        String timePattern = "hh:mm a";
        SimpleDateFormat simpleTimeFormat = new SimpleDateFormat(timePattern);
        String date = simpleDateFormat.format(now);
        String time = simpleTimeFormat.format(rightNow);
        Comments comment = new Comments();
        comment.setComment(commentText);
        comment.setProject(projectDAO.findProject(projectId));
        comment.setUser(userDAO.findUser(userId));
        comment.setDate(date);
        comment.setTime(time);
        comment.setActive(true);
        comment = projectDAO.createComment(comment);
        redir.addAttribute("projectId", comment.getProject().getId());
        return "redirect:viewProject.do";
    }
    @RequestMapping(path = "removeComment.do", method = RequestMethod.POST)
    public String removeComment(Integer commentId, HttpSession session, Model model, RedirectAttributes redir) {
        Comments comment = projectDAO.findComment(commentId);
        comment = projectDAO.deactivateComment(commentId);
        redir.addAttribute("projectId", comment.getProject().getId());
        return "redirect:viewProject.do";
    }
    
    @RequestMapping(path = "reactivateComment.do", method = RequestMethod.POST)
    public String reactivateComment(Integer commentId, HttpSession session, Model model, RedirectAttributes redir) {
        Comments comment = projectDAO.findComment(commentId);
        comment = projectDAO.reactivateComment(commentId);
        redir.addAttribute("projectId", comment.getProject().getId());
        return "redirect:viewProject.do";
    }
    
    @RequestMapping(path = "editItemsNeeded.do", method = RequestMethod.POST)
    public String editItemsNeeded(@RequestParam("projectId") Integer projectId, Integer itemId, Integer quantity, HttpSession session, Model model, RedirectAttributes redir) {
    	
    	Project project = projectDAO.findProject(projectId);
    	if(itemId != null) {
    		
    		ItemsNeeded needed = projectDAO.getItemsNeeded(itemId);
    		
    		needed.setQuantity(quantity);
    		project.removeItemsNeeded(needed);
    		project.addItemsNeeded(needed);
    		
    		if(quantity ==0) {
    			project.removeItemsNeeded(needed);
    			projectDAO.removeItemsNeeded(needed);
    		}
    		
    		project=projectDAO.updateProject(projectId, project);
    	}
    	
    	redir.addAttribute("projectId", projectId);
    	return "redirect:viewProject.do";
    }
    @RequestMapping(path = "addItemsNeeded.do", method = RequestMethod.POST)
    public String addItemsNeeded(@RequestParam("projectId") Integer projectId, Integer itemId, Integer quantity, HttpSession session, Model model, RedirectAttributes redir) {
    	
    	Project project = projectDAO.findProject(projectId);
    	if(itemId != null) {
    		
    		ItemsNeeded needed = new ItemsNeeded();
    		Item item = projectDAO.getItem(itemId);
    		needed.setItem(item);
    		needed.setQuantity(quantity);
    		needed.setProject(project);
    		needed = projectDAO.createItemsNeeded(needed);
    		project.addItemsNeeded(needed);
    		
    		project=projectDAO.updateProject(projectId, project);
    		
    	}
    	
    	redir.addAttribute("projectId", projectId);
    	return "redirect:viewProject.do";
    }
    
    	
    	
    	
    	
    	
    	
    	
    	
    	
    	
    	
    	
    	
    	
    	
    
    
}