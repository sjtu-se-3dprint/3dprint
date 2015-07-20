var globalModelId = null;
var globalModel = null;
var globalThumbnail = null;
var global_images = [];
var global_removed = [];

$(function() {

	findModelId();

	initModelInfo();

});

function initListeners(){

	// 点击图片事件
	$('.thumbnail').off('click').on('click', function() {
		globalThumbnail = this;

		// 触发隐藏的FileInput鼠标点击事件
		$('#uploadImageInput').click();
	})

	// 选完图片文件之后触发
	$('#uploadImageInput').fileupload({
		add : addImage,
	});
	
	$('#editModelBtn').off('click').on('click', editModel);
}

function findModelId() {

	// 从url中获取模型id，并检查正确性
	globalModelId = getUrlParam('model_id');
	if (!isPositiveInteger(globalModelId)) {
		alert('该模型不存在');
		return;
	}
}

function showModelBasicInfo() {
	$('#modelFile').text(globalModel.model_name + '.stl');
	$('#modelNameSpan').text(globalModel.model_name);
	$('#modelSizeSpan').text(
			globalModel.model_length + 'x' + globalModel.model_width + 'x'
					+ globalModel.model_height + '(mm)');
	$('#modelStyleSpan').text(globalModel.model_style);
	$('#addtimeSpan').text(
			new Date(globalModel.addtime).pattern("yyyy-MM-dd hh:mm:ss"));
	$('#updatetimeSpan').text(
			new Date(globalModel.updatetime).pattern("yyyy-MM-dd hh:mm:ss"));
}

function showModelImages() {
	var images = globalModel.model_images;
	if (!images || !images.length) {
		return false;
	}
	for (var i = 0; i < images.length && i <= 4; i++) {
		$($('.thumbnail img')[i]).css('padding-top', '0px');
		$('.thumbnail img')[i].src = ContextPath + images[i];
		$('.thumbnail img')[i].onload = thumbnailImgCenter;
		global_images[i] = {
			type : 'origin',
			index : globalModel.image_name.split(';')[i]
		};
	}
}

function showModelDetail() {

	setTimeout(function() {
		ue.setContent(globalModel.model_description);
	}, 300);

}

function thumbnailImgCenter() {
	var parentHeight = $(this).parent().height();
	var imgHeight = $(this).height();
	$(this).css('padding-top', (parentHeight - imgHeight) / 2 + 'px');
}

// 读取用户选择的图片文件，将其展示在界面上
function addImage(e, data) {

	if (!data || !data.files || !data.files[0]) {
		alert('添加图片失败');
		return;
	}

	var imagefile = data.files[0];

	// 限制大小
	var limit = 3; // MB
	if (imagefile.size > 1024 * 1024 * limit) {
		alert('最大支持3MB大小的图片');
		return;
	}

	var reader = new FileReader();
	reader.onload = imgOnload;

	// 转为base64格式
	reader.readAsDataURL(imagefile);
}

function imgOnload(evt) {

	var src = evt.target.result;
	if (src.indexOf('data:image') != 0) {
		alert('图片格式无法识别。');
		return;
	}

	// 显示图片
	$($(globalThumbnail).find('img')[0]).css('padding-top', '0px');
	$(globalThumbnail).find('img')[0].src = src;

	// 调整图片位置（垂直居中）
	var parentHeight = $(globalThumbnail).height();
	var imgHeight = $($(globalThumbnail).find('img')[0]).height();
	$($(globalThumbnail).find('img')[0]).css('padding-top',
			(parentHeight - imgHeight) / 2 + 'px');

	// 记录下来图片是否被替换以及新图片信息
	for (var i = 0; i < $('.thumbnail').length; i++) {
		if ($('.thumbnail')[i] == globalThumbnail) {
			if (global_images[i] && global_images[i].type == 'origin') {
				global_removed.push(global_images[i].index);
			}
			global_images[i] = {
				type : 'new',
				data : src,
			};
		}
	}
};

function initModelInfo() {
	$.ajax({
		url : ContextPath + '/common/modelInfo.ajax',
		type : 'post',
		dataType : 'json',
		contentType : 'application/json',
		data : JSON.stringify({
			model_id : globalModelId
		}),
		success : function(res) {
			if (res && res.success) {
				globalModel = res.value;
				if(res.value == null){
					alert('该模型不存在');
					return false;
				}
				showModelBasicInfo();
				showModelImages();
				showModelDetail();
				initListeners();
			} else if (res) {
				alert(res.message);
			}
		},

		error : function(err) {
			// alert('未知错误')
		}
	});
}

function editModel(){
	
	var model_description = ue.getContent();
	if(!ue.hasContents() || ue.getContentTxt() == 0){
		alert('请正确填写模型详细描述');
		return false;
	}
	
	if(global_removed.length == 0 && model_description == globalModel.model_description){
		var modified = false;
		for(var i=0; i<global_images.length; i++){
			if(global_images[i] && global_images[i].type != 'origin'){
				modified = true;
			}
		}
		if(!modified){
			alert('没有做出任何修改')
			return false;
		}
	}
	
	var param = {
			model_id : globalModel.model_id,
			model_images : global_images,
			model_images_removed : global_removed,
			model_description : model_description,
	}
	
	// 提交之前禁用提交按钮，防止多次提交
	$('#editModelBtn').off('click');
	
	$.ajax({
		url : ContextPath + '/user/modelEdit.ajax',
		type : 'post',
		dataType : 'json',
		contentType : 'application/json',
		data : JSON.stringify(param),
		success : function(res) {
			if (res && res.success) {
				alert('编辑模型成功！');
				window.location.href = ContextPath + '/view/user/userModel.htm';
			} else if (res) {
				alert(res.message);
			}
			$('#editModelBtn').off('click').on('click', editModel);
		},

		error : function(err) {
			$('#editModelBtn').off('click').on('click', editModel);
			// alert('未知错误')
		}
	});
}