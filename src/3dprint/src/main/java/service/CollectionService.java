package service;

import java.util.List;
import java.util.Map;

public interface CollectionService {
	/**
	 * 添加收藏（user_id,model_id)
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public Boolean addCollection(Map param) throws Exception;
	
	/**
	 * 判断该用户是否收藏该模型
	 * @param param
	 * @return
	 */
	public Boolean isCollection(Map param);
	
	/**
	 * 用户取消收藏该模型
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public Boolean removeCollection(Map param) throws Exception;
	
	/**
	 * 获取模型被收藏数
	 * @param param
	 * @return
	 */
	public int getCollectionNum(Map param);
	/**
	 * 用户获取自己收藏的模型列表
	 * @param param
	 * @return
	 * @throws Exception
	 */
	
	public List<Map> myCollection(Map param) throws Exception;
}
