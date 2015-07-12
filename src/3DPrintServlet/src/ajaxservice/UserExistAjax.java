package ajaxservice;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import database.UserService;
import util.Util;

/**
 * 查询用户名是否存在。
 */
public class UserExistAjax extends HttpServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
	        throws ServletException, IOException{
		
		String userName = req.getParameter("userName");
		if(Util.isEmpty(userName)){
			return;
		}
		userName = new String(userName.getBytes("ISO-8859-1"), "UTF-8");
		
		Boolean exist = UserService.getUserService().searchUserByName(userName) != null;

		resp.getWriter().print(wrapJSON(exist));
	}
	
	private String wrapJSON(boolean exist){
		return "{" + Util.quotation("exist") + ":" + exist + "}";
	}
}
