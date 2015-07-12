<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page import="service.GetLoginUserService,entity.*, database.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; ">

<link href="css/css-shoppingo/bootstrap.css" media="screen"
	rel="stylesheet" type="text/css" />
<link href="css/css-shoppingo/main.css" media="screen" rel="stylesheet"
	type="text/css" />
<link href="css/css-shoppingo/print.css" media="screen" rel="stylesheet"
	type="text/css" />
<link href="css/css-shoppingo/style.css" medial="all" rel="stylesheet" />


<link href="img/favicon.ico" rel="shortcut icon" />
<link href="img/apple-touch-icon.png" rel="apple-touch-icon" />
<link href="img/apple-touch-icon-72x72-precomposed.png"
	rel="apple-touch-icon" sizes="72x72" />
<link href="img/apple-touch-icon-114x114-precomposed.png"
	rel="apple-touch-icon" sizes="114x114" />

<title>3D打印创作服务平台-用户中心</title>
</head>
<body>
	<jsp:include page="header.jsp" flush="true"></jsp:include>
	<%
		User user = GetLoginUserService.service(request);
		if (user == null || !"user".equals(user.getAuthority())) {
			return;
		}
	%>


	<div class="boxed-container">
		<section class="main-container">
		<div class="container">
			<div class="row">
				<div class="shop-sidebar sidebar span3">
					<img alt="140x140" width=140 height=140 src="userheadimage?userID=<%=user.getId() + "&random=" + Math.random() %>"
						style="border-radius: 10px 10px 10px 10px;" /> <br />
					<p>你好，<%=user.getName()%>！</p>
					<hr />
					<ul class="nav nav-pills nav-stacked">
						<li class="active"><a href="./user_new.jsp">个人中心</a></li>
						<li><a href="./user_config_new.jsp">账号设置</a></li>
						<li><a href="./user_model_new.jsp">模型管理</a></li>
						<li><a href="./user_shop_new.jsp">购物管理</a></li>
						<li><a href="./user_collect_new.jsp">我的收藏</a></li>
						<li><a href="./user_forum_new.jsp">我的帖子</a></li>
					</ul>
				</div>
				<div class="main-content span9">
					<div>
						<ul class="products">
							<li class="span3">
								<div class="thumbnail">
									<img alt="300x200" src="img/manager/ok.png" />
									<div class="caption" contenteditable="true">
										<p>
											<span style="font-size: large;"> 上传的模型 </span>
											&nbsp;&nbsp;&nbsp; <span style="font-size: large;"> 0
											</span>
										</p>
									</div>
								</div>
							</li>
							<li class="span3">
								<div class="thumbnail">
									<img alt="300x200" src="img/manager/like.png" />
									<div class="caption" contenteditable="true">
										<p>
											<span style="font-size: large;"> 收藏的模型 </span>
											&nbsp;&nbsp;&nbsp; <span style="font-size: large;"> 0
											</span>
										</p>
									</div>
								</div>
							</li>
							<li class="span3">
								<div class="thumbnail">
									<img alt="300x200" src="img/manager/onway.png" />
									<div class="caption" contenteditable="true">
										<p>
											<span style="font-size: large;"> 待签收订单 </span>
											&nbsp;&nbsp;&nbsp; <span style="font-size: large;"> 0
											</span>
										</p>
									</div>
								</div>
							</li>
						</ul>
					</div>
					<hr />
					<p>
						<span style="font-size: large;"> 猜猜你喜欢 </span>
					</p>
					<ul class="products">
						<li class="product span3"><figure class="product-header">
							<img src="img/models/chair1.gif" /> <a
								class="product-link add-to-cart" href="#"> <i
								class="icon-shopping-cart"></i> 添加到购物车
							</a> <a class="product-link more-link" href="#"> <i
								class="icon-eye-open"></i> 查看详细内容
							</a> </figure>
							<div class="product-content">
								<h4 class="product-title">
									<a href="#">时尚红色椅子</a>
								</h4>
								<p class="product-price">
									<del>
										<span class="amount">￥99.00</span>
									</del>
									<ins>
										<span class="amount">￥79.99</span>
									</ins>
								</p>
								<a class="quick-view" href="#" title="Quick View"> <i
									class="icon-eye-open"></i>
								</a>
								<div class="product-desc hide">
									<p>error</p>
								</div>
							</div></li>
						<li class="product span3"><figure class="product-header">
							<img src="img/models/chair1.gif" /> <a
								class="product-link add-to-cart" href="#"> <i
								class="icon-shopping-cart"></i> 添加到购物车
							</a> <a class="product-link more-link" href="#"> <i
								class="icon-eye-open"></i> 查看详细内容
							</a> </figure>
							<div class="product-content">
								<h4 class="product-title">
									<a href="#">时尚红色椅子</a>
								</h4>
								<p class="product-price">
									<del>
										<span class="amount">￥99.00</span>
									</del>
									<ins>
										<span class="amount">￥79.99</span>
									</ins>
								</p>
								<a class="quick-view" href="#" title="Quick View"> <i
									class="icon-eye-open"></i>
								</a>
								<div class="product-desc hide">
									<p>error</p>
								</div>
							</div></li>
						<li class="product span3"><figure class="product-header">
							<img src="img/models/chair1.gif" /> <a
								class="product-link add-to-cart" href="#"> <i
								class="icon-shopping-cart"></i> 添加到购物车
							</a> <a class="product-link more-link" href="#"> <i
								class="icon-eye-open"></i> 查看详细内容
							</a> </figure>
							<div class="product-content">
								<h4 class="product-title">
									<a href="#">时尚红色椅子</a>
								</h4>
								<p class="product-price">
									<del>
										<span class="amount">￥99.00</span>
									</del>
									<ins>
										<span class="amount">￥79.99</span>
									</ins>
								</p>
								<a class="quick-view" href="#" title="Quick View"> <i
									class="icon-eye-open"></i>
								</a>
								<div class="product-desc hide">
									<p>error</p>
								</div>
							</div></li>
					</ul>
					<!-- .products -->
				</div>
			</div>
		</div>
		</section>
	</div>

	<script src="./js/jquery-1.11.1.min.js"></script>
</body>
</html>