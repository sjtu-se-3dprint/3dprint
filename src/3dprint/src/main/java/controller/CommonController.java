package controller;

import java.io.File;
import java.io.IOException;
import java.util.Date;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import service.UserService;

/**
 * 这个Controller负责处理所有不需要权限的ajax请求
 */
@Controller
@RequestMapping("/common")
public class CommonController extends BaseController {

	@Resource(name = "userServiceImpl")
	UserService userService;

	/**
	 * 新用户名是否可用
	 * 
	 * @param param
	 * @return
	 */
	@RequestMapping(value = "/usernameValid", method = RequestMethod.POST, consumes = "application/json")
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
	@RequestMapping(value = "/register", method = RequestMethod.POST, consumes = "application/json")
	@ResponseBody
	public Map register(@RequestBody Map param) {
		try {
			return initResult(true, userService.addPlainUser(param));
		} catch (Exception e) {
			e.printStackTrace();
			return initResult(false, e.getMessage(), "");
		}
	}

}
