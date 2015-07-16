<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/css/modelEdit.css" />
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/css/modelUpload.css" />
<title>模型编辑</title>
</head>
<body>
	<jsp:include page="../common/header.jsp" flush="true"></jsp:include>
	<script src="<%=request.getContextPath()%>/js/jquery.ui.widget.js"></script>
	<script src="<%=request.getContextPath()%>/js/jquery.fileupload.js"></script>

	<script type="text/javascript" charset="utf-8"
		src="<%=request.getContextPath()%>/ueditor1_4_3-utf8-jsp/ueditor.config.js"></script>
	<script type="text/javascript" charset="utf-8"
		src="<%=request.getContextPath()%>/ueditor1_4_3-utf8-jsp/ueditor.all.js"></script>

	<script src="<%=request.getContextPath()%>/js/user/model_edit.js"></script>

	<div class="container text-center" style="max-width: 1000px">

		<div class="row">
			<div class="col-md-12">
				<div class="panel panel-primary">
					<div class="panel-heading">
						<h3 class="panel-title">模型基本信息（不可修改）</h3>
					</div>
					<div class="panel-body">

						<form class="form-horizontal">
							<div class="row form-group">
								<label class="col-md-3 text-left control-label">模型文件：</label>
								<div class="col-md-3 control-label">
									<a id="modelFile" class="pull-left" href="#"></a>
								</div>
								<label class="col-md-3 control-label border-left">模型名称：</label>
								<div class="col-md-3 control-label">
									<span id="modelNameSpan" class="pull-left"></span>
								</div>
							</div>
							<div class="row form-group">
								<label class="col-md-3 control-label">模型尺寸：</label>
								<div class="col-md-3 control-label">
									<span id="modelSizeSpan" class="pull-left"></span>
								</div>
								<label class="col-md-3 control-label border-left">模型类型：</label>
								<div class="col-md-3 control-label">
									<span id="modelStyleSpan" class="pull-left"></span>
								</div>
							</div>
							<div class="row form-group">
								<label class="col-md-3 control-label">上传时间：</label>
								<div class="col-md-3 control-label">
									<span id="addtimeSpan" class="pull-left"></span>
								</div>
								<label class="col-md-3 control-label border-left">编辑时间：</label>
								<div class="col-md-3 control-label">
									<span id="updatetimeSpan" class="pull-left"></span>
								</div>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
		<div class="row">
			<div class="col-md-12">
				<div class="panel panel-primary">
					<div class="panel-heading">
						<h3 class="panel-title">模型预览图片（可修改）</h3>
					</div>
					<div class="panel-body">
						<div class="row">
							<div class="col-md-3">
								<a class="thumbnail center-block"> <img />
								</a>
							</div>
							<div class="col-md-3">
								<a class="thumbnail center-block"> <img />
								</a>
							</div>
							<div class="col-md-3">
								<a class="thumbnail center-block"> <img />
								</a>
							</div>
							<div class="col-md-3">
								<a class="thumbnail center-block"> <img />
								</a>
							</div>
							<input id="uploadImageInput" type="file" style="display: none" />
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="row">
			<div class="col-md-12">
				<div class="panel panel-primary">
					<div class="panel-heading">
						<h3 class="panel-title">模型详细描述（可修改）</h3>
					</div>
					<div class="panel-body" style="padding: 0">
						<script id="editor" type="text/plain" style="height: 300px;"></script>
						<script>
							var ue = UE.getEditor('editor');
						</script>
					</div>
				</div>
			</div>
		</div>
		<div class="row">
			<div class="col-md-2 col-md-push-5">
				<button type="button" id="editModelBtn" class="btn btn-primary"
					style="margin-top: 20px; margin-bottom: 70px; width: 100%">确认编辑</button>
			</div>
		</div>
	</div>
</body>
</html>