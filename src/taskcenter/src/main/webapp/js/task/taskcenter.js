var globalRow = null;
var globalUser = null;
var globalTab = null;

$(window).load(function() {

	getMyUser();

	$('#unprocessingTasks').on('show.bs.tab', showUnprocessingTasks);
	$('#processingTasks').on('show.bs.tab', showProcessingTasks);
	$('#processedTasks').on('show.bs.tab', showProcessedTasks);

	$('#pickTaskButton').off('click').on('click', pickTask);
	$('#publishTaskModalButton').off('click').on('click', publishTaskModal);
	$('#publishTaskButton').off('click').on('click', publishTask);
	$('#finishTaskButton').off('click').on('click', finishTask);
	$('#editTaskButton').off('click').on('click', editTask);

	$('#finishStatusSelect').change(finishStatusSelectChange);

	showUnprocessingTasks();

});

function taskDetailStyle(value, row, index) {
	return {
		classes : 'taskDetailStyle'
	};
}

function refreshTab(){
	switch(globalTab){
	case 'unprocessing':
		showUnprocessingTasks();
		break;
	case 'processing':
		showProcessingTasks();
		break;
	case 'processed':
		showProcessedTasks();
		break;
	}
}

function tableClasses(){
	return 'table table-striped';
}