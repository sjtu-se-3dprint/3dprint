package service;

import java.util.Map;

public interface CartService {
      
	/**
	 * 添加模型到购物车（一个）
	 * @param param
	 * @return
	 * @throws Exception 
	 */
	public Boolean addModelIntoCart(Map param) throws Exception;
	
	/**
	 * 判断该用户是否将该模型加入到购物车
	 * @param param
	 * @return
	 */
	public Boolean isInMyCart(Map param);
	
	/**
	 * 增加已在购物车中的模型的数目+1
	 * @param param
	 * @return
	 * @throws Exception 
	 */
	public Boolean addModelAmountInCart(Map param) throws Exception;
	
	/**
	 * 减少已在购物车中的模型的数目-1
	 * @param param
	 * @return
	 * @throws Exception 
	 */
	public Boolean reduceModelAmountInCart(Map param) throws Exception;
	
	/**
	 * 修改已在购物车中的模型的数目
	 * @param param
	 * @return
	 * @throws Exception 
	 */
	public Boolean modifyModelAmountInCart(Map param) throws Exception;
	
	/**
	 * 获取已在购物车中的模型的数目normal状态的
	 * @param param
	 * @return
	 * @throws Exception 
	 */
	public String getModelAmountInCart(Map param) throws Exception;
}
