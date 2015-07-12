var globalUser = null;

$(window).load(function() {

	getMyUser();

	getAllTaskListFromServer(createAllTaskTable);
});

function createAllTaskTable(data){
	allTaskFormat(data);
	$('#allTaskTable').bootstrapTable('destroy').bootstrapTable({
		columns : [ {
			title : '编号',
			field : 'task_id',
			sortable : true,
		}, {
			title : '任务名',
			field : 'task_name',
		},{
			title : '任务状态',
			field : 'task_status',
			sortable : true,
		},{
			title : '发布时间',
			field : 'addtime_format',
			sortable : true,
		}, {
			title : '发布者',
			field : 'user_name',
			sortable : true,
		}, {
			title : '操作',
			field : 'viewTask',
			align : 'center',
			valign : 'middle',
			formatter : viewTaskIcon,
			events : window.operateEvents = {
				'click .view' : function(e, value, row, index) {
					window.location.href = ContextPath + '/detail.htm?task_id=' + row.task_id;
				}
			}
		} ],
		classes : tableClasses()
	}).bootstrapTable('load', data);
}

function viewTaskIcon() {
	return "<a class='view' href='javascript:void(0)'style=''>查看历史流程</a><br>"
}

function getAllTaskListFromServer(callback){
	$.ajax({
		url : ContextPath + '/task/listAllTask.ajax',
		type : 'post',
		dataType : 'json',
		contentType : 'application/json',
		data : JSON.stringify({}),
		success : function(res) {
			if (res && res.success) {
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

function allTaskFormat(rows){
	for (var i = 0; i < rows.length; i++) {
		rows[i].addtime_format = new Date(rows[i].addtime)
				.pattern("yyyy-MM-dd hh:mm:ss");
		rows[i].updatetime_format = new Date(rows[i].updatetime)
				.pattern("yyyy-MM-dd hh:mm:ss");
	}
}
function tableClasses(){
	return 'table table-striped';
}