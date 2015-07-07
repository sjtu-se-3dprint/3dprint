<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<!DOCTYPE html>
<html lang="zh-CN">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<body>
	<jsp:include page="header.jsp" flush="true"></jsp:include>
	<div class="container">
		<div class="row">
			<form class="form-horizontal"
				action="<%=request.getContextPath()%>/j_spring_security_check"
				method="POST" accept-charset="utf-8"
				onsubmit="document.charset='utf-8';">
				<div class="form-group">
					<label for="inputUsername" class="col-sm-4 control-label">用户名</label>
					<div class="col-sm-4">
						<input type="text" class="form-control" id="inputUsername"
							placeholder="Username" name='j_username'>
					</div>
				</div>
				<div class="form-group">
					<label for="inputPassword" class="col-sm-4 control-label">密码</label>
					<div class="col-sm-4">
						<input type="password" class="form-control" id="inputPassword"
							placeholder="Password" name='j_password'>
					</div>
				</div>
				<div class="form-group">
					<div class="col-sm-offset-4 col-sm-6">
						<div class="checkbox">
							<label> <input type="checkbox" disabled>十天内免登录
							</label>
						</div>
					</div>
				</div>
				<div class="form-group">
					<div class="col-sm-offset-4 col-sm-6">
						<button id="loginBtn" type="submit" class="btn btn-default">登录</button>
						<a href="register" style="margin-left: 10px">去注册</a>
					</div>
				</div>
			</form>
		</div>
	</div>
	<script>
		$(function(){
// 			$('#loginBtn').bind('click', function(){
// 				$('form').submit();
// 				$.ajax({
// 					url: ContextPath + '/j_spring_security_check',
// 					type: 'post',
// 					data: {
// 						j_username:$('#inputUsername').val(),
// 						j_password:$('#inputPassword').val()
// 					},
// 					success: function(res){
// 						console.log(res);
// 						alert('OK');
// 					},
// 					error: function(){
// 						alert('Error');
// 					}
// 				});
			});
		})
	</script>
</body>
</html>