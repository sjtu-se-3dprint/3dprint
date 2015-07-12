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
 * 用户添加评论。返回添加结果给浏览器。
 */
public class UserCommentAjax extends HttpServlet {

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
		String commentText = req.getParameter("commentText");
		if(Util.isEmpty(modelID) || Util.isEmpty(commentText)){
			return;
		}
		
		commentText = new String(commentText.getBytes("ISO-8859-1"), "UTF-8");
		int modelIDValue;
		try{
			modelIDValue = Integer.parseInt(modelID);
		}catch(Exception e){
			return;
		}
		
		Boolean success = UserLikeCollectionCommentService
				.getUserLikeCollectionCommentService()
				.addComment(user.getId(), modelIDValue, commentText);

		if(success == null || !success){
			resp.getWriter().print(wrapJSON(false));
		}
		
		resp.setContentType("text/javascript; charset=utf-8");
		resp.getWriter().print(wrapJSON(true));
	}
	
	private String wrapJSON(boolean success){
		return "{" + Util.quotation("success") + ":" + success + "}";
	}
}
