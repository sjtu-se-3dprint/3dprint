package ajaxservice;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.InputStream;

import util.Util;
import database.UserService;

/**
 * 获取用户头像。
 */
public class UserHeadImageAjax extends HttpServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
	        throws ServletException, IOException{
		
		String userID = req.getParameter("userID");
		if(Util.isEmpty(userID)){
			return;
		}
		
		InputStream reader = UserService.getUserService().readUserImage(Integer.parseInt(userID));
		
		if(reader != null){
			byte[] bytes = new byte[1024];
			int count = 0;
			while((count = reader.read(bytes)) != -1){
				resp.getOutputStream().write(bytes, 0, count);
			}
		}
	}
}