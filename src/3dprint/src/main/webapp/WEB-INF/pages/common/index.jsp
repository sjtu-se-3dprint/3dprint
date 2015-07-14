<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="security"
	uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>3D打印创作服务平台</title>
</head>
<body>
	<security:authorize ifAnyGranted="ROLE_USER"></security:authorize>
	
	<jsp:include page="header.jsp" flush="true"></jsp:include>
	
	<security:authorize access="hasAnyRole('ROLE_USER', 'ROLE_ADMIN', 'ROLE_MANAGER')">
		<a href="logout.htm">注销</a><br><br>
	</security:authorize>
	<a href="user/index.htm">去User中心</a>
	<a href="admin/index.htm">去Admin中心</a>
	<a href="manager/index.htm">去Manager中心</a>
	<a href="login.htm">去登录页</a>
</body>
</html>