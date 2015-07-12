package ajaxservice;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import util.Util;

/**
 * 用户注销。删除用户的Cookie。返回结果给浏览器。
 * @author delin
 *
 */
public class LogoutAjax extends HttpServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
	        throws ServletException, IOException{
		
		// 覆盖之前的Cookie
		Cookie nameCookie = new Cookie("userName", null);
		Cookie idCookie = new Cookie("userID", null);
		nameCookie.setPath("/");
		idCookie.setPath("/");
		nameCookie.setMaxAge(0);
		idCookie.setMaxAge(0);
		resp.addCookie(nameCookie);
		resp.addCookie(idCookie);
		
		resp.getWriter().print(wrapJSON(true));
	}
	
	private String wrapJSON(boolean success){
		return "{" + Util.quotation("success") + ":" + success + "}";
	}
}