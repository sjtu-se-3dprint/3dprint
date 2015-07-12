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
 * 修改用户信息。
 */
public class ModifyUserInfoAjax extends HttpServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
	        throws ServletException, IOException{
		
		// 检查用户是否已经登录
		User user = GetLoginUserService.service(req);
		if(user == null){
			return;
		}

		String telephone = req.getParameter("telephone");
		String email = req.getParameter("email");
		String qq = req.getParameter("qq");
		if(Util.isEmpty(telephone) || Util.isEmpty(email) || Util.isEmpty(qq)){
			return;
		}
		telephone = new String(telephone.getBytes("ISO-8859-1"), "UTF-8");
		email = new String(email.getBytes("ISO-8859-1"), "UTF-8");
		qq = new String(qq.getBytes("ISO-8859-1"), "UTF-8");
		
		Boolean success = UserService.getUserService().updateUserInformation(user.getId(), email, telephone, qq);
		
		if(success == null){
			return;
		}
		
		resp.getWriter().print(wrapJSON(success));
	}
	
	private String wrapJSON(boolean success){
		return "{" + Util.quotation("success") + ":" + success + "}";
	}
}
