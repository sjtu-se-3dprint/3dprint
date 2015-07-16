package service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import service.CollectionService;
import mapper.CollectionMapper;
import service.UserService;

@Service("collectionServiceImpl")
public class CollectionServiceImpl implements CollectionService {

	@Resource(name = "collectionMapper")
	CollectionMapper collectionMapper;
	
	@Resource(name = "userServiceImpl")
	UserService userServiceImpl;
	
	@Transactional(propagation = Propagation.REQUIRED,rollbackFor = Exception.class)
	public Boolean addCollection(Map param) throws Exception{
		
		Map user = userServiceImpl.myInfo(null);
		if(user == null){
			throw new Exception("请先登录！");
		}

		param.put("user_id", user.get("user_id"));	
		param.put("status", "normal");
		
		Integer row = collectionMapper.addCollection(param);
			
		if (row == null || row != 1) {
			throw new Exception("添加模型收藏时发生错误。");
		}
		
		return true;
	}

	public Boolean isCollection(Map param){
		Map collection = collectionMapper.isCollection(param);
		return collection == null;
	}

	@Transactional(propagation = Propagation.REQUIRED,rollbackFor = Exception.class)
	public Boolean removeCollection(Map param) throws Exception{
		Map user = userServiceImpl.myInfo(null);
		if(user == null){
			throw new Exception("请先登录！");
		}
		
		param.put("user_id", user.get("user_id"));
		param.put("status", "normal");
		
		Map collection = collectionMapper.isCollection(param);
		if(collection == null){
			throw new Exception("未收藏该模型，删除失败");
		}
		
		Integer row = collectionMapper.removeCollection(collection);
		if (row == null || row != 1) {
			throw new Exception("删除模型收藏时发生错误。");
		}	
		return true;
	}
	
	//未写完，获得用户收藏的模型列表，暂时不知道如何处理
	public List<Map> myCollection(Map param) throws Exception{
		Map user = userServiceImpl.myInfo(null);
		if(user == null){
			throw new Exception("请先登录！");
		}

		param.put("user_id", user.get("user_id"));
		param.put("status", "normal");
		
		List<Map> mycollections = collectionMapper.findCollectionByUser(param);
		return mycollections;
	}
}
