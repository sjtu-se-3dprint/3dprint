<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="service.GetLoginUserService" %>
<%@ page import="entity.*, database.*" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html;">
<title>3D打印创作服务平台-用户中心</title>
    <style>
        .bdiv{
            border: 1px solid #99bbbb;
            padding: 5px;
        }
    </style>
</head>
<body>
	<jsp:include page="header.jsp" flush="true"></jsp:include>
	<%
		User user = GetLoginUserService.service(request);
		if(user == null || !"user".equals(user.getAuthority())){
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
                                    <img alt="user_pic" src="userheadimage?userID=<%=user.getId() + "&random=" + Math.random() %>" class="img-polaroid" />
                                    <div class="span12">
                                        <br>
                                        <span>
                                            &nbsp;&nbsp;你 好，</span>
                                        <span>
                                            <%=user.getName() %>！
                                        </span>
                                        <br>
                                        <br>
                                    </div>
                                    <ul class="nav nav-tabs nav-stacked" data-spy="affix" data-offset-top="125" >
                                        <li><a href="./user.jsp" >个人设置</a></li>
                                        <li class="active"><a href="./user_model.jsp">我的模型</a></li>
                                        <li><a href="./user_shop.jsp">我的购物</a></li>
                                        <li><a href="./user_collect.jsp">我的收藏</a></li>

                                        <li><a href="./user_forum.jsp">我的帖子</a></li>
                                    </ul>
                                </div>
                            </div>
                        </div>

                    </div>

                    <div class="span10">
                        <hr>
                        <div class="container-fluid">
                            <div class="row-fluid">
                                <div class="span12">
                                    <div class="row-fluid bdiv">
                                        <div class="span1">
                                            <label>

                                                <input type="checkbox" id="allCheckBox" onclick="selectAll();">
                                                &nbsp;&nbsp;&nbsp;全选</label>
                                        </div>
                                        <div class="span2">
                                            <button class="btn" onclick="deleteModelBatch();">删除选中</button>
                                        </div>
                                        <div class="span3">
                                            <p>&nbsp;&nbsp;&nbsp;模型信息</p>
                                        </div>
                                        <div class="span2">
                                            <p>规模</p>
                                        </div>
                                        <div class="span2">
                                            <p>性质</p>
                                        </div>
                                        <div class="span2">
                                            <p>操作</p>
                                        </div>
                                    </div>
                                    <br>
                                    <%
                                    List<Model> models = ModelService.getModelService().searchModelsByUserStatus(user.getId(), "normal");
                                    for(Model model:models){
	                                    out.println("<div class=\"row-fluid bdiv\">");
	                                    out.println("    <div class=\"span1\" style=\"padding-top: 45px;\"><input class=\"modelCheckBox\" name=\"" + model.getId() + "\" type=\"checkbox\"></div>");
	                                    out.println("    <a class=\"span2\" href=\"modeldetail.jsp?id=" + model.getId() + "\" >");
	                                    out.println("        <img alt=\"model\" src=\"modelimage?modelID=" + model.getId() + "&number=1" + "\" />");
	                                    out.println("    </a>");
	                                    out.println("    <div class=\"span3\">");
	                                    out.println("        <br>");
	                                    out.println("        <span>" + model.getName() + "</span>");
	                                    out.println("        <br>");
	                                    out.println("        <span>" + model.getDescriptrion() + "</span>");
	                                    out.println("    </div>");
	                                    out.println("    <div class=\"span2 \">");
	                                    out.println("        <br>");
	                                    out.println("        <span>" + "规模" + "</span>");
	                                    out.println("        <br>");
	                                    out.println("        <span>" + model.getLength().intValue() + "mm*" + model.getWidth().intValue() + "mm*" + model.getHeight().intValue() + "mm</span>");
	                                    out.println("    </div>");
	                                    out.println("    <div class=\"span2 \">");
	                                    out.println("        <br>");
	                                    out.println("        <span>" + model.getStyle() + "</span>");
	                                    out.println("    </div>");
	                                    out.println("    <div class=\"span2 \">");
	                                    out.println("        <br>");
	                                    out.println("        <button class=\"btn\" type=\"button\" onclick=\"location='model_reinfo.jsp?modelID=" + model.getId() + "'\">重新编辑</button>");
	                                    out.println("        <br><br>");
	                                    out.println("        <button class=\"btn\" type=\"button\" onclick=\"deleteModelSingle('" + model.getId() + "');\">删除</button>");
	                                    out.println("    </div>");
	                                    out.println("</div>");
	                                    out.println("<br><br>");
                                    }
                                    %>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
	
	<script>

		function selectAll(){
			var select = document.getElementById('allCheckBox').checked;
			var boxs = document.getElementsByClassName('modelCheckBox');
			for(var i=0; i<boxs.length; i++){
				boxs[i].checked = select;
			}
		}
		
		function deleteModelBatch(){
			var modelIDs = '';
			var boxs = document.getElementsByClassName('modelCheckBox');
			for(var i=0; i<boxs.length; i++){
				if(boxs[i].checked){
					modelIDs += boxs[i].name + ';';
				}
			}
			deleteModels(modelIDs);
		}
	
		function deleteModelSingle(modelID){
			deleteModels(modelID);
		}

		function deleteModels(modelIDs){
			$.ajax({
				type: "GET",
				url: 'ajax/deletemodels',
				data: {modelIDs: modelIDs},
				dataType: 'json',
				async: false,
				success: function(data){
					if(data.successCount > 0){
						alert('成功删除' + data.successCount + '个模型。');
						location = '';
					}else{
						alert('删除失败。');
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