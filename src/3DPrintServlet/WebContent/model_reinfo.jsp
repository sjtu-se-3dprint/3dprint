<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="entity.*, service.GetLoginUserService" %>
<%@ page import="database.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>3D打印创作服务平台-在线定制</title>
</head>
<body>
	<jsp:include page="header.jsp" flush="true"></jsp:include>
	
	<%
		User user = GetLoginUserService.service(request);
		if(user == null){
			return;
		}
		String modelIDStr = request.getParameter("modelID");
		int modelID = -1;
		try{
			modelID = Integer.parseInt(modelIDStr);
		}catch(Exception e){
			return;
		}
		Model model = ModelService.getModelService().searchModelByID(modelID);
		if(model == null || !"normal".equals(model.getStatus())){
			return;
		}
	%>
    <div class="container-fluid">
        <div class="container">
            <div class="row-fluid">
                <div class="span12">
                    <h3>模型信息编辑</h3>
                    <div class="row-fluid">
                        <div class="span4">
                            <h4 style="margin-top:50px;margin-left:20px;">需要修改模型文件请上传</h4>
                            <input type='file' single style='margin-left:20px' onchange="selectModelfile(this);">
                        </div>
                        <div class="span8">
                            <h3>模型上传须知</h3>
                            <h5>1.最大尺寸：64Mb或1000000个多边形</h5>
                            <h5>2.需要的文件格式：stl</h5>
                            <h5>3.贴图纹理格式：jpg,png</h5>
                            <h5>4.权限设置：默为不可见，请至个人中心修改</h5>
                        </div>
                    </div>
                    <div class="row-fluid" >
                        <div class="span6">
                            <div class="row-fluid">
                                <div class="span12">
                                    <h3>
                                        1.模型名称
                                        <input type='text' id="modelname" value="<%=model.getName()%>">
                                    </h3>
                                </div>
                            </div>
                            <div class="row-fluid">
                                <div class="span12">
                                    <h3> 2.模型规格 </h3>
                                    <div class="row-fluid">
                                        <div class="span3">
                                        </div>
                                        <div class="span9">
                                            <ul  style='margin-left:20%'>
                                                长：<input type='text' style='width:60px;margin-top:20px;' id="modellength" value="<%=model.getLength()%>"/>
                                            </ul>
                                            <ul  style='margin-left:20%'>
                                                宽：<input type='text' style='width:60px' id="modelwidth" value="<%=model.getWidth()%>"/>
                                            </ul>
                                            <ul  style='margin-left:20%'>
                                                高：<input type='text' style='width:60px' id="modelheight" value="<%=model.getHeight()%>"/>
                                            </ul>
                                            <ul style='font-size:16px;'>
                                                <input type='radio' name='单位' checked/>毫米
                                                <input type='radio' name='单位' disabled/>厘米
                                                <input type='radio' name='单位' disabled/>英寸
                                            </ul>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="row-fluid">
                                <div class="span12">
                                    <h3>
                                        3.添加图片(最多六张)
                                    </h3>
                                    <div class="row-fluid">
                                        <div class="span9" style='height:220px'>
                                            <input type='file' multiple id='file' onChange="selectImage(this);">
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="row-fluid">
                                <div class="span12">
                                    <h3>
                                        4.添加模型描述和说明
                                    </h3>
                                    <input type='text' style='width:300px;height:30px;' id='modeldescription' value="<%=model.getDescriptrion()%>"/>
                                </div>
                            </div>
                            <div class="row-fluid">
                                <div class="span12">
                                    <h3>
                                        5.添加类型
                                    </h3>
                                    <li>
                                        <select name="模型标签" id="modelstyle" >
                                            <option value="<%=model.getStyle() %>"><%=model.getStyle() %></option>
                                            <option value="时尚">时尚</option>
                                            <option value="简约">简约</option>
                                            <option value="实用">实用</option>
                                            <option value="精细">精细</option>
                                            <option value="高强度">高强度</option>
                                        </select>
                                    </li>
                                </div>
                            </div>
                        </div>
                        <div class="span6">
                            <h3>
                                                                 视图预览
                            </h3>
                            <div class="row-fluid">
                                <div class="span12">
                                    <li style='margin-top:50px;list-style-type:none'>
                                       	<img id='i1' src="<%=model.getImageNumber()>0?"modelimage?modelID=" + model.getId() + "&number=1":"" %>" width="160"/>
                                       	<button id='b1' style="visibility:hidden" onclick="deleteImage(1);">删除</button>
                                       	<img id='i2' src="<%=model.getImageNumber()>1?"modelimage?modelID=" + model.getId() + "&number=2":"" %>" width="160" style='margin-left:25px'/>
                                       	<button id='b2' style="visibility:hidden" onclick="deleteImage(2);">删除</button>
                                    </li>
                                    <li style='margin-top:50px;list-style-type:none'>
                                        <img id='i3' src="<%=model.getImageNumber()>2?"modelimage?modelID=" + model.getId() + "&number=3":"" %>" width="160"/>
                                        <button id='b3' style="visibility:hidden" onclick="deleteImage(3);">删除</button>
                                       	<img id='i4' src="<%=model.getImageNumber()>3?"modelimage?modelID=" + model.getId() + "&number=4":"" %>" width="160" style='margin-left:25px'/>
                                       	<button id='b4' style="visibility:hidden" onclick="deleteImage(4);">删除</button>
                                    </li>
                                    <li style='margin-top:50px;list-style-type:none'>
                                        <img id='i5' src="<%=model.getImageNumber()>4?"modelimage?modelID=" + model.getId() + "&number=5":"" %>" width="160"/>
                                        <button id='b5' style="visibility:hidden" onclick="deleteImage(5);">删除</button>
                                       	<img id='i6' src="<%=model.getImageNumber()>5?"modelimage?modelID=" + model.getId() + "&number=6":"" %>" width="160" style='margin-left:25px'/>
                                       	<button id='b6' style="visibility:hidden" onclick="deleteImage(6);">删除</button>
                                    </li>
                                </div>
                            </div> 
                        </div>
                    </div>
                    <button class="btn btn-success btn-large" type="button" style='margin-top:20px;margin-left:420px' onclick="upload();">提交信息</button>
                </div>
            </div>
        </div>
    </div>
	<jsp:include page="footer.jsp" flush="true"></jsp:include>
	<script>
		var modelID = <%=model.getId()%>;
		

		var modelfileChanged = false;
		var modelfileOK = true;
		var modelfile = null;
		function selectModelfile(file){
			
			modelfileOK = false;
			var stlfile = null;
			if(file.files && file.files[0]){
				stlfile = file.files[0];
			}else{
				alert('选择模型文件失败');
				return;
			}

			if(stlfile.name.indexOf('.stl') != stlfile.name.length-4){
				alert('只能上传后缀为.stl的模型文件。');
				return;
			}

			if(stlfile.size > 1024*1024){
				alert('只能上传<1MB的文件。');
				return;
			}

			var reader = new FileReader();
			reader.onload = function(evt){
				var src = evt.target.result;
				modelfile = src;
				modelfileOK = true;
			};
			reader.readAsDataURL(stlfile);
		}

		var oldImageNumber = <%=model.getImageNumber() %>;
		var oldImagefiles = new Array();
		for(var i=0; i<oldImageNumber; i++){
			var btn = document.getElementById('b' + (i+1));
			btn.style.visibility = 'visible';
			oldImagefiles[i] = i+1;
		}

		var imageNumber = 0;
		var imagefiles = new Array();
		function selectImage(file){
			if(oldImageNumber + imageNumber >= 6){
				alert('模型图片不能超过6张。');
				return;
			}

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
				document.getElementById('i' + (oldImageNumber+imageNumber+1)).src = src;
				imagefiles[imageNumber] = src;
				imageNumber++;
				var btn = document.getElementById('b' + (oldImageNumber+imageNumber));
				btn.style.visibility = 'visible';
			};
			reader.readAsDataURL(imagefile);
		}

		function deleteImage(num){
			if(num >= 1 && num <= oldImageNumber){
				for(var i=num-1; i<oldImageNumber; i++){
					oldImagefiles[i] = oldImagefiles[i+1];
				}
				oldImageNumber--;
			}else if(num > oldImageNumber && num <= oldImageNumber+imageNumber){
				for(var i=num-oldImageNumber; i<imageNumber; i++){
					imagefiles[i] = imagefiles[i+1];
				}
				imageNumber--;
			}
			var n = 0; 
			for(var i=0; i<oldImageNumber; i++){
				var img = document.getElementById('i' + (n+1));
				img.src = 'modelimage?modelID=' + modelID + '&number=' + oldImagefiles[i];
				n++;
			}
			for(var i=0; i<imageNumber; i++){
				var img = document.getElementById('i' + (n+1));
				img.src = imagefiles[i];
				n++;
			}
			for(var i=n; i<=6; i++){
				var btn = document.getElementById('b' + (n+1));
				var img = document.getElementById('i' + (n+1));
				img.src = '';
				btn.style.visibility = 'hidden';
			}
		}

		function upload(){
			if(!modelfileOK){
				alert('请上传正确的模型附件。');
				return;
			}

			var modelname = document.getElementById('modelname').value;
			if(modelname.length == 0){
				alert('请输入模型名称。');
				return;
			}

			var modellength = document.getElementById('modellength').value;
			var modelwidth = document.getElementById('modelwidth').value;
			var modelheight = document.getElementById('modelheight').value;
			if(modellength.length == 0 || modelwidth.length == 0 || modelheight.length == 0){
				alert('请输入模型规格。');
				return;
			}

			if(oldImageNumber+imageNumber < 1 ){
				alert('请上传至少1张图片。');
				return;
			}

			var modeldescription = document.getElementById('modeldescription').value;
			if(modeldescription == ''){
				alert('请添加模型描述与说明。');
				return;
			}

			var modelstyle = document.getElementById('modelstyle').value;

			console.log('modelname:' + modelname);
			console.log('size:' + modellength + 'x' + modelwidth + 'x' + modelheight);
			console.log('imagenumber:' + imageNumber);
			console.log('style:' + modelstyle);

			var imagesStr = '';
			for(var i=0; i<imageNumber; i++){
				imagesStr += imagefiles[i];
				imagesStr += '\r\n';
			}

			var oldImagesStr = '';
			for(var i=0; i<oldImageNumber; i++){
				oldImagesStr += oldImagefiles[i];
				oldImagesStr += '\r\n';
			}

			console.log("imagesStr:"+imagesStr); 
			console.log("oldImagesStr:"+oldImagesStr); 
			
			$.ajax({
				type:'POST',
				url: 'ajax/modifymodel',
				data: {modelID:modelID, modelfile: modelfile, modelname:modelname, length:modellength,
					width:modelwidth, height:modelheight, imagenumber:imageNumber, imagefiles:imagesStr,
					style: modelstyle, description:modeldescription, oldimagefiles:oldImagesStr},
				async: false,
				dataType: 'json',
				success: function(data){
					if(data.success){
						alert('修改模型成功。');
						<%
							if("user".equals(user.getAuthority())){
						%>
						location = 'user_model.jsp';
						<%
							}else if("manager".equals(user.getAuthority())){
						%>
						location = 'ma_model.jsp';
						<%		
							}
						%>
					}else{
						alert('修改失败。');
					}
				},
				error: function(err){
					alert('网络故障');
				}
			});
		}
	</script>
</body>
</html>