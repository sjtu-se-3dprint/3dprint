package config;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.web.WebAttributes;
import org.springframework.security.web.access.AccessDeniedHandler;

import com.fasterxml.jackson.databind.ObjectMapper;

/**
 * 当一个【已经登录】的用户访问某个需要权限的地址（但是权限不够）时会抛出异常，在这里处理。
 * 如果这个请求时ajax请求，那么返回一个json对象。
 * 如果是普通的浏览器页面请求，那么定向到权限不足页面。
 */
public class MyAccessDeniedHandler implements AccessDeniedHandler {

	String errorPage;

	static final ObjectMapper mapper = new ObjectMapper();
	static final Map map = new HashMap();
	static {
		map.put("success", false);
		map.put("message", "权限不够，拒绝访问！");
	}
	
	public void handle(HttpServletRequest request,
			HttpServletResponse response,
			AccessDeniedException accessDeniedException) throws IOException,
			ServletException {

		if ("XMLHttpRequest".equals(request.getHeader("X-Requested-With"))) { // 是ajax请求
			response.setHeader("Content-type", "text/html;charset=UTF-8");
			response.getWriter().print(mapper.writeValueAsString(map));
		} else if (errorPage != null) { // 页面请求，定向到错误页面
			request.setAttribute(WebAttributes.ACCESS_DENIED_403,
					accessDeniedException);
			response.setStatus(HttpServletResponse.SC_FORBIDDEN);
			RequestDispatcher dispatcher = request
					.getRequestDispatcher(errorPage);
			dispatcher.forward(request, response);
		}
	}

	public void setErrorPage(String errorPage) {
		this.errorPage = errorPage;
	}
}
