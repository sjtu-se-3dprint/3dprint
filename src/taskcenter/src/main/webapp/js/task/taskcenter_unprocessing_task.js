
function showUnprocessingTasks() {
	globalTab = 'unprocessing';
	$('#unprocessingTaskTable').bootstrapTable('destroy');
	getTaskListFromServer('未处理', createUnprocessingTaskTable);
}

function createUnprocessingTaskTable(data) {
	unprocessingFormat(data);
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
				},
				'click .edit' : function(e, value, row, index){
					globalRow = row;
					editTaskModal();
				},
				'click .delete' : function(e, value, row, index){
					globalRow = row;
					if(confirm('真的要删除任务【' + globalRow.task_name + '】吗？')){
						deleteTask();
					}
				}
			}
		} ],
		sortName : 'addtime_format',
		sortOrder : 'desc',
		classes : tableClasses()
	}).bootstrapTable('load', data);
}

function unprocessingFormat(rows) {
	for (var i = 0; i < rows.length; i++) {
		rows[i].addtime_format = new Date(rows[i].addtime)
				.pattern("MM-dd hh:mm:ss");
		rows[i].updatetime_format = new Date(rows[i].updatetime)
				.pattern("MM-dd hh:mm:ss");
	}
}

function processTheTaskIcon() {
	return "<a class='process' href='javascript:void(0)'style=''>领取任务</a><br>"
	+ "<a class='delete pull-right' href='javascript:void(0)'style='font-size:9px; color:#999;margin-top:10px;margin-right:0px'>删除</a>"
	+ "<a class='edit pull-right' href='javascript:void(0)'style='font-size:9px; color:#999;margin-top:10px;margin-right:5px'>编辑</a>"
}