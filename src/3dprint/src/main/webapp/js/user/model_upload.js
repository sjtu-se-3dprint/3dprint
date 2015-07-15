var globalThumbnail = null;
$(function() {
	$('.thumbnail').off('click').on('click', function() {
		globalThumbnail = this;
		$('#uploadImageInput').click();
	})

	$('#uploadImageInput').fileupload({
		add : addImage,
	});

	$.ajax({
		url : ContextPath + '/common/modelTypeList.ajax',
		type : 'post',
		dataType : 'json',
		contentType : 'application/json',
		data : JSON.stringify({}),
		success : function(res) {
			if (res && res.success) {
				console.log(res.value)
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
			alert('未知错误')
		}
	});
});

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