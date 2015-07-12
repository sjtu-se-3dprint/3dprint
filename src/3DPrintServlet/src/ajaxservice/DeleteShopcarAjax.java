package ajaxservice;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import database.ShoppingService;
import entity.User;
import service.GetLoginUserService;
import util.Util;

/**
 * 用户批量删除购物车。
 */
public class DeleteShopcarAjax extends HttpServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
	        throws ServletException, IOException{
		
		
		// 检查用户是否已经登录
		User user = GetLoginUserService.service(req);
		if(user == null){
			return;
		}
				
		String shopcarIDs = req.getParameter("shopcarIDs");
		
		if(Util.isEmpty(shopcarIDs)){
			return;
		}
		
		String [] shopcarIDStrs = shopcarIDs.split(";");
		ArrayList<Integer> shopcarIDValues = new ArrayList<Integer>();
		for(int i=0; i<shopcarIDStrs.length; i++){
			shopcarIDValues.add(Integer.parseInt(shopcarIDStrs[i]));
		}
		
		int count = 0;
		for(Integer id:shopcarIDValues){
			count += ShoppingService.getShoppingService().cancelShopcar(id)?1:0;
		}
		
		resp.getWriter().print(wrapJSON(count));
	}
	
	private String wrapJSON(int count){
		return "{" + Util.quotation("count") + ":" + count + "}";
	}

}
