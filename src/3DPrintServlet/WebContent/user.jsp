<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="service.GetLoginUserService,entity.*, database.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; ">
<title>3D打印创作服务平台-用户中心</title>
</head>
<body>
	<jsp:include page="header.jsp" flush="true"></jsp:include>
	<%
		User user = GetLoginUserService.service(request);
		if(user == null || !"user".equals(user.getAuthority())){
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
                                    <img alt="user_pic" src="userheadimage?userID=<%=user.getId() + "&random=" + Math.random() %>" class="img-polaroid" />
                                    <div class="span12">
                                        <br>
                                        <span>
                                            &nbsp;&nbsp;你 好，</span>
                                        <span>
                                            <%=user.getName()%>！
                                        </span>
                                        <br>
                                        <br>
                                    </div>
                                    <ul class="nav nav-tabs nav-stacked" data-spy="affix" data-offset-top="125" >
                                        <li class="active"><a href="./user.jsp" >个人设置</a></li>
                                        <li><a href="./user_model.jsp">我的模型</a></li>
                                        <li><a href="./user_shop.jsp">我的购物</a></li>
                                        <li><a href="./user_collect.jsp">我的收藏</a></li>
                                        <li><a href="./user_forum.jsp">我的帖子</a></li>
                                    </ul>
                                </div>
                            </div>
                        </div>

                    </div>

                    <div class="span10">
                        <hr>
                        <div class="tabbable">
                            <ul class="nav nav-tabs">
                                <li class="active">
                                    <a href="#panel-819612" data-toggle="tab">我的信息</a>
                                </li>
                                <li>
                                    <a href="#panel-390436" data-toggle="tab">修改资料</a>
                                </li>
                                <li>
                                    <a href="#panel-819613" data-toggle="tab">修改头像</a>
                                </li>
                                <li>
                                    <a href="#panel-390437" data-toggle="tab">修改密码</a>
                                </li>
                            </ul>
                            <div class="tab-content">
                                <div class="tab-pane active" id="panel-819612">
                                    <div class="container">
                                        <table class="table">
                                            <tr>
                                                <td>用户名：</td>
                                                <td><%=user.getName() %></td>
                                                <td> 手机：</td>
                                                <td><%=user.getTelephone()==null?"":user.getTelephone() %></td>
                                            </tr>
                                            <tr>
                                                <td>QQ</td>
                                                <td><%=user.getQq()==null?"":user.getQq() %></td>
                                                <td>邮箱</td>
                                                <td><%=user.getEmail()==null?"":user.getEmail() %></td>
                                            </tr>
                                            <tr>
                                                <td>注册时间</td>
                                                <td><%=user.getAddtime() %></td>
                                            </tr>
                                        </table>

                                    </div>
                                </div>
                                <div class="tab-pane" id="panel-390436">
                                    <div class="form-horizontal">
                                        <div class="control-group">
                                            <label class="control-label">用户名：</label>
                                            <div class="controls">
                                                <input type="text" id="inputnicheng" disabled value="<%=user.getName()%>">
                                            </div>
                                        </div>
                                        <div class="control-group">
                                            <label class="control-label">手机号：</label>
                                            <div class="controls">
                                                <input type="text" id="inputPhone" placeholder="输入手机号" value="<%=user.getTelephone()==null?"":user.getTelephone()%>">
                                            </div>
                                        </div>
                                        <div class="control-group">
                                            <label class="control-label">邮箱：</label>
                                            <div class="controls">
                                                <input type="text" id="inputEmail" placeholder="输入邮箱" value="<%=user.getEmail()==null?"":user.getEmail()%>">
                                            </div>
                                        </div>
                                        <div class="control-group">
                                            <label class="control-label">QQ：</label>
                                            <div class="controls">
                                                <input type="text" id="inputQQ" placeholder="输入QQ号" value="<%=user.getQq()==null?"":user.getQq()%>">
                                            </div>
                                        </div>
                                        <div class="control-group">
                                            <div class="controls">
                                                <button class="btn" onclick="modifyInfo();">确认</button>
                                                <button class="btn" onclick="reset();">重置</button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="tab-pane" id="panel-819613">
                                    <div class="span3">
                                        <img alt="user_pic" id="headimage" src="userheadimage?userID=<%=user.getId() + "&random=" + Math.random() %>" class="img-polaroid" />
                                    </div>
                                    <div class="span9">

                                        <form class="form-inline" role="form">
                                            <br><br>
                                            <div class="form-group">
                                                <label class="sr-only" for="inputfile">上传头像</label>
                                                <input type="file" id="inputfile" onchange="selectImage(this);">
                                            </div>
                                            <br>
                                            <p>仅支持JPG格式，文件小于3M。</p>
                                            <button type="submit" class="btn btn-default" id="submitimg" disabled onclick="upLoadImage();">提交</button>
                                        </form>
                                    </div>
                                </div>
                                <div class="tab-pane" id="panel-390437">
                                    <div class="container">
                                        <div class="form-horizontal" role="form">
                                            <div class="form-group">
                                                <label for="oldpass" class="col-sm-2 control-label">旧密码 ：</label>
                                                <div class="col-sm-10">
                                                    <input type="password" class="form-control" id="oldpass" placeholder="Old Password"><span id="oldpassTip" style="display:none;color:red;"></span>
                                                </div>
                                            </div>
                                            <br>
                                            <div class="form-group">
                                                <label for="newpass" class="col-sm-2 control-label">新密码 ：</label>
                                                <div class="col-sm-10">
                                                    <input type="password" class="form-control" style="width:250px;" id="newpass" placeholder="New Password"><span id="newpassTip" style="display:none;color:red;"></span>
                                                </div>
                                            </div>
                                            <br>
                                            <div class="form-group">
                                                <label for="newpassAgain" class="col-sm-2 control-label">再次确认新密码 ：</label>
                                                <div class="col-sm-10">
                                                    <input type="password" class="form-control" style="width:250px;" id="newpassAgain" placeholder="Again New Password"><span id="newpassAgainTip" style="display:none;color:red;"></span>
                                                </div>
                                            </div>
                                            <br>
                                            <div class="form-group">
                                                <label class="col-sm-2 control-label">  </label>
                                                <button type="submit" class="btn btn-primary" id="submit" style="text-align:center;" onclick="modifyPassword();">确认修改</button>
                                            </div>
                                        </form>
                                    </div>
                                    <div id="modifySuccess" class="alert alert-success alert-dismissable" style="width:50%;margin-left:40%;display:none;">
                                        <strong>Success!</strong> 你已成功修改密码！
                                    </div>
                                </div>
                            </div>
                        </div>

                    </div>
                </div>
            </div>
        </div>
    </div>
	
	<script src="./js/jquery-1.11.1.min.js"></script>
	<script>

		/**
		 * 清空修改信息input中的已填信息。
		 */
		function reset(){
			document.getElementById('inputEmail').value = '';
			document.getElementById('inputPhone').value = '';
			document.getElementById('inputQQ').value = '';
		}

		/**
		 * 修改用户信息。
		 */
		function modifyInfo(){
			var email = document.getElementById('inputEmail').value;
			var phone = document.getElementById('inputPhone').value;
			var qq = document.getElementById('inputQQ').value;
			if(phone == ''){
				alert('手机号不能为空。');
				return;
			}else if(email == ''){
				alert('邮箱不能为空。');
				return;
			}else if(qq == ''){
				alert('QQ号不能为空');
				return;
			}

			$.ajax({
				type:'GET',
				url: 'ajax/modifyuserinfo',
				data: {telephone:phone, email:email, qq:qq},
				async: false,
				dataType:'json',
				success: function(data){
					if(data.success){
						alert('修改信息成功。');
						location = '';
					}else{
						alert('修改失败。');
					}
				},
				error: function(err){
					alert('网络错误。');
				}
			});
		}

		function modifyPassword(){
			var oldPassword = document.getElementById('oldpass').value;
			var newPassword1 = document.getElementById('newpass').value;
			var newPassword2 = document.getElementById('newpassAgain').value;
			if(newPassword1 != newPassword2){
				alert('新密码不一致。');
				return;
			}
			if(newPassword1.length < 6){
				alert('新密码太短。');
				return;
			}

			$.ajax({
				type:'GET',
				url: 'ajax/modifypassword',
				data: {oldPassword:oldPassword, newPassword:newPassword1},
				async: false,
				dataType:'json',
				success: function(data){
					if(data.success){
						alert('修改密码成功。');
						location = '';
					}else{
						alert('修改失败。');
					}
				},
				error: function(err){
					alert('网络错误。');
				}
			});
		}

		var image = '';
		function selectImage(file){
			if(file.files && file.files[0]){
				var img = document.getElementById('headimage');
				img.onload = function(){
					console.log('img load');
					document.getElementById('submitimg').disabled = false;
				}
				var reader = new FileReader();
				reader.onload = function(evt){
					var src = evt.target.result;
					if(src.indexOf('data:image/jpeg') != 0){
						alert('你上传的文件不是图片或者不是JPG格式。');
						return;
					}
					image = src;
					img.src = src;
				};
				reader.readAsDataURL(file.files[0]);
			}
		}

		function upLoadImage(){
			$.ajax({
				type:'POST',
				url: 'ajax/uploaduserheadimage',
				data: {image: image},
				async: false,
				dataType: 'json',
				success: function(data){
					if(data.success){
						alert('修改头像成功。');
					}else{
						alert('修改失败。');
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