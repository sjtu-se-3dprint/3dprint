<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>3D打印创作服务平台-用户注册</title>
</head>
<body>
	<jsp:include page="header.jsp" flush="true"></jsp:include>
    <div class="container-fluid">
        <div class='container'>
            <div class="row-fluid">
                <div class="span12">
                    <div class="row-fluid">
                        <div class="span4">
                        </div>
                        <div class="span4">
                            <h3 style="text-align:center">3D打印平台注册</h3>
                            <div class="row-fluid">
                                <div class="span12">
                                    <li>
                                        用户名称
                                        <input id='User_name' type='text' onChange='name_test(this)'>               
                                        <button class='btn' onclick="userexist();">检测</button>
                                        <span id='test_result' style='color:red'></span>
                                    </li>
                                    <li>
                                        <form id="form1">输入密码:<input type="password" id="password1" onkeyup="pwStrength(this.value)" onblur="pwStrength(this.value)"> 
                                            <table cellpadding="1" bordercolordark="#fdfeff" bordercolorlight="#99ccff" cellspacing="1" style="width: 100px; display: inline; background-color: #e0f0ff;color:black"> 
                                                <tr> 
                                                    <td style='width:90px;'></td>
                                                    <td id="strength_L" style="width: 80px; height: 15px;" align="center"> 弱 </td> 
                                                    <td id="strength_M" style="width: 80px; height: 15px;" align="center"> 中 </td> 
                                                    <td id="strength_H" style="width: 80px; height: 15px;" align="center"> 强 </td> 
                                                </tr> 
                                            </table>
                                        </form>
                                        <span id='pwd_result' style='color:red'></span>       
                                    </li>
                                    <li>
                                        确认密码
                                        <input id='password2' type='password'>        
                                    </li>  
                                    <br />
                                </div>
                            </div>
                            <div class="row-fluid">
                                <div class="span12">
                                    <li class='reg_li2'>
                                        邮箱地址
                                        <input id='E-mail' type='text'>        
                                    </li>
                                    <li class='reg_li2'>
                                        手机号码
                                        <input id='Phone' type='text'>        
                                    </li>
                                    <br />
                                </div>
                            </div>
                            <div class="row-fluid">
                                <div class="span12" style='margin-top:80px; margin-left:100px' >
                                    <button class='btn' onClick="submit();" >提交</button>
                                </div>
                            </div>
                        </div>
                        <div class="span4">
                        </div>
                    </div>
                </div>
            </div>
        </div>
     </div>
     <script language="javascript" type="text/javascript"> 
       //CharMode函数 
       //测试某个字符是属于哪一类. 
       function CharMode(iN){ 
       if (iN>=48 && iN <=57) //数字 
       return 1; 
       if (iN>=65 && iN <=90) //大写字母 
       return 2; 
       if (iN>=97 && iN <=122) //小写 
       return 4; 
       else 
       return 8; //特殊字符 
       } 
       //bitTotal函数 
       //计算出当前密码当中一共有多少种模式 
       function bitTotal(num){ 
       modes=0; 
       for (i=0;i<4;i++){ 
       if (num & 1) modes++; 
       num>>>=1; 
       } 
       return modes; 
       } 
       //checkStrong函数 
       //返回密码的强度级别 
       function checkStrong(sPW){ 
       if (sPW.length<=4) 
       return 0; //密码太短 
       Modes=0; 
       for (i=0;i<sPW.length;i++){ 
       //测试每一个字符的类别并统计一共有多少种模式. 
       Modes|=CharMode(sPW.charCodeAt(i)); 
       } 
       return bitTotal(Modes); 
       } 
       //pwStrength函数 
       //当用户放开键盘或密码输入框失去焦点时,根据不同的级别显示不同的颜色 
       function pwStrength(pwd){ 
       O_color="#e0f0ff"; 
       L_color="#FF0000"; 
       M_color="#FF9900"; 
       H_color="#33CC00"; 
       if (pwd==null||pwd==''){ 
       Lcolor=Mcolor=Hcolor=O_color; 
       } 
       else 
       { 
       S_level=checkStrong(pwd); 
       //alert(S_level); 
       switch(S_level) 
       { 
       case 0: 
       Lcolor=Mcolor=Hcolor=O_color; 
       case 1: 
       Lcolor=L_color; 
       Mcolor=Hcolor=O_color; 
       break; 
       case 2: 
       Lcolor=Mcolor=M_color; 
       Hcolor=O_color; 
       break; 
       default: 
       Lcolor=Mcolor=Hcolor=H_color; 
       } 
       } 
       document.getElementById("strength_L").style.background=Lcolor; 
       document.getElementById("strength_M").style.background=Mcolor; 
       document.getElementById("strength_H").style.background=Hcolor; 

       var len=pwd.length;
       if(len<6 || len>20) 
           document.getElementById('pwd_result').innerHTML="请输入6-20位密码"
       else {
    	   document.getElementById('pwd_result').innerHTML="";
    	   for(i=0;i<len;i++){
               x=pwd[i];
               if((x<'0')||(x>'9'&&x<'A')||(x>'Z'&&x<'a')||(x>'z'))
                   document.getElementById("test_result").innerHTML="用户名中含有非法字符";
           }
       }
       return; 
       } 

       function name_test(obj){
           var name=obj.value;
           var len=name.length;
           if(len<6 || len>20) 
               document.getElementById("test_result").innerHTML="请输入6-20字节的用户名";
           else{
        	   document.getElementById("test_result").innerHTML='';
        	   if(name[0]=='_') document.getElementById("test_result").innerHTML="不能以下划线开头";
               for(i=0;i<len;i++){
                   x=name[i];
                   if(((x<'0')||(x>'9'&&x<'A')||(x>'Z'&&x<'a')||(x>'z'))&&x!='_')
                       document.getElementById("test_result").innerHTML="用户名中含有非法字符";
               }
           }
       }
   </script> 
	<jsp:include page="footer.jsp" flush="true"></jsp:include>
	
	<script>

		var userNameRecord;
		var userNameExist = true;
		/**
		 * 检查用户名是否已经存在。
		 * 用户点击检测时调用此函数。
		 */
		function userexist(){
			var userName = document.getElementById('User_name').value;
			userNameRecord = userName;
			$.ajax({
				type: 'GET',
				url: 'ajax/userexist',
				data: {userName: userName},
				dataType: 'json',
				async: false,
				success: function(data){
					userNameExist = data.exist;
					alert('用户名 "' + userName + '" ' + (!userNameExist?'可用' : '已存在') + '。');
				},
				error: function(err){
					alert('网络故障');
					console.log('ajax/userexist error.');
				}
			});
		}

		function register(userName, password, email, telephone){

			var userName = document.getElementById('User_name').value;
			var password = document.getElementById('password1').value;
			var email = document.getElementById('E-mail').value;
			var telephone = document.getElementById('Phone').value;
			console.log(userName);
			console.log(password);
			console.log(email);
			console.log(telephone);

			$.ajax({
				type: "GET",
				url: 'ajax/register',
				data: {userName: userName, password: password, email: email, telephone: telephone},
				dataType: 'json',
				async: false,
				success: function(data){
					if(data.success){
						alert('注册成功！');
						location = 'login.jsp';
					}else{
						alert('注册失败，该用户名已经被注册。');
					}
				},
				error: function(err){
					alert('网络故障');
				}
			});
		}

		/**
		 * 检查注册信息是否合法，然后进行注册。
		 * 用户点击提交时调用此函数。
		 */
		function submit(){

			if(!checkLegal()){
				return;
			}

			register();
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

			// 检查邮箱
			var checkEmailResult = checkEmail();
			if(checkEmailResult != 'OK'){
				alert(checkEmailResult);
				return false;
			}

			// 检查电话
			var checkTelephoneResult = checkTelephone();
			if(checkTelephoneResult != 'OK'){
				alert(checkTelephoneResult);
				return false;
			}

			// 检查验证码
			/*var checkIdentifyResult = checkIdentify();
			if(checkIdentifyResult != 'OK'){
				alert(checkIdentifyResult);
				return false;
			}*/

			// 检查是否勾上了同意网站声明
			/*var checkRuleResult = checkRule();
			if(checkRuleResult != 'OK'){
				alert(checkRuleResult);
				return false;
			}*/

			return true;
		}

		/**
		 * 用户名是否合法。
		 * 暂时只检查了用户名是否存在。还需要检查用户名的长度、字符集等。
		 */
		function checkUserName(){
			var userName = document.getElementById('User_name').value;
			if(userNameExist || userName != userNameRecord){
				return '用户名已经存在，或者未检查，请点击检测按钮检测。'
			}
			return 'OK';
		}

		/**
		 * 密码是否合法。
		 * 暂时只检查了密码是否一致，以及密码长度是否>=6。还需要检查密码的字符集等。
		 */
		function checkPassword(){
			var password1 = document.getElementById('password1').value;
			var password2 = document.getElementById('password2').value;
			if(password1 != password2){
				return '密码不一致';
			}
			if(password1.length == 0){
				return '密码不能为空';
			}
			if(password1.length < 6){
				return '密码太短';
			}
			return 'OK';
		}

		/**
		 * 邮箱是否合法。
		 * 暂时只检查了邮箱是否为空。还需要检查邮箱的格式。
		 */
		function checkEmail(){
			var email = document.getElementById('E-mail').value;
			if(email.length <= 0){
				return '邮箱不能为空';
			}
			return 'OK'
		}

		/**
		 * 电话是否合法。
		 * 暂时只检查了电话是否为空。还需要检查电话的格式。
		 */
		function checkTelephone(){
			var telephone = document.getElementById('Phone').value;
			if(telephone.length <= 0){
				return '手机号码不能为空';
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

		/**
		 * 是否已经同意网站声明。
		 */
		function checkRule(){
			var rule = document.getElementById('If_check').checked;
			if(!rule){
				return '必须同意网站声明才能注册';
			}
			return 'OK';
		}
	</script>
</body>
</html>