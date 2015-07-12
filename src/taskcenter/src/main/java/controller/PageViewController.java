package controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class PageViewController {

	@RequestMapping(value = "/index.htm", method = RequestMethod.GET)
	public String taskcenter(ModelMap model) {
		return "taskcenter";
	}

	@RequestMapping(value = "/history.htm", method = RequestMethod.GET)
	public String history(ModelMap model) {
		return "taskhistory";
	}

	@RequestMapping(value = "/detail.htm", method = RequestMethod.GET)
	public String detail(ModelMap model) {
		return "taskdetail";
	}

	@RequestMapping(value = "/404.htm", method = RequestMethod.GET)
	public String notfound(ModelMap model) {
		return "404";
	}

	@RequestMapping(value = "/login.htm", method = RequestMethod.GET)
	public String login(ModelMap model) {
		return "login";
	}

	@RequestMapping(value = "/loginfailed.htm", method = RequestMethod.GET)
	public String loginfailed(ModelMap model) {
		return "loginfailed";
	}

	@RequestMapping(value = "/logout.htm", method = RequestMethod.GET)
	public String logout(ModelMap model) {
		return "logout";
	}

}
