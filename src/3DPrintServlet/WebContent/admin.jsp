<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="service.GetLoginUserService,entity.*, database.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; ">
<title>3D打印创作服务平台-admin中心</title>
</head>
<body>
	<jsp:include page="header.jsp" flush="true"></jsp:include>
	<%
		User user = GetLoginUserService.service(request);
		if(user == null || !"admin".equals(user.getAuthority())){
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
                                    <img alt="user_pic" src="./img/users/user2.jpg" class="img-polaroid" />
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
                                        <li  class="active"><a href="admin.jsp" >个人设置</a></li>
                                        <li><a href="ad_user.jsp" >用户管理</a></li>
                                        <li><a href="ad_comment.jsp">评论管理</a></li>
                                        <li><a href="ad_forum.jsp">论坛管理</a></li>
                                        <li><a href="ad_addlesson_new.jsp">发布教程</a></li>
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
                                    <a href="#panel-390437" data-toggle="tab">修改密码</a>
                                </li>
                            </ul>
                            <div class="tab-content">
                                <div class="tab-pane active" id="panel-819612">
                                    <div class="container">
                                        <table class="table">
                                            <tr>
                                                <td>用户名：</td>
                                                <td><%=user.getName()%></td>
                                                <td> 电话：</td>
                                                <td><%=user.getTelephone()%></td>
                                            </tr>
                                            <tr>
                                                <td>邮箱</td>
                                                <td><%=user.getEmail()%></td>
                                                <td>QQ</td>
                                                <td><%=user.getQq()%></td>
                                            </tr>
                                            <tr>
                                                <td>注册时间</td>
                                                <td><%=user.getAddtime()%></td>
                                            </tr>

                                        </table>

                                    </div>
                                </div>

                                <div class="tab-pane" id="panel-390437">
                                    <div class="container">
                                        <div class="form-horizontal">
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
                                        </div>
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
	<jsp:include page="footer.jsp" flush="true"></jsp:include>
	<script>
	function modifyPassword(){
		var oldPassword = document.getElementById('oldpass').value;
		var newPassword1 = document.getElementById('newpass').value;
		var newPassword2 = document.getElementById('newpassAgain').value;
		if(oldPassword == ''){
			alert('请输入旧密码。');
			return;
		}
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
	</script>
</body>
</html>