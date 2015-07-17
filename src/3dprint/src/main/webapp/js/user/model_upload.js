var globalThumbnail = null;
$(function() {
	
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
	
	$('#uploadModelBtn').off('click').on('click', uploadModel);

	// 初始化模型类型
	initModelType();
});

// 从数据库取出模型类型信息，显示在界面上，提供给用户选择类型
function initModelType(){
	$.ajax({
		url : ContextPath + '/common/modelTypeList.ajax',
		type : 'post',
		dataType : 'json',
		contentType : 'application/json',
		data : JSON.stringify({}),
		success : function(res) {
			if (res && res.success) {
				var types = res.value;
				var selectContent = '';
				for(var i=0; i<types.length; i++){
					selectContent += '<option value="' + types[i].model_type_id + '">'
						+ types[i].model_type_name + '</option>';
				}
				$('#modelTypeSelect').append(selectContent);
			} else if (res) {
				alert(res.message);
			}
		},

		error : function(err) {
			// alert('未知错误')
		}
	});
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

};

function uploadModel(){
	
	// 检查模型文件是否加载成功
	var model_file_seq = globalFileSeq;
	if(model_file_seq == null){
		alert('请选择模型文件')
		return false;
	}
	
	// 检查模型名称是否正确填写
	var model_name = $('#inputModelName').val();
	if(model_name.length == ''){
		alert('请正确填写模型名称');
		return false;
	}
	
	// 检查模型尺寸是否正确填写
	var model_length = $('#inputModelLength').val();
	var model_width = $('#inputModelWidth').val();
	var model_height = $('#inputModelHeight').val();
	if(!isPositiveInteger(model_length)
			|| !isPositiveInteger(model_width)
			|| !isPositiveInteger(model_height)){
		alert('请正确填写模型尺寸（必须为正整数）');
		return false;
	}
	
	// 检查模型类型是否正确选择
	var model_type = $('#modelTypeSelect').find("option:selected").text()
	if($('#modelTypeSelect').val() < 1){
		alert('请选择模型类型');
		return false;
	}
	
	// 检查模型预览图片是否已选择
	var model_images = new Array();
	$('.thumbnail img').each(function(){
		if(this.src != ''){
			model_images.push(this.src);
		}
	});
	if(model_images.length == 0){
		alert('请至少选择1张模型预览图片')
		return false;
	}
	
	// 检查模型描述是否正确填写
	var model_description = ue.getContent();
	if(!ue.hasContents() || ue.getContentTxt() == 0){
		alert('请正确填写模型详细描述');
		return false;
	}
	
	var param = {
			model_file_seq : model_file_seq,
			model_name : model_name,
			model_length : model_length,
			model_width : model_width,
			model_height : model_height,
			model_style : model_type,
			model_description : model_description,
			model_images : model_images,
	}

	// 提交之前禁用提交按钮，防止多次提交
	$('#uploadModelBtn').off('click');
	
	$.ajax({
		url : ContextPath + '/user/modelUpload.ajax',
		type : 'post',
		dataType : 'json',
		contentType : 'application/json',
		data : JSON.stringify(param),
		success : function(res) {
			if (res && res.success) {
				alert('上传模型成功！');
				window.location.href = ContextPath + '/view/user/userModel.htm';
			} else if (res) {
				alert(res.message);
			}
			$('#uploadModelBtn').off('click').on('click', uploadModel);
		},

		error : function(err) {
			$('#uploadModelBtn').off('click').on('click', uploadModel);
			// alert('未知错误')
		}
	});
}