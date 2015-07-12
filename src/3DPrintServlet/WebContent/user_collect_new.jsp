<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page
	import="service.GetLoginUserService,entity.*, database.*, java.util.List"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; ">

<link href="css/css-shoppingo/bootstrap.css" media="screen"
	rel="stylesheet" type="text/css" />
<link href="css/css-shoppingo/main.css" media="screen" rel="stylesheet"
	type="text/css" />
<!-- print stylesheet from printstylesheet.com, it's standard -->
<link href="css/css-shoppingo/print.css" media="screen" rel="stylesheet"
	type="text/css" />
<!-- custom style from user, not from us as developer -->
<link href="css/css-shoppingo/style.css" medial="all" rel="stylesheet" />
<title>3D打印创作服务平台-我的收藏</title>
</head>
<body>
	<jsp:include page="header.jsp" flush="true"></jsp:include>
	<%
		User user = GetLoginUserService.service(request);
		if (user == null || !"user".equals(user.getAuthority())) {
			return;
		}
	%>

<body class="shop">
	<div class="boxed-container">
		<section class="main-container">
		<div class="container">
			<div class="row">
				<div class="shop-sidebar sidebar span3">
					<img alt="140x140" width=140 height=140
						src="userheadimage?userID=<%=user.getId() + "&random=" + Math.random()%>"
						style="border-radius: 10px 10px 10px 10px;" /> <br />
					<p>
						你好，<%=user.getName()%>！
					</p>
					<hr />
					<ul class="nav nav-pills nav-stacked">
						<li><a href="./user_new.jsp">个人中心</a></li>
						<li><a href="./user_config_new.jsp">账号设置</a></li>
						<li><a href="./user_model_new.jsp">模型管理</a></li>
						<li><a href="./user_shop_new.jsp">购物管理</a></li>
						<li class="active"><a href="./user_collect_new.jsp">我的收藏</a></li>
						<li><a href="./user_forum_new.jsp">我的帖子</a></li>
					</ul>
				</div>
				<div class="main-content span9">
					<header class="block-header">
					<h3 class="block-title">所有产品</h3>
					<!-- <div class="pagination">
						<div class="paging-number">
							<span class="page-numbers current">1</span> <a href="#"
								class="page-numbers">2</a> <a href="#" class="page-numbers">3</a>
							<span href="#" class="page-numbers">...</span> <a href="#"
								class="page-numbers">24</a> <a href="#"
								class="next page-numbers"><i class="icon-chevron-right"></i></a>
						</div>
						<div class="view-show">
							<span>翻页:</span> <a href="#">20</a> <a href="#">30</a>
						</div>
					</div>
					.pagination --> <!-- 					<div class="products-ordering"> --> <!-- 						<form class="ordering-wrapper"> -->
					<!-- 							<label>排序方法：</label> <select name="sort" --> <!-- 								class="orderby custom_select"> -->
					<!-- 								<option value="title" selected="selected">热度</option> -->
					<!-- 								<option value="date">最新</option> --> <!-- 								<option value="price_high">价格从高到底</option> -->
					<!-- 								<option value="price_low">价格从低到高</option> --> <!-- 							</select> -->
					<!-- 						</form> --> <!-- 						<div class="view-mode"> --> <!-- 							<a href="#grid" class="selected"><i class="icon-th-large"></i></a> -->
					<!-- 							<a href="#list"><i class="icon-th-list"></i></a> --> <!-- 						</div> -->
					<!-- 					</div> --> <!-- .products-ordering --> </header>
					<!-- .block-header -->

					<ul class="products">
						<%
							List<Collection> collections = UserLikeCollectionCommentService
																									.getUserLikeCollectionCommentService()
																									.searchCollectionsByUserID(user.getId());
																							for (Collection collection : collections) {
																								Model model = ModelService.getModelService().searchModelByID(
																										collection.getModelID());
						%>

						<li class="product span3"><figure class="product-header">
							<img src="modelimage?number=1&modelID=<%=model.getId()%>" style="z-index:1"/> <a
								class="product-link add-to-cart"
								href="javascript:addtoShopcar(<%=model.getId()%>)"> <i
								class="icon-shopping-cart"></i> 添加到购物车
							</a> <a class="product-link more-link"
								href="modeldetail.jsp?id=<%=model.getId()%>"> <i
								class="icon-eye-open"></i> 查看详细内容
							</a> </figure>
							<div class="product-content">
								<h4 class="product-title">
									<a href="modeldetail.jsp?id=<%=model.getId()%>"><%=model.getName()%></a>
								</h4>
								<div style="margin-top: -13px">
									<div style="float: left">
										<span><%=model.getStyle()%></span>
									</div>
									<div style="float: right">
										<span>点赞数(<%=model.getUserlike()%>)
										</span>&nbsp;&nbsp;<span>收藏数(<%=model.getCollection()%>)
										</span>
									</div>
								</div>
								<!-- <p class="product-price">
									<del>
										<span class="amount">￥99.00</span>
									</del>
									<ins>
										<span class="amount">￥79.99</span>
									</ins>
								</p> -->
								<!-- <a class="quick-view" href="#" title="Quick View"> <i
									class="icon-eye-open"></i>
								</a>
								<div class="product-desc hide">
									<p>error</p>
								</div> -->
							</div></li>
						<%
							}
						%>
					</ul>
					<!-- .products -->

					<!-- <div class="pagination">
						<div class="paging-number">
							<span class="page-numbers current">1</span> <a href="#"
								class="page-numbers">2</a> <a href="#" class="page-numbers">3</a>
							<span href="#" class="page-numbers">...</span> <a href="#"
								class="page-numbers">24</a> <a href="#"
								class="next page-numbers"><i class="icon-chevron-right"></i></a>
						</div>
						<div class="view-show">
							<span>翻页：</span> <a href="#">20</a> <a href="#">30</a>
						</div>
						<a href="#top" class="scroll-to">Back to Top</a>
					</div>
					.pagination -->
				</div>
			</div>
		</div>
		</section>
	</div>
	<script>
		function addtoShopcar(modelID) {
			$.ajax({
				type : 'GET',
				url : 'ajax/addshopcar',
				data : {
					modelID : modelID
				},
				dataType : 'json',
				async : false,
				success : function(data) {
					if (data.success) {
						alert('成功添加购物车。');
						location = '';
					} else {
						alert('该商品已在购物车中。');
					}
				},
				error : function(err) {
					alert('网络故障');
				}
			});
		}
		function selectAll() {
			var select = document.getElementById('allCheckBox').checked;
			var boxs = document.getElementsByClassName('modelCheckBox');
			for (var i = 0; i < boxs.length; i++) {
				boxs[i].checked = select;
			}
		}

		function cancelUserCollectionBatch() {
			var modelIDs = '';
			var boxs = document.getElementsByClassName('modelCheckBox');
			for (var i = 0; i < boxs.length; i++) {
				if (boxs[i].checked) {
					modelIDs += boxs[i].name + ';';
				}
			}
			cancelUserCollections(modelIDs);
		}

		function cancelUserCollectionSingle(modelID) {
			cancelUserCollections(modelID);
		}

		function cancelUserCollections(modelIDs) {
			$.ajax({
				type : "GET",
				url : 'ajax/cancelusercollections',
				data : {
					modelIDs : modelIDs
				},
				dataType : 'json',
				async : false,
				success : function(data) {
					if (data.successCount > 0) {
						alert('成功取消' + data.successCount + '个收藏。');
						location = '';
					} else {
						alert('取消失败。');
					}
				},
				error : function(err) {
					alert('网络故障');
				}
			});
		}
	</script>
</body>
</html>