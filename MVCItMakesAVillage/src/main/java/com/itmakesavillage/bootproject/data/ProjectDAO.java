package com.itmakesavillage.bootproject.data;

import java.util.List;
import java.util.Set;

import com.itmakesavillage.jpaproject.entities.Address;
import com.itmakesavillage.jpaproject.entities.Category;
import com.itmakesavillage.jpaproject.entities.Comments;
import com.itmakesavillage.jpaproject.entities.Item;
import com.itmakesavillage.jpaproject.entities.ItemsNeeded;
import com.itmakesavillage.jpaproject.entities.Project;
import com.itmakesavillage.jpaproject.entities.State;

public interface ProjectDAO {
	
	public Project findProject(int id);
	public Project createProject(Project project);
	public Project updateProject(int id, Project project);
	public Set<Project> searchProject(String keyword);
	public List<Project> getAllProject();
	public List<Category> getAllCategories();
	public Category findCategoryById(int id);
	public List<State> getAllStates();
	public State getStateById(int stateId);
	public Address updateAddress(Address address);
	public Address createAddress(Address address);
	public Comments deactivateComment(int commentId);
	public Comments reactivateComment(int commentId);
	public Comments createComment(Comments comment);
	public Comments findComment(int commentId);
	public List<Item> getAllItems();
	public Item getItem(int itemId);
	ItemsNeeded getItemsNeeded(int itemId);
	Item createItem(Item item);
	ItemsNeeded createItemsNeeded(ItemsNeeded itemsNeeded);
	ItemsNeeded removeItemsNeeded(ItemsNeeded itemsNeeded);


}
