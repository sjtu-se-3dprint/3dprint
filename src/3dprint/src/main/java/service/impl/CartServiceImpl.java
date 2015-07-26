package service.impl;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import mapper.CartMapper;
import service.CartService;
import service.UserService;

@Service("cartServiceImpl")
public class CartServiceImpl implements CartService{

	@Resource(name = "cartMapper")
	CartMapper cartMapper;
	
	@Resource(name = "userServiceImpl")
	UserService userServiceImpl;
	
	@Transactional(propagation = Propagation.REQUIRED,rollbackFor = Exception.class)
	public Boolean addModelIntoCart(Map param) throws Exception {
		Map user = userServiceImpl.myInfo(null);
		if(user == null){
			throw new Exception("请先登录！");
		}
		param.put("user_id", user.get("user_id"));	
		param.put("status", "deleted");
		
		Map isincartd = cartMapper.isInMyCart(param);
		//若cart表中无被deleted的记录,则进入操作
		if(isincartd == null)
		{
			param.put("status", "normal");	
			Map isincartn = cartMapper.isInMyCart(param);
			//若原购物车中该模型，曾增加其个数
			if(isincartn == null){
				Integer row = cartMapper.addModelIntoCart(param);
				if (row == null || row != 1) {
					throw new Exception("添加购物车时发生错误。");
				}
				return true;
			}
			else {
				Integer row = cartMapper.addModelAmountInCart(param);
				if (row == null || row != 1) {
					throw new Exception("添加购物车时发生错误。");
				}
				return true;
			}
			
		}
		//原先有被delete的条目，恢复加入购物车且amount数初始化为1
		Integer row = cartMapper.recoverModelInCart(param);
		
		if (row == null || row != 1) {
			throw new Exception("添加购物车时发生错误。");
		}
		return true;
	}

	public Boolean isInMyCart(Map param) {
		Map user = userServiceImpl.myInfo(null);
		param.put("user_id", user.get("user_id"));	
		Map collection = cartMapper.isInMyCart(param);
		return collection == null;
	}

	@Transactional(propagation = Propagation.REQUIRED,rollbackFor = Exception.class)
	public Boolean addModelAmountInCart(Map param) throws Exception {
		Map user = userServiceImpl.myInfo(null);
		param.put("user_id", user.get("user_id"));
		
		Integer row = cartMapper.addModelAmountInCart(param);
		if (row == null || row != 1) {
			throw new Exception("添加失败，系统错误，请重试。");
		}
		return true;
	}

	@Transactional(propagation = Propagation.REQUIRED,rollbackFor = Exception.class)
	public Boolean reduceModelAmountInCart(Map param) throws Exception {
		Map user = userServiceImpl.myInfo(null);
		param.put("user_id", user.get("user_id"));
		
		Integer row = cartMapper.reduceModelAmountInCart(param);
		if (row == null || row != 1) {
			throw new Exception("减少失败，系统错误，请重试。");
		}
		return true;
	}
	@Transactional(propagation = Propagation.REQUIRED,rollbackFor = Exception.class)
	public Boolean modifyModelAmountInCart(Map param) throws Exception {
		Map user = userServiceImpl.myInfo(null);
		param.put("user_id", user.get("user_id"));
		
		Integer row = cartMapper.modifyModelAmountInCart(param);
		if (row == null || row != 1) {
			throw new Exception("修改数目失败，系统错误，请重试。");
		}
		return true;
	}

	public String getModelAmountInCart(Map param) throws Exception {
		Map user = userServiceImpl.myInfo(null);
		if(user == null){
			throw new Exception("请先登录！");
		}
		param.put("user_id", user.get("user_id"));
		
		Map result = cartMapper.getModelAmountInCart(param);
		if(result == null){
			return "0";
		}
		else{
		return result.get("amount").toString();
		}
	}

}
