var amountPerPage = 9;
var currPage = 1;
var modelInfo = null;

$(function() {

	getUserInfo(function() {

		// 显示用户头像
		initUserHead();

	});

	getUserModels(currPage, amountPerPage);
})

function showModels() {
	if (!modelInfo || !modelInfo.models) {
		return;
	}
	$('#modelContainer').html('');
	for (var i = 0; i < modelInfo.models.length; i++) {
		$('#modelContainer').append(createModelHtml(modelInfo.models[i]));

	}
}

function createModelHtml(model) {
	var content = '';
	content += '<div class="modelThumbnail pull-left">';
	content += '<div class="img">';
	content += '<img src="'
			+ ContextPath
			+ '/'
			+ (model.model_images && model.model_images[0] ? model.model_images[0]
					: '...') + '" alt="not found">';
	content += '</div>';
	content += '<div class="name">' + model.model_name + '</div>';
	content += '<div class="operate">';
	content += '<a href="javascript:deleteMyModel(' + model.model_id + ')" class="pull-right">删除</a> <a href="' + ContextPath
			+ '/view/user/modelEdit.htm?model_id=' + model.model_id
			+ '" class="pull-right">编辑</a>';
	content += '</div>';
	content += '</div>';
	return content;
}

function getUserModels(page, amount) {
	$.ajax({
		url : ContextPath + '/user/myModels.ajax',
		type : 'post',
		dataType : 'json',
		contentType : 'application/json',
		data : JSON.stringify({
			page : page,
			amount : amount
		}),
		success : function(res) {
			if (res && res.success) {

				console.log(res.value);
				modelInfo = res.value;

				showModels();

			} else if (res) {
				alert(res.message);
			}
		},
		error : function(err) {
			// alert('未知错误');
		}
	});
}

function deleteMyModel(model_id){
	if(!confirm('确定要删除此模型？')){
		return false;
	}
	$.ajax({
		url : ContextPath + '/user/deleteMyModel.ajax',
		type : 'post',
		dataType : 'json',
		contentType : 'application/json',
		data : JSON.stringify({
			model_id: model_id
		}),
		success : function(res) {
			if (res && res.success) {
//				alert('删除成功');
				getUserModels(currPage, amountPerPage);
			} else if (res) {
				alert(res.message);
			}
		},
		error : function(err) {
			// alert('未知错误');
		}
	});
}