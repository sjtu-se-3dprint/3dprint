<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="entity.User, service.GetLoginUserService" %>
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
			out.println("<script>");
			out.println("alert('请先登录。')");
			out.println("</script>");
			return;
		}
	%>
    <div class="container-fluid">
       
            <div class="row-fluid">
                <div class="span12">
                    <ul class="breadcrumb" style='bgcolor=#000;'>
                    <li>
                        <a href="index.jsp">首页</a> <span class="divider">/</span>
                    </li>
                  
                   <li class='active'>
                 模型上传
                   </li>
                </ul>
                <div class='container'>
                    <h3>模型上传与信息完善</h3>
                    <div class="row-fluid">
                        <div class="span4">
                            <h4 style="margin-top:50px;margin-left:20px;">请选择要上传的模型文件</h4>
                            <h5>（目前仅支持英文文件名）</h5>
                            <input type='file' single style='margin-left:20px' onchange="selectModelfile(this);">
                        </div>
                        <div class="span8">
                            <h3>模型上传须知</h3>
                            <h5>1.最大尺寸：1Mb或50000个多边形</h5>
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
                                        <input type='text' id="modelname">
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
                                                长：<input type='text' style='width:60px;margin-top:20px;' id="modellength"/>
                                            </ul>
                                            <ul  style='margin-left:20%'>
                                                宽：<input type='text' style='width:60px' id="modelwidth"/>
                                            </ul>
                                            <ul  style='margin-left:20%'>
                                                高：<input type='text' style='width:60px' id="modelheight"/>
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
                                            <table>
                                            <tbody>
                                                <tr>
                                                    <td><button class='btn' id='b1' onClick='del(1)' style='display: none'>删除</button></td>
                                                    <td><span id='f1'></span></td>
                                                </tr>
                                                <tr>
                                                    <td><button class='btn' id='b2' onClick='del(2)' style='display: none'>删除</button></td>
                                                    <td><span id='f2'></span></td>
                                                </tr>
                                                <tr>
                                                    <td><button class='btn' id='b3' onClick='del(3)' style='display: none'>删除</button></td>
                                                    <td><span id='f3'></span></td>
                                                </tr>
                                                <tr>
                                                    <td><button class='btn' id='b4' onClick='del(4)' style='display: none'>删除</button></td>
                                                    <td><span id='f4'></span></td>
                                                </tr>
                                                <tr>
                                                    <td><button class='btn' id='b5' onClick='del(5)' style='display: none'>删除</button></td>
                                                    <td><span id='f5'></span></td>
                                                </tr>
                                                <tr>
                                                    <td><button class='btn' id='b6' onClick='del(6)' style='display: none'>删除</button></td>
                                                    <td><span id='f6'></span></td>
                                            </tbody>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="row-fluid">
                                <div class="span12">
                                    <h3>
                                        4.添加模型描述和说明
                                    </h3>
                                    <input type='text' style='width:300px;height:30px;' id='modeldescription'/>
                                </div>
                            </div>
                            <div class="row-fluid">
                                <div class="span12">
                                    <h3>
                                        5.添加类型
                                    </h3>
                                    <li>
                                        <select name="模型标签" id="modelstyle">
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
                                        <img id='i1' src="" width="180"/>
                                        <img id='i2' src="" width="180" style='margin-left:40px'/>
                                    </li>
                                    <li style='margin-top:50px;list-style-type:none'>
                                        <img id='i3' src="" width="180"/>
                                        <img id='i4' src="" width="180" style='margin-left:40px'/>
                                    </li>
                                    <li style='margin-top:50px;list-style-type:none'>
                                        <img id='i5' src="" width="180"/>
                                        <img id='i6' src="" width="180" style='margin-left:40px'/>
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
	    var number=0;
	    function putfilename(){
		    var file=document.getElementById('file');
		    number=file.files.length;
		    if (number>6) alert('请最多上传6张图片')
		    else
		    for(i=1;i<=number;i++){
			    var ele="f"+i.toString();
			    var im="i"+i.toString();
			    var bu="b"+i.toString();
			    document.getElementById(bu).style.display="block";
			    var element=document.getElementById(ele)
			    element.innerHTML=file.files[i-1].name;
			    var image=document.getElementById(im);
			    var im_src=file.files[i-1].name;
			}
		}
		function del(num){
			var file=document.getElementById("file");
			for (i=num;i<number;i++){
				var thisele="f"+i.toString();
				var nextele="f"+(i+1).toString();
				thiselement=document.getElementById(thisele);
				nextelement=document.getElementById(nextele);
				thiselement.innerHTML=nextelement.innerHTML;
			}
			lastelement=document.getElementById("f"+number.toString());
			lastelement.innerHTML='';
			lastbutton=document.getElementById("b"+number.toString());
			lastbutton.style.display="none";

			number=number-1;
		}

		var modelfileOK = false;
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

		var imageNumber = 0;
		var imagefiles = new Array();
		function selectImage(file){
			if(imageNumber >= 6){
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
				document.getElementById('i' + (imageNumber+1)).src = src;
				imagefiles[imageNumber] = src;
				imageNumber++;
			};
			reader.readAsDataURL(imagefile);
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

			if(imageNumber < 1 ){
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
			
			$.ajax({
				type:'POST',
				url: 'ajax/uploadmodel',
				data: {modelfile: modelfile, modelname:modelname, length:modellength,
					width:modelwidth, height:modelheight, imagenumber:imageNumber, imagefiles:imagesStr,
					style: modelstyle, description:modeldescription},
				async: false,
				dataType: 'json',
				success: function(data){
					if(data.success){
						alert('上传成功。');
						location = 'user_model.jsp';
					}else{
						alert('上传失败。');
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