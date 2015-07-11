var globalUser = null;
var globalTaskId = null;

$(window).load(function() {

	getMyUser();

	globalTaskId = getUrlParam('task_id');

	if (globalTaskId == null || !/^[0-9]*[1-9][0-9]*$/.test(globalTaskId)) {
		alert('不存在的任务');
		return;
	}
	
	taskHistoryDetail(createTaskDetailTable);

});

function createTaskDetailTable(data){
	detailTaskFormat(data);
	$('#taskDetailTable').bootstrapTable('destroy').bootstrapTable({
		columns : [ {
			title : '操作类型',
			field : 'record_type',
		}, {
			title : '操作后任务名',
			field : 'record_task_name',
		},{
			title : '操作后任务状态',
			field : 'record_task_status',
			sortable : true,
		}, {
			title : '操作者',
			field : 'record_user_name',
			sortable : true,
		}, {
			title : '操作时间',
			field : 'addtime_format',
			sortable : true,
		}, {
			title : '操作',
			field : 'viewTask',
			align : 'center',
			valign : 'middle',
			formatter : detailTaskIcon,
			events : window.operateEvents = {
				'click .view' : function(e, value, row, index) {

					$('#detailModal').modal('show');
					$('#task_name').text(row.record_task_name);
					$('#task_detail').html(row.record_task_detail);
					$('#record_type').text(row.record_type);
					$('#record_user_name').text(row.record_user_name);
					$('#record_task_status').text(row.record_task_status);
					$('#addtime_format').text(row.addtime_format);
					$('#record_other').show();
					if('领取任务' == row.record_type){
						$('#record_other').text('预计完成时间：' + row.record_days + '天');
					}else if('申请延期' == row.record_type){
						$('#record_other').text('延期天数：' + row.record_delay + '天');
					}else{
						$('#record_other').hide();
					}
					
					$('#task_name').text(row.task_name);
					$('#task_name').text(row.task_name);
					$('#task_name').text(row.task_name);
					$('#task_name').text(row.task_name);
				}
			}
		} ],
		classes : tableClasses()
	}).bootstrapTable('load', data);
}

function detailTaskIcon(){
	return "<a class='view' href='javascript:void(0)'style=''>查看详情</a><br>"
}

function taskHistoryDetail(callback) {
	$.ajax({
		url : ContextPath + '/task/taskHistoryDetail.ajax',
		type : 'post',
		dataType : 'json',
		contentType : 'application/json',
		data : JSON.stringify({
			task_id : globalTaskId
		}),
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

function detailTaskFormat(rows){
	for (var i = 0; i < rows.length; i++) {
		rows[i].addtime_format = new Date(rows[i].addtime)
				.pattern("yyyy-MM-dd hh:mm:ss");
		if(rows[i].operator){
			rows[i].record_user_name = rows[i].operator.user_name;
		}
	}
}
function tableClasses(){
	return 'table table-striped';
}