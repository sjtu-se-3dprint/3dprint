<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page import="service.GetLoginUserService"%>
<%@ page import="entity.*, database.*"%>
<%@ page import="java.util.List"%>
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
<!-- 	<script src="js/js-shoppinggo/libs/jquery-1.7.1.min.js" type="text/javascript"></script> -->

<title>3D打印创作服务平台-模型管理</title>
</head>
<body>
	<jsp:include page="header.jsp" flush="true"></jsp:include>
	<%
		User user = GetLoginUserService.service(request);
			if(user == null || !"user".equals(user.getAuthority())){
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
						<li class="active"><a href="./user_model_new.jsp">模型管理</a></li>
						<li><a href="./user_shop_new.jsp">购物管理</a></li>
						<li><a href="./user_collect_new.jsp">我的收藏</a></li>
						<li><a href="./user_forum_new.jsp">我的帖子</a></li>
					</ul>
				</div>
				<div class="main-content span9">
					<div class="thumbnail">
						<input type="checkbox" id="allCheckBox" onclick="selectAll();">&nbsp;&nbsp;&nbsp;全选&nbsp;&nbsp;&nbsp;
						<button type="button" class="btn btn-danger"
							onclick="deleteModelBatch();">合并删除</button>
					</div>
					<table class="table" contenteditable="true">
						<thead>
							<tr>
								<th></th>
								<th>编号</th>
								<th>模型描述</th>
								<th>上传时间</th>
								<th>规模</th>
								<th>性质</th>
								<th>操作</th>
							</tr>
						</thead>
						<tbody>
							<%
								List<Model> models = ModelService.getModelService().searchModelsByUserStatus(user.getId(), "normal");
							                                    for(Model model:models){
							%>
							<tr>
								<td><input type="checkbox" class="modelCheckBox"
									name="<%=model.getId()%>"></td>
								<td><%=model.getId()%></td>
								<td>
									<div style="float: left;">
										<a href="<%="modeldetail.jsp?id=" + model.getId()%>"> <img
											alt="model" width="100" height="70"
											src="<%="modelimage?modelID=" + model.getId() + "&number=1"%>" /><br />
										</a>
									</div>
									<div style="float: left; padding: 5px;">
										<%=model.getName() + ": " + model.getDescriptrion()%>
									</div>
								</td>
								<td><%=model.getAddtime().toLocaleString()%></td>
								<td><%=model.getLength().intValue()%>mm*<%=model.getWidth().intValue()%>mm*<%=model.getHeight().intValue()%>mm</td>
								<td><%=model.getStyle()%></td>
								<td>
									<button type="button" class="btn btn-success"
										onclick="location='model_reinfo.jsp?modelID=<%=model.getId()%>'">编辑</button>&nbsp;
									<button type="button" class="btn btn-danger"
										onclick="deleteModelSingle('<%=model.getId()%>');"\>删除</button>
								</td>
							</tr>
							<%
								}
							%>
						</tbody>
					</table>
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
		function selectAll() {
			var select = document.getElementById('allCheckBox').checked;
			var boxs = document.getElementsByClassName('modelCheckBox');
			for (var i = 0; i < boxs.length; i++) {
				boxs[i].checked = select;
			}
		}

		function deleteModelBatch() {
			var modelIDs = '';
			var boxs = document.getElementsByClassName('modelCheckBox');
			for (var i = 0; i < boxs.length; i++) {
				if (boxs[i].checked) {
					modelIDs += boxs[i].name + ';';
				}
			}
			if (modelIDs == '') {
				alert('请选择至少一个模型')
				return;
			}

			deleteModels(modelIDs);
		}

		function deleteModelSingle(modelID) {
			deleteModels(modelID);
		}

		function deleteModels(modelIDs) {
			$.ajax({
				type : "GET",
				url : 'ajax/deletemodels',
				data : {
					modelIDs : modelIDs
				},
				dataType : 'json',
				async : false,
				success : function(data) {
					if (data.successCount > 0) {
						alert('成功删除' + data.successCount + '个模型。');
						location = '';
					} else {
						alert('删除失败。');
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