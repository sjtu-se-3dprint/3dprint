package database;

public class UserLikeCollectionCommentService {
	public static UserLikeCollectionCommentServiceInterface getUserLikeCollectionCommentService(){
		return DB.getDB();
	}
}
