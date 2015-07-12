package database;

public class UserService {

	public static UserServiceInterface getUserService(){
		return DB.getDB();
	}
}
