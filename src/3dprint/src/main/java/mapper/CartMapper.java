package mapper;

import java.util.List;
import java.util.Map;

/**
 * 对应购物车表cart
 * 2015.07.23
 */
public interface CartMapper {
    
	/**
	 * 根据用户ID查找其购物车内容
	 * @param map
	 * @return
	 */
	public List getCartByUserId(Map map);
	
	/**
	 * 添加模型到购物车
	 * @param map
	 * @return
	 */
	
	public Integer addModelIntoCart(Map map);
	
	/**
	 * 在购物车中deleted状态的，重新加入即恢复它
	 * @param map
	 * @return
	 */
	public Integer recoverModelInCart(Map map);
	
	/**
	 * 将购物车中的模型删除
	 * @param map
	 * @return
	 */
	public Integer removeModelFromCart(Map map);
	
	/**
	 * 判断用户是否已经添加该模型
	 * @param map
	 * @return
	 */
	public Map isInMyCart(Map map);
	
	/**
	 * 增加已在购物车中的模型的数目+1
	 * @param map
	 * @return
	 */
	public Integer addModelAmountInCart(Map map);
	
	/**
	 * 减少已在购物车中的模型数目-1
	 * @param map
	 * @return
	 */
	public Integer reduceModelAmountInCart(Map map);
	
	/**
	 * 修改购物车中的模型的数目
	 * @param map
	 * @return
	 */
	public Integer modifyModelAmountInCart(Map map);
	
	/**
	 * 根据用户ID和模型ID获取购物车中的模型的数目
	 * @param map
	 * @return
	 */
	public Map getModelAmountInCart(Map map);
}
