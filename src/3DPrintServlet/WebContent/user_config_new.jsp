<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page import="service.GetLoginUserService,entity.*, database.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; ">

<link href="css/css-shoppingo/bootstrap.css" media="screen"
	rel="stylesheet" type="text/css" />
<title>3D打印创作服务平台-账号设置</title>
</head>
<body>
	<jsp:include page="header.jsp" flush="true"></jsp:include>
	<%
		User user = GetLoginUserService.service(request);
		if (user == null || !"user".equals(user.getAuthority())) {
			return;
		}
	%>

</head>

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
						<li class="active"><a href="./user_config_new.jsp">账号设置</a></li>
						<li><a href="./user_model_new.jsp">模型管理</a></li>
						<li><a href="./user_shop_new.jsp">购物管理</a></li>
						<li><a href="./user_collect_new.jsp">我的收藏</a></li>
						<li><a href="./user_forum_new.jsp">我的帖子</a></li>
					</ul>
				</div>
				<div class="main-content span9">
					<div class="tabbable" id="tabs-176309">
						<ul class="nav nav-tabs">
							<li class="active"><a href="#panel-01" data-toggle="tab">基本信息</a>
							</li>
							<li><a href="#panel-02" data-toggle="tab">上传头像</a></li>
							<li><a href="#panel-03" data-toggle="tab">修改密码</a></li>
							<li><a href="#panel-04" data-toggle="tab">收货地址</a></li>
							<li><a href="#panel-05" data-toggle="tab">发票信息</a></li>
						</ul>
						<div class="tab-content">
							<div class="tab-pane active" id="panel-01">
								<form class="form-horizontal">
									<fieldset>
										<div class="control-group">
											<span class="sr-only" for="inputnicheng">用户名：</span> <input
												type="text" class="form-control" id="inputnicheng"
												value="<%=user.getName()%>" disabled placeholder="null">
										</div>
										<div class="control-group">
											<span class="sr-only" for="inputPhone">手机：</span> <input
												type="text" class="form-control" id="inputPhone"
												value="<%=user.getTelephone() == null ? "" : user.getTelephone()%>"
												placeholder="输入手机号">
										</div>
										<div class="control-group">
											<span class="sr-only" for="inputQQ">QQ：</span> <input
												type="text" class="form-control" id="inputQQ"
												value="<%=user.getQq() == null ? "" : user.getQq()%>"
												placeholder="输入QQ号">
										</div>
										<div class="control-group">
											<span class="sr-only" for="inputEmail">邮箱：</span> <input
												type="text" class="form-control" id="inputEmail"
												value="<%=user.getEmail() == null ? "" : user.getEmail()%>"
												placeholder="输入邮箱地址">
										</div>
										<div class="control-group">
											<span class="sr-only" for="e-mail">注册时间：<%=user.getAddtime()%></span>
										</div>
										<!-- <div class="control-group">
											<span class="sr-only" for="sex">性别：</span> <span
												class="radio"> <input type="radio"
												name="optionsRadios" id="optionsRadiosMen" value="option1"
												checked> 男
											</span> <span class="radio"> <input type="radio"
												name="optionsRadios" id="optionsRadiosWomen" value="option2">
												女
											</span>
										</div> -->
										<br />
										<div class="control-group">
											<label for="sig">签名档：</label>
											<textarea class="form-control" id="sig" rows="4"></textarea>
										</div>
									</fieldset>
								</form>
								<button type="button" class="btn btn-primary" id="save"
									onclick="modifyInfo();">保存</button>
							</div>
							<div class="tab-pane" id="panel-02">
								<div class="product span3">
									<div>
										<img alt="user picture" src="userheadimage?userID=<%=user.getId() + "&random=" + Math.random() %>"
											class="img-rounded" width="180" height="180" id="headimage" >
									</div>
								</div>
								<div class="product span3">
									<form role="form">
										<div class="form-group">
											<label for="inputfile">本地图片文件</label> <input type="file"
												id="inputfile" onchange="selectImage(this);"> <br />
											<p class="help-block">请选择本地图片文件，仅支持JPEG</p>
										</div>
										<br /> <br /> <br />
										<button type="button" class="btn btn-primary" id="submitimg" onclick="upLoadImage();" disabled>提交</button>
									</form>
								</div>
							</div>
							<div class="tab-pane" id="panel-03">
								<form class="form-horizontal">
									<fieldset>
										<div class="control-group">
											<span class="sr-only" for="old_password">原密码：</span> <input
												type="password" class="form-control" id="oldpass">
										</div>
										<div class="control-group">
											<span class="sr-only" for="new_password">新密码：</span> <input
												type="password" class="form-control" id="newpass">
										</div>
										<div class="control-group">
											<span class="sr-only" for="confirm_password">确认密码：</span> <input
												type="password" class="form-control" id="newpassAgain">
										</div>
									</fieldset>
								</form>
								<br />
								<button type="button" class="btn btn-primary" id="submit" onclick="modifyPassword();">确认修改</button>
							</div>
							<div class="tab-pane" id="panel-04">
								<table class="table table-striped" contenteditable="true">
									<thead>
										<tr>
											<th>收货人</th>
											<th>联系方式</th>
											<th>地址</th>
											<th>操作</th>
										</tr>
									</thead>
									<tbody>
										<tr>
											<td>王臻</td>
											<td>18217527179</td>
											<td>上海；闵行区；东川路800号</td>
											<td><a href="#">[修改]</a>&nbsp;<a href="#">[删除]</a></td>
										</tr>
										<tr>
											<td>刘德霖</td>
											<td>1234567890</td>
											<td>上海；闵行区；东川路800号</td>
											<td><a href="#">[修改]</a>&nbsp;<a href="#">[删除]</a></td>
										</tr>
									</tbody>
								</table>
								<div class="radio">
									<label> <input type="radio" name="newAddressRadios"
										id="newAddressRadio" value="option1">新增地址
									</label>
								</div>
								<form>
									<fieldset>
										<legend>地址编辑</legend>
										<table>
											<tr>
												<td>*收货人：</td>
												<td><input type="text"></td>
											</tr>
											<tr>
												<td>*联系电话：</td>
												<td><input type="text"></td>
											</tr>
											<tr>
												<td>*所在地区：</td>
												<td><input type="text"></td>
											</tr>
											<tr>
												<td>*详细地址：</td>
												<td><input type="text"></td>
											</tr>
											<tr>
												<td>邮编：</td>
												<td><input type="text"></td>
											</tr>
										</table>
									</fieldset>
								</form>
								<button type="button" class="btn btn-primary" disabled>提交</button>
							</div>
							<div class="tab-pane" id="panel-05">
								<table class="table table-striped" contenteditable="true">
									<thead>
										<tr>
											<th>发票类型</th>
											<th>发票抬头</th>
											<th>发票内容</th>
											<th>操作</th>
										</tr>
									</thead>
									<tbody>
										<tr>
											<td>[增值税发票]</td>
											<td>上海交通大学</td>
											<td>明细</td>
											<td><a href="#">[修改]</a>&nbsp;<a href="#">[删除]</a></td>
										</tr>
									</tbody>
								</table>
								<div class="radio">
									<label> <input type="radio" name="newAddressRadios"
										id="newAddressRadio" value="option1">新增发票信息
									</label>
								</div>
								<form>
									<fieldset>
										<legend>发票信息</legend>
										<table>
											<tr>
												<td>
													<form>
														*发票类型： <input type="radio" name="fapiao" value="normal">普通发票&nbsp;
														<input type="radio" name="fapiao" value="zengzhi">增值税发票
													</form>
												</td>
											</tr>
											<tr>
												<td>
													<form>
														*单位名称：<input type="text">
													</form>
												</td>
											</tr>
											<tr>
												<td>
													<form>
														*发票内容： <input type="radio" name="fapiao" value="normal">快速成型件&nbsp;
														<input type="radio" name="fapiao" value="zengzhi">明细
													</form>
												</td>
											</tr>
										</table>
									</fieldset>
								</form>
								<hr />
								<button type="button" class="btn btn-primary" disabled>提交</button>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		</section>
	</div>

	<script>
		/**
		 * 清空修改信息input中的已填信息。
		 */
		function reset() {
			document.getElementById('inputEmail').value = '';
			document.getElementById('inputPhone').value = '';
			document.getElementById('inputQQ').value = '';
		}

		/**
		 * 修改用户信息。
		 */
		function modifyInfo() {
			var email = document.getElementById('inputEmail').value;
			var phone = document.getElementById('inputPhone').value;
			var qq = document.getElementById('inputQQ').value;
			if (phone == '') {
				alert('手机号不能为空。');
				return;
			} else if (email == '') {
				alert('邮箱不能为空。');
				return;
			} else if (qq == '') {
				alert('QQ号不能为空');
				return;
			}

			$.ajax({
				type : 'GET',
				url : 'ajax/modifyuserinfo',
				data : {
					telephone : phone,
					email : email,
					qq : qq
				},
				async : false,
				dataType : 'json',
				success : function(data) {
					if (data.success) {
						alert('修改信息成功。');
						location = '';
					} else {
						alert('修改失败。');
					}
				},
				error : function(err) {
					alert('网络错误。');
				}
			});
		}

		function modifyPassword() {
			var oldPassword = document.getElementById('oldpass').value;
			var newPassword1 = document.getElementById('newpass').value;
			var newPassword2 = document.getElementById('newpassAgain').value;
			if (newPassword1 != newPassword2) {
				alert('新密码不一致。');
				return;
			}
			if (newPassword1.length < 6) {
				alert('新密码太短。');
				return;
			}

			$.ajax({
				type : 'GET',
				url : 'ajax/modifypassword',
				data : {
					oldPassword : oldPassword,
					newPassword : newPassword1
				},
				async : false,
				dataType : 'json',
				success : function(data) {
					if (data.success) {
						alert('修改密码成功。');
						location = '';
					} else {
						alert('修改失败。');
					}
				},
				error : function(err) {
					alert('网络错误。');
				}
			});
		}

		var image = '';
		function selectImage(file) {
			if (file.files && file.files[0]) {
				var img = document.getElementById('headimage');
				img.onload = function() {
					console.log('img load');
					document.getElementById('submitimg').disabled = false;
				}
				var reader = new FileReader();
				reader.onload = function(evt) {
					var src = evt.target.result;
					if (src.indexOf('data:image/jpeg') != 0) {
						alert('你上传的文件不是图片或者不是JPG格式。');
						return;
					}
					image = src;
					img.src = src;
				};
				reader.readAsDataURL(file.files[0]);
			}
		}

		function upLoadImage() {
			$.ajax({
				type : 'POST',
				url : 'ajax/uploaduserheadimage',
				data : {
					image : image
				},
				async : false,
				dataType : 'json',
				success : function(data) {
					if (data.success) {
						alert('修改头像成功。');
						location = '';
					} else {
						alert('修改失败。');
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