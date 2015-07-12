<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="service.GetLoginUserService,entity.*, database.*, java.util.List" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; ">
<title>3D打印创作服务平台-admin中心</title>
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
                                        <li class="active"><a href="ad_comment.jsp">评论管理</a></li>
                                        <li><a href="ad_forum.jsp">论坛管理</a></li>
                                        <li><a href="ad_addlesson_new.jsp">发布教程</a></li>
                                    </ul>
                                </div>
                            </div>
                        </div>

                    </div>

                    <div class="span10">
                        <hr>
                        <div class="container-fluid">
                            <div class="row-fluid">
                                <div class="span14"> 
                                    <div class="row-fluid bdiv">
                                        <div class="span1">
                                            <label>
                                                &nbsp;
                                                <input type="checkbox" id="allCheckBox" onclick="selectAll();">
                                                &nbsp;&nbsp;&nbsp;全选</label>
                                        </div>
										<%
                                    	String sort = request.getParameter("sort");
										if(sort == null){ 
											sort = "time-down";
										}
										String limit = request.getParameter("limit");
										String limitid = request.getParameter("limitid");
										int limitidValue = 0;
										if(limit != null){
											limitidValue = Integer.parseInt(limitid);
										}
										%>
                                        <a class="span2" href="ad_comment.jsp?sort=model-<%="model-up".equals(sort)?"down":"up"%><%=limit==null?"":("&limit="+limit+"&limitid="+limitid)%>">
                                            <p>被评模型<%="model-up".equals(sort)?"↑":("model-down".equals(sort)?"↓":"") %></p>
                                        </a>
                                        <a class="span2" href="ad_comment.jsp?sort=user-<%="user-up".equals(sort)?"down":"up"%><%=limit==null?"":("&limit="+limit+"&limitid="+limitid)%>">
                                            <p>&nbsp;评论者<%="user-up".equals(sort)?"↑":("user-down".equals(sort)?"↓":"") %></p>
                                        </a>
                                        <div class="span3">
                                            <p>&nbsp;&nbsp;&nbsp;&nbsp;评论内容</p>
                                        </div> 
                                        <a class="span2" href="ad_comment.jsp?sort=time-<%="time-up".equals(sort)?"down":"up"%><%=limit==null?"":("&limit="+limit+"&limitid="+limitid)%>">
                                            <p>评论时间<%="time-up".equals(sort)?"↑":("time-down".equals(sort)?"↓":"") %></p>
                                        </a>
                                        <div class="span2">
                                            <button class="btn" onclick="deleteComments();">批量删除</button>
                                        </div>
                                    </div>
                                    <br>
                                    <%
                                    	List<Comment> comments = null;
                                    UserLikeCollectionCommentServiceInterface service = UserLikeCollectionCommentService
                                            .getUserLikeCollectionCommentService();
                                    	if("model".equals(limit)){
                                    		if("time-up".equals(sort)){
	                                    		comments = service.searchCommentByStatusOrderByTimeLimitByModel("normal", true, limitidValue);
	                                    	}else if("time-down".equals(sort)){
	                                    		comments = service.searchCommentByStatusOrderByTimeLimitByModel("normal", false, limitidValue);
	                                    	}else if("user-up".equals(sort)){
	                                    		comments = service.searchCommentByStatusOrderByCommenterIDLimitByModel("normal", true, limitidValue);
	                                    	}else if("user-down".equals(sort)){
	                                    		comments = service.searchCommentByStatusOrderByCommenterIDLimitByModel("normal", false, limitidValue);
	                                    	}else if("model-up".equals(sort)){
	                                    		comments = service.searchCommentByStatusOrderByModelIDLimitByModel("normal", true, limitidValue);
	                                    	}else if("model-down".equals(sort)){
	                                    		comments = service.searchCommentByStatusOrderByModelIDLimitByModel("normal", false, limitidValue);
	                                    	}else{
	                                    		comments = service.searchCommentByStatus("normal");
	                                    	}
                                    	}else if("user".equals(limit)){
                                    		if("time-up".equals(sort)){
	                                    		comments = service.searchCommentByStatusOrderByTimeLimitByUser("normal", true, limitidValue);
	                                    	}else if("time-down".equals(sort)){
	                                    		comments = service.searchCommentByStatusOrderByTimeLimitByUser("normal", false, limitidValue);
	                                    	}else if("user-up".equals(sort)){
	                                    		comments = service.searchCommentByStatusOrderByCommenterIDLimitByUser("normal", true, limitidValue);
	                                    	}else if("user-down".equals(sort)){
	                                    		comments = service.searchCommentByStatusOrderByCommenterIDLimitByUser("normal", false, limitidValue);
	                                    	}else if("model-up".equals(sort)){
	                                    		comments = service.searchCommentByStatusOrderByModelIDLimitByUser("normal", true, limitidValue);
	                                    	}else if("model-down".equals(sort)){
	                                    		comments = service.searchCommentByStatusOrderByModelIDLimitByUser("normal", false, limitidValue);
	                                    	}else{
	                                    		comments = service.searchCommentByStatus("normal");
	                                    	}
                                    	}else{
	                                    	if("time-up".equals(sort)){
	                                    		comments = service.searchCommentByStatusOrderByTime("normal", true);
	                                    	}else if("time-down".equals(sort)){
	                                    		comments = service.searchCommentByStatusOrderByTime("normal", false);
	                                    	}else if("user-up".equals(sort)){
	                                    		comments = service.searchCommentByStatusOrderByCommenterID("normal", true);
	                                    	}else if("user-down".equals(sort)){
	                                    		comments = service.searchCommentByStatusOrderByCommenterID("normal", false);
	                                    	}else if("model-up".equals(sort)){
	                                    		comments = service.searchCommentByStatusOrderByModelID("normal", true);
	                                    	}else if("model-down".equals(sort)){
	                                    		comments = service.searchCommentByStatusOrderByModelID("normal", false);
	                                    	}else{
	                                    		comments = service.searchCommentByStatus("normal");
	                                    	}
                                    	}
                                       	for(Comment comment : comments){ 
                                       		Model model = ModelService.getModelService().searchModelByID(comment.getModel().getId());
                                       		User commenter = UserService.getUserService().searchUserByID(comment.getUser().getId());
                                       		out.println("<div class=\"row-fluid bdiv\">");
                                       		out.println("    <div class=\"span1\" style=\"padding-top: 20px;\">");
                                       		out.println("        &nbsp;&nbsp;<input type=\"checkbox\" class=\"commentCheckBox\" name=\"" + comment.getId() + "\">");
                                       		out.println("        <br><br>");
                                       		out.println("    </div>");
                                       		out.println("    <a class=\"span2\" href=\"modeldetail.jsp?id=" + comment.getModel().getId() + "\">");
                                       		out.println("        <br>");
                                       		if("model".equals(limit)){
                                       			out.println("        <input checked type=\"checkbox\" onclick=\"selectModel(this, " + model.getId() + ");\">");
                                       		}else{
                                       			out.println("        <input type=\"checkbox\" onclick=\"selectModel(this, " + model.getId() + ");\">");
                                       		}
                                       		out.println("        <span>" + model.getName() + "</span>");
                                       		out.println("    </a>");
                                       		out.println("    <div class=\"span2\">"); 
                                       		out.println("        <br>");
                                       		if("user".equals(limit)){
                                       			out.println("        <input checked type=\"checkbox\" onclick=\"selectUser(this, " + commenter.getId() + ");\">");
                                       		}else{
                                       			out.println("        <input type=\"checkbox\" onclick=\"selectUser(this, " + commenter.getId() + ");\">");
                                       		}
                                       		out.println("        <span>" + commenter.getName() + "</span>");
                                       		out.println("    </div>");
                                       		out.println("");
                                       		out.println("    <div class=\"span3 \">");
                                       		out.println("        <br>");
                                       		out.println("        <span>" + comment.getComment() + "</span>");
                                       		out.println("    </div>");
                                       		out.println("");
                                       		out.println("    <div class=\"span2 \">");
                                       		out.println("        <br>");
                                       		out.println("        <span>" + comment.getAddtime() + "</span>");
                                       		out.println("    </div>");
                                       		out.println("");
                                       		out.println("    <div class=\"span2 \">");
                                       		out.println("        <br>");
                                       		out.println("        <button class=\"btn-danger\" type=\"button\" onclick=\"deleteComment('" + comment.getId() + "');\">删除评论</button>");
                                       		out.println("    </div>");
                                       		out.println("</div>");
                                       		out.println("<br/>");
                                       	}
                                       	if("model".equals(limit)){
                                    		if("time-up".equals(sort)){
	                                    		comments = service.searchCommentByStatusOrderByTimeLimitByModel("deleted", true, limitidValue);
	                                    	}else if("time-down".equals(sort)){
	                                    		comments = service.searchCommentByStatusOrderByTimeLimitByModel("deleted", false, limitidValue);
	                                    	}else if("user-up".equals(sort)){
	                                    		comments = service.searchCommentByStatusOrderByCommenterIDLimitByModel("deleted", true, limitidValue);
	                                    	}else if("user-down".equals(sort)){
	                                    		comments = service.searchCommentByStatusOrderByCommenterIDLimitByModel("deleted", false, limitidValue);
	                                    	}else if("model-up".equals(sort)){
	                                    		comments = service.searchCommentByStatusOrderByModelIDLimitByModel("deleted", true, limitidValue);
	                                    	}else if("model-down".equals(sort)){
	                                    		comments = service.searchCommentByStatusOrderByModelIDLimitByModel("deleted", false, limitidValue);
	                                    	}else{
	                                    		comments = service.searchCommentByStatus("deleted");
	                                    	}
                                    	}else if("user".equals(limit)){
                                    		if("time-up".equals(sort)){
	                                    		comments = service.searchCommentByStatusOrderByTimeLimitByUser("deleted", true, limitidValue);
	                                    	}else if("time-down".equals(sort)){
	                                    		comments = service.searchCommentByStatusOrderByTimeLimitByUser("deleted", false, limitidValue);
	                                    	}else if("user-up".equals(sort)){
	                                    		comments = service.searchCommentByStatusOrderByCommenterIDLimitByUser("deleted", true, limitidValue);
	                                    	}else if("user-down".equals(sort)){
	                                    		comments = service.searchCommentByStatusOrderByCommenterIDLimitByUser("deleted", false, limitidValue);
	                                    	}else if("model-up".equals(sort)){
	                                    		comments = service.searchCommentByStatusOrderByModelIDLimitByUser("deleted", true, limitidValue);
	                                    	}else if("model-down".equals(sort)){
	                                    		comments = service.searchCommentByStatusOrderByModelIDLimitByUser("deleted", false, limitidValue);
	                                    	}else{
	                                    		comments = service.searchCommentByStatus("deleted");
	                                    	}
                                    	}else{
	                                    	if("time-up".equals(sort)){
	                                    		comments = service.searchCommentByStatusOrderByTime("deleted", true);
	                                    	}else if("time-down".equals(sort)){
	                                    		comments = service.searchCommentByStatusOrderByTime("deleted", false);
	                                    	}else if("user-up".equals(sort)){
	                                    		comments = service.searchCommentByStatusOrderByCommenterID("deleted", true);
	                                    	}else if("user-down".equals(sort)){
	                                    		comments = service.searchCommentByStatusOrderByCommenterID("deleted", false);
	                                    	}else if("model-up".equals(sort)){
	                                    		comments = service.searchCommentByStatusOrderByModelID("deleted", true);
	                                    	}else if("model-down".equals(sort)){
	                                    		comments = service.searchCommentByStatusOrderByModelID("deleted", false);
	                                    	}else{
	                                    		comments = service.searchCommentByStatus("deleted");
	                                    	}
                                    	}
                                       	for(Comment comment : comments){
                                       		Model model = ModelService.getModelService().searchModelByID(comment.getModel().getId());
                                       		User commenter = UserService.getUserService().searchUserByID(comment.getUser().getId());
                                       		out.println("<div class=\"row-fluid bdiv\">");
                                       		out.println("    <div class=\"span1\" style=\"padding-top: 20px;\">");
                                       		out.println("        &nbsp;&nbsp;<input disabled type=\"checkbox\" class=\"deletedCommentCheckBox\" name=\"" + comment.getId() + "\">");
                                       		out.println("        <br><br>");
                                       		out.println("    </div>");
                                       		out.println("    <a class=\"span2\" href=\"modeldetail.jsp?id=" + comment.getModel().getId() + "\">");
                                       		out.println("        <br>");
                                       		if("model".equals(limit)){
                                       			out.println("        <input checked type=\"checkbox\" onclick=\"selectModel(this, " + model.getId() + ");\">");
                                       		}else{
                                       			out.println("        <input type=\"checkbox\" onclick=\"selectModel(this, " + model.getId() + ");\">");
                                       		} 
                                       		out.println("        <span>" + model.getName() + "</span>");
                                       		out.println("    </a>");
                                       		out.println("    <div class=\"span2\">");
                                       		out.println("        <br>");
                                       		if("user".equals(limit)){
                                       			out.println("        <input checked type=\"checkbox\" onclick=\"selectUser(this, " + commenter.getId() + ");\">");
                                       		}else{
                                       			out.println("        <input type=\"checkbox\" onclick=\"selectUser(this, " + commenter.getId() + ");\">");
                                       		} 
                                       		out.println("        <span>" + commenter.getName() + "</span>");
                                       		out.println("    </div>");
                                       		out.println("");
                                       		out.println("    <div class=\"span3 \">");
                                       		out.println("        <br>");
                                       		out.println("        <span>" + comment.getComment() + "</span>");
                                       		out.println("    </div>");
                                       		out.println("");
                                       		out.println("    <div class=\"span2 \">");
                                       		out.println("        <br>");
                                       		out.println("        <span>" + comment.getAddtime() + "</span>");
                                       		out.println("    </div>");
                                       		out.println(""); 
                                       		out.println("    <div class=\"span2 \">");
                                       		out.println("        <br>");
                                       		out.println("        <button class=\"btn\" type=\"button\" disabled>已经删除</button>");
                                       		out.println("    </div>");
                                       		out.println("</div>");
                                       		out.println("<br/>");
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
	<jsp:include page="footer.jsp" flush="true"></jsp:include>
	<script>
	function selectAll(){
		var select = document.getElementById('allCheckBox').checked;
		var boxs = document.getElementsByClassName('commentCheckBox');
		for(var i=0; i<boxs.length; i++){
			boxs[i].checked = select;
		}
	}

	function deleteComment(id){
		deleteCommentsAjax(id);
	}

	function deleteComments(){
		var commentIDs = '';
		var boxs = document.getElementsByClassName('commentCheckBox');
		for(var i=0; i<boxs.length; i++){
			if(boxs[i].checked){
				commentIDs += boxs[i].name + ';';
			}
		}
		if(commentIDs == ''){
			alert('请选中评论。');
			return;
		}
		deleteCommentsAjax(commentIDs);
	}

	function deleteCommentsAjax(ids){
		$.ajax({
			type: "GET",
			url: 'ajax/deletecomments',
			data: {commentIDs: ids},
			dataType: 'json',
			async: false,
			success: function(data){
				if(data.count > 0){
					alert('成功删除' + data.count + '条评论。');
					location = '';
				}else{
					alert('删除失败');
				}
			},
			error: function(err){
				alert('网络故障');
			}
		});
	}

	function selectModel(box, modelID){ 
		if(box.checked){
			location = 'ad_comment.jsp?sort=<%=sort%>&limit=model&limitid=' + modelID;
		}else{
			location = 'ad_comment.jsp?sort=<%=sort%>';
		}
	}

	function selectUser(box, userID){
		if(box.checked){ 
			location = 'ad_comment.jsp?sort=<%=sort%>&limit=user&limitid=' + userID;
		}else{
			location = 'ad_comment.jsp?sort=<%=sort%>';
		}
	}
	</script>
</body>
</html>