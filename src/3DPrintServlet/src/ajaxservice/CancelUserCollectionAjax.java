package ajaxservice;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import database.UserLikeCollectionCommentService;
import entity.User;
import service.GetLoginUserService;
import util.Util;

/**
 * 用户取消收藏。返回操作结果给浏览器。
 */
public class CancelUserCollectionAjax extends HttpServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
	        throws ServletException, IOException{
		
		// 检查用户是否已经登录
		User user = GetLoginUserService.service(req);
		if(user == null){
			return;
		}
		
		String modelID = req.getParameter("modelID");
		
		if(Util.isEmpty(modelID)){
			return;
		}
		
		int modelIDValue;
		try{
			modelIDValue = Integer.parseInt(modelID);
		}catch(Exception e){
			return;
		}
		
		Boolean success = UserLikeCollectionCommentService
				.getUserLikeCollectionCommentService()
				.cancelColletion(user.getId(), modelIDValue);

		if(success == null){
			return;
		}
		
		resp.getWriter().print(wrapJSON(success));
	}
	
	private String wrapJSON(boolean success){
		return "{" + Util.quotation("success") + ":" + success + "}";
	}

}
