package controller;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

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
}
