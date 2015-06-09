<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
</head>
<body>
	<jsp:include page="../common/header.jsp" flush="true"></jsp:include>
	<script src="<%=request.getContextPath()%>/js/user/user_setting.js"></script>
	<div class="container">
		<div class="col-md-3">
			<div  class="thumbnail center-block" style="width:150px;height:150px">
				<img id="headimage" class="" src="<%=request.getContextPath()%>/image/userhead_default.jpg" />
			</div>
			<a href="" class="center-block text-center" style="margin-top:-10px">你好：<span id="usernameText"></span></a>

			<div class="list-group center-block" style="width:160px; padding-top:20px;">
				<a href="#" class="list-group-item active">个人设置</a> <a
					href="#" class="list-group-item">我的模型</a> <a
					href="#" class="list-group-item">我的购物</a> <a href="#"
					class="list-group-item">我的收藏</a> <a href="#"
					class="list-group-item">我的帖子</a>
			</div>
		</div>
		<ul class="nav nav-tabs col-md-9">
			<li class="active"><a href="#panel-modify-info" data-toggle="tab">修改资料</a></li>
			<li><a href="#panel-modify-headimage" data-toggle="tab">修改头像</a></li>
			<li><a href="#panel-modify-password" data-toggle="tab">修改密码</a></li>
		</ul>
		<div class="tab-content col-md-9">
			<div class="tab-pane active" id="panel-modify-info">
				<div class="row">
					<div class="form-horizontal" style="padding-top:40px; margin-left:-40px">
						<div class="form-group">
							<label for="inputUsername" class="col-sm-2 control-label">用户名：</label>
							<div class="col-sm-4">
								<input type="text" class="form-control" id="inputUsername"
									placeholder="Username" readonly>
							</div>
						</div>
						<div class="form-group">
							<label for="inputTelephone" class="col-sm-2 control-label">手机号：</label>
							<div class="col-sm-4">
								<input type="text" class="form-control" id="inputTelephone"
									placeholder="Telephone" >
							</div>
						</div>
						<div class="form-group">
							<label for="inputEmail" class="col-sm-2 control-label">邮箱：</label>
							<div class="col-sm-4">
								<input type="text" class="form-control" id="inputEmail"
									placeholder="E-mail" >
							</div>
						</div>
						<div class="form-group">
							<label for="inputQQ" class="col-sm-2 control-label">QQ：</label>
							<div class="col-sm-4">
								<input type="text" class="form-control" id="inputQQ"
									placeholder="QQ Number" >
							</div>
						</div>
						<div class="form-group">
							<div class="col-sm-offset-4 col-sm-2">
								<button id="modifyInfoBtn" type="submit" class="btn btn-primary" style="width:100%">保存修改</button>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="tab-pane" id="panel-modify-headimage"></div>
			<div class="tab-pane" id="panel-modify-password"></div>
		</div>
	</div>
</body>
</html>