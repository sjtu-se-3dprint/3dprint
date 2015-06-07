<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="security"
	uri="http://www.springframework.org/security/tags"%>

<!-- 为什么我用3.3.4版本的bootstrap不行，换回原来项目里的bootstrap样式就好了？ -->

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

<nav class="navbar navbar-default">
	<div class="container-fluid">
		<div class="navbar-header">
			<a class="navbar-brand" href="#">3DPrint</a>
		</div>

		<div class="collapse navbar-collapse"
			id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav navbar-right">
				<security:authorize access="!hasRole('ROLE_ANONYMOUS')">
					<li>
						<a href="#">
							<span class="text-primary">
								<security:authentication property="principal.username"></security:authentication>
							</span>
						</a>
					</li>
					<li class="dropdown">
						<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">用户管理
								<span class="caret"></span>
						</a>
						<ul class="dropdown-menu" role="menu">
							<security:authorize access="hasRole('ROLE_ADMIN')">
								<li><a href="#">Admin中心</a></li>
							</security:authorize>
							<security:authorize access="hasRole('ROLE_MANAGER')">
								<li><a href="#">Manager中心</a></li>
							</security:authorize>
							<security:authorize access="hasRole('ROLE_USER')">
								<li><a href="#">用户中心</a></li>
								<li><a href="#">购物车</a></li>
							</security:authorize>
							<li class="divider"></li>
							<li><a href="<%=request.getContextPath()%>/view/logout">注销</a></li>
						</ul>
					</li>
				</security:authorize>
				
				<!-- 未登录用户能够看见登录按钮 -->
				<security:authorize access="hasRole('ROLE_ANONYMOUS')">
					<li>
						<button type="button" class="btn btn-primary btn-sm"
							style="margin: 9px"
							onclick="javascript:window.location.href='<%=request.getContextPath()%>/view/login'">登录</button>
					</li>
				</security:authorize>
				<li><a href="<%=request.getContextPath()%>/view/register">注册</a></li>
			</ul>
		</div>
	</div>
</nav>