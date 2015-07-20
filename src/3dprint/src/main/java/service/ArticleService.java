package service;

import java.util.List;
import java.util.Map;

public interface ArticleService {

	public List findArticleTypes(Map param) throws Exception;
	
	public Boolean publishArticle(Map param) throws Exception;
	
	
}
