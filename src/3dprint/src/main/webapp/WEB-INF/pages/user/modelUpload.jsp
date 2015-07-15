<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>模型上传</title>
</head>
<body>
	<jsp:include page="../common/header.jsp" flush="true"></jsp:include>
	<script src="<%=request.getContextPath()%>/js/jquery.ui.widget.js"></script>
	<script src="<%=request.getContextPath()%>/js/jquery.fileupload.js"></script>
	<script src="<%=request.getContextPath()%>/js/user/model_upload.js"></script>

	<div class="container">
		<div class="row">
			<button id="selectFileBtn" class="btn btn-primary">选择模型文件</button><span id="selectFileHint" style="padding-left:10px">加载中：100%</span>
		</div>
		<div class="row" style="margin-top: 30px">
			<form id="upload" method="post" style="display:none"
				action="<%=request.getContextPath()%>/user/modelFileUpload.ajax"
				enctype="multipart/form-data">
				<input id="uploadInput" type="file"/>
			</form>
		</div>
	</div>
</body>
</html>