<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/css/articleIndex.css" />
<title>论坛首页</title>
</head>
<body>
	<jsp:include page="../common/header.jsp" flush="true"></jsp:include>
	<script src="<%=request.getContextPath()%>/js/common/articleIndex.js"></script>

	<div class="container text-center" style="max-width: 1000px">
		<div class="row" style="padding-bottom: 15px;">
			<div class="col-md-12">
				<a href="<%=request.getContextPath()%>/view/user/articlePublish.htm"
					class="pull-right publishBtn" style="text-decoration: none">我要发帖</a>
			</div>
		</div>
	</div>
</body>
</html>