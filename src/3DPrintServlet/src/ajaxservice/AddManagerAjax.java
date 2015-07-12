package ajaxservice;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import database.UserService;
import entity.User;
import service.GetLoginUserService;
import util.Util;

/**
 * 添加管理员。
 */
public class AddManagerAjax extends HttpServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
	        throws ServletException, IOException{
		
		// 检查用户是否已经登录
		User user = GetLoginUserService.service(req);
		if(user == null || !"admin".equals(user.getAuthority())){
			return;
		}
				
		String userName = req.getParameter("userName");
		String password = req.getParameter("password");
		
		if(Util.isEmpty(userName) || Util.isEmpty(password)){
			return;
		}
		
		User manager = UserService.getUserService().createManager(userName, password);
		
		resp.getWriter().print(wrapJSON(manager != null));
	}
	
	private String wrapJSON(boolean success){
		return "{" + Util.quotation("success") + ":" + success + "}";
	}

}
