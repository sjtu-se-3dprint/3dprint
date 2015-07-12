package database;

public class PostService {
	public static PostServiceInterface getPostService(){
		return DB.getDB();
	}
}
