package ajaxservice;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import database.PostService;
import database.ShoppingService;
import service.GetLoginUserService;
import entity.Material;
import entity.Shopcar;
import entity.User;
import util.Util;

/**
 * 用户发表帖子。
 */
public class AddPostcommentAjax extends HttpServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
	        throws ServletException, IOException{
		
		// 检查用户是否已经登录
		User user = GetLoginUserService.service(req);
		if(user == null){ 
			return;
		}

		String postID = req.getParameter("postID");
		String content = req.getParameter("content");
		if(Util.isEmpty(postID) || Util.isEmpty(content)){
			return;
		}
		
		Boolean success = PostService.getPostService().addPostComment(user.getId(), Integer.parseInt(postID), content);
		resp.getWriter().print(wrapJSON(success));
	}
	
	private String wrapJSON(Boolean success){
		return "{" + Util.quotation("success") + ":" + success + "}";
	}

}
