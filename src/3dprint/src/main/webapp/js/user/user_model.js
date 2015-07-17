
$(function() {

	getUserInfo(function(){
		
		// 显示用户头像
		initUserHead();

	});
	
	getUserModels(1, 9);
})

function getUserModels(page, amount){
	$.ajax({
		url : ContextPath + '/user/myModels.ajax',
		type : 'post',
		dataType : 'json',
		contentType : 'application/json',
		data : JSON.stringify({
			page: page,
			amount: amount
		}),
		success : function(res) {
			if (res && res.success) {

				console.log(res.value);
				
			} else if (res) {
				alert(res.message);
			}
		},
		error : function(err) {
			// alert('未知错误');
		}
	});
}