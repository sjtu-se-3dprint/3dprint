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
 * 删除用户。
 */
public class DeleteUserAjax extends HttpServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
	        throws ServletException, IOException{
		
		// 检查用户是否已经登录
		User user = GetLoginUserService.service(req);
		if(user == null || !"admin".equals(user.getAuthority())){
			return;
		}

		String userID = req.getParameter("userID");
		if(Util.isEmpty(userID)){
			return;
		}
		userID = new String(userID.getBytes("ISO-8859-1"), "UTF-8");
		
		Boolean success = UserService.getUserService().updateUserStatus(Integer.parseInt(userID), "deleted");

		resp.getWriter().print(wrapJSON(success));
	}
	
	private String wrapJSON(Boolean success){
		return "{" + Util.quotation("success") + ":" + success + "}";
	}
}
