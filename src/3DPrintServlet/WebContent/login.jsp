<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>3D打印创作服务平台-用户登录</title>
</head>
<body>
	<jsp:include page="header.jsp" flush="true"></jsp:include>
    <div class="reg">
        <div class="container-fluid">
            <div class='container'>
                <div class="row-fluid">
                    <div class="span4">
                    </div>
                    <div class="span4">
                        <h3 align="center"> 登    录</h3>
                        <div class="row-fluid">
                            <div class="span12">
                                <li class='reg_li2'>
                                    用户名
                                    <input id='User_name' type='text'>
                                </li>
                                <li class='reg_li2'>
                                    密码
                                    <input id='Password' type='password' style='margin-left:14px;'>         
                                </li>
                                <br />
                            </div>
                        </div>
                        <div class="row-fluid">
                            <div class="span12">
                                <button class='btn' onClick="submit()" style='height:35px;margin-left:130px'>登录</button>
                            </div>
                        </div>
                    </div>
                    <div class="span4">
                    </div>
                </div>
            </div>
        </div>
    </div>
	
	
	<script>

		/**
		 * 检查登录信息是否合法，然后进行登录。
		 * 用户点击登录时调用此函数。
		 */
		function submit(){
			
			if(!checkLegal()){
				return;
			}

			login();
		}

		function checkLegal(){
			
			// 检查用户名
			var checkUserNameResult = checkUserName();
			if(checkUserNameResult != 'OK'){
				alert(checkUserNameResult);
				return false;
			}

			// 检查密码
			var checkPasswordResult = checkPassword();
			if(checkPasswordResult != 'OK'){
				alert(checkPasswordResult);
				return false;
			}

			// 检查验证码
			var checkIdentifyResult = checkIdentify();
			if(checkIdentifyResult != 'OK'){
				alert(checkIdentifyResult);
				return false;
			}
			
			return true;
		}

		/**
		 * 用户名格式是否合法。
		 * 暂时只检查了是否为空。
		 */
		function checkUserName(){
			var userName = document.getElementById('User_name').value;
			if(userName.length == 0){
				return '用户名不能为空';
			}
			return 'OK';
		}

		/**
		 * 密码格式是否合法。
		 * 暂时只检查了是否为空。
		 */		
		function checkPassword(){
			var password = document.getElementById('Password').value;
			if(password.length == 0){
				return '密码不能为空';
			}
			return 'OK';
		}

		/**
		 * 验证码是否正确。
		 * 暂时默认为正确。
		 */
		function checkIdentify(){
			return 'OK';
		}
		
		function login(){
			var userName = document.getElementById('User_name').value;
			var password = document.getElementById('Password').value;
			console.log(userName);
			console.log(password);
			$.ajax({
				type: "GET",
				url: 'ajax/login',
				data: {userName: userName, password: password},
				dataType: 'json',
				async: false,
				success: function(data){
					console.log(data);
					if(data.success){
						//alert('登陆成功！');
						
						var lastpage = getQueryString('lastpage');
						if(data.authority == 'admin'){
							location = 'admin.jsp';
						}else if(data.authority == 'manager'){
							location = 'manager.jsp';
						}else if(data.authority == 'user'){
							if(lastpage==null){
								location = 'index.jsp';
							}else if(lastpage.indexOf('manager') != -1
									|| lastpage.indexOf('mg_') != -1){
								location = 'index.jsp';
							}else{
								location = lastpage;
							}
						}
					}else{
						alert('用户名或密码错误。');
					}
				},
				error: function(err){
					alert('网络故障');
				}
			});
		}

		function getQueryString(name) {
		    var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i");
		    var r = window.location.search.substr(1).match(reg);
		    if (r != null) return unescape(r[2]); return null;
		}
	</script>
</body>
</html>