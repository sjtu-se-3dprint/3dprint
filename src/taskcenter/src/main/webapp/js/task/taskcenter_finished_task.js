
function showProcessedTasks() {
	globalTab = 'processed';
	$('#processedTaskTable').bootstrapTable('destroy');
	getTaskListFromServer('已完成', createProcessedTaskTable);
}

function createProcessedTaskTable(data) {
	processedFormat(data);
	$('#processedTaskTable').bootstrapTable('destroy').bootstrapTable({
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
			title : '完成时间',
			field : 'finish_time',
			sortable : true,
		}, {
			title : '执行者',
			field : 'executor_name'
		}, {
			title : '操作',
			field : 'finishedTask',
			align : 'center',
			valign : 'middle',
			formatter : finishedTaskIcon,
			events : window.operateEvents = {
				'click .finished' : function(e, value, row, index) {
					globalRow = row;

					$('#finishedTaskModal').modal('show');
					$('#task_id_finished').text(row.task_id);
					$('#task_addtime_finished').text(row.addtime_format);
					$('#task_updatetime_finished').text(row.updatetime_format);
					$('#task_name_finished').text(row.task_name);
					$('#task_status_finished').text(row.task_status);
					$('#task_publisher_finished').text(row.user_name);
					$('#task_detail_finished').html(row.task_detail);
					$('#task_startime_finished').text(row.starttime_format);
					$('#task_endtime_finished').text(row.endtime_format);
					$('#task_finishtime_finished').text(row.finish_time);
					$('#task_executor_finished').text(row.executor_name);
				}
			}
		} ],
		sortName : 'finish_time',
		sortOrder : 'desc'
	}).bootstrapTable('load', data);
}

function finishedTaskIcon() {
	return "<a class='finished' href='javascript:void(0)'style=''>任务详情</a><br>"
}


function processedFormat(rows) {
	for (var i = 0; i < rows.length; i++) {
		rows[i].addtime_format = new Date(rows[i].addtime)
				.pattern("MM-dd hh:mm:ss");
		rows[i].updatetime_format = new Date(rows[i].updatetime)
				.pattern("MM-dd hh:mm:ss");
		if (rows[i].executor) {
			rows[i].starttime_format = new Date(rows[i].executor.addtime)
					.pattern("MM-dd hh:mm:ss");
			rows[i].executor_name = rows[i].executor.user_name;
			var finishTime = new Date(rows[i].executor.updatetime);
			rows[i].finish_time = finishTime.pattern("MM-dd hh:mm:ss");
			var endTime = new Date(rows[i].executor.addtime);
			endTime.setDate(endTime.getDate()
					+ rows[i].executor.process_duration);
			rows[i].endtime_format = endTime.pattern("MM-dd hh:mm:ss");

		}
	}
}