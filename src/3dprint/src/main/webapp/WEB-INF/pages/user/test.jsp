<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
</head>
<script src="<%=request.getContextPath()%>/js/jquery-1.11.1.min.js"></script>
<body>

<jsp:include page="../common/header.jsp" flush="true"></jsp:include>
<script src="<%=request.getContextPath()%>/js/user/model_collection.js"></script>		<!-- 引入js必须在动态jsp include指令之后 -->
<script src="<%=request.getContextPath()%>/js/user/user_cart.js"></script>
测试添加模型收藏</br>
添加购物车功能
<p>
<button id ="btntest" class = "btn btn-primary"></button>
</p>
<p>
<button id = "btncount" class = "btn btn-primary"></button></br>
</p>
<p>
<button id = "btnCart" class = "btn btn-primary">加入购物车</button>
</p>
</body>
</html>