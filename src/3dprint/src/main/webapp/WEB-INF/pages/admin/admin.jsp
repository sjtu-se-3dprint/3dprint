<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">

<script src="../../js/util.js"></script>

<style>
.link {
	padding-bottom: 5px;
	font-size: 18px;
}
</style>
<title>Insert title here</title>
</head>
<body>
	<jsp:include page="../common/header.jsp" flush="true"></jsp:include>
	<div class="container">
		<div class="row" style="text-align: center">
			<h2>这是Admin中心！</h2>
		</div>
		<div class="row">
			<div class="col-md-2">
				<div class="link">
					<a href="../user/index">去User中心</a>
				</div>
				<div class="link">
					<a href="../manager/index">去Manager中心</a>
				</div>
				<div class="link">
					<a href="../index">返回首页</a>
				</div>
				<br>
				<div class="link">
					<a href="../logout">注销</a>
				</div>
			</div>
			<div class="col-md-10">
				<div>
					<div>
						<ul class="nav nav-tabs hcrm-nav hcrm-nav-tabs" role="tablist"
							id="myTab">
							<li id="plainUsersTab" class="active"><a
								href="#showPlainUsers" data-toggle="tab">现有用户</a></li>
							<li id="deletedPlainUsersTab"><a
								href="#showDeletedPlainUsers" data-toggle="tab">已删用户</a></li>
							<li id="deletedPlainUsersTab"><a href="#addPlainUsers"
								data-toggle="tab">添加用户</a></li>
						</ul>
						<div class="tab-content">
							<div class="tab-pane active" id="showPlainUsers">
								<table id="plainUserTable"></table>
							</div>
							<div class="tab-pane" id="showDeletedPlainUsers">
								<table id="deletedUserTable"></table>
							</div>
							<div class="tab-pane" id="addPlainUsers">
								<div class="row" style="padding-top: 20px">
									<div class="col-md-2 text-right"
										style="padding-top: 5px; font-size: 17px">
										<label class="control-label">用户名：</label>
									</div>
									<div class="col-md-3">
										<input id="usernameText" class="form-control" type="text">
									</div>
								</div>
								<div class="row" style="padding-top: 20px">
									<div class="col-md-2 text-right"
										style="padding-top: 5px; font-size: 17px">
										<label class="control-label">密码：</label>
									</div>
									<div class="col-md-3">
										<input id="passwordText" class="form-control" type="password">
									</div>
								</div>
								<div class="row" style="padding-top: 20px">
									<div class="col-md-2 text-right"></div>
									<div class="col-md-3 text-right">
										<button id="submitNewUser" class="btn btn-primary"
											style="width: 100%; font-size: 17px">提交</button>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<script>
		$('#plainUsersTab').on('show.bs.tab', showPlainUsers);
		$('#deletedPlainUsersTab').on('show.bs.tab', showDeletedPlainUsers);
		showPlainUsers();

		$('#submitNewUser').click(addPlainUsers);

		function addPlainUsers() {
			var username = $('#usernameText').val();
			var password = $('#passwordText').val();
			if (username == '' || password == '') {
				alert('用户名和密码不能为空！');
				return;
			}

			$.ajax({
				url : '../../admin/addPlainUser',
				type : 'post',
				dataType : 'json',
				contentType : 'application/json',
				data : JSON.stringify({
					name : username,
					password : password
				}),
				success : function(res) {
					if (res && res.success) {
						alert('新增用户成功！');
						$('#usernameText').val('');
						$('#passwordText').val('');
					} else if (res) {
						alert(res.message);
					} else {
						alert('新增用户失败！');
					}
				},
				error : function(err) {
					alert('未知错误');
				}
			});
		}

		function showPlainUsers() {
			queryPlainUsers('normal');
		}

		function showDeletedPlainUsers() {
			queryPlainUsers('deleted');
		}

		function queryPlainUsers(status) {

			$.ajax({
				url : '../../admin/queryPlainUserList',
				type : 'post',
				dataType : 'json',
				contentType : 'application/json',
				data : JSON.stringify({
					status : status
				}),
				success : function(res) {
					if (res && res.success) {
						changeTimeFormat(res.value);
						if (status === 'normal') {
							showTable('#plainUserTable', res.value,
									getCommonPlainUserColumns());
						} else if (status === 'deleted') {
							showTable('#deletedUserTable', res.value,
									getDeletedPlainUserColumns());
						}
					} else if (res) {
						alert(res.message);
					} else {
						alert('删除用户失败！');
					}
				},
				error : function(err) {
					alert('未知错误');
				}
			});
		}

		function changeTimeFormat(rows) {
			for (var i = 0; i < rows.length; i++) {
				rows[i].addtime = new Date(rows[i].addtime)
						.pattern("yyyy-MM-dd hh:mm:ss");
				rows[i].updatetime = new Date(rows[i].updatetime)
						.pattern("yyyy-MM-dd hh:mm:ss");
			}
		}

		function removeUser(user) {
			$.ajax({
				url : '../../admin/removePlainUser',
				type : 'post',
				dataType : 'json',
				contentType : 'application/json',
				data : JSON.stringify(user),
				success : function(res) {
					if (res && res.success) {
						alert('删除成功');
						$('#plainUserTable').bootstrapTable('remove', {
							field : 'user_id',
							values : [ user.user_id ]
						});
					} else if (res) {
						alert(res.message);
					} else {
						alert('删除用户失败！');
					}
				},
				error : function(err) {
					alert('未知错误');
				}
			});
		}

		function getCommonPlainUserColumns() {
			var columns = getCommonColumns();
			columns.push({
				title : '操作',
				field : 'deletePlainUserIcon',
				align : 'center',
				valign : 'middle',
				formatter : removeIcon,
				events : window.operateEvents = {
					'click .remove' : function(e, value, row, index) {
						removeUser(row);
					}
				}
			});
			return columns;
		}

		function removeIcon() {
			var editDelStr = "<a class='remove' href='javascript:void(0)'style='text-decoration: underline;'>删除</a>";
			return editDelStr;
		}

		function getDeletedPlainUserColumns() {
			var columns = getCommonColumns();
			columns.push({
				title : '操作',
				field : 'resumePlainUserIcon',
				align : 'center',
				valign : 'middle',
				formatter : resumeIcon,
				events : window.operateEvents = {
					'click .resume' : function(e, value, row, index) {
						resumeUser(row);
					}
				}
			});
			return columns;
		}

		var rollback = false;
		function resumeUser(user) {
			if (rollback) {
				user.rollback = true;
			}
			$.ajax({
				url : '../../admin/resumePlainUser',
				type : 'post',
				dataType : 'json',
				contentType : 'application/json',
				data : JSON.stringify(user),
				success : function(res) {
					if (res && res.success) {
						alert('恢复成功');
						$('#deletedUserTable').bootstrapTable('remove', {
							field : 'user_id',
							values : [ user.user_id ]
						});
					} else if (res) {
						alert(res.message);
					} else {
						alert('删除用户失败！');
					}
				},
				error : function(err) {
					alert('未知错误');
				}
			});
		}

		function resumeIcon() {
			var editDelStr = "<a class='resume' href='javascript:void(0)'style='text-decoration: underline;'>恢复</a>";
			return editDelStr;
		}

		function getCommonColumns() {
			return [ {
				title : '用户ID',
				field : 'user_id',
			}, {
				title : '用户名',
				field : 'name',
			}, {
				title : '密码',
				field : 'password',
			}, {
				title : '邮箱地址',
				field : 'email',
			}, {
				title : '电话号码',
				field : 'telephone',
			}, {
				title : 'QQ',
				field : 'qq',
			}, {
				title : '注册时间',
				field : 'addtime',
			}, {
				title : '修改时间',
				field : 'updatetime',
			} ];
		}

		function showTable(tableId, rows, columns) {
			$(tableId).bootstrapTable('destroy').bootstrapTable({
				columns : columns,
				height : 400
			}).bootstrapTable('append', rows);
		}
	</script>
</body>
</html>