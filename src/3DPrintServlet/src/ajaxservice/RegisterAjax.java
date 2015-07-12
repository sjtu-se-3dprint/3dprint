package ajaxservice;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import database.UserService;
import entity.User;
import util.Util;

/**
 * 用户注册。返回注册结果。
 * @author delin
 *
 */
public class RegisterAjax extends HttpServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
	        throws ServletException, IOException{
		
		String userName = req.getParameter("userName");
		String password = req.getParameter("password");
		String email = req.getParameter("email");
		String telephone = req.getParameter("telephone");
		if(Util.isEmpty(userName) || Util.isEmpty(password)
				|| Util.isEmpty(email) || Util.isEmpty(telephone)){
			return;
		}
		userName = new String(userName.getBytes("ISO-8859-1"), "UTF-8");
		password = new String(password.getBytes("ISO-8859-1"), "UTF-8");
		email = new String(email.getBytes("ISO-8859-1"), "UTF-8");
		telephone = new String(telephone.getBytes("ISO-8859-1"), "UTF-8");
		
		User user = UserService.getUserService().createUser(userName, password);
		if(user != null){
			boolean count = UserService.getUserService().updateUserInformation(user.getId(), email, telephone, null);
			System.out.println(count);
		}
		
		resp.getWriter().print(wrapJSON(user != null));
	}
	
	private String wrapJSON(boolean success){
		return "{" + Util.quotation("success") + ":" + success + "}";
	}
}
