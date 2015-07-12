package service;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;

import database.UserService;
import entity.User;

public class GetLoginUserService {
	
	public static User service(HttpServletRequest request){
		
		System.out.println("GetLoginUserService");
		boolean isLogin = false;;
		String userID = null;
		Cookie[] cookies = request.getCookies();
		if(cookies == null){
			isLogin = false;
		}else{
	    	for(int i=0; i<cookies.length; i++){
	    		Cookie cookie = cookies[i];
	    		if(cookie.getName().equals("userID")){
	    			isLogin = true;
	    			userID = cookie.getValue();
	    		}
	    	}
		}
		
		if(!isLogin){
			System.out.println("not login");
			return null;
		}
		
		User user = UserService.getUserService().searchUserByID(Integer.parseInt(userID));
		System.out.println(user.getAuthority() + ": " + user.getName());
		return user;
	}
}
