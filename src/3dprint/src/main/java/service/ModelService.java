package service;

import javax.servlet.http.HttpServletRequest;

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
}
