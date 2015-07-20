package mapper;

import java.util.List;
import java.util.Map;

public interface ArticleMapper {

	/**
	 * 查询出帖子类型列表
	 * @param map
	 * @return
	 */
	public List findArticleTypes(Map map);
	
	/**
	 * 根据ID查出帖子类别
	 * @param map
	 * @return
	 */
	public Map findArticleTypeById(Map map);
	
	/**
	 * 插入帖子
	 * @param map
	 * @return
	 */
	public Integer insertArticle(Map map);
	
	/**
	 * 根据帖子ID找帖子基本信息
	 * @param map
	 * @return
	 */
	public Map findArticleById(Map map);
	
	/**
	 * 修改帖子的名称、内容，不修改类别
	 * @param map
	 * @return
	 */
	public Integer updateArticle(Map map);
	
	/**
	 * 查找帖子，会根据type_name进行筛选，根据limit_from、amount进行筛选
	 * 按照发布时间倒序排列
	 * @return
	 */
	public List findArticles(Map map);
	
	/**
	 * 某个类别的帖子个数
	 * @param map
	 * @return
	 */
	public Integer countArticlesByTypeId(Map map);
}
