package ajaxservice;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import database.PostService;
import entity.Post;
import entity.User;
import service.GetLoginUserService;
import util.Util;

/**
 * 删除帖子。
 */
public class DeletePostAjax extends HttpServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
	        throws ServletException, IOException{
		
		// 检查用户是否已经登录
		User user = GetLoginUserService.service(req);
		if(user == null){
			return;
		}

		String postID = req.getParameter("postID");
		if(Util.isEmpty(postID)){
			return;
		}
		
		Post post = PostService.getPostService().searchPostById(Integer.parseInt(postID));
		if(post == null || post.getUser().getId() != user.getId()){
			resp.getWriter().print(wrapJSON(false));
			return;
		}
		
		Boolean success = PostService.getPostService().updatePostStatus(Integer.parseInt(postID), "deleted");
		resp.getWriter().print(wrapJSON(success));
	}
	
	private String wrapJSON(Boolean success){
		return "{" + Util.quotation("success") + ":" + success + "}";
	}
}
