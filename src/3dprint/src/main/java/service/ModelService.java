package service;

import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.Map;

public interface ModelService {

	/**
	 * 模型文件上传。
	 * 在模型上传页面，用户选择了一个模型文件，先上传模型文件，
	 * 之后真正上传模型的时候，就不需要再次提交模型文件了
	 * @param request
	 * @return
	 * @throws Exception
	 */
	public String uploadTempModel(HttpServletRequest request) throws Exception;
	
	/**
	 * 模型上传
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public Boolean uploadModel(Map param) throws Exception;
	
	/**
	 * 获取用户上传的模型列表
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public Map myModels(Map param) throws Exception;
	
	/**
	 * 删除用户自己上传的模型
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public Boolean deleteMyModel(Map param) throws Exception;
	
	/**
	 * 模型编辑
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public Boolean editModel(Map param) throws Exception;
	
	/**
	 * 查询模型的类型，获取模型类型列表
	 * @param param
	 * @return map 模型类型列表
	 */
	public List totalModelType(Map param);
	
	/**
	 * 查询模型
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public Map findModelById(Map param) throws Exception;
	
	/**
	 * 获得模型的收藏数
	 * @param param
	 * @return
	 */
	public int countCollections(Map param);
	
	/**
	 * 修改模型的收藏数
	 * @param param
	 * @return
	 */
	public Boolean modifyCollections(Map param);
}
