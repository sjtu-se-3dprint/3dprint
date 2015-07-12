<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="service.GetLoginUserService,entity.*, database.*, java.util.List" %>
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
                                        <li><a href="./user_model.jsp">我的模型</a></li>
                                        <li><a href="./user_shop.jsp">我的购物</a></li>
                                        <li class="active"><a href="./user_collect.jsp">我的收藏</a></li>

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
                                            <button class="btn" onclick="cancelUserCollectionBatch();">删除选中</button>
                                        </div>
                                        <div class="span3">
                                            <p>&nbsp;&nbsp;&nbsp;模型信息</p>
                                        </div>
                                        <div class="span2">
                                            <p>受欢迎度</p>
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
										List<Collection> collections = UserLikeCollectionCommentService
											.getUserLikeCollectionCommentService()
											.searchCollectionsByUserID(user.getId());
										for(Collection collection: collections){
											Model model = ModelService.getModelService().searchModelByID(collection.getModelID());
											out.println("<div class=\"row-fluid bdiv\">");
											out.println("");
											out.println("    <div class=\"span1\" style=\"padding-top: 45px;\"><input type=\"checkbox\" class=\"modelCheckBox\" name=\"" + model.getId() + "\"></div>");
											out.println("    <a href=\"modeldetail.jsp?id=" + model.getId() + "\" class=\"span2\">");
											out.println("        <img alt=\"model\" src=\"modelimage?number=1&modelID=" + model.getId() + "\" />");
											out.println("    </a>");
											out.println("    <div class=\"span3\">");
											out.println("        <br>");
											out.println("        <span>" + model.getName() + "</span>");
											out.println("        <br>");
											out.println("        <span>模型基本描述信息</span>");
											out.println("    </div>");
											out.println("    <div class=\"span2 \">");
											out.println("        <br>");
											out.println("        <span>点赞数：</span>");
											out.println("");
											out.println("        <span>" + model.getUserlike() + "</span>");
											out.println("        <br>");
											out.println("        <span>收藏数：</span>");
											out.println("        <span>" + model.getCollection() + "</span>");
											out.println("        <br>");
											out.println("        <span>差评数：</span>");
											out.println("        <span>" + model.getDislike() + "</span>");
											out.println("    </div>");
											out.println("    <div class=\"span2 \">");
											out.println("        <br>");
											out.println("        <span>" + model.getStyle() + "</span>");
											out.println("    </div>");
											out.println("    <div class=\"span2 \">");
											out.println("        <br>");
											out.println("        <button class=\"btn\" type=\"button\" onclick=\"addtoShopcar('" + model.getId() + "')\">加入购物车</button>");
											out.println("        <br><br>");
											out.println("        <button class=\"btn\" type=\"button\" onclick=\"cancelUserCollectionSingle('" + model.getId() + "')\">取消收藏</button>");
											out.println("    </div>");
											out.println("");
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
	
	<script>
	
		function addtoShopcar(modelID){
			$.ajax({
				type:'GET',
				url: 'ajax/addshopcar',
				data:{modelID:modelID},
				dataType:'json',
				async:false,
				success: function(data){
					if(data.success){
						alert('成功添加购物车。');
					}else{
						alert('该商品已在购物车中。');
					}
				},
				error: function(err){
					alert('网络故障');
				}
			});
		}
		function selectAll(){
			var select = document.getElementById('allCheckBox').checked;
			var boxs = document.getElementsByClassName('modelCheckBox');
			for(var i=0; i<boxs.length; i++){
				boxs[i].checked = select;
			}
		}
		
		function cancelUserCollectionBatch(){
			var modelIDs = '';
			var boxs = document.getElementsByClassName('modelCheckBox');
			for(var i=0; i<boxs.length; i++){
				if(boxs[i].checked){
					modelIDs += boxs[i].name + ';';
				}
			}
			cancelUserCollections(modelIDs);
		}
	
		function cancelUserCollectionSingle(modelID){
			cancelUserCollections(modelID);
		}

		function cancelUserCollections(modelIDs){
			$.ajax({
				type: "GET",
				url: 'ajax/cancelusercollections',
				data: {modelIDs: modelIDs},
				dataType: 'json',
				async: false,
				success: function(data){
					if(data.successCount > 0){
						alert('成功取消' + data.successCount + '个收藏。');
						location = '';
					}else{
						alert('取消失败。');
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