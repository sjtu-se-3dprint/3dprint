var globalArticleId = null;
var globalArticle = null;

$(function(){
	
	findArticleId();
	
	initArticleInfo();
	
});

function showArticleInfo(){
	$('#inputArticleName').val(globalArticle.article_name);
	$('#selectArticleType').html('<option>' + globalArticle.article_type + '</option>');
	setTimeout(function() {
		ue.setContent(globalArticle.article_content);
	}, 300);
}

function initListeners(){
	$('#editArticleBtn').off('click').on('click', editArticle);
}

function initArticleInfo(){
	if(globalArticleId == null){
		return false;
	}
	$.ajax({
		url : ContextPath + '/common/articleInfo.ajax',
		type : 'post',
		dataType : 'json',
		contentType : 'application/json',
		data : JSON.stringify({
			article_id : globalArticleId
		}),
		success : function(res) {
			if (res && res.success) {
				globalArticle = res.value;
				if(res.value == null){
					alert('该帖子不存在');
					return false;
				}
				showArticleInfo();
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

function findArticleId() {

	// 从url中获取模型id，并检查正确性
	globalArticleId = getUrlParam('article_id');
	if (!isPositiveInteger(globalArticleId)) {
		alert('该帖子不存在');
		return;
	}
}

function editArticle(){
	var article_name = $('#inputArticleName').val();
	if(!article_name || article_name == ''){
		alert('请正确填写帖子标题');
		return false;
	}
	
	var article_content = ue.getContent();
	if(!ue.hasContents() || ue.getContentTxt() == 0){
		alert('请正确填写帖子详细内容');
		return false;
	}
	
	$.ajax({
		url : ContextPath + '/user/articleEdit.ajax',
		type : 'post',
		dataType : 'json',
		contentType : 'application/json',
		data : JSON.stringify({
			article_id: globalArticleId,
			article_name: article_name,
			article_content : article_content
		}),
		success : function(res) {
			if (res && res.success) {
				alert('修改帖子成功');
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