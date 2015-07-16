<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>

</head>
<script src="<%=request.getContextPath()%>/js/jquery-1.11.1.min.js"></script>
<body>

<jsp:include page="../common/header.jsp" flush="true"></jsp:include>
test 
模型1
<button id ="btntest" class = "btn btn-primary">添加收藏</button>
<button id ="btntest2" class = "btn btn-primary">添加收藏</button>
<script>
$(function() {		//initialization	
	$('#btntest').click(addCollection();		//点击注册时提交
	$('#btntest').click(removeCollection();		//点击注册时提交
});

function addCollection(){
$.ajax({
	url : ContextPath+'/user/addCollection.ajax',
	type : 'post',
	dataType : 'json',
	contentType : 'application/json',
	data : JSON.stringify({
		model_id : 28
	}),
	success : function(res) {
		if (res && res.success) {
			alert('收藏成功！');
			window.location.href = 'test.htm';
		} else if (res) {
			alert(res.message);
		}
	},
	error : function(err) {
		alert('未知错误');
	}
});
}
alert('test')
</script>
</body>
</html>