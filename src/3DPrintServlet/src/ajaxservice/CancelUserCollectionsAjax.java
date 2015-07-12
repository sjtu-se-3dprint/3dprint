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
 * 删除用户收藏。
 */
public class CancelUserCollectionsAjax extends HttpServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
	        throws ServletException, IOException{
		
		// 检查用户是否已经登录
		User user = GetLoginUserService.service(req);
		if(user == null){
			return;
		}

		String modelIDs = req.getParameter("modelIDs");
		if(Util.isEmpty(modelIDs)){
			return;
		}
		modelIDs = new String(modelIDs.getBytes("ISO-8859-1"), "UTF-8");
		
		String[] idStrs = modelIDs.split(";");
		ArrayList<Integer> ids = new ArrayList<Integer>();
		for(int i=0; i<idStrs.length; i++){
			ids.add(Integer.parseInt(idStrs[i]));
		}
		
		int successCount = 0;
		for(Integer id:ids){
			successCount += UserLikeCollectionCommentService
			.getUserLikeCollectionCommentService()
			.cancelColletion(user.getId(), id) ? 1:0;
		}
		
		resp.getWriter().print(wrapJSON(successCount));
	}
	
	private String wrapJSON(int successCount){
		return "{" + Util.quotation("successCount") + ":" + successCount + "}";
	}
}
