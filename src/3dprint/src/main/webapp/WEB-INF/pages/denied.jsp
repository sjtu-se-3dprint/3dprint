<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
	<body>
	
		<h1 id="banner">你没有浏览该页的权限 !!</h1>
	
		<hr />
	
		<c:if test="${not empty error}">
			<div style="color:red">
				Your fake login attempt was bursted, dare again !!<br /> 
				Caused : ${sessionScope["SPRING_SECURITY_LAST_EXCEPTION"].message}
			</div>
		</c:if>
	
		<p class="message">拒绝访问!</p>
		<a href="/3dprint/view/common/index">去首页</a>
		<a href="/3dprint/view/login">重新登录</a> 
	</body>
</html>