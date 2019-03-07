package com.itmakesavillage.bootproject.controllers;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.itmakesavillage.bootproject.data.UserDAO;
import com.itmakesavillage.jpaproject.entities.User;

@Controller
public class LoginController {
	@Autowired
	private UserDAO userDAO;
	
	@RequestMapping(path="login.do", method=RequestMethod.GET)
	public String goToLoginPage(HttpSession session) {
		User user = (User)session.getAttribute("user");
		if(user != null) {
			return "redirect:index.do";
		}
		return "login";		
	}
	@RequestMapping(path="login.do", method=RequestMethod.POST)
	public String userLogin(User user, HttpSession session, RedirectAttributes redir) {
		System.out.println(user);
		user = userDAO.getUserByUserNameAndPassword(user.getUserName(), user.getPassword());
		System.out.println(user);
		
		boolean loginFail = false;
		boolean activeFail = false;
		
		if(user == null) {
			loginFail = true;
			redir.addFlashAttribute("loginFail", loginFail);
			session.removeAttribute("user");
			session.setAttribute("user", null);
			System.out.println("checking my stuff");
			return "redirect:login.do";
		}
		if(!user.isActive()) {
			activeFail=true;
			redir.addFlashAttribute("activeFail", activeFail);
			redir.addFlashAttribute("userId", user.getId());
			session.setAttribute("user", null);
			return "redirect:login.do";
		
		}
			session.setAttribute("user", user);
		
		return "redirect:home.do";
	}
	@RequestMapping(path="loginToProject.do", method=RequestMethod.POST)
	public String userLoginToProject(User user, Integer projectId, HttpSession session, RedirectAttributes redir) {
		System.out.println(user);
		user = userDAO.getUserByUserNameAndPassword(user.getUserName(), user.getPassword());
		System.out.println(user);
		
		boolean loginFail = false;
		boolean activeFail = false;
		
		if(user == null) {
			loginFail = true;
			redir.addFlashAttribute("loginFail", loginFail);
			session.removeAttribute("user");
			session.setAttribute("user", null);
			System.out.println("checking my stuff");
			return "redirect:login.do";
		}
		if(!user.isActive()) {
			activeFail=true;
			redir.addFlashAttribute("activeFail", activeFail);
			redir.addFlashAttribute("userId", user.getId());
			session.setAttribute("user", null);
			return "redirect:login.do";
			
		}
		session.setAttribute("user", user);
		redir.addAttribute("projectId", projectId);
		
		return "redirect:viewProject.do";
	}
	
	@RequestMapping(path="logout.do", method=RequestMethod.GET)
	public String userLogout(HttpSession session) {
		session.removeAttribute("user");
		return "index";
		
		
	}
	
	
	
	
//	goHome
//	home.do/()/GET/index.jsp
//
//	login
//	login.do/()/GET/Login.jsp
//
//	login
//	login.do(username-String password-String)/POST/Index.jsp
//
//	logout
//	logout.do/(user)/POST/index.jsp
	
	
	
	

}
