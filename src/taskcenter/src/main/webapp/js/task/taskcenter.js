$(window).load(function() {
	$('#unprocessingTasks').on('show.bs.tab', showUnprocessingTasks);
	$('#processingTasks').on('show.bs.tab', showProcessingTasks);
	$('#processedTasks').on('show.bs.tab', showProcessedTasks);

	$('#pickTaskButton').off('click').on('click', pickTask);
	$('#publishTaskModalButton').off('click').on('click', publishTaskModal);
	$('#publishTaskButton').off('click').on('click', publishTask);
	$('#finishTaskButton').off('click').on('click', finishTask);

	$('#finishStatusSelect').change(finishStatusSelectChange);

	showUnprocessingTasks();

	fillUserSelect();
});

var globalRow = null;

function finishStatusSelectChange() {
	if ($('#finishStatusSelect').val() == '2') { // 申请延期
		$('#finishStatusDurationSpan').show();
		$('#finishStatusDurationInput').val('');
	} else {
		$('#finishStatusDurationSpan').hide();
	}
}
function publishTaskModal() {
	$('#publishTaskModal').modal('show');

	$('#publishTaskModal').css('z-index', 100);

	$('#taskNameInput').val('');
	ue.setContent('');

	$('.modal-backdrop').css('z-index', 99);
}

function finishTask() {
	var finishStatus = $('#finishStatusSelect').val();
	switch (finishStatus) {
	case '1': // 正常结束
		alert('正常结束');
		break;
	case '2': // 申请延期
		var delay = $('#finishStatusDurationInput').val();
		if(!/^[0-9]*[1-9][0-9]*$/.test(delay)){
			alert('请输入延期天数（正整数）');
			return;
		}
		alert('申请延期');
		break;
	case '3': // 撤销任务
		alert('撤销任务');
		break;
	default:
		alert('请选择结束状态后再提交。');
	}
}

function publishTask() {
	var task_name = $('#taskNameInput').val();
	var task_detail = ue.getContent();
	var task_publisher = $('#userSelectPublishTask').val();
	var min_name_len = 5;
	var min_detail_len = 10;
	if (!task_name || task_name.length < min_name_len) {
		alert('请输入至少' + min_name_len + '个字的任务名称。');
		return;
	}
	var plainContent = ue.getContentTxt();
	if (!plainContent || plainContent.length < min_detail_len) {
		alert('请输入至少' + min_detail_len + '个字的任务详细描述。');
		return;
	}
	if (!task_publisher || task_publisher < 1) {
		alert('请选择角色。');
		return;
	}

	$.ajax({
		url : ContextPath + '/task/publishTask.ajax',
		type : 'post',
		dataType : 'json',
		contentType : 'application/json',
		data : JSON.stringify({
			task_name : task_name,
			task_detail : task_detail,
			task_publisher : task_publisher
		}),
		success : function(res) {
			if (res && res.success) {
				alert('发布成功！');
				$('#publishTaskModal').modal('hide');
				showUnprocessingTasks();
			} else if (res) {
				alert(res.message);
			} else {
				alert('服务器异常！');
			}
		},
		error : function(err) {
			alert('未知错误');
		}
	});
}

function pickTask() {
	var executor_id = $('#userSelect').val();
	var duration = $('#durationSelect').val();
	if (!executor_id || !duration || executor_id < 1 || duration < 1) {
		alert('请选择好角色和天数后再提交。');
		return;
	}

	$.ajax({
		url : ContextPath + '/task/startTask.ajax',
		type : 'post',
		dataType : 'json',
		contentType : 'application/json',
		data : JSON.stringify({
			executor_id : executor_id,
			process_duration : duration,
			task_id : globalRow.task_id
		}),
		success : function(res) {
			if (res && res.success) {
				alert('领取成功！');
				$('#processTheTaskModal').modal('hide');
				showUnprocessingTasks();
			} else if (res) {
				alert(res.message);
			} else {
				alert('服务器异常！');
			}
		},
		error : function(err) {
			alert('未知错误');
		}
	});
}

function fillUserSelect() {
	$.ajax({
		url : ContextPath + '/task/listUser.ajax',
		type : 'post',
		dataType : 'json',
		contentType : 'application/json',
		data : JSON.stringify({}),
		success : function(res) {
			if (res && res.success) {
				if (res.value && res.value.length) {
					var userSelectText = '<option value="-1">请选择</option>';
					for (var i = 0; i < res.value.length; i++) {
						userSelectText += '<option value="'
								+ res.value[i].user_id + '">'
								+ res.value[i].user_name + '</option>';
					}

					$('#userSelect').html(userSelectText);
					$('#userSelectPublishTask').html(userSelectText);
					$('#userSelect_finish').html(userSelectText);
				}
			} else if (res) {
				alert(res.message);
			} else {
				alert('服务器异常！');
			}
		},
		error : function(err) {
			alert('未知错误');
		}
	});
}

function showUnprocessingTasks() {
	$('#unprocessingTaskTable').bootstrapTable('destroy');
	getTaskListFromServer('未处理', createUnprocessingTaskTable);
}

function showProcessingTasks() {
	$('#processingTaskTable').bootstrapTable('destroy');
	getTaskListFromServer('正在进行中', createProcessingTaskTable);
}

function showProcessedTasks() {
	alert('showProcessedTasks');
}

function createUnprocessingTaskTable(data) {
	changeTimeFormat(data);
	$('#unprocessingTaskTable').bootstrapTable('destroy').bootstrapTable({
		columns : [ {
			title : '编号',
			field : 'task_id',
			sortable : true,
		}, {
			title : '任务名',
			field : 'task_name',
		}, {
			title : '任务内容',
			field : 'task_detail',
			cellStyle : 'taskDetailStyle',
		},/*
			 * { title : '任务状态', field : 'task_status', },
			 */{
			title : '发布时间',
			field : 'addtime_format',
			sortable : true,
		}, {
			title : '发布者',
			field : 'user_name',
			sortable : true,
		}, {
			title : '操作',
			field : 'processTheTask',
			align : 'center',
			valign : 'middle',
			formatter : processTheTaskIcon,
			events : window.operateEvents = {
				'click .process' : function(e, value, row, index) {
					globalRow = row;

					$('#processTheTaskModal').modal('show');
					$('#task_id').text(row.task_id);
					$('#task_addtime').text(row.addtime_format);
					$('#task_updatetime').text(row.updatetime_format);
					$('#task_name').text(row.task_name);
					$('#task_status').text(row.task_status);
					$('#task_publisher').text(row.user_name);
					$('#task_detail').html(row.task_detail);

					$('#durationSelect').val(-1);
				}
			}
		} ]
	}).bootstrapTable('append', data);
}

function processTheTaskIcon() {
	return "<a class='process' href='javascript:void(0)'style='text-decoration: underline;'>领取任务</a>";
}
function taskDetailStyle(value, row, index) {
	return {
		classes : 'taskDetailStyle'
	};
}
function createProcessingTaskTable(data) {
	processingFormat(data);
	$('#processingTaskTable').bootstrapTable('destroy').bootstrapTable({
		columns : [ {
			title : '编号',
			field : 'task_id',
			sortable : true,
		}, {
			title : '任务名',
			field : 'task_name',
		}, {
			title : '任务内容',
			field : 'task_detail',
			cellStyle : 'taskDetailStyle',
		},/*
			 * { title : '任务状态', field : 'task_status', }, { title : '发布时间',
			 * field : 'addtime_format', }, { title : '发布者', field :
			 * 'user_name', },
			 */{
			title : '执行者',
			field : 'executor_name',
			sortable : true,
		}, {
			title : '开始时间',
			field : 'starttime_format',
			sortable : true,
		}, {
			title : '预计完成时间',
			field : 'endtime_format',
			sortable : true,
		}, {
			title : '操作',
			field : 'processTheTask',
			align : 'center',
			valign : 'middle',
			formatter : finishTheTaskIcon,
			events : window.operateEvents = {
				'click .finish' : function(e, value, row, index) {
					globalRow = row;

					$('#finishTheTaskModal').modal('show');
					$('#task_id_finish').text(row.task_id);
					$('#task_addtime_finish').text(row.addtime_format);
					$('#task_updatetime_finish').text(row.updatetime_format);
					$('#task_name_finish').text(row.task_name);
					$('#task_status_finish').text(row.task_status);
					$('#task_publisher_finish').text(row.user_name);
					$('#task_detail_finish').html(row.task_detail);
					$('#task_startime_finish').text(row.starttime_format);
					$('#task_endtime_finish').text(row.endtime_format);

					$('#finishStatusDurationSpan').hide();

					$('#userSelect_finish').val(row.executor.process_id);
					$('#finishStatusSelect').val(-1);
				}
			}
		} ],
	}).bootstrapTable('append', data);
}

function finishTheTaskIcon() {
	return "<a class='finish' href='javascript:void(0)'style='text-decoration: underline;'>完成任务</a>";
}

function getTaskListFromServer(task_status, callback) {
	$.ajax({
		url : ContextPath + '/task/listTask.ajax',
		type : 'post',
		dataType : 'json',
		contentType : 'application/json',
		data : JSON.stringify({
			task_status : task_status
		}),
		success : function(res) {
			if (res && res.success) {
				console.log(res);
				callback(res.value);
			} else if (res) {
				alert(res.message);
			} else {
				alert('服务器异常！');
			}
		},
		error : function(err) {
			alert('未知错误');
		}
	});
}

function changeTimeFormat(rows) {
	for (var i = 0; i < rows.length; i++) {
		rows[i].addtime_format = new Date(rows[i].addtime)
				.pattern("yyyy-MM-dd hh:mm");
		rows[i].updatetime_format = new Date(rows[i].updatetime)
				.pattern("yyyy-MM-dd hh:mm");
	}
}

function processingFormat(rows) {
	for (var i = 0; i < rows.length; i++) {
		rows[i].addtime_format = new Date(rows[i].addtime)
				.pattern("yyyy-MM-dd hh:mm");
		rows[i].updatetime_format = new Date(rows[i].updatetime)
				.pattern("yyyy-MM-dd hh:mm");
		if (rows[i].executor) {
			rows[i].starttime_format = new Date(rows[i].executor.addtime)
					.pattern("yyyy-MM-dd hh:mm");
			rows[i].executor_name = rows[i].executor.user_name;
			var endTime = new Date(rows[i].executor.addtime);
			endTime.setDate(endTime.getDate() + 1);
			rows[i].endtime_format = endTime.pattern("yyyy-MM-dd hh:mm");

		}
	}
}