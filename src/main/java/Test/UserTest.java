package Test;

import java.util.Date;

import dao.UserDAO;
import entity.User;

public class UserTest {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		User user = new User("Chit Chit", "chit@gmail.com", "chitchit", "SUPPLIER", "Chit Pyone", true, new Date());
		//testing user save
		user = UserDAO.save(user);
		display(user);
	}

	static void display(User user) {
		System.out.println("User Info");
		System.out.println("ID: "+user.getId());
		System.out.println("Email: "+user.getEmail());
		System.out.println("Role: "+user.getRole());
		System.out.println("Password: "+user.getPassword());
		System.out.println("Business Name: "+user.getBusiness_name());
		System.out.println("Status: "+ (user.getStatus()==true? "Active":"Inactive"));
		System.out.println("Joined Date: "+ user.getJoined_date());
	}
}
