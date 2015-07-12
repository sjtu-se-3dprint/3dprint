<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="security"
	uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
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

<script src="<%=request.getContextPath()%>/js/util.js"></script>

<script src="<%=request.getContextPath()%>/js/task/taskcenter_ajax.js"></script>
<script src="<%=request.getContextPath()%>/js/task/taskhistory.js"></script>

<link rel="stylesheet"
	href="<%=request.getContextPath()%>/css/taskcenter.css" />

<title>任务历史流程</title>
</head>
<body>
	<div class="container" style="padding-bottom: 100px">
		<div class="row">
			<div class="collapse navbar-collapse"
				id="bs-example-navbar-collapse-1">
				<ul class="nav navbar-nav navbar-right">
					<li><a href="#"><span class="text-primary"> <security:authentication
									property="principal.username"></security:authentication>
						</span> </a></li>
					<li class="dropdown"><a href="#" class="dropdown-toggle"
						data-toggle="dropdown" role="button" aria-expanded="false">更多
							<span class="caret"></span>
					</a>
						<ul class="dropdown-menu" role="menu">
							<li><a href="<%=request.getContextPath()%>/index.htm">任务中心</a></li>
							<li class="divider"></li>
							<li><a href="<%=request.getContextPath()%>/logout.htm">注销</a></li>
						</ul></li>
				</ul>
			</div>
		</div>
		<div>
			<div style="padding-top: 30px">
				<table id="allTaskTable"></table>
			</div>
		</div>
	</div>
</body>
</html>