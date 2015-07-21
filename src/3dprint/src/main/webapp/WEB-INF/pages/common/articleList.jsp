<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/css/articleIndex.css" />
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/css/articleList.css" />
<title>论坛</title>
</head>
<body>
	<jsp:include page="../common/header.jsp" flush="true"></jsp:include>
	<script src="<%=request.getContextPath()%>/js/common/articleList.js"></script>

	<div class="container" style="max-width: 1000px">
		<div class="row" style="padding-bottom: 15px;">
			<div class="col-md-8 article-path">
				<a href="<%=request.getContextPath()%>/view/common/articleIndex.htm" class="pull-left">论坛首页</a>
				<div>&gt;</div>
				<div id="title"></div>
			</div>
			<div class="col-md-4">
				<a href="<%=request.getContextPath()%>/view/user/articlePublish.htm"
					class="pull-right publishBtn" style="text-decoration: none">我要发帖</a>
			</div>
		</div>
	</div>
	<div id="articleContainer" class="container" style="max-width: 1000px">
		<!-- 		<div class="row"> -->
		<!-- 			<div class="col-md-12"> -->
		<!-- 				<div class="panel panel-warning"> -->
		<!-- 					<div class="panel-heading"> -->
		<!-- 						<h3 class="panel-title">3D模型</h3> -->
		<!-- 					</div> -->
		<!-- 					<div class="panel-body text-left"> -->
		<!-- 						<div class="articlePagination"> -->
		<!-- 							<a href="#" class="pagination-item">首页</a> <a href="#" -->
		<!-- 								class="pagination-item">&lt;上一页</a> <a href="#" -->
		<!-- 								class="pagination-item">1</a> <a href="#" -->
		<!-- 								class="pagination-item">2</a> <span class="pagination-item">3</span> -->
		<!-- 							<a href="#" class="pagination-item">4</a> <a href="#" -->
		<!-- 								class="pagination-item">下一页&gt;</a> <a href="#" -->
		<!-- 								class="pagination-item">末页</a> -->
		<!-- 						</div> -->
		<!-- 						<div class="pageInfo">共计<span>12</span>篇帖子，分为<span>3</span>页</div> -->
		<!-- 						<div class="articleItem"> -->
		<!-- 							<a href="#" class="articleName">【宇宙】遨游天际浩渺，带你看宇宙之最</a> -->
		<!-- 							<div class="articleText">畅所欲言留言板！20万层盖起来！！！ 把贴吧当弹幕玩儿~ -->
		<!-- 								把你内心奔腾的草泥马都放出来吧！ 用过的第一台华为手机 成为花粉的理由 比头上帽畅所欲言留言板！20万层盖起来！！！ -->
		<!-- 								把贴吧当弹幕玩儿~ 把你内心奔腾的草泥马都放出来吧！ 用过的第一台华为手机 成为花粉的理由 比头上帽...</div> -->
		<!-- 							<div class="articleImages"> -->
		<!-- 								<img -->
		<!-- 									src="/3dprint/ueditor/jsp/upload/image/20150720/1437430999732075450.jpg" /> -->
		<!-- 								<img -->
		<!-- 									src="/3dprint/ueditor/jsp/upload/image/20150720/1437431004665031756.jpg" /> -->
		<!-- 								<img -->
		<!-- 									src="/3dprint/ueditor/jsp/upload/image/20150720/1437431011859090111.jpg" /> -->
		<!-- 							</div> -->
		<!-- 							<div class="articlePublisher"> -->
		<!-- 								<a class="publisher" href="#"><span -->
		<!-- 									class="glyphicon glyphicon-user" aria-hidden="true"></span>123456</a> -->
		<!-- 								<a class="time"><span class="glyphicon glyphicon-time" -->
		<!-- 									aria-hidden="true"></span>1分钟前</a> -->
		<!-- 							</div> -->
		<!-- 						</div> -->
		<!-- 						<div class="articleItem"> -->
		<!-- 							<a href="#" class="articleName">【宇宙】遨游天际浩渺，带你看宇宙之最</a> -->
		<!-- 							<div class="articleText">畅所欲言留言板！20万层盖起来！！！ 把贴吧当弹幕玩儿~ -->
		<!-- 								把你内心奔腾的草泥马都放出来吧！ 用过的第一台华为手机 成为花粉的理由 比头上帽畅所欲言留言板！20万层盖起来！！！ -->
		<!-- 								把贴吧当弹幕玩儿~ 把你内心奔腾的草泥马都放出来吧！ 用过的第一台华为手机 成为花粉的理由 比头上帽...</div> -->
		<!-- 						</div> -->
		<!-- 					</div> -->
		<!-- 				</div> -->
		<!-- 			</div> -->
		<!-- 		</div> -->
	</div>
</body>
</html>