<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page import="service.GetLoginUserService,entity.*, database.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; ">
<title>3D打印创作服务平台-admin中心</title>
<script type="text/javascript" charset="utf-8"
	src="ueditor1_4_3-utf8-jsp/ueditor.config.js"></script>
<script type="text/javascript" charset="utf-8"
	src="ueditor1_4_3-utf8-jsp/ueditor.all.min.js"> 
	
</script>
</head>
<body>
	<jsp:include page="header.jsp" flush="true"></jsp:include>
	<%
		User user = GetLoginUserService.service(request);
		if (user == null || !"admin".equals(user.getAuthority())) {
			return;
		}
	%>
	<div class="container-fluid">
		<div class="row-fluid">
			<div class="span12">
				<div class="row-fluid">

					<div class="span2">
						<hr>
						<div class="row-fluid">
							<div class="span12">
								<div class="col-xs-3" id="myScrollspy">
									<img alt="user_pic" src="./img/users/user2.jpg"
										class="img-polaroid" />
									<div class="span12">
										<br> <span> &nbsp;&nbsp;你 好，</span> <span> <%=user.getName()%>！
										</span> <br> <br>
									</div>
									<ul class="nav nav-tabs nav-stacked" data-spy="affix"
										data-offset-top="125">
										<li><a href="admin.jsp">个人设置</a></li>
										<li><a href="ad_user.jsp">用户管理</a></li>
										<li><a href="ad_comment.jsp">评论管理</a></li>
										<li><a href="ad_forum.jsp">论坛管理</a></li>
										<li class="active"><a href="ad_addlesson_new.jsp">发布教程</a></li>
									</ul>
								</div>
							</div>
						</div>

					</div>

					<div class="span10">
						<hr>
						<div class="tabbable">
							<ul class="nav nav-tabs">
								<li class="active"><a href="#panel-819612"
									data-toggle="tab">发布教程</a></li>
							</ul>
							<div class="tab-content">
								<div class="tab-pane active" id="panel-819612">
									<div class="container" id="lesson_content"
										style="padding-top: 10px;">
										<div>
											教程标题：<input type="text" id="lesson_title" style="width: 80%">
										</div>
										<div>教程内容：</div>
										<script id="editor" type="text/plain" style="height:250px;"></script>
										<script>
											var ue = UE
													.getEditor('editor');
										</script>
									</div>
									<div style="margin: 0 auto; text-align: center">
										<input class="btn btn-primary" type="button" value="提交教程"
											onclick="submit_lesson();">
									</div>
								</div>
							</div>
						</div>

					</div>
				</div>
			</div>
		</div>
	</div>
	<jsp:include page="footer.jsp" flush="true"></jsp:include>
	<script>
		function submit_lesson() {

			var title = $('#lesson_title').val();
			if (title == '') {
				alert('请输入教程标题');
				return;
			}

			if (!ue.hasContents()) {
				alert('教程内容不能为空。');
				return;
			}

			var content = ue.getContent();
			var lesson = new Object();
			lesson.title = title;
			lesson.content = content;
			$.ajax({
				type : 'POST',
				url : 'ajax/addlesson_new',
				dataType : 'json',
				contentType : 'application/json',
				data : JSON.stringify(lesson),
				success : function(data) {
					alert('发布教程成功');
					location = 'lessons_new.jsp?id=' + data.id;
				},
				error : function(e) {
					alert('请先登录');
				}
			})
			console.log(content);
			// 			$.ajax({
			// 				type : "POST",
			// 				url : "ajax/addlesson",
			// 				dataType : "json",
			// 				contentType : "application/json",
			// 				data : JSON.stringify(lesson),
			// 				success : function(data) {
			// 					alert('ok:' + data)
			// 				},
			// 				error : function(e) {
			// 					console.log('请先登录');
			// 				}
			// 			});
		}
	</script>
</body>
</html>