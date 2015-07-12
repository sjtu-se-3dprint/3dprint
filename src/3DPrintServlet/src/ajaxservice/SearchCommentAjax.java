package ajaxservice;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import database.UserLikeCollectionCommentService;
import database.UserService;
import entity.Comment;
import entity.User;
import util.Util;

/**
 * 根据模型ID查询评价信息。
 */
public class SearchCommentAjax extends HttpServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
	        throws ServletException, IOException{

		String modelID = req.getParameter("modelID");
		String page = req.getParameter("page");
		if(Util.isEmpty(page) || Util.isEmpty(modelID)){
			return;
		}
		
		int modelIDValue;
		int pageValue;
		try{
			modelIDValue = Integer.parseInt(modelID);
			pageValue = Integer.parseInt(page);
		}catch(Exception e){
			return;
		}
		
		List<Comment> comments = UserLikeCollectionCommentService
				.getUserLikeCollectionCommentService()
				.searchCommentByModelStatus(modelIDValue, "normal");
		
		int CountPerPage = 5;
    	int maxPage = (comments.size()-1)/CountPerPage + 1;
    	pageValue = Math.max(pageValue, 1);
    	pageValue = Math.min(pageValue, maxPage);
    	List<Comment> commetsResult = new ArrayList<Comment>();
    	for(int i=CountPerPage*(pageValue-1),j=0; i<comments.size() && j<CountPerPage; i++, j++){
    		Comment comment = comments.get(i);
    		User commenter = UserService.getUserService().searchUserByID(comment.getUser().getId());
    		comment.setUser(commenter);
    		commetsResult.add(comment);
    	}

		resp.setContentType("text/javascript; charset=utf-8");
		resp.getWriter().print(wrapJSON(commetsResult, pageValue, maxPage));
	}
	
	private String wrapJSON(List<Comment> comments, int currentPage, int maxPage){
		
		StringBuilder json = new StringBuilder();
		json.append("{");
		json.append(Util.quotation("comments") + ":[");
		for(int i=0; i<comments.size(); i++){
			json.append(comments.get(i).toJSON());
			if(i != comments.size()-1){
				json.append(",");
			}
		}
		json.append("],");
		json.append(Util.quotation("currentPage") + ":");
		json.append(currentPage);
		json.append(",");
		json.append(Util.quotation("maxPage") + ":");
		json.append(maxPage);
		json.append("}");
		return json.toString();
	}

}
