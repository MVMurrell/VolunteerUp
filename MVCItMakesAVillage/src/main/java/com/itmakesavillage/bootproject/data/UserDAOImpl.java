package com.itmakesavillage.bootproject.data;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.transaction.Transactional;

import org.springframework.stereotype.Service;

import com.itmakesavillage.jpaproject.entities.User;

@Transactional
@Service
public class UserDAOImpl implements UserDAO {
	
	@PersistenceContext
	EntityManager em;

	@Override
	public User findUser(int id) {
		return em.find(User.class, id);
	}

	@Override
	public User createUser(User user) {
		user.setRole("standard");
		em.persist(user);
		System.out.println(user);
		return user;
	}

	@Override
	public User updateUser(int id, User user) {
		System.out.println(user);
		User userToEdit = em.find(User.class, id);
		userToEdit.setEmail(user.getEmail());
		userToEdit.setUserName(user.getUserName());
		userToEdit.setPassword(user.getPassword());
		return userToEdit;
	}

	@Override
	public Set<User> searchUser(String keyword) {
		keyword = "%" + keyword + "%";
		keyword = keyword.replaceAll(" ", "% %");
		String searchArr[] = keyword.split(" ");
		Set<User> users = new HashSet<>();
		
		for (String searchWord : searchArr) {
			String query = "SELECT u from User u WHERE userName like:search";
			users.addAll(em.createQuery(query, User.class).setParameter("search", searchWord).getResultList());
		}
		return users;
	}

	@Override
	public List<User> getAllUser() {
		List<User> allUsers = new ArrayList<User>();
		String query = "Select user FROM User user";
		allUsers = em.createQuery(query, User.class).getResultList();
		return allUsers;
	}

	@Override
	public User getUserByUserNameAndPassword(String userName, String password) {
		User user = null;
		List<User> users = this.getAllUser();
		for (User user2 : users) {
			if(user2.getUserName().equals(userName) && user2.getPassword().equals(password)) {
				user = user2;
				break;
			}
		}
		return user;
	}

}
