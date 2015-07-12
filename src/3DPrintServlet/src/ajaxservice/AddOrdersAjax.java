package ajaxservice;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import database.ShoppingService;
import service.GetLoginUserService;
import entity.Material;
import entity.Shopcar;
import entity.User;
import util.Util;

/**
 * 用户添加订单。
 */
public class AddOrdersAjax extends HttpServlet {

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
		String materialIDs = req.getParameter("materialIDs");
		String numbers = req.getParameter("numbers");
		
		if(Util.isEmpty(shopcarIDs) || Util.isEmpty(materialIDs) || Util.isEmpty(numbers)){
			return;
		}
		
		String[] shopcarIDStrs = shopcarIDs.split(";");
		String[] materialIDStrs = materialIDs.split(";");
		String[] numberStrs = numbers.split(";");
		if(shopcarIDStrs.length != materialIDStrs.length || shopcarIDStrs.length != numberStrs.length){
			return;
		}
		int sz = shopcarIDStrs.length;
		if(sz == 0){
			return;
		}

		int count = 0;
		for(int i=0; i<sz; i++){
			int shopcarID = Integer.parseInt(shopcarIDStrs[i]);
			int materialID = Integer.parseInt(materialIDStrs[i]);
			int number = Integer.parseInt(numberStrs[i]);
			if(number <=0 ){
				continue;
			}
			Shopcar shopcar = ShoppingService.getShoppingService().searchShopcarByID(shopcarID);
			if(shopcar == null){
				continue;
			}
			Material material = ShoppingService.getShoppingService().searchMaterialByID(materialID);
			if(material == null){
				continue;
			}
			Boolean success = ShoppingService.getShoppingService().addOrder(user.getId(), shopcar.getModel().getId(), materialID, number, 0, "waiting check");
			if(success){
				count+=1;
				ShoppingService.getShoppingService().cancelShopcar(shopcarID);
			}
		}
		resp.getWriter().print(wrapJSON(count));
	}
	
	private String wrapJSON(int count){
		return "{" + Util.quotation("count") + ":" + count + "}";
	}

}
