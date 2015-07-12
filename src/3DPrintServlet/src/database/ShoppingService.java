package database;

public class ShoppingService {
	public static ShoppingServiceInterface getShoppingService(){
		return DB.getDB();
	}
}
