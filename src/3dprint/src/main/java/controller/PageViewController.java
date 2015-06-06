package controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * 这个Controller负责处理页面请求。 把页面请求转接到相对应的页面文件（.html、.jsp等）
 */
@Controller
@RequestMapping("/view")
public class PageViewController {

	/**
	 * 登录界面
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public String login(ModelMap model) {
		return "login";
	}

	/**
	 * 权限不足页面
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/accessdenied", method = RequestMethod.GET)
	public String accessdenied(ModelMap model) {
		model.addAttribute("error", "true");
		return "denied";
	}
	
	/**
	 * 登录失败
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/loginfailed", method = RequestMethod.GET)
	public String loginfailed(ModelMap model) {
		model.addAttribute("error", "true");
		return "loginfailed";
	}

	/**
	 * 登出页面
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	public String logout(ModelMap model) {
		return "logout";
	}
	
	/**
	 * 主页
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/common/index", method = RequestMethod.GET)
	public String index(ModelMap model) {
		return "index";
	}
	
	/**
	 * Admin中心
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/admin/index", method = RequestMethod.GET)
	public String admin(ModelMap model) {
		return "admin";
	}
	
	/**
	 * Manager中心
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/manager/index", method = RequestMethod.GET)
	public String manager(ModelMap model) {
		return "manager";
	}
	
	/**
	 * User中心
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/user/index", method = RequestMethod.GET)
	public String user(ModelMap model) {
		return "user";
	}
}
