
function publishTaskModal() {
	$('#publishTaskModal').modal('show');

	$('#publishTaskModal').css('z-index', 100);

	$('#taskNameInput').val('');
	ue.setContent('');

	$('.modal-backdrop').css('z-index', 99);
}

function editTaskModal() {
	$('#editTaskModal').modal('show');

	$('#editTaskModal').css('z-index', 100);

	$('#editTaskNameInput').val(globalRow.task_name);
	ueEdit.setContent(globalRow.task_detail);

	$('.modal-backdrop').css('z-index', 99);
}