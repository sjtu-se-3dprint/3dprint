// 获取已登录的用户信息
function getMyUser() {
	$.ajax({
		url : ContextPath + '/task/myUser.ajax',
		type : 'post',
		dataType : 'json',
		async : false,
		contentType : 'application/json',
		data : JSON.stringify({}),
		success : function(res) {
			if (res && res.success) {
				globalUser = res.value;

				$('#userSelectPublishTask').text(globalUser.user_name);
				$('#userSelect').text(globalUser.user_name);
				$('#userSelect_finish').text(globalUser.user_name);
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

// 获取任务列表
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

function deleteTask() {
	$
			.ajax({
				url : ContextPath + '/task/deleteTask.ajax',
				type : 'post',
				dataType : 'json',
				contentType : 'application/json',
				data : JSON.stringify({
					task_id : globalRow.task_id
				}),
				success : function(res) {
					if (res && res.success) {
						alert('删除成功！');
						refreshTab();
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

// 发布任务
function publishTask() {
	var task_name = $('#taskNameInput').val();
	var task_detail = ue.getContent();
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

	$
			.ajax({
				url : ContextPath + '/task/publishTask.ajax',
				type : 'post',
				dataType : 'json',
				contentType : 'application/json',
				data : JSON.stringify({
					task_name : task_name,
					task_detail : task_detail,
				}),
				success : function(res) {
					if (res && res.success) {
						alert('发布成功！');
						$('#publishTaskModal').modal('hide');
						refreshTab();
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

function editTask() {
	var task_name = $('#editTaskNameInput').val();
	var task_detail = ueEdit.getContent();
	var min_name_len = 5;
	var min_detail_len = 10;
	if (!task_name || task_name.length < min_name_len) {
		alert('请输入至少' + min_name_len + '个字的任务名称。');
		return;
	}
	var plainContent = ueEdit.getContentTxt();
	if (!plainContent || plainContent.length < min_detail_len) {
		alert('请输入至少' + min_detail_len + '个字的任务详细描述。');
		return;
	}

	$
			.ajax({
				url : ContextPath + '/task/editTask.ajax',
				type : 'post',
				dataType : 'json',
				contentType : 'application/json',
				data : JSON.stringify({
					task_id : globalRow.task_id,
					task_name : task_name,
					task_detail : task_detail,
				}),
				success : function(res) {
					if (res && res.success) {
						alert('编辑成功！');
						$('#editTaskModal').modal('hide');
						refreshTab();
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

// 领取任务
function pickTask() {
	var duration = $('#durationSelect').val();
	if (!duration || duration < 1) {
		alert('请选择好天数后再提交。');
		return;
	}

	$.ajax({
		url : ContextPath + '/task/startTask.ajax',
		type : 'post',
		dataType : 'json',
		contentType : 'application/json',
		data : JSON.stringify({
			process_duration : duration,
			task_id : globalRow.task_id
		}),
		success : function(res) {
			if (res && res.success) {
				alert('领取成功！');
				$('#processTheTaskModal').modal('hide');
				refreshTab();
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

// 完成任务
function endTask() {
	$.ajax({
		url : ContextPath + '/task/endTask.ajax',
		type : 'post',
		dataType : 'json',
		contentType : 'application/json',
		data : JSON.stringify({
			task_id : globalRow.task_id
		}),
		success : function(res) {
			if (res && res.success) {
				alert('提交成功！');
				$('#finishTheTaskModal').modal('hide');
				refreshTab();
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

// 申请延期
function delayTask(delay) {
	$.ajax({
		url : ContextPath + '/task/delayTask.ajax',
		type : 'post',
		dataType : 'json',
		contentType : 'application/json',
		data : JSON.stringify({
			task_id : globalRow.task_id,
			delay_days : delay
		}),
		success : function(res) {
			if (res && res.success) {
				alert('延期成功！');
				$('#finishTheTaskModal').modal('hide');
				refreshTab();
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

// 撤销正在执行的任务
function cancelTask() {
	$.ajax({
		url : ContextPath + '/task/cancelTask.ajax',
		type : 'post',
		dataType : 'json',
		contentType : 'application/json',
		data : JSON.stringify({
			task_id : globalRow.task_id
		}),
		success : function(res) {
			if (res && res.success) {
				alert('撤销成功！');
				$('#finishTheTaskModal').modal('hide');
				refreshTab();
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
