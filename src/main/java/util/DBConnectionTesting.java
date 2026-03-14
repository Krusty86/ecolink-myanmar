package util;

public class DBConnectionTesting {
	public static void main(String[] args) {
		try {
			if(DBConnection.connect()!=null)
				System.out.println("Connection success!");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
