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

<script src="<%=request.getContextPath()%>/js/task/taskcenter.js"></script>
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/css/taskcenter.css" />

<script type="text/javascript" charset="utf-8"
	src="<%=request.getContextPath()%>/ueditor1_4_3-utf8-jsp/ueditor.config.js"></script>
<script type="text/javascript" charset="utf-8"
	src="<%=request.getContextPath()%>/ueditor1_4_3-utf8-jsp/ueditor.all.js"></script>

<title>任务中心</title>
</head>
<body>
	<div class="container" style="padding-bottom:100px">
		<div>
			<button id="publishTaskModalButton" class="btn btn-primary"
				style="margin-top: 30px">发布任务</button>
		</div>
		<div style="padding-top: 30px">
			<ul class="nav nav-tabs hcrm-nav hcrm-nav-tabs" role="tablist"
				id="myTab">
				<li id="unprocessingTasks" class="active"><a
					href="#showUnprocessingTasks" data-toggle="tab">未处理的任务</a></li>
				<li id="processingTasks"><a href="#showProcessingTasks"
					data-toggle="tab">正在进行中的任务</a></li>
				<li id="processedTasks"><a href="#showProcessedTasks"
					data-toggle="tab">已完成的任务</a></li>
				<!-- 				<li id="myTasks"><a href="#showMyTasks" data-toggle="tab">我的任务</a></li> -->
			</ul>
			<div class="tab-content">
				<div class="tab-pane active" id="showUnprocessingTasks">
					<table id="unprocessingTaskTable"></table>
				</div>
				<div class="tab-pane" id="showProcessingTasks">
					<table id="processingTaskTable"></table>
				</div>
				<div class="tab-pane" id="showProcessedTasks">
					<table id="processedTaskTable"></table>
				</div>
				<div class="tab-pane" id="showMyTasks">
					<table id="myTaskTable"></table>
				</div>
			</div>
		</div>

		<div class="modal fade" id="processTheTaskModal">
			<div class="modal-dialog modal-lg">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
						<h4 class="modal-title">任务详情</h4>
					</div>
					<div class="modal-body">
						<div class="fontsize_11 fontcolor_6">
							<div class="row margin_5">
								<div class="col-md-2">
									编码：<span id="task_id"></span>
								</div>
								<div class="col-md-5">
									发布时间：<span id="task_addtime"></span>
								</div>
								<div class="col-md-5">
									修改时间：<span id="task_updatetime"></span>
								</div>
							</div>
							<div class="row margin_5">
								<div class="col-md-4">
									任务名称：<span id="task_name"></span>
								</div>
								<div class="col-md-4">
									任务状态：<span id="task_status"></span>
								</div>
								<div class="col-md-4">
									发布者：<span id="task_publisher"></span>
								</div>
							</div>
						</div>
						<div class="fontsize_13 fontcolor_5">
							<div class="row margin_5 border_top">
								<div class="col-md-12">任务详情：</div>
							</div>
							<div class="row margin_5 border_bottom">
								<div class="col-md-12 margin_left_10 margin_right_10"
									id="task_detail"></div>
							</div>
						</div>
						<div class="fontsize_13 fontcolor_5">
							<div class="row margin_5">
								<div class="col-md-5">
									请选择你的角色：<select id="userSelect">
									</select>
								</div>
							</div>
							<div class="row margin_5">
								<div class="col-md-7">
									请选择你的预计完成该任务的天数：<select id="durationSelect">
										<option value="-1">请选择</option>
										<option value="1">1</option>
										<option value="2">2</option>
										<option value="3">3</option>
										<option value="4">4</option>
										<option value="5">5</option>
										<option value="6">6</option>
										<option value="7">7</option>
										<option value="8">8</option>
										<option value="9">9</option>
										<option value="10">10</option>
										<option value="11">11</option>
										<option value="12">12</option>
										<option value="13">13</option>
										<option value="14">14</option>
										<option value="15">15</option>
									</select>
								</div>
							</div>
						</div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
						<button type="button" class="btn btn-primary" id="pickTaskButton">领取任务</button>
					</div>
				</div>
			</div>
		</div>

		<div class="modal fade" id="publishTaskModal">
			<div class="modal-dialog modal-lg">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
						<h4 class="modal-title">发布任务</h4>
					</div>
					<div class="modal-body">
						<div class="fontsize_13 fontcolor_5">
							<div class="row margin_5">
								任务名称： <input type="text" id="taskNameInput" style="width: 80%">
							</div>
							<div class="row margin_5">
								选择角色： <select id="userSelectPublishTask">
								</select>
							</div>
							<div class="row margin_5 border_top padding_top_5">任务详细描述：
							</div>
							<div class="row margin_5">
								<script id="editor" type="text/plain" style="height: 400px;"></script>
								<script>
									var ue = UE.getEditor('editor');
								</script>
							</div>
						</div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
						<button type="button" class="btn btn-primary"
							id="publishTaskButton">发布任务</button>
					</div>
				</div>
			</div>
		</div>
		
		<div class="modal fade" id="finishTheTaskModal">
			<div class="modal-dialog modal-lg">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
						<h4 class="modal-title">完成任务</h4>
					</div>
					<div class="modal-body">
						<div class="fontsize_11 fontcolor_6">
							<div class="row margin_5">
								<div class="col-md-2">
									编码：<span id="task_id_finish"></span>
								</div>
								<div class="col-md-5">
									发布时间：<span id="task_addtime_finish"></span>
								</div>
								<div class="col-md-5">
									修改时间：<span id="task_updatetime_finish"></span>
								</div>
							</div>
							<div class="row margin_5">
								<div class="col-md-2">
								</div>
								<div class="col-md-5">
									领取时间：<span id="task_startime_finish"></span>
								</div>
								<div class="col-md-5">
									预计完成时间：<span id="task_endtime_finish"></span>
								</div>
							</div>
							<div class="row margin_5">
								<div class="col-md-4">
									任务名称：<span id="task_name_finish"></span>
								</div>
								<div class="col-md-4">
									任务状态：<span id="task_status_finish"></span>
								</div>
								<div class="col-md-4">
									发布者：<span id="task_publisher_finish"></span>
								</div>
							</div>
						</div>
						<div class="fontsize_13 fontcolor_5">
							<div class="row margin_5 border_top">
								<div class="col-md-12">任务详情：</div>
							</div>
							<div class="row margin_5 border_bottom">
								<div class="col-md-12 margin_left_10 margin_right_10"
									id="task_detail_finish"></div>
							</div>
						</div>
						<div class="fontsize_13 fontcolor_5">
							<div class="row margin_5">
								<div class="col-md-5">
									你的角色：<select id="userSelect_finish" disabled>
									</select>
								</div>
							</div>
							<div class="row margin_5">
								<div class="col-md-7">
									结束状态：<select id="finishStatusSelect">
										<option value="-1">请选择</option>
										<option value="1">完成任务</option>
										<option value="2">申请延期</option>
										<option value="3">撤销任务</option>
									</select>
									<span id="finishStatusDurationSpan" style="display:none">输入延期天数：<input id="finishStatusDurationInput" type="text"></span>
								</div>
							</div>
						</div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
						<button type="button" class="btn btn-primary" id="finishTaskButton">结束任务</button>
					</div>
				</div>
			</div>
		</div>
		
		<div class="modal fade" id="finishedTaskModal">
			<div class="modal-dialog modal-lg">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
						<h4 class="modal-title">任务详情</h4>
					</div>
					<div class="modal-body">
						<div class="fontsize_11 fontcolor_6">
							<div class="row margin_5">
								<div class="col-md-3">
									编码：<span id="task_id_finished"></span>
								</div>
								<div class="col-md-3">
									发布时间：<span id="task_addtime_finished"></span>
								</div>
								<div class="col-md-3">
									修改时间：<span id="task_updatetime_finished"></span>
								</div>
							</div>
							<div class="row margin_5">
								<div class="col-md-3">
								</div>
								<div class="col-md-3">
									领取时间：<span id="task_startime_finished"></span>
								</div>
								<div class="col-md-3">
									预计完成时间：<span id="task_endtime_finished"></span>
								</div>
								<div class="col-md-3">
									实际完成时间：<span id="task_finishtime_finished"></span>
								</div>
							</div>
							<div class="row margin_5">
								<div class="col-md-3">
									任务名称：<span id="task_name_finished"></span>
								</div>
								<div class="col-md-3">
									任务状态：<span id="task_status_finished"></span>
								</div>
								<div class="col-md-3">
									发布者：<span id="task_publisher_finished"></span>
								</div>
								<div class="col-md-3">
									执行者：<span id="task_executor_finished"></span>
								</div>
							</div>
						</div>
						<div class="fontsize_13 fontcolor_5">
							<div class="row margin_5 border_top">
								<div class="col-md-12">任务详情：</div>
							</div>
							<div class="row margin_5 border_bottom">
								<div class="col-md-12 margin_left_10 margin_right_10"
									id="task_detail_finished"></div>
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