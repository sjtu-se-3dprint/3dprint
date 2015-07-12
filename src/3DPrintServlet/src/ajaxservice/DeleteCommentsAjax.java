package ajaxservice;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import database.UserLikeCollectionCommentService;
import entity.User;
import service.GetLoginUserService;
import util.Util;

/**
 * 删除评论。
 */
public class DeleteCommentsAjax extends HttpServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
	        throws ServletException, IOException{
		
		// 检查用户是否已经登录
		User user = GetLoginUserService.service(req);
		if(user == null || !"admin".equals(user.getAuthority())){
			return;
		}

		String commentIDs = req.getParameter("commentIDs");
		if(Util.isEmpty(commentIDs)){
			return;
		}

		String[] commentStrs = commentIDs.split(";");
		ArrayList<Integer> comments = new ArrayList<Integer>();
		for(String commentStr : commentStrs){
			comments.add(Integer.parseInt(commentStr));
		}
		
		int successCount = 0;
		for(Integer id: comments){
			successCount += UserLikeCollectionCommentService
			.getUserLikeCollectionCommentService()
			.updateCommentStatus(id, "deleted") ? 1:0;
		}
		
		resp.getWriter().print(wrapJSON(successCount));
	}
	
	private String wrapJSON(Integer count){
		return "{" + Util.quotation("count") + ":" + count + "}";
	}
}
