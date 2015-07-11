<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<!DOCTYPE html>
<html lang="zh-CN">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">

<link rel="stylesheet"
	href="<%=request.getContextPath()%>/css/bootstrap-3.3.4-dist/css/bootstrap.min.css" />

<link rel="stylesheet"
	href="<%=request.getContextPath()%>/css/bootstrap-table-master/src/bootstrap-table.css" />

<script src="<%=request.getContextPath()%>/js/jquery-1.11.1.min.js"></script>
<script
	src="<%=request.getContextPath()%>/css/bootstrap-3.3.4-dist/js/bootstrap.min.js"></script>
<script
	src="<%=request.getContextPath()%>/css/bootstrap-table-master/src/bootstrap-table.js"></script>
<script
	src="<%=request.getContextPath()%>/css/bootstrap-table-master/src/locale/bootstrap-table-zh-CN.js"></script>

<body>
	<div class="container">
		<div class="row" style="margin-top:40px">
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
						<button id="loginBtn" type="submit" class="btn btn-default">登录</button>
					</div>
				</div>
			</form>
		</div>
	</div>
</body>
</html>