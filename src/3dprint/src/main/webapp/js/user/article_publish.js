
$(function(){
	
	initArticleTypes();
	
	$('#publishArticleBtn').off('click').on('click', publishArticle);
});

function publishArticle(){
	var article_name = $('#inputArticleName').val();
	if(!article_name || article_name == ''){
		alert('请正确填写帖子标题');
		return false;
	}
	
	var article_type_id = $('#selectArticleType').val();
	if(!article_type_id || article_type_id < 1){
		alert('请选择帖子类别');
		return false;
	}
	
	var article_content = ue.getContent();
	if(!ue.hasContents() || ue.getContentTxt() == 0){
		alert('请正确填写帖子详细内容');
		return false;
	}
	
	$.ajax({
		url : ContextPath + '/user/articlePublish.ajax',
		type : 'post',
		dataType : 'json',
		contentType : 'application/json',
		data : JSON.stringify({
			article_name: article_name,
			article_type_id : article_type_id,
			article_content : article_content
		}),
		success : function(res) {
			if (res && res.success) {
				alert('发表帖子成功');
				window.location.href = '';
			} else if (res) {
				alert(res.message);
			}
		},

		error : function(err) {
			// alert('未知错误')
		}
	});
}

function showArticleTypes(types){
	if(!types || !types.length){
		return false;
	}
	var typesHtml = '<option value="-1">请选择</option>';
	for(var i=0; i<types.length; i++){
		typesHtml += '<option value="' + types[i].article_type_id + '">' + types[i].article_type + '</option>';
	}
	$('#selectArticleType').html(typesHtml);
}

function initArticleTypes(){
	$.ajax({
		url : ContextPath + '/common/articleTypeList.ajax',
		type : 'post',
		dataType : 'json',
		contentType : 'application/json',
		data : JSON.stringify({}),
		success : function(res) {
			if (res && res.success) {
				showArticleTypes(res.value);
			} else if (res) {
				alert(res.message);
			}
		},

		error : function(err) {
			// alert('未知错误')
		}
	});
}