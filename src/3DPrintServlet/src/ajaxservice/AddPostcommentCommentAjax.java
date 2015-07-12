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

public class AddPostcommentCommentAjax extends HttpServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
	        throws ServletException, IOException{
		
		User user = GetLoginUserService.service(req);
		if(user == null){ 
			return;
		}

		String commentId = req.getParameter("comment_id");
		String content = req.getParameter("content");
		if(Util.isEmpty(commentId) || Util.isEmpty(content)){
			return;
		}
		
		System.out.println(commentId);
		Boolean success = PostService.getPostService().addPostCommentComment(user.getId(), Integer.parseInt(commentId), content);
		resp.getWriter().print(wrapJSON(success));
	}
	
	private String wrapJSON(Boolean success){
		return "{" + Util.quotation("success") + ":" + success + "}";
	}

}
