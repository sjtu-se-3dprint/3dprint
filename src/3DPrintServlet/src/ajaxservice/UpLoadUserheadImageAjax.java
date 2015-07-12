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
import sun.misc.BASE64Decoder;  

/**
 * 用户上传头像。
 */
public class UpLoadUserheadImageAjax extends HttpServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
	        throws ServletException, IOException{
		
		User user = GetLoginUserService.service(req);
		if(user == null){
			return;
		}
		
		String image = req.getParameter("image");
		
		if(Util.isEmpty(image)){
			return;
		}
		
		// 只允许jpg
		String header = "data:image/jpeg;base64,";
		if(image.indexOf(header) != 0){
			resp.getWriter().print(wrapJSON(false));
			return;
		}
		
		// 去掉头部
		image = image.substring(header.length());
		
		// 储存图片
		Boolean success = false;
		BASE64Decoder decoder = new BASE64Decoder();
		try{
			byte[] decodedBytes = decoder.decodeBuffer(image);
			success = UserService.getUserService().updateUserImage(user.getId(), decodedBytes);
		}catch(Exception e){
			e.printStackTrace();
		}
		
		resp.getWriter().print(wrapJSON(success));
	}
	
	private String wrapJSON(boolean success){
		return "{" + Util.quotation("success") + ":" + success + "}";
	}

}
