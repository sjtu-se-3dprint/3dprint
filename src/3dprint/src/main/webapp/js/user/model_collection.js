/**
 * 模型页面，关于模型收藏
 */

$(function() {		//initialization
	
	getCollectionCount();
	
	$.ajax({
			url : ContextPath+'/user/isCollection.ajax',
			type : 'post',
			dataType : 'json',
			contentType : 'application/json',
			data : JSON.stringify({
				model_id : 9 ,
				status:"normal"
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

function getCollectionCount(){
	$.ajax({
		url : ContextPath+'/user/getCollectionNum.ajax',
		type : 'post',
		dataType : 'json',
		contentType : 'application/json',
		data : JSON.stringify({
			model_id : 9
		}),
		success : function(res) {
			if (res && res.success) {
				$('#btncount').html(res.value);
			} else if (res) {
				alert(res.message);
			}
		},
		error : function(err) {
			alert('未知错误');
		}
		});

}
function addCollection(){	
$.ajax({
	url : ContextPath+'/user/addCollection.ajax',
	type : 'post',
	dataType : 'json',
	contentType : 'application/json',
	data : JSON.stringify({
		model_id : 9
	}),
	success : function(res) {
		if (res && res.success) {
			alert('收藏成功！');
			$('#btntest').html("取消收藏");
			$('#btntest').one("click",removeCollection);
			getCollectionCount();
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
			model_id : 9
		}),
		success : function(res) {
			if (res && res.success) {
				alert('取消成功！');
				$('#btntest').html("添加收藏");
				$('#btntest').one("click",addCollection);
				getCollectionCount();
			} else if (res) {
				alert(res.message);
			}
		},
		error : function(err) {
			alert('未知错误');
		}
	});
}


