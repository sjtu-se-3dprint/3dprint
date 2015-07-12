<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page
	import="service.GetLoginUserService,entity.*, database.*,java.util.List"%>
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
<title>3D打印创作服务平台-我的帖子</title>
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
						<li><a href="./user_shop_new.jsp">购物管理</a></li>
						<li><a href="./user_collect_new.jsp">我的收藏</a></li>
						<li class="active"><a href="./user_forum_new.jsp">我的帖子</a></li>
					</ul>
				</div>
				<div class="main-content span9">
					<table class="table" contenteditable="false">
						<thead>
							<tr>
								<td>序号</td>
								<td>帖子名</td>
								<td>所属板块</td>
								<td>发帖人</td>
								<td>发帖时间</td>
								<td>回复数</td>
								<td>操作</td>
							</tr>
						</thead>
						<tbody>
							<%
								List<Post> posts = PostService.getPostService()
										.searchPostByUserStatus(user.getId(), "normal");
								int i = 1;
								for (Post post : posts) {
							%>
							<tr class="one-row">
								<td><%=i++%></td>
								<td><%=(post.getTitle().length() > 14 ? post.getTitle()
						.subSequence(0, 14) + "..." : post.getTitle())%></td>
								<td><%=post.getFirstCategory() + "("
						+ post.getSecondCategory() + ")"%></td>
								<td><%=user.getName()%></td>
								<td><%=post.getAddtime().toLocaleString()%></td>
								<td><%=post.getResponse()%></td>
								<td>
									<button type="button" class="btn btn-success"
										onclick="location='forum_content.jsp?id=<%=post.getId()%>'">查看</button>&nbsp;
									<button type="button" class="btn btn-warning"
										onclick="deletePost(<%=post.getId()%>)">删除</button>
								</td>
							</tr>
							<%
								}
							%>
							
							<%
								posts = PostService.getPostService()
										.searchPostByUserStatus(user.getId(), "deleted");
								for (Post post : posts) {
							%>
							<tr class="one-row">
								<td><%=i++%></td>
								<td><%=(post.getTitle().length() > 14 ? post.getTitle()
						.subSequence(0, 14) + "..." : post.getTitle())%></td>
								<td><%=post.getFirstCategory() + "("
						+ post.getSecondCategory() + ")"%></td>
								<td><%=user.getName()%></td>
								<td><%=post.getAddtime().toLocaleString()%></td>
								<td><%=post.getResponse()%></td>
								<td>
									<button type="button" class="btn" disabled>已经删除</button>
								</td>
							</tr>
							<%
								}
							%>
						</tbody>
					</table>
				</div>
			</div>
		</div>
		</section>
	</div>
	
	<script>
	function deletePost(id){
		$.ajax({
			type: "GET",
			url: 'ajax/deletepost',
			data: {postID: id},
			dataType: 'json',
			async: false,
			success: function(data){
				if(data.success){
					alert('删除成功。');
					location = '';
				}else{
					alert('删除失败。');
				}
			},
			error: function(err){
				alert('网络故障。');
			}
		});
	}
	</script>
</body>
</html>