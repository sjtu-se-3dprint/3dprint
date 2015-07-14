var user = null;

$(function() {

	// 请求用户信息
	$.ajax({
		url : ContextPath + '/user/myInfo.ajax',
		type : 'post',
		dataType : 'json',
		contentType : 'application/json',
		data : JSON.stringify({}),
		success : function(res) {
			if (res && res.success) {

				// 储存用户信息
				user = res.value;

				// 显示用户头像
				initUserHead();

				// 显示用户信息
				initUserInfo();

				// 绑定修改头像tab中选择图片按钮事件
				bindModifyUserheadButton();
				
				// 绑定修改密码按钮事件
				bindModifyPasswordButton();

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

// 显示用户头像、头像下的用户名
function initUserHead() {

	$('#usernameText').html(user.name)

	$("<img/>").load(function() {
		$('#headimage').attr('src', ContextPath + '/image/userhead/' + user.user_id + '/large.png' + '?' + new Date().getTime());
	}).error(function() {
		console.log("error loading image");
	}).attr("src", ContextPath + '/image/userhead/' + user.user_id + '/large.png');
}

// 显示用户信息
function initUserInfo() {
	$('#inputUsername').val(user.name);
	$('#inputTelephone').val(user.telephone);
	$('#inputEmail').val(user.email);
	$('#inputQQ').val(user.qq);
	$('#modifyInfoBtn').unbind('click').bind('click', modifyUserInfo);
}

// 修改用户信息
function modifyUserInfo() {
	$.ajax({
		url : ContextPath + '/user/modifyInfo.ajax',
		type : 'post',
		dataType : 'json',
		contentType : 'application/json',
		data : JSON.stringify({
			telephone : $('#inputTelephone').val(),
			email : $('#inputEmail').val(),
			qq : $('#inputQQ').val()
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

function bindModifyUserheadButton() {
	$('#headimageSelectBtn').unbind('click').bind('click', function() {
		$('#headimageSelecter').click();
	});

	$('#headimageSubmitBtn').unbind('click').bind('click', function() {
		submitUserheadImage();
	});

	$('#headimageCancelBtn').unbind('click').bind('click', function() {
		cancelUserheadImage();
	});
}

// 初始化canvas
function initUserheadCanvas(img) {

	var theCanvas = document.getElementById('theCanvas');
	var context = theCanvas.getContext('2d');

	var length = parseInt(theCanvas.style.width);
	var max = img.width > img.height ? img.width : img.height;
	var ratio = length / max;
	var width = parseInt(img.width * ratio);
	var height = parseInt(img.height * ratio);
	var originX = parseInt((length - width) / 2);
	var originY = parseInt((length - height) / 2);

	context.clearRect(-1, -1, length + 2, length + 2);
	context.drawImage(img, originX, originY, width, height);

	var min = width < height ? width : height;

	var left = -30 - length + originX;
	var right = -30 - originX - 1;
	var top = originY;
	var bottom = length - originY - 1;
	var filter = $('#headimageFilter');
	filter.css('width', min).css('height', min);
	filter.css('left', -30 - length + originX).css('top', originY);
	new Drag("headimageFilter", "headimageFilter", {
		area : {
			left : left,
			right : right,
			top : top,
			bottom : bottom
		}
	}, drag)
	$('#headimageFilter').show();

	drag();
}

// 拖动过滤器时的回调（由Drag对象回调），根据过滤器的位置、大小，绘制图像到三个canvas中
function drag() {

	var theCanvas = document.getElementById('theCanvas');
	var length = parseInt(theCanvas.style.width);

	var filter = $('#headimageFilter');
	var left = parseInt(filter.css('left')) + length + 30;
	var top = parseInt(filter.css('top'));
	var width = parseInt(filter.css('width'));
	var height = parseInt(filter.css('height'));

	var largeCanvas = document.getElementById('headimageLarge');
	var midCanvas = document.getElementById('headimageMid');
	var smallCanvas = document.getElementById('headimageSmall');
	
	drawScaledCanvas(theCanvas, left, top, width, height, largeCanvas);
	drawScaledCanvas(largeCanvas, 0, 0, largeCanvas.width, largeCanvas.height,
			midCanvas);
	drawScaledCanvas(midCanvas, 0, 0, midCanvas.width, midCanvas.height,
			smallCanvas);
}

// 把oldCanvas中的一个矩形部分重绘到newCanvas里面
function drawScaledCanvas(oldCanvas, left, top, width, height, newCanvas) {
	var context = newCanvas.getContext('2d');
	context.clearRect(-1, -1, parseInt(newCanvas.style.width)+2, parseInt(newCanvas.style.height)+2);
	context.drawImage(oldCanvas, left, top, width, height, 0, 0,
			parseInt(newCanvas.style.width), parseInt(newCanvas.style.height));
}

function cancelUserheadImage(){
	var theCanvas = document.getElementById('theCanvas');
	var context = theCanvas.getContext('2d');
	var length = parseInt(theCanvas.style.width);
	context.clearRect(-1, -1, length + 2, length + 2);
	drag();
	$('#headimageBtnGroup').addClass('hidden');
	$('#headimageFilter').hide();
	$('#headimageSelecter').val('');
}

// 提交用户头像
function submitUserheadImage() {
	
	// 把canvas转成base64格式的字符串
	var largeCanvas = document.getElementById('headimageLarge');
	var midCanvas = document.getElementById('headimageMid');
	var smallCanvas = document.getElementById('headimageSmall');
	var largeImg = largeCanvas.toDataURL();
	var midImg = midCanvas.toDataURL();
	var smallImg = smallCanvas.toDataURL();

	// 提交图像数据
	$.ajax({
		url : ContextPath + '/user/modifyUserhead.ajax',
		type : 'post',
		dataType : 'json',
		contentType : 'application/json',
		data : JSON.stringify({
			largeImg : largeImg,
			midImg : midImg,
			smallImg : smallImg
		}),
		success : function(res) {
			if(res && res.success){
				window.location.href = ''; // 刷新页面
			}else if(res){
				alert(res.message);
			}
		},
		error : function() {
			alert("Error");
		}
	});
}

// 从本地选择了一个文件
function selectUserhead(file) {

	if (!file.files || !file.files[0]) {
		return;
	}
	var file = file.files[0];

	// 格式不支持
	var type = file.type;
	if (type != 'image/jpeg' && type != 'image/gif' && type != 'image/png') {
		alert('你选择的文件格式不支持，请重新选择！');
		return;
	}

	// 文件太大
	var size = file.size;
	if (size > 5 * 1024 * 1024) {
		alert('你选择的文件太大，请重新选择！');
		return;
	}

	var img = new Image();
	img.onload = function() { // 加载图片完成，初始化canvas
		initUserheadCanvas(img);

		$('#headimageBtnGroup').removeClass('hidden');
	}

	var reader = new FileReader();
	reader.onload = function(evt) { // 读取文件完成，加载图片
		img.src = evt.target.result;
	};

	// 读取文件
	reader.readAsDataURL(file);
}

// 绑定修改密码按钮事件
function bindModifyPasswordButton(){
	$('#modifyPasswordBtn').unbind('click').bind('click', modifyPassword);
}

// 修改用户密码
function modifyPassword(){
	var oldPassword = $('#inputOldPassword').val();
	var newPassword = $('#inputNewPassword').val();
	var confirmPassword = $('#inputConfirmPassword').val();
	if(oldPassword == ''){
		alert('请填写原密码！');
		return;
	}
	if(newPassword.length < 5){
		alert('新密码最少需要5位！');
		return;
	}
	if(newPassword != confirmPassword){
		alert('两次密码不一致！');
		return;
	}
	if(oldPassword == newPassword){
		alert('新密码不能与原密码相同！');
		return;
	}
	
	$.ajax({
		url : ContextPath + '/user/modifyPassword.ajax',
		type : 'post',
		dataType : 'json',
		contentType : 'application/json',
		data : JSON.stringify({
			oldPassword: oldPassword,
			newPassword: newPassword
		}),
		success : function(res) {
			if (res && res.success) {
				$('#inputOldPassword').val('');
				$('#inputNewPassword').val('');
				$('#inputConfirmPassword').val('');
				alert('修改密码成功！');
			}else if(res){
				alert(res.message);
			}
		},
		error : function(){
			alert('未知错误');
		}
	});
}