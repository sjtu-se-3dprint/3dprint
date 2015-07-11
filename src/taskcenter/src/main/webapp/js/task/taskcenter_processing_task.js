
function showProcessingTasks() {
	globalTab = 'processing';
	$('#processingTaskTable').bootstrapTable('destroy');
	getTaskListFromServer('正在进行中', createProcessingTaskTable);
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

					$('#userSelect_finish').val(row.executor.user_id);
					$('#finishStatusSelect').val(-1);
				},
				'click .edit' : function(e, value, row, index){
					globalRow = row;
					editTaskModal();
				}
			}
		} ],
		sortName : 'starttime_format',
		sortOrder : 'desc'
	}).bootstrapTable('load', data);
}


function processingFormat(rows) {
	for (var i = 0; i < rows.length; i++) {
		rows[i].addtime_format = new Date(rows[i].addtime)
				.pattern("MM-dd hh:mm:ss");
		rows[i].updatetime_format = new Date(rows[i].updatetime)
				.pattern("MM-dd hh:mm:ss");
		if (rows[i].executor) {
			rows[i].starttime_format = new Date(rows[i].executor.addtime)
					.pattern("MM-dd hh:mm:ss");
			rows[i].executor_name = rows[i].executor.user_name;
			var endTime = new Date(rows[i].executor.addtime);
			endTime.setDate(endTime.getDate()
					+ rows[i].executor.process_duration);
			rows[i].endtime_format = endTime.pattern("MM-dd hh:mm:ss");

		}
	}
}

function finishTheTaskIcon(value, row) {
	if (row.executor.user_id == globalUser.user_id) {
		return "<a class='finish' href='javascript:void(0)'style=''>完成任务</a><br>"
			+ "<a class='edit pull-right' href='javascript:void(0)'style='font-size:9px; color:#999;margin-top:10px'>编辑</a>";
	} else {
		return '';
	}
}

function finishStatusSelectChange() {
	if ($('#finishStatusSelect').val() == '2') { // 申请延期
		$('#finishStatusDurationSpan').show();
		$('#finishStatusDurationInput').val('');
	} else {
		$('#finishStatusDurationSpan').hide();
	}
}

function finishTask() {
	var finishStatus = $('#finishStatusSelect').val();
	switch (finishStatus) {
	case '1': // 正常结束
		endTask();
		break;
	case '2': // 申请延期
		var delay = $('#finishStatusDurationInput').val();
		if (!/^[0-9]*[1-9][0-9]*$/.test(delay)) {
			alert('请输入延期天数（正整数）');
			return;
		}
		delayTask(delay);
		break;
	case '3': // 撤销任务
		cancelTask();
		break;
	default:
		alert('请选择结束状态后再提交。');
	}
}
