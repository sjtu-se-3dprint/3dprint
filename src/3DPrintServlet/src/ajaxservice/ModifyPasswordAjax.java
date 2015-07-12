package ajaxservice;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import service.GetLoginUserService;
import database.UserService;
import entity.User;
import util.Util;

/**
 * 修改用户密码。
 */
public class ModifyPasswordAjax extends HttpServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
	        throws ServletException, IOException{
		
		// 检查用户是否已经登录
		User user = GetLoginUserService.service(req);
		if(user == null){
			return;
		}

		String oldPassword = req.getParameter("oldPassword");
		String newPassword = req.getParameter("newPassword");
		if(Util.isEmpty(oldPassword) || Util.isEmpty(newPassword)){
			return;
		}
		oldPassword = new String(oldPassword.getBytes("ISO-8859-1"), "UTF-8");
		newPassword = new String(newPassword.getBytes("ISO-8859-1"), "UTF-8");
		
		Boolean success = UserService.getUserService().updateUserPassword(user.getId(), oldPassword, newPassword);
		
		if(success == null){
			return;
		}
		
		resp.getWriter().print(wrapJSON(success));
	}
	
	private String wrapJSON(boolean success){
		return "{" + Util.quotation("success") + ":" + success + "}";
	}
}
