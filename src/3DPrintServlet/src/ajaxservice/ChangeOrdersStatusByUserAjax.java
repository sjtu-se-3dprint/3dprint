package ajaxservice;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import database.ShoppingService;
import service.GetLoginUserService;
import entity.User;
import util.Util;

/**
 * 改变订单状态（用户）。
 */
public class ChangeOrdersStatusByUserAjax extends HttpServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
	        throws ServletException, IOException{
		
		// 检查用户是否已经登录
		User user = GetLoginUserService.service(req);
		if(user == null){
			return;
		}

		String status = req.getParameter("status");
		String orderIDs = req.getParameter("orderIDs");
		if(Util.isEmpty(status) || Util.isEmpty(orderIDs)){
			System.out.println("status or orderIDs are empty.");
			return;
		}
		
		status = new String(status.getBytes("ISO-8859-1"), "UTF-8");

		String[] orderIDStrs = orderIDs.split(";");
		int count = 0;
		for(String orderIDStr : orderIDStrs){
			int orderID = Integer.parseInt(orderIDStr);
			Boolean success = ShoppingService.getShoppingService().updateOrderStatusByUser(orderID, user.getId(), status);
			count += success?1:0;
		}
		resp.getWriter().print(wrapJSON(count));
	}
	
	private String wrapJSON(Integer count){
		return "{" + Util.quotation("count") + ":" + count + "}";
	}
}
