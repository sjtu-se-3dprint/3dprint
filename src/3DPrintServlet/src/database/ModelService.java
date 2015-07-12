package database;

public class ModelService {
	public static ModelServiceInterface getModelService(){
		return DB.getDB();
	}
}
