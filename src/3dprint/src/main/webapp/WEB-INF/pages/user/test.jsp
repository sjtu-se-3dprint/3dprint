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
<button id ="btntest" class = "btn btn-primary"></button>
<button id = "haha" class = "btn btn-primary">被多少人收藏了</button>
<script>
$(function() {		//initialization
	$('#haha').click(getCollectionNum);
		$.ajax({
			url : ContextPath+'/user/isCollection.ajax',
			type : 'post',
			dataType : 'json',
			contentType : 'application/json',
			data : JSON.stringify({
				model_id : 4
			}),
			success : function(res) {
				if (res && res.success) {
					if(res.value){
						$('#btntest').html("tianjia收藏");
						$('#btntest').one("click",addCollection);
					    }else{	
							$('#btntest').html("quxiao收藏");
							$('#btntest').one("click",removeCollection);	
					    }			
					} else if (res) {
						alert(res.message);
				}
			},
			error : function(err) {
				alert('未知错误');
			}
		});

});

function addCollection(){	
$.ajax({
	url : ContextPath+'/user/addCollection.ajax',
	type : 'post',
	dataType : 'json',
	contentType : 'application/json',
	data : JSON.stringify({
		model_id : 4
	}),
	success : function(res) {
		if (res && res.success) {
			alert('收藏成功！');
			$('#btntest').html("取消收藏");
			$('#btntest').one("click",removeCollection);
		} else if (res) {
			alert(res.message);
		}
	},
	error : function(err) {
		alert('未知错误');
	}
});
}

function removeCollection(){
	$.ajax({
		url : ContextPath+'/user/removeCollection.ajax',
		type : 'post',
		dataType : 'json',
		contentType : 'application/json',
		data : JSON.stringify({
			model_id : 4
		}),
		success : function(res) {
			if (res && res.success) {
				alert('取消成功！');
				$('#btntest').html("添加收藏");
				$('#btntest').one("click",addCollection);
			} else if (res) {
				alert(res.message);
			}
		},
		error : function(err) {
			alert('未知错误');
		}
	});
}

function getCollectionNum(){
	$ajax({
		url : ContextPath+'/user/getCollectionNum.ajax',
		type : 'post',
		dataType : 'json',
		contentType : 'application/json',
		data : JSON.stringify({
			model_id : 4
		}),
		success : function(res) {
			if (res && res.success) {
				alert('res.value')			
				$('#haha').html("res.value");
			} else if (res) {
				alert(res.message);
			}
		},
		error : function(err) {
			alert('未知错误');
		}
		});
}
</script>
</body>
</html>