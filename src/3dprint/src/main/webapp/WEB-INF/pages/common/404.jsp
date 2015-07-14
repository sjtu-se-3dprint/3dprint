<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="security"
	uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
</head>
<body>
	<jsp:include page="header.jsp" flush="true"></jsp:include>
	<h2>404 Not Found the Page!</h2>
	<h2>找不到该页面！</h2>
	<h4>
		<a href="<%=request.getContextPath()%>/view/index.htm">点击这里跳转到主页</a>
	</h4>
</body>
</html>