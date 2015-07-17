var user = {};

// 获取用户自己的信息
function getUserInfo(callback) {
	$.ajax({
		url : ContextPath + '/user/myInfo.ajax',
		type : 'post',
		dataType : 'json',
		contentType : 'application/json',
		data : JSON.stringify({}),
		success : function(res) {
			if (res && res.success) {

				user = res.value;
				
				// 如果存在回调函数就回调
				callback && callback();
				
			} else if (res) {
				alert(res.message);
			}
		},
		error : function(err) {
			// alert('未知错误');
		}
	});
}

//显示用户头像、头像下的用户名
function initUserHead() {

	$('#usernameText').html(user.name)

	$("<img/>").load(function() {
		$('#headimage').attr('src', ContextPath + '/image/userhead/' + user.user_id + '/large.png' + '?' + new Date().getTime());
	}).error(function() {
		console.log("error loading image");
	}).attr("src", ContextPath + '/image/userhead/' + user.user_id + '/large.png');
}