<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<!DOCTYPE html>
<html lang="zh-CN">
<body>
	<jsp:include page="header.jsp" flush="true"></jsp:include>
	<script src="<%=request.getContextPath()%>/js/common/register.js"></script>

	<div class="container">
		<div class="row">
			<div class="form-horizontal">
				<div class="form-group" id="inputUsernameGroup">
					<label for="inputUsername" class="col-sm-4 control-label">用户名</label>
					<div class="col-sm-4">
						<input type="text" class="form-control" id="inputUsername"
							placeholder="Username"> <span id="inputUsernameError"
							class="hidden glyphicon glyphicon-remove form-control-feedback"
							aria-hidden="true"></span> <span id="inputUsernameSuccess"
							class="hidden glyphicon glyphicon-ok form-control-feedback"
							aria-hidden="true"></span>
					</div>
					<label class="control-label pull-left" id="inputUsernameMessage"></label>
				</div>
				<div class="form-group" id="inputPasswordGroup">
					<label for="inputPassword" class="col-sm-4 control-label">密码</label>
					<div class="col-sm-4">
						<input type="password" class="form-control" id="inputPassword"
							placeholder="Password"> <span id="inputPasswordError"
							class="hidden glyphicon glyphicon-remove form-control-feedback"
							aria-hidden="true"></span> <span id="inputPasswordSuccess"
							class="hidden glyphicon glyphicon-ok form-control-feedback"
							aria-hidden="true"></span>
					</div>
					<label class="control-label pull-left" id="inputPasswordMessage"></label>
				</div>
				<div class="form-group" id="inputConfirmGroup">
					<label for="inputConfirm" class="col-sm-4 control-label">确认密码</label>
					<div class="col-sm-4">
						<input type="password" class="form-control" id="inputConfirm"
							placeholder="Password Again"> <span id="inputConfirmError"
							class="hidden glyphicon glyphicon-remove form-control-feedback"
							aria-hidden="true"></span> <span id="inputConfirmSuccess"
							class="hidden glyphicon glyphicon-ok form-control-feedback"
							aria-hidden="true"></span>
					</div>
					<label class="control-label pull-left" id="inputConfirmMessage"></label>
				</div>
				<div class="form-group">
					<div class="col-sm-offset-4 col-sm-6">
						<button id="registerBtn" type="submit" class="btn btn-default">注册</button>
						<a href="login" style="margin-left:10px">去登录</a>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>