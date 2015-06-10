<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="zh-CN">
	<body>
		<jsp:include page="header.jsp" flush="true"></jsp:include>
		<h1 id="banner">登录失败 !!</h1>
	
		<hr />
	
		<p class="message">用户名或者密码错误!</p>
		<a href="/3dprint/view/index">去首页</a> 
		<a href="/3dprint/view/login">返回登录页</a>
	</body>
</html>