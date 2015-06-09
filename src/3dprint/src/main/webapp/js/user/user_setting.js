var user = null;

$(function() {

	// 请求用户信息
	$.ajax({
		url : ContextPath + '/user/myInfo',
		type : 'post',
		dataType : 'json',
		contentType : 'application/json',
		data : JSON.stringify({}),
		success : function(res) {
			if (res && res.success) {

				user = res.value;

				initUserHead();

				initUserInfo();

			} else if (res) {
				alert(res.message);
			} else {
				alert('服务器异常！');
			}
		},
		error : function(err) {
			alert('未知错误');
		}
	});
})

function initUserHead() {

	$('#usernameText').html(user.name)

	$("<img/>").load(function() {

	}).error(function() {
		console.log("error loading image");
	}).attr("src", '...');
}

function initUserInfo() {
	$('#inputUsername').val(user.name);
	$('#inputTelephone').val(user.telephone);
	$('#inputEmail').val(user.email);
	$('#inputQQ').val(user.qq);
	$('#modifyInfoBtn').unbind('click').bind('click', modifyUserInfo);
}

function modifyUserInfo() {
	$.ajax({
		url : ContextPath + '/user/modifyInfo',
		type : 'post',
		dataType : 'json',
		contentType : 'application/json',
		data : JSON.stringify({
			telephone : $('#inputTelephone').val(),
			email: $('#inputEmail').val(),
			qq: $('#inputQQ').val()
		}),
		success : function(res) {
			if (res && res.success) {
				window.location.href = '';
			} else if (res) {
				alert(res.message);
			} else {
				alert('服务器异常！');
			}
		},
		error : function(err) {
			alert('未知错误');
		}
	});
}