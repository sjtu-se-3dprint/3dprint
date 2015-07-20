package mapper;

import java.util.List;
import java.util.Map;

public interface ModelMapper {
	/**
	 * 得到模型的类型列表
	 * @param map
	 * @return
	 */
	public List getTotalModelType(Map map);
	
	/**
	 * 插入模型
	 * @param map
	 * @return
	 */
	public Integer insertModel(Map map);
	
	/**
	 * 修改模型（只修改模型描述、模型图片信息）
	 * @param map
	 * @return
	 */
	public Integer updateModelById(Map map);
	
	/**
	 * 修改模型状态
	 * @param map
	 * @return
	 */
	public Integer updateModelStatusById(Map map);
	
	/**
	 * 查询模型
	 * @param map
	 * @return
	 */
	public Map findModelById(Map map);
	
	/**
	 * 在有类别无关键字的情况下获取模型列表
	 * @param map 查询条件
	 * @return
	 */
	public List getModelList(Map map);
	
	/**
	 * 在有类别有关键字的情况下获取模型列表
	 * @param map 查询条件
	 * @return
	 */
	public List getModelListWithoutKeyWord(Map map);
	
	/**
	 * 在无类别和无关键字的情况下获取模型列表
	 * @param map
	 * @return
	 */
	public List getModelListWithoutType(Map map);
	
	/**
	 * 在无类别和无关键字的情况下获取模型列表
	 * @param map
	 * @return
	 */
	public List getModelListWithoutTypeWithoutKeyWord(Map map);

	/**
	 * 查询用户上传的模型
	 * @param map
	 * @return
	 */
	public List findModelsByUserId(Map map);
	
	/**
	 * 查询用户上传的模型总数
	 * @param map
	 * @return
	 */
	public Integer countModelsByUserId(Map map);
	
	/**
	 * 查询该模型收藏数
	 * @param map
	 * @return
	 */
	
	public Integer countCollectionsByModelId(Map map);
	
	/**
	 * 修改模型收藏数
	 * @param map
	 * @return
	 */
	public Boolean modifyCollections(Map map);
}
