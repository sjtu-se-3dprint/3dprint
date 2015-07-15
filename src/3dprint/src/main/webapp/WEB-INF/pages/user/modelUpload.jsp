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

	<script type="text/javascript" charset="utf-8"
		src="<%=request.getContextPath()%>/ueditor1_4_3-utf8-jsp/ueditor.config.js"></script>
	<script type="text/javascript" charset="utf-8"
		src="<%=request.getContextPath()%>/ueditor1_4_3-utf8-jsp/ueditor.all.js"></script>

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

				<!-- 模型名称 -->
				<div class="form-group">
					<label for="inputModelName" class="control-label pull-left">模型名称：</label>
					<div class="col-md-10">
						<input type="text" class="form-control" id="inputModelName"
							placeholder="Model Name">
					</div>
				</div>

				<!-- 模型尺寸，模型类型 -->
				<div class="form-group">
					<label class="control-label pull-left">模型尺寸：</label>
					<div class="col-md-1 pull-left"
						style="padding-right: 5px; width: 100px">
						<input type="text" class="form-control" id="inputModelLength"
							placeholder="Length">
					</div>
					<span class="control-label pull-left">长（毫米）</span>
					<div class="col-md-1 pull-left"
						style="padding-right: 5px; width: 100px">
						<input type="text" class="form-control" id="inputModelWidth"
							placeholder="Width">
					</div>
					<span class="control-label pull-left">宽（毫米）</span>
					<div class="col-md-1 pull-left"
						style="padding-right: 5px; width: 100px">
						<input type="text" class="form-control" id="inputModelHeight"
							placeholder="Height">
					</div>
					<span class="control-label pull-left">高（毫米）</span> <label
						class="control-label pull-left" style="padding-left: 50px">模型类型：</label>
					<div class="col-md-2 pull-left" style="padding-right: 5px">
						<select id="modelTypeSelect" class="form-control pull-left"><option
								value="-1">请选择</option></select>
					</div>
				</div>

				<!-- 图片上传 -->
				<div class="form-group">
					<label class="control-label pull-left">模型预览图片（1~4张）：</label>
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

				<div class="form-group">
					<label class="control-label pull-left">模型详细描述：</label>
				</div>
				<div class="col-md-12">
					<script id="editor" type="text/plain" style="height: 300px;"></script>
					<script>
						var ue = UE.getEditor('editor');
					</script>
				</div>

				<div class="col-md-2 col-md-push-5">
					<button type="button" id="uploadModelBtn" class="btn btn-primary" style="margin-top:20px; margin-bottom:70px; width:100%">确认上传</button>
				</div>
			</form>
		</div>
	</div>
</body>
</html>