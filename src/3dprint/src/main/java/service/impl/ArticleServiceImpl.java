package service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import mapper.ArticleMapper;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import exception.ServiceException;
import service.ArticleService;
import service.UserService;

@Service("articleServiceImpl")
public class ArticleServiceImpl implements ArticleService {

	static private int MAX_ARTICLE_NAME = 100;
	
	static private int MAX_ARTICLE_CONTENT = 19500;
	
	@Resource(name = "userServiceImpl")
	UserService userService;
	
	@Resource(name = "articleMapper")
	ArticleMapper articleMapper;
	

	public List findArticleTypes(Map param) throws Exception {
		param.put("staus", "normal");
		return articleMapper.findArticleTypes(param);
	}

	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
	public Boolean publishArticle(Map param) throws Exception {

		Map me = userService.myInfo(null);
		if (me == null) {
			throw new ServiceException("请登录后再尝试");
		}
		
		// 验证帖子的type是否正确
		param.put("status", "normal");
		Map type = articleMapper.findArticleTypeById(param);
		if(type == null){
			throw new ServiceException("找不到该帖子类型");
		}
		
		// 验证帖子名是否正确
		String article_name = (String) param.get("article_name");
		checkArticleName(article_name);
		
		// 验证帖子内容是否正确
		String article_content = (String) param.get("article_content");
		checkArticleContent(article_content);
		
		// 插入帖子
		Map articleParam = new HashMap();
		articleParam.put("article_name", article_name);
		articleParam.put("article_type", type.get("article_type"));
		articleParam.put("article_content", article_content);
		articleParam.put("user_id", me.get("user_id"));
		if(1 != articleMapper.insertArticle(articleParam)){
			throw new ServiceException("发布帖子失败");
		}
		
		return true;
	}

	public Map findArticleById(Map param) throws Exception {
		param.put("status", "normal");
		return articleMapper.findArticleById(param);
	}

	public Boolean editArticle(Map param) throws Exception {

		Map me = userService.myInfo(null);
		if (me == null) {
			throw new ServiceException("请登录后再尝试");
		}
		
		// 检查帖子是否存在、是否是此人上传
		param.put("status", "normal");
		Map article = articleMapper.findArticleById(param);
		if(article == null){
			throw new ServiceException("找不到该帖子");
		}else if(!("" + article.get("user_id")).equals("" + me.get("user_id"))){
			throw new ServiceException("你没有权限修改此帖子");
		}
		
		// 验证帖子名是否正确
		String article_name = (String) param.get("article_name");
		checkArticleName(article_name);
		
		// 验证帖子内容是否正确
		String article_content = (String) param.get("article_content");
		checkArticleContent(article_content);
		
		// 更新帖子内容
		if(1 != articleMapper.updateArticle(param)){
			throw new ServiceException("修改帖子失败");
		}
		
		return true;
	}
	
	private void checkArticleName(String article_name) throws Exception{
		if(article_name == null || article_name.length() == 0){
			throw new ServiceException("请正确填写帖子名称");
		}else if(article_name.length() > MAX_ARTICLE_NAME){
			throw new ServiceException("帖子名称太长");
		}
	}
	
	private void checkArticleContent(String article_content) throws Exception{
		if(article_content == null || article_content.length() == 0){
			throw new ServiceException("请正确填写帖子详细内容");
		}else if(article_content.length() > MAX_ARTICLE_CONTENT){
			throw new ServiceException("帖子详细内容太长");
		}
	}

}
