<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/css/modelUpload.css" />
<title>模型上传</title>
</head>
<body>
	<jsp:include page="../common/header.jsp" flush="true"></jsp:include>
	<script src="<%=request.getContextPath()%>/js/jquery.ui.widget.js"></script>
	<script src="<%=request.getContextPath()%>/js/jquery.fileupload.js"></script>
	<script
		src="<%=request.getContextPath()%>/js/user/model_file_upload.js"></script>
	<script src="<%=request.getContextPath()%>/js/user/model_upload.js"></script>

	<div class="container" style="max-width: 1000px">
		<div class="row">
			<button id="selectFileBtn" class="btn btn-primary">选择模型文件</button>
			<span id="selectFileHint" style="padding-left: 10px">加载中：100%</span>
		</div>
		<div class="row" style="margin-top: 30px">
			<form id="upload" method="post" style="display: none"
				action="<%=request.getContextPath()%>/user/modelFileUpload.ajax"
				enctype="multipart/form-data">
				<input id="uploadInput" type="file" />
			</form>
		</div>
		<div class="row">
			<form class="form-horizontal">
				<div class="form-group">
					<label for="inputModelName" class="control-label pull-left">模型名称：</label>
					<div class="col-md-10">
						<input type="text" class="form-control" id="inputModelName"
							placeholder="Model Name">
					</div>
				</div>
				<div class="form-group">
					<label class="control-label pull-left">模型尺寸：</label>
					<div class="col-md-2 pull-left" style="padding-right: 5px">
						<input type="text" class="form-control" id="inputModelLength"
							placeholder="Model Length">
					</div>
					<span class="control-label pull-left">长（毫米）</span>
					<div class="col-md-2 pull-left" style="padding-right: 5px">
						<input type="text" class="form-control" id="inputModelWidth"
							placeholder="Model Width">
					</div>
					<span class="control-label pull-left">宽（毫米）</span>
					<div class="col-md-2 pull-left" style="padding-right: 5px">
						<input type="text" class="form-control" id="inputModelHeight"
							placeholder="Model Height">
					</div>
					<span class="control-label pull-left">高（毫米）</span>
				</div>

				<div class="form-group">
					<label class="control-label pull-left">模型预览图片（最多4张）：</label>
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
				<div class="col-md-3">
					<a class="thumbnail center-block"> <img />
					</a>
				</div>
				<input id="uploadImageInput" type="file" style="display: none" />
			</form>
		</div>
	</div>
</body>
</html>