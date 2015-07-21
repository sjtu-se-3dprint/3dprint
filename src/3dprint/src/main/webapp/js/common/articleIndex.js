var amountPerType = 5;
var globalArticleTypes = null;

$(function() {
	initArticleClassify();
});

// 遍历所有type，发请求给服务器，获取帖子列表
function initArticles() {
	if (!globalArticleTypes) {
		return false;
	}
	for (var i = 0; i < globalArticleTypes.length; i++) {
		findArticles(globalArticleTypes[i].article_type_id);
	}
}

// 展示所有帖子type
function showArticleClassify() {
	if (!globalArticleTypes) {
		return false;
	}
	var html = ''
	for (var i = 0; i < globalArticleTypes.length; i++) {
		html += createArticleClassifyContent(
				globalArticleTypes[i].article_type,
				globalArticleTypes[i].article_type_id);
	}
	$('.container').append(html);
}

// 创建需要展示的每个帖子type框
function createArticleClassifyContent(title, type_id) {
	return '<div class="row articleClassify">' + '<div class="col-md-12">'
			+ '<div class="panel">' + '<div class="panel-heading">'
			+ '<h3 class="panel-title"><a href="' + ContextPath
			+ '/view/common/articleList.htm?article_type_id=' + type_id + '">' + title
			+ '</a></h3>' + '</div>' + '<div class="panel-body" id="classify_'
			+ type_id + '"></div>' + '</div>' + '</div>' + '</div>';
}

// 获取帖子的所有type
function initArticleClassify() {
	$.ajax({
		url : ContextPath + '/common/articleTypeList.ajax',
		type : 'post',
		dataType : 'json',
		contentType : 'application/json',
		data : JSON.stringify({}),
		success : function(res) {
			if (res && res.success) {
				globalArticleTypes = res.value;
				showArticleClassify();
				initArticles();
			} else if (res) {
				alert(res.message);
			}
		},

		error : function(err) {
			// alert('未知错误')
		}
	});
}

// 展示某一个type的帖子
function showArticles(article_type_id, articles) {
	var html = '';
	if (!articles || !articles.length) {
		html == ''
				&& (html = '<div style="padding-bottom:30px">此分类暂时还没有帖子</div>');
	} else {
		for (var i = 0; i < articles.length; i++) {
			html += createArticleContent(articles[i]);
		}
	}
	$('#classify_' + article_type_id).html(html);
}

// 创建需要展示的帖子内容
function createArticleContent(article) {
	var html = '<div class="articleItem text-left">'
			+ '<div class="articleName"><a href="' + '">'
			+ article.article_name + '</a></div>' + '<div class="articleText">'
			+ article.text + '</div>' + createArticleImages(article.images)
			+ createArticlePublisher(article) + '</div>';
	return html;
}

// 创建需要展示的帖子发布者信息
function createArticlePublisher(article) {

	var html = '<div class="articlePublisher">'
			+ '<a class="publisher" href="#"><span class="glyphicon glyphicon-user" aria-hidden="true"></span>'
			+ article.user_name
			+ '</a>'
			+ '<a class="time"><span class="glyphicon glyphicon-time" aria-hidden="true"></span>'
			+ getTimeTag(article) + '</a>' + '</div>';
	return html;
}

// 根据帖子的发布时间，返回需要显示的发布时间标签内容
function getTimeTag(article) {
	var now = new Date();
	var publishTime = new Date(article.addtime);
	var time = parseInt((now.getTime() - publishTime.getTime()) / 1000 / 60);
	time < 0 && (time = 0);
	var timeTag = '';
	if (time == 0) {
		timeTag = '1分钟内';
	} else if (time < 60) {
		timeTag = time + '分钟前';
	} else if (time < 60 * 24) {
		timeTag = parseInt(time / 60) + '小时' + parseInt(time % 60) + '分钟前';
	} else {
		timeTag = publishTime.pattern("yyyy-MM-dd hh:mm");
	}
	return timeTag;
}

// 创建需要展示的帖子图片Html
function createArticleImages(images) {
	if (!images || images.length < 1) {
		return '';
	}
	var html = '<div class="articleImages">';
	for (var i = 0; i < images.length; i++) {
		html += createArticleImage(images[i]);
	}
	html += '</div>';
	return html;
}

function createArticleImage(image) {
	return '<img src="' + image + '"/>';
}

// 根据类型ID，查出最近发布的几篇帖子，并且展示出来
function findArticles(article_type_id) {
	$.ajax({
		url : ContextPath + '/common/articleOverview.ajax',
		type : 'post',
		dataType : 'json',
		contentType : 'application/json',
		data : JSON.stringify({
			article_type_id : article_type_id,
			amount : amountPerType,
			page : 1
		}),
		success : function(res) {
			if (res && res.success) {
				showArticles(article_type_id, res.value);
			} else if (res) {
				alert(res.message);
			}
		},

		error : function(err) {
			// alert('未知错误')
		}
	});
}