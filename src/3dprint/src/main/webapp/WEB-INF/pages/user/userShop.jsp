<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>用户中心</title>
</head>
<body>
	<jsp:include page="../common/header.jsp" flush="true"></jsp:include>
	<script src="<%=request.getContextPath()%>/js/user/user_info.js"></script>
	<script src="<%=request.getContextPath()%>/js/user/user_setting.js"></script>
	<div class="container">
		<div class="col-md-3">
			<div class="thumbnail center-block"
				style="width: 150px; height: 150px">
				<img id="headimage" class=""
					src="<%=request.getContextPath()%>/image/userhead_default.jpg" />
			</div>
			<a href="" class="center-block text-center" style="margin-top: -10px">你好：<span
				id="usernameText"></span></a>

			<div class="list-group center-block"
				style="width: 160px; padding-top: 20px;">
				<a href="<%=request.getContextPath()%>/view/user/index.htm"
					class="list-group-item">个人设置</a> <a href="<%=request.getContextPath()%>/view/user/userModel.htm"
					class="list-group-item">我的模型</a> <a href="<%=request.getContextPath()%>/view/user/userShop.htm"
					class="list-group-item active">我的购物</a> <a href="<%=request.getContextPath()%>/view/user/userCollection.htm"
					class="list-group-item">我的收藏</a> <a href="<%=request.getContextPath()%>/view/user/userArticle.htm"
					class="list-group-item">我的帖子</a>
			</div>
		</div>
	</div>
</body>
</html>