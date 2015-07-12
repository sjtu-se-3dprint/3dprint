<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="service.GetLoginUserService,entity.*, database.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; ">
<title>3D打印创作服务平台-admin中心</title>
</head>
<body>
	<jsp:include page="header.jsp" flush="true"></jsp:include>
	<%
		User user = GetLoginUserService.service(request);
		if(user == null || !"admin".equals(user.getAuthority())){
			return;
		}
	%>
    <div class="container-fluid">
        <div class="row-fluid">
            <div class="span12">
                <div class="row-fluid">

                    <div class="span2">
                        <hr>
                        <div class="row-fluid">
                            <div class="span12">
                                <div class="col-xs-3" id="myScrollspy">
                                    <img alt="user_pic" src="./img/users/user2.jpg" class="img-polaroid" />
                                    <div class="span12">
                                        <br>
                                        <span>
                                            &nbsp;&nbsp;你 好，</span>
                                        <span>
                                            <%=user.getName()%>！
                                        </span>
                                        <br>
                                        <br>
                                    </div>
                                    <ul class="nav nav-tabs nav-stacked" data-spy="affix" data-offset-top="125" >
                                        <li><a href="admin.jsp" >个人设置</a></li>
                                        <li><a href="ad_user.jsp" >用户管理</a></li>
                                        <li><a href="ad_comment.jsp">评论管理</a></li>
                                        <li><a href="ad_forum.jsp">论坛管理</a></li>
                                        <li  class="active"><a href="ad_addlesson.jsp">发布教程</a></li>
                                    </ul>
                                </div>
                            </div>
                        </div>

                    </div>

                    <div class="span10">
                        <hr>
                        <div class="tabbable">
                            <ul class="nav nav-tabs">
                                <li class="active">
                                    <a href="#panel-819612" data-toggle="tab">发布教程</a>
                                </li>
                            </ul>
                            <div class="tab-content">
                                <div class="tab-pane active" id="panel-819612">
                                    <div class="container">
                                    	<input class="btn btn-info" type="button" value="添加段落" onclick="add_passage();">
                                    	<input class="btn btn-info" type="button" value="添加图片" onclick="add_image();">
                                    	<input class="btn btn-info" type="button" value="添加视频" onclick="add_video();">
                                    	<input class="btn btn-info" type="file" value="上传图片" style="display:none" id="file_upload" onchange="add_img_callback(this);">
                                    </div>
                                    <div class="container" id="lesson_content" style="padding-top:10px;">
                                    	<div>
                                    		教程标题：<input type="text" id="lesson_title" style="width:80%">
                                    	</div>
                                    </div>
                                    <div style="margin:0 auto; text-align:center">
                                    	<input class="btn btn-primary" type="button" value="提交教程" onclick="submit_lesson();">
                                    </div>
                                </div>
                            </div>
                        </div>

                    </div>
                </div>
            </div>
        </div>
    </div>
	<jsp:include page="footer.jsp" flush="true"></jsp:include>
	<script>
		function submit_lesson(){
			
			var title = $('#lesson_title').val();
			if(title == ''){
				alert('请输入教程标题');
				return;
			}
			
			var new_arr = new Array();
			var new_seq = 0;
			for(var i=0; i<seq; i++){
				var o = arr[i];
				if(o.type == 'txt'){
					if(!$('#' + i).val()==''){
						o.txt = $('#' + i).val();
						new_arr[new_seq++] = o;
					}
				}else{
					new_arr[new_seq++] = o;
				}
			}
			
			if(new_seq <= 0){
				alert('请输入教程内容');
				return;
			}
			
			var lesson = new Object();
			lesson.title = title;
			lesson.content = new_arr;
			console.log(lesson);
			console.log(JSON.stringify(lesson));
		 	$.ajax({
				type : "POST",
				url : "ajax/addlesson",
				dataType : "json",
				contentType : "application/json",
				data : JSON.stringify(lesson),
				success : function(data) {
					alert('ok:'+data)
				},
				error : function(e) {
					console.log('请先登录');
				}
			}); 
			console.log(JSON.stringify(new_arr));
		}
	
		var arr = new Array();
		var seq = 0;
		function getSeq(){
			return seq++;
		}
		function add_passage(){
			var o = new Object();
			arr[seq] = o;
			o.type = 'txt';
			o.id = getSeq() + '';
			var content = '<textarea rows="5" style="width:80%" id="' + o.id + '"></textarea><br><br>';
			$('#lesson_content').append(content);
		}
		function add_video(){
			var url = prompt('请输入视频源地址：','http://');
			if(url == null){
				return;
			}
			var o = new Object();
			arr[seq] = o;
			o.type = 'video';
			o.id = getSeq() + '';
			o.url = url;
			var content = '<embed src="' + url + '"' +
                'type="application/x-shockwave-flash" allowfullscreen="true" width="600" height="400" quality="high" style="display: block;">';
			$('#lesson_content').append(content);
		}
		function add_image(){
			$('#file_upload').click();
		}
		function add_img_callback(file){
			var imagefile = null;
			if(file.files && file.files[0]){
				imagefile = file.files[0];
			}else{
				alert('选择图片失败。');
				return;
			}

			if(imagefile.size > 1024*1024){
				alert('只能上传<1MB的图片。');
				return;
			}
			
			var reader = new FileReader();
			reader.onload = function(evt){
				var src = evt.target.result;
				if(src.indexOf('data:image') != 0){
					alert('图片格式无法识别。');
					return;
				}
				var o = new Object();
				arr[seq] = o;
				o.type = 'img';
				o.id = getSeq() + '';
				o.src = src;
				var content = '<img src="' + src + '" id="' + o.id + '"/><br><br>';
				$('#lesson_content').append(content);
				//document.getElementById('i' + (imageNumber+1)).src = src;
				//imagefiles[imageNumber] = src;
			};
			reader.readAsDataURL(imagefile);
		}
	</script>
</body>
</html>