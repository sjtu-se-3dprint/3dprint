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

<script src="<%=request.getContextPath()%>/js/task/taskdetail.js"></script>

<script src="<%=request.getContextPath()%>/js/task/taskcenter_ajax.js"></script>
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/css/taskcenter.css" />

<title>任务详情</title>
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
							<li><a href="<%=request.getContextPath()%>/history.htm">任务历史流程列表</a></li>
							<li class="divider"></li>
							<li><a href="<%=request.getContextPath()%>/logout.htm">注销</a></li>
						</ul></li>
				</ul>
			</div>
		</div>
		<div class="row">
			<div style="padding-top: 30px">
				<table id="taskDetailTable"></table>
			</div>
		</div>
		
		<div class="modal fade" id="detailModal">
			<div class="modal-dialog modal-lg">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
						<h4 class="modal-title">操作后任务详情</h4>
					</div>
					<div class="modal-body">
						<div class="fontsize_13 fontcolor_5">
							<div class="row margin_5">
								<div class="col-md-3">
								操作类型：<span id="record_type"></span>
								</div>
								<div class="col-md-9">
								操作后任务名称：<span id="task_name"></span>
								</div>
							</div>
							<div class="row margin_5">
								<div class="col-md-3">
								操作者：<span id="record_user_name"></span>
								</div>
								<div class="col-md-4">
								操作后任务状态：<span id="record_task_status"></span>
								</div>
								<div class="col-md-4">
								操作时间：<span id="addtime_format"></span>
								</div>
							</div>
							<div class="row margin_5">
								<div class="col-md-12">
								<span id="record_other"></span>
								</div>
							</div>
						</div>
						<div class="fontsize_13 fontcolor_5">
							<div class="row margin_5 border_top">
								<div class="col-md-12">操作后任务详细描述：</div>
							</div>
							<div class="row margin_5 border_bottom">
								<div class="col-md-12 margin_left_10 margin_right_10"
									id="task_detail"></div>
							</div>
						</div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>