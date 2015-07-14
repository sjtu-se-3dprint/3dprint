<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="zh-CN">
	<body>
		<jsp:include page="header.jsp" flush="true"></jsp:include>
		<h1 id="banner">你没有浏览该页的权限 !!</h1>
	
		<hr />
	
		<c:if test="${not empty error}">
			<div style="color:red">
				Your fake login attempt was bursted, dare again !!<br /> 
				Caused : ${sessionScope["SPRING_SECURITY_LAST_EXCEPTION"].message}
			</div>
		</c:if>
	
		<a href="/3dprint/view/index.htm">返回首页</a>
		<a href="/3dprint/view/login.htm">重新登录</a> 
	</body>
</html>