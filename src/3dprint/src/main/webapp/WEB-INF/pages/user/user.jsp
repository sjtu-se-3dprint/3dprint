<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
</head>
<body>
	<jsp:include page="../common/header.jsp" flush="true"></jsp:include>
	<script src="<%=request.getContextPath()%>/js/user/user_setting.js"></script>
	<script src="<%=request.getContextPath()%>/js/common/drag.js"></script>
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
				<a href="#" class="list-group-item active">个人设置</a> <a href="#"
					class="list-group-item">我的模型</a> <a href="#"
					class="list-group-item">我的购物</a> <a href="#"
					class="list-group-item">我的收藏</a> <a href="#"
					class="list-group-item">我的帖子</a>
			</div>
		</div>
		<ul class="nav nav-tabs col-md-9">
			<li class="active"><a href="#panel-modify-info"
				data-toggle="tab">修改资料</a></li>
			<li><a href="#panel-modify-headimage" data-toggle="tab">修改头像</a></li>
			<li><a href="#panel-modify-password" data-toggle="tab">修改密码</a></li>
		</ul>
		<div class="tab-content col-md-9">
			<div class="tab-pane active" id="panel-modify-info">
				<div class="row">
					<div class="form-horizontal"
						style="padding-top: 40px; margin-left: -40px">
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
									placeholder="Telephone">
							</div>
						</div>
						<div class="form-group">
							<label for="inputEmail" class="col-sm-2 control-label">邮箱：</label>
							<div class="col-sm-4">
								<input type="text" class="form-control" id="inputEmail"
									placeholder="E-mail">
							</div>
						</div>
						<div class="form-group">
							<label for="inputQQ" class="col-sm-2 control-label">QQ：</label>
							<div class="col-sm-4">
								<input type="text" class="form-control" id="inputQQ"
									placeholder="QQ Number">
							</div>
						</div>
						<div class="form-group">
							<div class="col-sm-offset-4 col-sm-2">
								<button id="modifyInfoBtn" type="submit" class="btn btn-primary"
									style="width: 100%">保存修改</button>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="tab-pane" id="panel-modify-headimage"
				style="padding: 20px">
				<input id="headimageSelecter" type="file" class="hidden"
					onchange="selectUserhead(this)" />
				<div class="row" style="padding-top: 20px">
					<div class="col-md-3">
						<button id="headimageSelectBtn" class="btn btn-success"
							style="width: 100%">选择图片</button>
					</div>
				</div>
				<div class="row" style="padding-top: 10px">
					<p class="col-md-10 text-muted">支持JPG、GIF、PNG格式，文件应小于5MB</p>
				</div>
				<div class="row">
					<canvas id="theCanvas" width="300" height="300" class=""
						style="width: 300px; height: 300px; border: 1px solid #AAA; float: left">
					</canvas>
					<div style="height: 300px; float: left; margin-left: 30px;">
						<div style="position: relative">
							<div id="headimageFilter"
								style="position: absolute; border: 1px dotted #777; display: none">
								<div id="headimageFilterScaler"
									style="position: absolute; bottom: 0; right: 0; width: 10px; height: 10px; background: gray"></div>
							</div>
							<p class="text-danger"
								style="position: absolute; width: 270px; top: 10px;">
								您上传的头像会自动生成三种尺寸，请注意头像是否清晰</p>
							<canvas id="headimageLarge" width="180" height="180"
								style="position: absolute; top: 60px; width: 180px; height: 180px; border: 1px solid #AAA;"></canvas>
							<div
								style="position: absolute; top: 250px; width: 180px; text-align: center">
								<p class="text-muted" class="font-size:9px">大尺寸头像，180x180像素</p>
							</div>
							<canvas id="headimageMid" width="50" height="50"
								style="position: absolute; top: 60px; left: 220px; width: 50px; height: 50px; border: 1px solid #AAA;"></canvas>
							<div
								style="position: absolute; top: 120px; left: 200px; width: 90px; text-align: center">
								<p class="text-muted font-size:9px">中尺寸头像</p>
								<p class="text-muted font-size:9px" style="margin-top: -10px">50x50像素</p>
							</div>
							<canvas id="headimageSmall" width="30" height="30"
								style="position: absolute; top: 180px; left: 230px; width: 30px; height: 30px; border: 1px solid #AAA;"></canvas>
							<div
								style="position: absolute; top: 220px; left: 200px; width: 90px; text-align: center">
								<p class="text-muted font-size:9px">小尺寸头像</p>
								<p class="text-muted font-size:9px" style="margin-top: -10px">30x30像素</p>
							</div>
						</div>
					</div>
				</div>
				<div id="headimageBtnGroup" class="row hidden"
					style="padding-top: 20px">
					<div class="col-md-2">
						<button id="headimageSubmitBtn" class="btn btn-default"
							style="width: 100%">保存</button>
					</div>
					<div class="col-md-2">
						<button id="headimageCancelBtn" class="btn btn-default"
							style="width: 100%">取消</button>
					</div>
				</div>
			</div>
			<div class="tab-pane" id="panel-modify-password">
				<div class="form-horizontal"
					style="padding-top: 40px; margin-left: -40px">
					<div class="form-group">
						<label for="inputTelephone" class="col-sm-2 control-label">原密码：</label>
						<div class="col-sm-4">
							<input type="password" class="form-control" id="inputOldPassword"
								placeholder="Old Password">
						</div>
					</div>
					<div class="form-group">
						<label for="inputEmail" class="col-sm-2 control-label">新密码：</label>
						<div class="col-sm-4">
							<input type="password" class="form-control" id="inputNewPassword"
								placeholder="New Password">
						</div>
					</div>
					<div class="form-group">
						<label for="inputQQ" class="col-sm-2 control-label">确认密码：</label>
						<div class="col-sm-4">
							<input type="password" class="form-control" id="inputConfirmPassword"
								placeholder="Confirm New Password">
						</div>
					</div>
					<div class="form-group">
						<div class="col-sm-offset-4 col-sm-2">
							<button id="modifyPasswordBtn" type="submit" class="btn btn-primary"
								style="width: 100%">确认修改</button>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>