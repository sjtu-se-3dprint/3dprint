package service;

import java.util.List;
import java.util.Map;

public interface ArticleService {

	/**
	 * 找出所有帖子类型
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public List findArticleTypes(Map param) throws Exception;
	
	/**
	 * 发表帖子
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public Boolean publishArticle(Map param) throws Exception;
	
	/**
	 * 根据帖子ID找出帖子基本信息
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public Map findArticleById(Map param) throws Exception;
	
	/**
	 * 编辑帖子
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public Boolean editArticle(Map param) throws Exception;
	
	/**
	 * 根据帖子类别找出前几个帖子（用于展示在首页上）
	 * @param param
	 * @return
	 */
	public List findArticleOverviewByTypeId(Map param) throws Exception;
	
	/**
	 * 根据帖子类别找出帖子列表
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public Map findArticlesByTypeId(Map param) throws Exception;
	
}
