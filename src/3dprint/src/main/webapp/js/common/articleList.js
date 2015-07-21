var amountPerPage = 9;
var currPage = 1;
var globalTypeId = null;
var globalArticles = null;

$(function() {

	findTypeId();

	initArticleListInfo(currPage);
});

// 展示某一个type的帖子
function showArticles() {
	$('#articleContainer').html(
			createArticleClassifyContent(globalArticles.article_type,
					globalTypeId));
	var articles = globalArticles.articles;
	
	var html = '';
	if (!articles || !articles.length) {
		html == ''
				&& (html = '<div style="padding-bottom:30px">此分类暂时还没有帖子</div>');
	} else {
		var pagination = createPagination();
		var pageInfo = createPageInfo();
		html += pagination;
		html += pageInfo;
		
		// 遍历帖子
		for (var i = 0; i < articles.length; i++) {
			html += createArticleContent(articles[i]);
		}

		html += pagination;
		html += pageInfo;
	}
	$('#classify_' + globalTypeId).html(html);
}

function createPageInfo(){
	
	if(!globalArticles){
		return '';
	}

	var total = globalArticles.total;
	var maxPage = parseInt((total+amountPerPage-1)/amountPerPage);
	
	return '<div class="pageInfo">共计<span>' + total + '</span>篇帖子，分为<span>' + maxPage + '</span>页。</div>';
}

// 生成页码
function createPagination(){
	
	if(!globalArticles){
		return '';
	}
	
	// 如果总共就只有一页，就不需要页码了
	var total = globalArticles.total;
	if(total <= amountPerPage){
		return '';
	}
	
	var paginationHtml = '<div class="articlePagination">';
	var maxPage = parseInt((total+amountPerPage-1)/amountPerPage); // 总页数
	var from = currPage - 4; // 显示当前页的前4页
	var to = currPage + 5; // 显示当前页的后5页
	
	// 显示的页数是from~to，但是它们可能超出了范围，所以限制from>0、to<=maxPage
	// 但是这样的话，就可能导致总共显示不了10页（比如说当前页为3，那么只会显示1~8页）
	from = Math.max(1, from);
	to = Math.min(maxPage, to);
	
	// 为了使得尽可能显示10页，调整一下from和to
	if(from == 1){
		to = Math.min(maxPage, from+9);
	}
	if(to == maxPage){
		from = Math.max(1, to-9)
	}
	
	// 如果当前页不是首页，那么显示首页和上一页
	if(currPage > 1){
		paginationHtml += '<a href="javascript:gotoPage(' + (1) + ')">' + '首页' + '</a> ';
		paginationHtml += '<a href="javascript:gotoPage(' + (currPage-1) + ')">' + '<上一页' + '</a> ';
	}
	
	// 显示页码
	for(var i=from; i<=to; i++){
		if(i != currPage){
			paginationHtml += '<a href="javascript:gotoPage(' + i + ')">' + i + '</a> ';
		}else{
			paginationHtml += '<span>' + i + '</span> ';
		}
	}
	
	// 如果当前页不是末页，那么显示下一页和末页
	if(currPage < maxPage){
		paginationHtml += '<a href="javascript:gotoPage(' + (currPage+1) + ')">' + '下一页>' + '</a> ';
		paginationHtml += '<a href="javascript:gotoPage(' + (maxPage) + ')">' + '末页' + '</a> ';
	}
	
	paginationHtml += '</div>';
	return paginationHtml;
}

function gotoPage(p){
	initArticleListInfo(p);
}

// 创建需要展示的每个帖子type框
function createArticleClassifyContent(title, type_id) {
	return '<div class="row articleClassify">' + '<div class="col-md-12">'
			+ '<div class="panel">' + '<div class="panel-heading">'
			+ '<h3 class="panel-title">' + title + '</h3>'
			+ '</div>' + '<div class="panel-body" id="classify_' + type_id
			+ '"></div>' + '</div>' + '</div>' + '</div>';
}

// 创建需要展示的帖子内容
function createArticleContent(article) {
	var html = '<div class="articleItem text-left">'
			+ '<div class="articleName"><a href="#">' + article.article_name
			+ '</a></div>' + '<div class="articleText">' + article.text
			+ '</div>' + createArticleImages(article.images)
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

function findTypeId() {

	// 从url中获取模型id，并检查正确性
	globalTypeId = getUrlParam('article_type_id');
	if (!isPositiveInteger(globalTypeId)) {
		globalTypeId = null;
		alert('不存在该类别');
		return;
	}
}

function initArticleListInfo(page) {
	if (globalTypeId == null) {
		return false;
	}
	$.ajax({
		url : ContextPath + '/common/articleList.ajax',
		type : 'post',
		dataType : 'json',
		contentType : 'application/json',
		data : JSON.stringify({
			article_type_id : globalTypeId,
			page : page,
			amount : amountPerPage
		}),
		success : function(res) {
			if (res && res.success) {
				globalArticles = res.value;
				currPage = page;
				showArticles();
			} else if (res) {
				alert(res.message);
			}
		},

		error : function(err) {
			// alert('未知错误')
		}
	});
}