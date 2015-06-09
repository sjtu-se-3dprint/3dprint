package controller;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import service.UserService;

/**
 * 这个Controller负责处理所有user权限的ajax请求
 */
@Controller
@RequestMapping("/user")
public class UserController extends BaseController {
	
	@Resource(name = "userServiceImpl")
	UserService userService;

	/**
	 * 获取用户自己的信息
	 * @param param
	 * @return
	 */
	@RequestMapping(value = "/myInfo", method = RequestMethod.POST, consumes = "application/json")
	@ResponseBody
	public Map myInfo(@RequestBody Map param) {
		return initResult(true, userService.myInfo(param));
	}

	/**
	 * 修改用户自己的资料
	 * @param param
	 * @return
	 */
	@RequestMapping(value = "/modifyInfo", method = RequestMethod.POST, consumes = "application/json")
	@ResponseBody
	public Map modifyInfo(@RequestBody Map param) {
		try {
			return initResult(true, userService.modifyInfo(param));
		} catch (Exception e) {
			e.printStackTrace();
			return initResult(false, e.getMessage(), "");
		}
	}
}
