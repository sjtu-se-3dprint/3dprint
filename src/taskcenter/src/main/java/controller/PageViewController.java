package controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.baidu.ueditor.ActionEnter;

@Controller
public class PageViewController {

	@RequestMapping(value = "/index.htm", method = RequestMethod.GET)
	public String taskcenter(ModelMap model) {
		return "taskcenter";
	}

//	@RequestMapping(value = "/ueditor1_4_3-utf8-jsp-2/jsp/controller.jsp", method = RequestMethod.GET)
//	public void ueditor(HttpServletRequest request, HttpServletResponse response) {
//		System.out.println("UEditor!");
//		try {
//			request.setCharacterEncoding("utf-8");
//			response.setHeader("Content-Type", "text/html");
//
//			String rootPath = "D://";
//
//			String result = new ActionEnter(request, rootPath).exec();
//			response.getWriter().write(result);
//			System.out.println(result);
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//	}
//
//	@RequestMapping(value = "/ueditor1_4_3-utf8-jsp-2/jsp/controller.ajax", method = RequestMethod.GET)
//	public void ueditor2(HttpServletRequest request, HttpServletResponse response) {
//		System.out.println("UEditor!");
//		try {
//			request.setCharacterEncoding("utf-8");
//			response.setHeader("Content-Type", "text/html");
//
//			String rootPath = "D://";
//
//			String result = new ActionEnter(request, rootPath).exec();
//			response.getWriter().write(result);
//			System.out.println(result);
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//	}
}
