/**
 * 
 */
$(function(){
	getModelAmountInCart();
});

function modifBtnHtml(amount){
    if(amount>0){
    	$('#btnCart').html("添加购物车("+amount+")");
    }
    else{
    	$('#btnCart').html("添加购物车");
    }
    return true;
}


function getModelAmountInCart(){
	$.ajax({
		url : ContextPath+'/user/getModelAmountInCart.ajax',
		type : 'post',
		dataType : 'json',
		contentType : 'application/json',
		data : JSON.stringify({
			model_id : 1
		}),
		success : function(res) {
			if (res && res.success) {
				//alert(res.value);
				modifBtnHtml(res.value);
				$('#btnCart').one("click",addModelInCart);
			} else if (res) {
				alert(res.message);
			}
		},
		error : function(err) {
			alert('未知错误');
		}
	});
}
function addModelInCart(){
	$.ajax({
		url : ContextPath+'/user/addModelInCart.ajax',
		type : 'post',
		dataType : 'json',
		contentType : 'application/json',
		data : JSON.stringify({
			model_id : 1
		}),
		success : function(res) {
			if (res && res.success) {
				alert('加入购物车成功！');
				getModelAmountInCart();
			} else if (res) {
				alert(res.message);
			}
		},
		error : function(err) {
			alert('未知错误');
		}
	});
}

//function addModelAmountInCart(){
//	$.ajax({
//		url : ContextPath+'/user/addModelAmountInCart.ajax',
//		type : 'post',
//		dataType : 'json',
//		contentType : 'application/json',
//		data : JSON.stringify({
//			model_id : 9
//		}),
//		success : function(res) {
//			if (res && res.success) {
//				alert(res.value);
//			} else if (res) {
//				alert(res.message);
//			}
//		},
//		error : function(err) {
//			alert('未知错误');
//		}
//	});
//}