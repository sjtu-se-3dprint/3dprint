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
 * 这个Controller负责处理所有admin权限的ajax请求
 */
@Controller
@RequestMapping("/admin")
public class AdminController extends BaseController {

	@Resource(name = "userServiceImpl")
	UserService userService;

	/**
	 * 查出只有一个权限且为USER的所有用户
	 * 
	 * @param param
	 * @return
	 */
	@RequestMapping(value = "/queryPlainUserList.ajax", method = RequestMethod.POST, consumes = "application/json")
	@ResponseBody
	public Map queryPlainUserList(@RequestBody Map param) {
		return initResult(true, userService.queryPlainUserList(param));
	}

	/**
	 * 删除一个用户
	 * 
	 * @param param
	 * @return
	 */
	@RequestMapping(value = "/removePlainUser.ajax", method = RequestMethod.POST, consumes = "application/json")
	@ResponseBody
	public Map removePlainUser(@RequestBody Map param) {
		try {
			return initResult(true, userService.removePlainUser(param));
		} catch (Exception e) {
			e.printStackTrace();
			return initResult(false, e.getMessage(), "");
		}
	}
	
	/**
	 * 恢复一个用户
	 * @param param
	 * @return
	 */
	@RequestMapping(value = "/resumePlainUser.ajax", method = RequestMethod.POST, consumes = "application/json")
	@ResponseBody
	public Map resumePlainUser(@RequestBody Map param) {
		try {
			return initResult(true, userService.resumePlainUser(param));
		} catch (Exception e) {
			e.printStackTrace();
			return initResult(false, e.getMessage(), "");
		}
	}
	
	/**
	 * 添加一个权限为User的用户
	 * @param param
	 * @return
	 */
	@RequestMapping(value = "/addPlainUser.ajax", method = RequestMethod.POST, consumes = "application/json")
	@ResponseBody
	public Map addPlainUser(@RequestBody Map param) {
		try {
			return initResult(true, userService.addPlainUser(param));
		} catch (Exception e) {
			e.printStackTrace();
			return initResult(false, e.getMessage(), "");
		}
	}
}
