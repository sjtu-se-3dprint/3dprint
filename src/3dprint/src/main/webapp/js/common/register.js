var config = {
	usernameLength : 5,
	passwordLength : 6
};
var usernameValid; // 记录用户输入的用户名是否可用
var passwordValid; // 记录用户输入的密码是否符合格式

$(function() {
	$('#inputUsername').focus();
	$('#inputUsername').blur(isUsernameValid);
	$('#inputPassword').blur(isPasswordValid);
	$('#inputConfirm').blur(isConfirmValid);
	$('#inputPassword').focus(confirmValidReset);
	$('#registerBtn').click(submitRegister);

	$('#inputUsername').keydown(inputEnter);
	$('#inputPassword').keydown(inputEnter);
	$('#inputConfirm').keydown(inputEnter);
});

function inputEnter(e){
	if(e.which == 13){
		submitRegister();
	}
}

function isUsernameValid() {
	usernameValid = 'error';
	var errorMessage = '';
	var username = $('#inputUsername').val();
	if (username == '') {
		errorMessage = '用户名不能为空';
	} else if (username.length < config.usernameLength) {
		errorMessage = '用户名至少需要' + config.usernameLength + '位';
	} else {
		usernameValid = 'waiting';
		errorMessage = '正在查询...';
		usernameValidAjax(username);
	}
	valid(usernameValid, '#inputUsername', errorMessage);
}

function isPasswordValid() {
	passwordValid = 'error';
	var errorMessage = '';
	var password = $('#inputPassword').val();
	if (password == '') {
		errorMessage = '密码不能为空';
	} else if (password.length < config.passwordLength) {
		errorMessage = '密码至少需要' + config.passwordLength + '位';
	} else {
		passwordValid = 'success';
	}
	valid(passwordValid, '#inputPassword', errorMessage);
	if(passwordValid == 'success' && $('#inputConfirm').val()!='' && $('#inputPassword').val() != $('#inputConfirm').val()){
		isConfirmValid();
	}
}

function isConfirmValid() {
	// 如果密码格式不对，那么直接不对比两次密码
	if (passwordValid != 'success') {
		return;
	}
	var password = $('#inputPassword').val();
	var confirm = $('#inputConfirm').val();
	if (confirm == password) {
		valid('success', '#inputConfirm');
	} else {
		valid('error', '#inputConfirm', '两次输入密码不一致');
	}
}

function confirmValidReset() {
	valid('waiting', '#inputConfirm', '');
}

function usernameValidAjax(username) {
	$.ajax({
		url : '../common/usernameValid',
		type : 'post',
		dataType : 'json',
		contentType : 'application/json',
		data : JSON.stringify({
			name : username
		}),
		success : function(res) {
			if (res && res.success) {
				if (res.value) {
					usernameValid = 'success';
					valid(usernameValid, '#inputUsername');
				} else {
					usernameValid = 'error';
					valid(usernameValid, '#inputUsername', '用户名"' + username
							+ '"已经被占用');
				}
			} else if (res) {
				alert(res.message);
			}
		},
		error : function(err) {
			alert('未知错误');
		}
	});
}

function valid(isValid, id, message) {
	if (isValid == 'success') { // 可用
		$(id + 'Group').addClass('has-success');
		$(id + 'Group').removeClass('has-error');
		$(id + 'Group').addClass('has-feedback');
		$(id + 'Success').removeClass('hidden');
		$(id + 'Error').addClass('hidden');
		$(id + 'Message').addClass('hidden');
	} else if (isValid == 'error') { // 不可用
		$(id + 'Group').removeClass('has-success');
		$(id + 'Group').addClass('has-error');
		$(id + 'Group').addClass('has-feedback');
		$(id + 'Success').addClass('hidden');
		$(id + 'Error').removeClass('hidden');
		$(id + 'Message').removeClass('hidden');
		$(id + 'Message').html(message);
	} else if (isValid == 'waiting') { // 等待服务器验证
		$(id + 'Group').removeClass('has-success');
		$(id + 'Group').removeClass('has-error');
		$(id + 'Group').removeClass('has-feedback');
		$(id + 'Success').addClass('hidden');
		$(id + 'Error').addClass('hidden');
		$(id + 'Message').html(message);
	}
}

function submitRegister() {
	var success = true;
	if (usernameValid != 'success') {
		success = false;
		isUsernameValid();
	}
	if (passwordValid != 'success') {
		success = false;
		isPasswordValid();
	} else if ($('#inputPassword').val() != $('#inputConfirm').val()) {
		success = false;
		isConfirmValid();
	}
	if (!success) {
		return;
	}

	$.ajax({
		url : '../common/register',
		type : 'post',
		dataType : 'json',
		contentType : 'application/json',
		data : JSON.stringify({
			name : $('#inputUsername').val(),
			password : $('#inputPassword').val()
		}),
		success : function(res) {
			if (res && res.success) {
				alert('注册成功！');
				window.location.href = 'login';
			} else if (res) {
				alert(res.message);
			}
		},
		error : function(err) {
			alert('未知错误');
		}
	});

}