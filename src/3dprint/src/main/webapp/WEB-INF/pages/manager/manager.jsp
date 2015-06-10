<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
</head>
<body>
	<jsp:include page="../common/header.jsp" flush="true"></jsp:include>
	<h2>这是Manager中心！</h2>
	<a href="../user/index">去User中心</a>
	<a href="../admin/index">去Admin中心</a>
	<a href="../index">返回首页</a>
	<br><br>
	<a href="../logout">注销</a>
</body>
</html>