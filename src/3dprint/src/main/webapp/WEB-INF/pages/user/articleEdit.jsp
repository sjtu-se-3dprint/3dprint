<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/css/articlePublish.css" />
<title>编辑帖子</title>
</head>
<body>
	<jsp:include page="../common/header.jsp" flush="true"></jsp:include>

	<script type="text/javascript" charset="utf-8"
		src="<%=request.getContextPath()%>/ueditor1_4_3-utf8-jsp/ueditor.config.js"></script>
	<script type="text/javascript" charset="utf-8"
		src="<%=request.getContextPath()%>/ueditor1_4_3-utf8-jsp/ueditor.all.js"></script>

	<script src="<%=request.getContextPath()%>/js/user/article_edit.js"></script>

	<div class="container" style="max-width: 1000px">
		<div class="row">
			<form class="form-horizontal">

				<div class="form-group">
					<div class="pull-left labelWidth">
						<label for="inputArticleName" class="control-label"
							>帖子标题：</label>
					</div>
					<div class="marginForLabel">
						<input type="text" class="form-control" id="inputArticleName"
							placeholder="Article Name">
					</div>
				</div>
				<div class="form-group">
					<div class="pull-left labelWidth">
						<label for="selectArticleType" class="control-label"
							>帖子类别：</label>
					</div>
					<div class="marginForLabel">
						<select class="form-control" id="selectArticleType" disabled>
							<option>请选择</option>
						</select>
					</div>
				</div>
				<div class="form-group">
					<label class="control-label pull-left">帖子详细内容：</label>
				</div>
				<div class="form-group">
					<script id="editor" type="text/plain" style="height: 500px;"></script>
					<script>
						var ue = UE.getEditor('editor');
					</script>
				</div>
			</form>
		</div>
		<div class="row">
			<div class="col-md-2 col-md-push-5">
				<button type="button" id="editArticleBtn" class="btn btn-primary"
					style="margin-top: 20px; margin-bottom: 70px; width: 100%">确认修改帖子</button>
			</div>
		</div>
	</div>
</body>
</html>