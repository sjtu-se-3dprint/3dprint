<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page
	import="service.GetLoginUserService,entity.*, database.*, java.util.List, java.util.ArrayList"%>
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

<title>3D打印创作服务平台-购物管理</title>
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
						<li class="active"><a href="./user_shop_new.jsp">购物管理</a></li>
						<li><a href="./user_collect_new.jsp">我的收藏</a></li>
						<li><a href="./user_forum_new.jsp">我的帖子</a></li>
					</ul>
				</div>
				<div class="main-content span9">
					<div class="tabbable">
						<%
							List<Order> waitingCheckOrders = ShoppingService
									.getShoppingService().searchOrdersByUserStatus(
											user.getId(), "waiting check");
							List<Order> checkedOrders = ShoppingService.getShoppingService()
									.searchOrdersByUserStatus(user.getId(), "checked");
							List<Order> waitingReceiveOrders = ShoppingService
									.getShoppingService().searchOrdersByUserStatus(
											user.getId(), "waiting receive");
							List<Order> receivedOrders = ShoppingService.getShoppingService()
									.searchOrdersByUserStatus(user.getId(), "received");
							List<Order> canceledOrders = ShoppingService.getShoppingService()
									.searchOrdersByUserStatus(user.getId(), "canceled");
							List<Order> allOrders = new ArrayList<Order>();
							allOrders.addAll(waitingCheckOrders);
							allOrders.addAll(checkedOrders);
							allOrders.addAll(waitingReceiveOrders);
							allOrders.addAll(receivedOrders);
							allOrders.addAll(canceledOrders);
						%>
						<ul class="nav nav-tabs">
							<li class="active"><a href="#panel-819612" data-toggle="tab">全部订单
									<span>(<%=allOrders.size()%>)
								</span>
							</a></li>
							<li><a href="#panel-390436" data-toggle="tab">待确认付款 <span>(<%=waitingCheckOrders.size()%>)
								</span></a></li>
							<li><a href="#panel-390437" data-toggle="tab">待发货 <span>(<%=checkedOrders.size()%>)
								</span></a></li>
							<li><a href="#panel-390438" data-toggle="tab">待确认收货 <span>(<%=waitingReceiveOrders.size()%>)
								</span></a></li>
							<li><a href="#panel-390439" data-toggle="tab">已完成 <span>(<%=receivedOrders.size()%>)
								</span></a></li>
							<li><a href="#panel-390440" data-toggle="tab">失败订单 <span>(<%=canceledOrders.size()%>)
								</span></a></li>
						</ul>

						<!-- 全部订单 -->
						<div class="tab-content">
							<div class="tab-pane active" id="panel-819612">
								<table class="table" contenteditable="true">
									<thead>
										<tr>
											<th>订单号</th>
											<th>购买模型</th>
											<th>模型信息</th>
											<th>材料</th>
											<th>下单时间</th>
											<th>数量</th>
											<th>成交价格</th>
											<th>交易状态</th>
											<th>操作</th>
										</tr>
									</thead>
									<tbody>
										<%
											for (Order order : allOrders) {
												Model model = ModelService.getModelService().searchModelByID(
														order.getModel().getId());
												User buyer = UserService.getUserService().searchUserByID(
														order.getUser().getId());
												Material material = ShoppingService.getShoppingService()
														.searchMaterialByID(order.getMaterial().getId());
										%>
										<tr>
											<td><%=order.getId()%></td>
											<td><img alt="model" width="100" height="70"
												src="modelimage?number=1&modelID=<%=model.getId()%>" /><br /><%=model.getName()%></td>
											<td><div><%=model.getDescriptrion()%></div></td>
											<td><%=material.getName()%></td>
											<td><%=order.getAddtime().toLocaleString()%></td>
											<td><%=order.getNumber()%></td>
											<% 
												if("waiting check".equals(order.getStatus())
														|| "canceled".equals(order.getStatus())){
											%>
											<td>无</td>
											<%
												}else{
											%>
											<td><%=order.getPrice() %></td>
											<%
												}
											%>
											<%
												if("waiting check".equals(order.getStatus())){
													out.println("<td>待确认付款</td>");
													out.println("<td><button type=\"button\" class=\"btn btn-success\" onclick=\"cancelOrder(" + order.getId() + ")\">取消</button></td>");
												}else if("checked".equals(order.getStatus())){
													out.println("<td>待发货</td>");
													out.println("<td><button type=\"button\" class=\"btn btn-danger\" disabled>提醒发货</button></td>");
												}else if("waiting receive".equals(order.getStatus())){
													out.println("<td>待确认收货</td>");
													out.println("<td><button type=\"button\" class=\"btn btn-success\" onclick=\"received(" + order.getId() + ")\">确认收货</button></td>");
												}else if("received".equals(order.getStatus())){
													out.println("<td>已完成</td>");
													out.println("<td><button type=\"button\" class=\"btn btn-warning\" onclick=\"location='modeldetail.jsp?id=" + order.getId() + "'\">评价</button></td>");
												}else if("canceled".equals(order.getStatus())){
													out.println("<td>已取消</td>");
													out.println("<td>无</td>");
												}
											%>
										</tr>
										<%
											}
										%>
									</tbody>
								</table>
							</div>

							<!-- 待确认付款 -->
							<div class="tab-pane" id="panel-390436">
								<table class="table" contenteditable="true">
									<thead>
										<tr>
											<th>订单号</th>
											<th>购买模型</th>
											<th>模型信息</th>
											<th>材料</th>
											<th>下单时间</th>
											<th>数量</th>
											<th>交易状态</th>
											<th>操作</th>
										</tr>
									</thead>
									<tbody>
										<%
											for (Order order : waitingCheckOrders) {
												Model model = ModelService.getModelService().searchModelByID(
														order.getModel().getId());
												User buyer = UserService.getUserService().searchUserByID(
														order.getUser().getId());
												Material material = ShoppingService.getShoppingService()
														.searchMaterialByID(order.getMaterial().getId());
										%>
										<tr>
											<td><%=order.getId()%></td>
											<td><img alt="model" width="100" height="70"
												src="modelimage?number=1&modelID=<%=model.getId()%>" /><br /><%=model.getName()%></td>
											<td><div><%=model.getDescriptrion()%></div></td>
											<td><%=material.getName()%></td>
											<td><%=order.getAddtime().toLocaleString()%></td>
											<td><%=order.getNumber()%></td>
											<td><%=""%>待确认付款</td>
											<td>
												<button type="button" class="btn btn-success" onclick="cancelOrder(<%=order.getId()%>)">取消</button>&nbsp;
												<button type="button" class="btn btn-warning" onclick="location='modeldetail.jsp?id=<%=model.getId()%>'">评价</button>
											</td>
										</tr>
										<%
											}
										%>
									</tbody>
								</table>
							</div>

							<!-- 待发货 -->
							<div class="tab-pane" id="panel-390437">
								<table class="table" contenteditable="true">
									<thead>
										<tr>
											<th>订单号</th>
											<th>购买模型</th>
											<th>模型信息</th>
											<th>材料</th>
											<th>下单时间</th>
											<th>数量</th>
											<th>成交价格</th>
											<th>交易状态</th>
											<th>操作</th>
										</tr>
									</thead>
									<tbody>
										<%
											for (Order order : checkedOrders) {
												Model model = ModelService.getModelService().searchModelByID(
														order.getModel().getId());
												User buyer = UserService.getUserService().searchUserByID(
														order.getUser().getId());
												Material material = ShoppingService.getShoppingService()
														.searchMaterialByID(order.getMaterial().getId());
										%>
										<tr>
											<td><%=order.getId()%></td>
											<td><img alt="model" width="100" height="70"
												src="modelimage?number=1&modelID=<%=model.getId()%>" /><br /><%=model.getName()%></td>
											<td><div><%=model.getDescriptrion()%></div></td>
											<td><%=material.getName()%></td>
											<td><%=order.getAddtime().toLocaleString()%></td>
											<td><%=order.getNumber()%></td>
											<td>￥<%=order.getPrice()%></td>
											<td>已付款，待发货</td>
											<td>
												<button type="button" class="btn btn-danger" disabled>提醒发货</button>&nbsp;
												<button type="button" class="btn btn-warning" onclick="location='modeldetail.jsp?id=<%=model.getId()%>'">评价</button>
											</td>
										</tr>
										<%
											}
										%>
									</tbody>
								</table>
							</div>

							<!-- 待确认收货 -->
							<div class="tab-pane" id="panel-390438">
								<table class="table" contenteditable="true">
									<thead>
										<tr>
											<th>订单号</th>
											<th>购买模型</th>
											<th>模型信息</th>
											<th>材料</th>
											<th>下单时间</th>
											<th>数量</th>
											<th>成交价格</th>
											<th>交易状态</th>
											<th>操作</th>
										</tr>
									</thead>
									<tbody>
										<%
											for (Order order : waitingReceiveOrders) {
												Model model = ModelService.getModelService().searchModelByID(
														order.getModel().getId());
												User buyer = UserService.getUserService().searchUserByID(
														order.getUser().getId());
												Material material = ShoppingService.getShoppingService()
														.searchMaterialByID(order.getMaterial().getId());
										%>
										<tr>
											<td><%=order.getId()%></td>
											<td><img alt="model" width="100" height="70"
												src="modelimage?number=1&modelID=<%=model.getId()%>" /><br /><%=model.getName()%></td>
											<td><div><%=model.getDescriptrion()%></div></td>
											<td><%=material.getName()%></td>
											<td><%=order.getAddtime().toLocaleString()%></td>
											<td><%=order.getNumber()%></td>
											<td>￥<%=order.getPrice()%></td>
											<td>待确认收货</td>
											<td>
												<button type="button" class="btn btn-success" onclick="received(<%=order.getId()%>)">确认收货</button>&nbsp;
												<button type="button" class="btn btn-warning" onclick="location='modeldetail.jsp?id=<%=model.getId()%>'">评价</button>
											</td>
										</tr>
										<%
											}
										%>
									</tbody>
								</table>
							</div>

							<!-- 已完成 -->
							<div class="tab-pane" id="panel-390439">
								<table class="table" contenteditable="true">
									<thead>
										<tr>
											<th>订单号</th>
											<th>购买模型</th>
											<th>模型信息</th>
											<th>材料</th>
											<th>下单时间</th>
											<th>数量</th>
											<th>成交价格</th>
											<th>交易状态</th>
											<th>操作</th>
										</tr>
									</thead>
									<tbody>
										<tr>
											<%
												for (Order order : receivedOrders) {
													Model model = ModelService.getModelService().searchModelByID(
															order.getModel().getId());
													User buyer = UserService.getUserService().searchUserByID(
															order.getUser().getId());
													Material material = ShoppingService.getShoppingService()
															.searchMaterialByID(order.getMaterial().getId());
											%>
											<td><%=order.getId()%></td>
											<td><img alt="model" width="100" height="70"
												src="modelimage?number=1&modelID=<%=model.getId()%>" /><br /><%=model.getName()%></td>
											<td><div><%=model.getDescriptrion()%></div></td>
											<td><%=material.getName()%></td>
											<td><%=order.getAddtime().toLocaleString()%></td>
											<td><%=order.getNumber()%></td>
											<td>￥<%=order.getPrice()%></td>
											<td>已完成</td>
											<td>
												<button type="button" class="btn btn-warning" onclick="location='modeldetail.jsp?id=<%=model.getId()%>'">评价</button>
											</td>
										</tr>
										<%
											}
										%>
									</tbody>
								</table>
							</div>

							<!-- 失败订单 -->
							<div class="tab-pane" id="panel-390440">
								<table class="table" contenteditable="true">
									<thead>
										<tr>
											<th>订单号</th>
											<th>购买模型</th>
											<th>模型信息</th>
											<th>材料</th>
											<th>下单时间</th>
											<th>数量</th>
											<th>交易状态</th>
											<th>操作</th>
										</tr>
									</thead>
									<tbody>
										<%
											for (Order order : canceledOrders) {
												Model model = ModelService.getModelService().searchModelByID(
														order.getModel().getId());
												User buyer = UserService.getUserService().searchUserByID(
														order.getUser().getId());
												Material material = ShoppingService.getShoppingService()
														.searchMaterialByID(order.getMaterial().getId());
										%>
										<tr>
											<td><%=order.getId()%></td>
											<td><img alt="model" width="100" height="70"
												src="modelimage?number=1&modelID=<%=model.getId()%>" /><br /><%=model.getName()%></td>
											<td><div><%=model.getDescriptrion()%></div></td>
											<td><%=material.getName()%></td>
											<td><%=order.getAddtime().toLocaleString()%></td>
											<td><%=order.getNumber()%></td>
											<td>已取消</td>
											<td>无</td>
										</tr>
										<%
											}
										%>
									</tbody>
								</table>
							</div>
						</div>
					</div>
					<!-- <div class="pagination">
							<div class="paging-number">
								<span class="page-numbers current">1</span>
								<a href="#" class="page-numbers">2</a>
								<a href="#" class="page-numbers">3</a>
								<span href="#" class="page-numbers">...</span>
								<a href="#" class="page-numbers">24</a>
								<a href="#" class="next page-numbers"><i class="icon-chevron-right"></i></a>
							</div>
							<div class="view-show">
							  <span>翻页:</span>
							  <a href="#">20</a>
							  <a href="#">30</a>
							</div>
						</div>.pagination -->
				</div>
			</div>
		</div>
		</section>
	</div>
	
	<script>
		function selectAll(){
			var select = document.getElementById('allShopcarCheckBox').checked;
			var boxs = document.getElementsByClassName('shopcarCheckBox');
			for(var i=0; i<boxs.length; i++){
				boxs[i].checked = select;
			}
		}
		
		function collection(isCollection, modelID){
			if(isCollection){
				var success = cancelUserCollection(modelID);
				if(success){
					alert('取消收藏成功。');
					location = '';
				}else{
					alert('取消收藏失败。');
				}
			}else{
				var success = addUserCollection(modelID);
				if(success){
					alert('添加收藏成功。');
					location = '';
				}else{
					alert('添加收藏失败。');
				}
			}
		}

		function deleteShopcarAll(){
			document.getElementById('allShopcarCheckBox').checked = true;
			selectAll();
			deleteShopcarBatch();
		}

		function deleteShopcarBatch(){
			var boxs = document.getElementsByClassName('shopcarCheckBox');
			var modelIDs = '';
			for(var i=0; i<boxs.length; i++){
				if(boxs[i].checked){
					modelIDs += boxs[i].name + ';';
				}
			}
			if(modelIDs == ''){
				alert('请选中模型。');
				return;
			}
			var count = deleteShopcars(modelIDs);
			if(count > 0){
				alert('成功移出' + count + '个模型。');
				location = '';
			}else{
				alert('移出购物车失败。');
			}
		}

		function deleteShopcar(modelID){
			console.log('delete shopcar');
			if(deleteShopcars(modelID)==1){
				alert('1个商品已经移出购物车。');
				location = '';
			}else{
				alert('操作失败');
			}
		}

		/**
		 * 用户收藏。
		 */
		function addUserCollection(modelID){
			var success = false;
			$.ajax({
				type:'GET',
				url: 'ajax/usercollection',
				data:{modelID:modelID},
				dataType:'json',
				async:false,
				success: function(data){
					success = data.success;
				},
				error: function(err){
					alert('网络故障。');
				}
			});
			return success;
		}

		/**
		 * 用户取消收藏。
		 */
		function cancelUserCollection(modelID){
			var success = false;
			$.ajax({
				type:'GET',
				url: 'ajax/cancelusercollection',
				data:{modelID:modelID},
				dataType:'json',
				async:false,
				success: function(data){
					success = data.success;
				},
				error: function(err){
					alert('网络故障。');
				}
			});
			return success;
		}

		function received(orderID){
			receivedAjax(orderID);
		}

		function cancelOrder(orderID){
			cancelOrdersAjax(orderID);
		}

		function receivedAjax(orderIDs){
			console.log('取消订单');
			$.ajax({
				type: "GET",
				url: 'ajax/changeordersstatusbyuser',
				data: {status:'received',orderIDs:orderIDs},
				dataType: 'json',
				async: false,
				success: function(data){
					if(data.count > 0){
						alert(data.count + '个订单收货成功。');
						location = '';
					}else{
						alert('操作失败。');
					}
				},
				error: function(err){
					alert('网络故障');
				}
			});
		}

		function cancelOrdersAjax(orderIDs){
			console.log('取消订单');
			$.ajax({
				type: "GET",
				url: 'ajax/changeordersstatusbyuser',
				data: {status:'canceled',orderIDs:orderIDs},
				dataType: 'json',
				async: false,
				success: function(data){
					if(data.count > 0){
						alert('取消' + data.count + '订单成功。');
						location = '';
					}else{
						alert('取消订单失败。');
					}
				},
				error: function(err){
					alert('网络故障');
				}
			});
		}
	</script>
</body>
</html>