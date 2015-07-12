<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="service.GetLoginUserService,entity.*, database.*, java.util.List" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; ">
<title>3D打印创作服务平台-admin中心</title>
        <style>
            .bdiv{
                border: 1px solid #99bbbb;
                padding: 5px;
            }
        </style>
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
                    <!------------------------左边侧栏----------------------->
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
                                        <li><a href="admin.jsp" >个人设置</a></li>
                                        <li  class="active"><a href="ad_user.jsp" >用户管理</a></li>
                                        <li><a href="ad_comment.jsp">评论管理</a></li>
                                        <li><a href="ad_forum.jsp">论坛管理</a></li>
                                        <li><a href="ad_addlesson_new.jsp">发布教程</a></li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-------------------右边内容------------------------------------->

                    <div class="span10">
                        <hr>
                        <div class="tabbable">
                            <ul class="nav nav-tabs">
                            	<% String tab = request.getParameter("tab"); %>
                                <li class="<%="2".equals(tab)?"":"active"%>">
                                    <a href="#panel-819618" data-toggle="tab">普通用户</a>
                                </li>

                                <li class="<%="2".equals(tab)?"active":""%>">
                                    <a href="#panel-819619" data-toggle="tab">系统用户</a>
                                </li>
                            </ul>

                            <div class="tab-content">
                                <div class="tab-pane <%="2".equals(tab)?"":"active"%>" id="panel-819618">
                                    <div class="container-fluid">
                                        <div class="row-fluid">
                                            <table class="table table-hover">
                                                <thead>
                                                    <tr>
                                                        <th>用户名</th>
                                                        <th>手机号</th>
                                                        <th>邮箱</th>
                                                        <th>注册时间</th>
                                                        <th>操作</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                	<%
                                                		List<User> users = UserService.getUserService().searchUsersByAuthorityStatus("user", "normal");
                                                		for(User u: users){
                                                			out.println("<tr>");
                                                			out.println("    <td>" + u.getName() + "</td>");
                                                			out.println("    <td>" + u.getTelephone() + "</td>");
                                                			out.println("    <td>" + u.getEmail() + "</td>");
                                                			out.println("    <td>" + u.getAddtime() + "</td>");
                                                			out.println("    <td><button class=\"btn-danger\" onclick=\"deleteUser('" + u.getId() + "')\">删除用户</button> </td>");
                                                			out.println("</tr>");
                                                		}
                                                		users = UserService.getUserService().searchUsersByAuthorityStatus("user", "deleted");
                                                		for(User u: users){
                                                			out.println("<tr>");
                                                			out.println("    <td>" + u.getName() + "</td>");
                                                			out.println("    <td>" + u.getTelephone() + "</td>");
                                                			out.println("    <td>" + u.getEmail() + "</td>");
                                                			out.println("    <td>" + u.getAddtime() + "</td>");
                                                			out.println("    <td><button disabled>已经删除</button> </td>");
                                                			out.println("</tr>");
                                                		}
                                                	%>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                </div>

                                <!--------------切换卡2----系统用户管理----------------------------->
                                <div class="tab-pane <%="2".equals(tab)?"active":""%>" id="panel-819619">
                                    <div class="container-fluid">
                                        <div class="row-fluid">
                                            <div class="span12">
                                                <table class="table table-hover">
                                                    <thead>
                                                        <tr>
                                                            <th>系统账号</th>
                                                            <th>手机号</th>
                                                            <th>邮箱</th>
                                                            <th>注册时间</th>
                                                            <th>操作</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <%
                                                        	List<User> managers = UserService.getUserService().searchUsersByAuthorityStatus("manager", "normal");
	                                                		for(User u: managers){
	                                                			out.println("<tr>");
	                                                			out.println("    <td>" + u.getName() + "</td>");
	                                                			out.println("    <td>" + u.getTelephone() + "</td>");
	                                                			out.println("    <td>" + u.getEmail() + "</td>");
	                                                			out.println("    <td>" + u.getAddtime() + "</td>");
	                                                			out.println("    <td><button class=\"btn-danger\" onclick=\"deleteManager('" + u.getId() + "')\">删除用户</button> </td>");
	                                                			out.println("</tr>");
	                                                		}
	                                                		managers = UserService.getUserService().searchUsersByAuthorityStatus("manager", "deleted");
	                                                		for(User u: managers){
	                                                			out.println("<tr>");
	                                                			out.println("    <td>" + u.getName() + "</td>");
	                                                			out.println("    <td>" + u.getTelephone() + "</td>");
	                                                			out.println("    <td>" + u.getEmail() + "</td>");
	                                                			out.println("    <td>" + u.getAddtime() + "</td>");
	                                                			out.println("    <td><button disabled>已经删除</button> </td>");
	                                                			out.println("</tr>");
	                                                		}
	                                                	%>
                                                    </tbody>
                                                </table>
                                                <br><br>
                                                <hr>
                                                <div class="span6">
                                                    <span>可以为网站添加一个新的系统管理员，管理模型和订单</span>
                                                </div>
                                                <div class="span4">
                                                    <!-- <button class="btn">添加账号</button> -->
                                                </div>
                                            </div>
                                            <br><br>
                                            <!-----------------------点击“添加账号”出现的，用于给网站添加一个系统管理员账号------------------------------------>
                                            <div class="span10">
                                                <br><br>
                                                <div class="container bdiv">
                                                    <div class="form-horizontal">
                                                        <br>
                                                        <div class="form-group">
                                                            <label class="col-sm-2 control-label">账号名</label>
                                                            <div class="col-sm-10">
                                                                <input type="text" class="form-control" id="managerName"
                                                                       placeholder="请输入账号">
                                                            </div>
                                                        </div>
                                                        <br>
                                                        <div class="form-group">
                                                            <label class="col-sm-2 control-label">密码</label>
                                                            <div class="col-sm-10">
                                                                <input type="password" class="form-control password" id="managerPassword"
                                                                       placeholder="请输入初始密码">
                                                            </div>
                                                        </div>
                                                        <br>
                                                        <div class="form-group span8" style="float: right;">
                                                            <div class="col-sm-offset-2 col-sm-10">
                                                                <button type="submit" class="btn btn-default" onclick="addManager();">确认添加</button>
                                                            </div>
                                                        </div>
                                                        <!------------------添加成功之后在系统用户处可以显示，可登录---------------------->
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
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
	<script type="text/javascript">
	function deleteUser(id){
		$.ajax({
			type: "GET",
			url: 'ajax/deleteuser',
			data: {userID: id},
			dataType: 'json',
			async: false,
			success: function(data){
				if(data.success){
					alert('删除成功。');
					location = 'ad_user.jsp';
				}else{
					alert('删除失败。');
				}
			},
			error: function(err){
				alert('网络故障。');
			}
		});
	}

	function deleteManager(id){
		$.ajax({
			type: "GET",
			url: 'ajax/deleteuser',
			data: {userID: id},
			dataType: 'json',
			async: false,
			success: function(data){
				if(data.success){
					alert('删除成功。');
					location = 'ad_user.jsp?tab=2';
				}else{
					alert('删除失败。');
				}
			},
			error: function(err){
				alert('网络故障。');
			}
		});
	}

	function addManager(){
		var managerName = document.getElementById('managerName').value;
		var managerPassword = document.getElementById('managerPassword').value;
		console.log(managerName);
		console.log(managerPassword);

		if(managerName.length < 6){
			alert('用户名必须大于6位。');
			return;
		}
		if(managerPassword.length < 6){
			alert('密码必须大于6位。');
			return;
		}

		$.ajax({
			type: "GET",
			url: 'ajax/addmanager',
			data: {userName: managerName, password:managerPassword},
			dataType: 'json',
			async: false,
			success: function(data){
				if(data.success){
					alert('添加成功。');
					location = 'ad_user.jsp?tab=2';
				}else{
					alert('添加失败，该用户名被占用了。');
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