var instruction = 'getModelTypeList';
var modelTypeList;

/*初始化函数*/
$(function() {
	getModelTypeList();
});

function getModelTypeList() {
	$.ajax({
		url : ContextPath+'/common/modelTypeList.ajax',
		type : 'post',
		dataType : 'json',
		contentType : 'application/json',
		data : JSON.stringify({
			instr : instruction
		}),
		
		success : function(resp) {
			if (resp && resp.success) {
				modelTypeList = resp.value;
				//这里应该与更新列表的操作
				updateModelTypeList(modelTypeList);
			}
			else if (resp) {
				alert(resp.message);
			}
		},
		
		error : function(err) {
			alert('未知错误')
		}
	});
}

function updateModelTypeList(typeList) {
	var i;
	for (i = 0; i<typeList.length; i++) {
		var item = "<a href=\"#\" class=\"list-group-item\">";
		item = item + typeList[i].model_type_name;
		item = item + "</a>"
		$('#model_type_list').append(item);
	}
}