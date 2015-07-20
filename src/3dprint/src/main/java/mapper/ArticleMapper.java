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
}
