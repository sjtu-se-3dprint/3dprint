package database;

public class LessonService {
	public static LessonServiceInterface getModelService(){
		return DB.getDB();
	}
}
