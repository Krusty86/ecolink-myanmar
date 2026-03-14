package util;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {
	private static final String URL = "jdbc:mysql://localhost:3306/ecolinkmyanmar";
	private static final String USER = "root";
	private static final String PASS = "1234";
	
	public static Connection connect() throws Exception{
		Connection con = null;
		Class.forName("com.mysql.cj.jdbc.Driver");
		con = DriverManager.getConnection(URL, USER, PASS);
		return con;
	}
}
