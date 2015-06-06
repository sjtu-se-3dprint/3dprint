<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="security"
	uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<script src="../../js/jquery-1.11.1.min.js"></script>
<title>Insert title here</title>
</head>
<body>
	<h2>这是3DPrint网站的首页！</h2>
	<security:authorize ifAnyGranted="ROLE_USER">
		<h3>你拥有角色为：普通用户（USER）</h3>
	</security:authorize>
	<security:authorize ifAnyGranted="ROLE_ADMIN">
		<h3>你拥有角色为：管理员（ADMIN）</h3>
	</security:authorize>
	<security:authorize ifAnyGranted="ROLE_MANAGER">
		<h3>你拥有角色为：管理员（MANAGER）</h3>
	</security:authorize>
	<security:authorize access="hasAnyRole('ROLE_USER', 'ROLE_ADMIN', 'ROLE_MANAGER')">
		<a href="../logout">注销</a><br><br>
	</security:authorize>
	<a href="../user/index">去User中心</a>
	<a href="../admin/index">去Admin中心</a>
	<a href="../manager/index">去Manager中心</a>
	<a href="../login">去登录页</a>
</body>
</html>