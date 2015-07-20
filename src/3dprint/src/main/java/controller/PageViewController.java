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
	
	@RequestMapping(value = "/oldhead.htm", method = RequestMethod.GET)
	public String oldhead(ModelMap model) {
		return "common/oldheader";
	}

	/**
	 * 页面导航栏
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/head.htm", method = RequestMethod.GET)
	public String head(ModelMap model) {
		return "common/header";
	}
	
	/**
	 * 登录界面
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/login.htm", method = RequestMethod.GET)
	public String login(ModelMap model) {
		return "common/login";
	}

	/**
	 * 注册界面
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/register.htm", method = RequestMethod.GET)
	public String register(ModelMap model) {
		return "common/register";
	}

	/**
	 * 权限不足页面
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/accessdenied.htm", method = RequestMethod.GET)
	public String accessdenied(ModelMap model) {
		model.addAttribute("error", "true");
		return "common/denied";
	}
	
	@RequestMapping(value = "/404.htm", method = RequestMethod.GET)
	public String notfound(ModelMap model) {
		model.addAttribute("error", "true");
		return "common/404";
	}
	
	/**
	 * 登录失败
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/loginfailed.htm", method = RequestMethod.GET)
	public String loginfailed(ModelMap model) {
		model.addAttribute("error", "true");
		return "common/loginfailed";
	}

	/**
	 * 登出页面
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/logout.htm", method = RequestMethod.GET)
	public String logout(ModelMap model) {
		return "common/logout";
	}
	
	/**
	 * 主页
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/index.htm", method = RequestMethod.GET)
	public String index(ModelMap model) {
		return "common/index";
	}
	
	/**
	 * Admin中心
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/admin/index.htm", method = RequestMethod.GET)
	public String admin(ModelMap model) {
		return "admin/admin";
	}
	
	/**
	 * Manager中心
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/manager/index.htm", method = RequestMethod.GET)
	public String manager(ModelMap model) {
		return "manager/manager";
	}
	
	/**
	 * User中心-个人设置
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/user/index.htm", method = RequestMethod.GET)
	public String user(ModelMap model) {
		return "user/user";
	}
	
	/**
	 * User中心-我的模型
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/user/userModel.htm", method = RequestMethod.GET)
	public String userModel(ModelMap model) {
		return "user/userModel";
	}
	

	/**
	 * User中心-我的购物
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/user/userShop.htm", method = RequestMethod.GET)
	public String userShop(ModelMap model) {
		return "user/userShop";
	}
	
	/**
	 * User中心-我的收藏
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/user/userCollection.htm", method = RequestMethod.GET)
	public String userCollection(ModelMap model) {
		return "user/userCollection";
	}
	
	/**
	 * User中心-我的帖子
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/user/userArticle.htm", method = RequestMethod.GET)
	public String userArticle(ModelMap model) {
		return "user/userArticle";
	}
	
	/**
	 * 模型商城
	 * @param model
	 * @return  
	 */
	@RequestMapping(value = "/common/modelCenter.htm", method = RequestMethod.GET)
	public String modelCenter(ModelMap model) {
		return "common/modelCenter";
	}
	
	/**
	 * 模型上传
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/user/modelUpload.htm", method = RequestMethod.GET)
	public String modelUpload(ModelMap model) {
		return "user/modelUpload";
	}
	

	/**
	 * 模型编辑
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/user/modelEdit.htm", method = RequestMethod.GET)
	public String modelEdit(ModelMap model) {
		return "user/modelEdit";
	}
	
	/**
	 * 帖子发布
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/user/articlePublish.htm", method = RequestMethod.GET)
	public String articlePublish(ModelMap model) {
		return "user/articlePublish";
	}

	/**
	 * 收藏测试页面
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/user/test.htm", method = RequestMethod.GET)
	public String addCollection(ModelMap model) {
		return "/user/test";
	}

}
