package controller;

import java.util.Map;
import java.util.HashMap;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import service.ArticleService;
import service.UserService;
import service.ModelService;

/**
 * 这个Controller负责处理所有不需要权限的ajax请求
 */
@Controller
@RequestMapping("/common")
public class CommonController extends BaseController {

	@Resource(name = "userServiceImpl")
	UserService userService;
	
	@Resource(name = "modelServiceImpl")	//resource的name要与具体实现类中的service name相对应
	ModelService modelService;
	
	@Resource(name = "articleServiceImpl")
	ArticleService articleService;

	/**
	 * 新用户名是否可用
	 * 
	 * @param param
	 * @return
	 */
	@RequestMapping(value = "/usernameValid.ajax", method = RequestMethod.POST, consumes = "application/json")
	@ResponseBody
	public Map usernameValid(@RequestBody Map param) {
		return initResult(true, userService.isUsernameValid(param));
	}

	/**
	 * 注册新用户
	 * 
	 * @param param
	 * @return
	 */
	@RequestMapping(value = "/register.ajax", method = RequestMethod.POST, consumes = "application/json")
	@ResponseBody
	public Map register(@RequestBody Map param) {
		try {
			return initResult(true, userService.addPlainUser(param));
		} catch (Exception e) {
			e.printStackTrace();
			return initResult(false, e.getMessage(), "");
		}
	}
	
	/**
	 * 查询模型类型列表
	 * 
	 * @param param
	 * @return
	 */
	@RequestMapping(value = "/modelTypeList.ajax", method = RequestMethod.POST, consumes = "application/json")
	@ResponseBody
	public Map getModelTypeList(@RequestBody Map param) {
		return initResult(true, modelService.totalModelType(param));
	}
	
	/**
	 * 获取模型列表
	 * @param param
	 * @return
	 */
	@RequestMapping(value = "/modelList.ajax", method = RequestMethod.POST, consumes = "application/json")
	@ResponseBody
	public Map getModelList(@RequestBody Map param) {
		return initResult(true, modelService.getModelList(param));
	}
	
	/**
	 * 获取当前查询条件下满足条件模型的个数
	 */
	@RequestMapping(value = "/modelCount.ajax", method = RequestMethod.POST, consumes = "application/json")
	@ResponseBody
	public Map getModelCount(@RequestBody Map param) {
		Map model_count = new HashMap();
		model_count.put("count", modelService.getModelCount(param));
		return initResult(true, model_count);
	}

	/**
	 * 获取模型信息
	 * @param param
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/modelInfo.ajax", method = RequestMethod.POST, consumes = "application/json")
	@ResponseBody
	public Map modelInfo(@RequestBody Map param) {
		try {
			return initResult(true, modelService.findModelById(param));
		} catch (Exception e) {
			e.printStackTrace();
			return initResult(false, e.getMessage(), "");
		}
	}
	
	/**
	 * 获取帖子信息
	 * @param param
	 * @return
	 */
	@RequestMapping(value = "/articleInfo.ajax", method = RequestMethod.POST, consumes = "application/json")
	@ResponseBody
	public Map articleInfo(@RequestBody Map param) {
		try {
			return initResult(true, articleService.findArticleById(param));
		} catch (Exception e) {
			e.printStackTrace();
			return initResult(false, e.getMessage(), "");
		}
	}
	

	/**
	 * 根据帖子类别找出前几个帖子（用于展示在首页上）
	 * @param param
	 * @return
	 */
	@RequestMapping(value = "/articleOverview.ajax", method = RequestMethod.POST, consumes = "application/json")
	@ResponseBody
	public Map articleOverview(@RequestBody Map param) {
		try {
			return initResult(true, articleService.findArticleOverviewByTypeId(param));
		} catch (Exception e) {
			e.printStackTrace();
			return initResult(false, e.getMessage(), "");
		}
	}

	/**
	 * 获取帖子类型列表
	 * @param param
	 * @return
	 */
	@RequestMapping(value = "/articleTypeList.ajax", method = RequestMethod.POST, consumes = "application/json")
	@ResponseBody
	public Map articleTypeList(@RequestBody Map param) {
		try {
			return initResult(true, articleService.findArticleTypes(param));
		} catch (Exception e) {
			e.printStackTrace();
			return initResult(false, e.getMessage(), "");
		}
	}
	
	/**
	 * 根据帖子类型、页码，获取帖子列表
	 * @param param
	 * @return
	 */
	@RequestMapping(value = "/articleList.ajax", method = RequestMethod.POST, consumes = "application/json")
	@ResponseBody
	public Map articleList(@RequestBody Map param) {
		try {
			return initResult(true, articleService.findArticlesByTypeId(param));
		} catch (Exception e) {
			e.printStackTrace();
			return initResult(false, e.getMessage(), "");
		}
	}
}
