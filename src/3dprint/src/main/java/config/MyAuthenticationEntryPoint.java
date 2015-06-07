package config;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.AuthenticationEntryPoint;

import com.fasterxml.jackson.databind.ObjectMapper;

/**
 * 当一个【未登录】的用户访问某个需要权限的地址时会抛出异常，在这里处理。
 * 如果这个请求时ajax请求，那么返回一个json对象。
 * 如果是普通的浏览器页面请求，那么定向到登录页面。
 */
public class MyAuthenticationEntryPoint implements AuthenticationEntryPoint {

	String loginPage;
	
	static final ObjectMapper mapper = new ObjectMapper();
	static final Map map = new HashMap();
	static {
		map.put("success", false);
		map.put("message", "请先登录！");
	}
	
	public void commence(HttpServletRequest request,
			HttpServletResponse response, AuthenticationException authException)
			throws IOException, ServletException {

		if ("XMLHttpRequest".equals(request.getHeader("X-Requested-With"))) { // 是ajax请求
			response.setHeader("Content-type", "text/html;charset=UTF-8");
			response.getWriter().print(mapper.writeValueAsString(map));
		} else if (loginPage != null) {
			RequestDispatcher dispatcher = request
					.getRequestDispatcher(loginPage);
			dispatcher.forward(request, response);
		}
	}

	public void setLoginPage(String loginPage) {
		this.loginPage = loginPage;
	}
}
