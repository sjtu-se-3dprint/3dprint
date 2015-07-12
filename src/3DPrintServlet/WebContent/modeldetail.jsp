<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="service.*,entity.*, database.*, java.util.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>3D打印创作服务平台</title>
</head>
<body>
	<jsp:include page="header.jsp" flush="true"></jsp:include>
	<%
		// 是否已经登录，关系到可否点赞、是否评价收藏过等
		User user = GetLoginUserService.service(request);
	
		// 获取模型信息
		String modelID = request.getParameter("id");
		int id = 0;
		try{
			id = Integer.parseInt(modelID);
		}catch(Exception e){
			return;
		}
		
		Model model = ModelService.getModelService().searchModelByID(id);
	%>
    <div class="container">
        <div class="row">
            <div class="span12">
                <ul class="breadcrumb">
                    <li>
                        <a href="index.jsp">首页</a> <span class="divider">/</span>
                    </li>
                    <li>
                        <a href="modellist.jsp">模型商城</a> <span class="divider">/</span>
                    </li>
                    <li class="active">
                        <%=model.getName() %>
                    </li>
                </ul>
                <div class="row">
                    <div class="span12">
                        <div class="row">
                            <div class="span8">
                                <h3 class="text-left text-success">
                                    <strong><%=model.getName() %></strong>
                                </h3>
                                <div class="tabbable tabs-right" id="tabs-464040">
                                    <ul class="nav nav-tabs">
                                    	<%
                                    		int panelNumber = 822259;
                                    		for(int i=0; i<model.getImageNumber(); i++){
                                    			out.println("<li>");
                                    			out.println("<a data-toggle=\"tab\" href=\"#panel-" + (panelNumber+i) + "\">");
                                    			out.println("<img width=\"140\" src=\"modelimage?modelID=" + model.getId() + "&number=" + (i+1) + "\" class=\"img-rounded\" />");
                                    			out.println("</a>");
                                    			out.println("</li>");
                                    		}
                                    	%>
                                    </ul>
                                    <div class="tab-content">
                                    	<%
                                    		for(int i=0; i<model.getImageNumber(); i++){
                                    			if(i==0)
                                    				out.println("<div class=\"tab-pane active\" id=\"panel-"+ (panelNumber+i) + "\">");
                                    			else
                                    				out.println("<div class=\"tab-pane\" id=\"panel-"+ (panelNumber+i) + "\">");
                                    			out.println("<p>");
                                    			out.println("<img width=\"620\" src=\"modelimage?modelID=" + model.getId() + "&number=" + (i+1) + "\" class=\"img-rounded\" />");
                                    			out.println("</p>");
                                    			out.println("</div>");

                                    		}
                                    	%>
                                    </div>
                                </div>
                                <div class="tabbable" id="tabs-824183">
                                    <ul class="nav nav-tabs">
                                        <li class="active">
                                            <a data-toggle="tab" href="#panel-813606">模型详情</a>
                                        </li>
                                        <li>
                                            <a data-toggle="tab" href="#comments">模型评价</a>
                                        </li>
                                    </ul>
                                    <div class="tab-content">
                                        <div class="tab-pane active" id="panel-813606">
                                            <p>
                                                发布时间：<%=model.getAddtime() %>
                                            </p>
                                            <p>
                                                性质：<%=model.getStyle() %>
                                            </p>
                                            <p>
                                                编号：#<%=model.getId() %>
                                            </p>
                                            <p>
                                                模型尺寸：<%=model.getLength() %>mm*<%=model.getWidth() %>mm*<%=model.getHeight() %>mm
                                            </p>
                                        </div>
                                        <div class="tab-pane" id="comments">
                                        	<%
                                        		List<Comment> comments = UserLikeCollectionCommentService
                                        	                                        								.getUserLikeCollectionCommentService()
                                        	                                        								.searchCommentByModelStatus(model.getId(), "normal");
                                        	                                        		int CountPerPage = 5;
                                        	                                            	int maxPage = (comments.size()-1)/CountPerPage + 1;
                                        	                                            	for(int i=0; i<comments.size()&&i<CountPerPage; i++){
                                        	                                            		Comment comment = comments.get(i);
                                        	                                            		User commenter = UserService.getUserService().searchUserByID(comment.getUser().getId());
                                        	                                            		out.println("<div class=\"container-fluid\">");
                                        	                                        			out.println("    <div class=\"span2\">");
                                        	                                        			out.println("        <img alt=\"用户头像\" src=\"userheadimage?userID=" + comment.getUser().getId() + "\" class=\"img-rounded\" />");
                                        	                                        			out.println("    </div>");
                                        	                                        			out.println("    <div class=\"span8\">");
                                        	                                        			out.println("        <p>" + comment.getComment() + "</p>");
                                        	                                        			out.println("    </div>");
                                        	                                        			out.println("    <div class=\"span8\">");
                                        	                                        			out.println("        <div class=\"uBar\">");
                                        	                                        			out.println("            <span class=\"f1\" style=\"float: right\">" + commenter.getName() + " 发表于：" + comment.getAddtime() + "</span>");
                                        	                                        			out.println("        </div>");
                                        	                                        			out.println("    </div>");
                                        	                                        			out.println("</div>");
                                        	                                        			out.println("<br>");
                                        	                                            	}
                                        	%>
                                            <div class="pagination pagination-right pagination-large">
                                                <ul>
                                                    <%
			                                    		int from = 1;
			                                    		int to = 1 + 2;
			                                    		to = to > maxPage ? maxPage : to;
		                                    			out.println("<li class=\"disabled\"><a>首页</a></li>");
		                                    			out.println("<li class=\"disabled\"><a>上一页</a></li>");
			                                    		for(int i=from; i<=to; i++){
			                                    			if(1 == i){
			                                    				out.println("<li class=\"active\"><a>" + i + "</a></li>");
			                                    			}else{
			                                    				out.println("<li onclick=\"searchComment('" + i + "');\"><a>" + i + "</a><li>");
			                                    			}
			                                    		}
			                                    		if(to < maxPage){
			                                    			out.println("<li><a>...</a></li>");
			                                    		}
			                                    		if(1 == maxPage){
			                                    			out.println("<li class=\"disabled\"><a>下一页</a></li>");
			                                    			out.println("<li class=\"disabled\"><a>末页</a></li>");
			                                    		}else{
			                                    			out.println("<li onclick=\"searchComment('" + (2) + "');\"><a>下一页</a></li>");
			                                    			out.println("<li onclick=\"searchComment('" + (maxPage) + "')\"><a>末页</a></li>");
			                                    		}
			                                    	%>
                                                </ul>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="span4">
                                <div class="row">
                                    <div class="line"><br><br></div>
                                    <div class="span12">
                                        <br><br>
                                        <button class="btn btn-large btn-info" type="button" onclick="addtoShopcar();">添加到购物车</button>
                                        <button class="btn btn-large btn-info" type="button" onclick="downloadModel();">下载模型</button>
                                        <br>
                                    </div>
                                </div>
                                <br><br>
                                <div class="row" id="myview">

                                    <div class="span3">
                                        <a class="btn btn-small" href="#" onclick="userlike('userlike');">
                                            <li class="icon-thumbs-up"></li>
                                            <%
                                            	String likeText = "点赞";
                                            	Boolean userlike = null;
                                            	if(user != null){
                                            		userlike = UserLikeCollectionCommentService
                                            				.getUserLikeCollectionCommentService()
                                            				.isUserlike(user.getId(), model.getId());
                                            		if(userlike != null && userlike){
                                            			likeText = "取消";
                                            		}
                                            	}
                                            	out.println("<span id=\"userlikeText\">" + likeText + "</span>");
                                            	out.println("<span id=\"userlikeCount\">(" + model.getUserlike() + ")</span>");
                                            	
                                            %>
                                        </a>

                                    </div>
                                    <div class="span3">
                                        <a class="btn btn-small" href="#" onclick="userlike('dislike');">
                                            <li class="icon-thumbs-down"></li>
                                            <%
	                                            String dislikeText = "差评";
	                                        	if(user != null){
	                                        		if(userlike != null && !userlike){
	                                        			dislikeText = "取消";
	                                        		}
	                                        	}
                                            	out.println("<span id=\"dislikeText\">" + dislikeText + "</span>");
                                            	out.println("<span id=\"dislikeCount\">(" + model.getDislike() + ")</span>");
                                            	
                                            %>
                                        </a>
                                    </div>
                                    <div class="span4">
                                        <a class="btn btn-small" href="#" onclick="userCollection();">
                                            <li class="icon-star"></li>
                                            <%
                                            	String collectionText = "收藏";
                                            	Boolean collection = null;
                                            	if(user != null){
                                            		collection = UserLikeCollectionCommentService
                                    				.getUserLikeCollectionCommentService()
                                    				.isCollection(user.getId(), model.getId());
                                            		if(collection != null && collection){
                                            			collectionText = "已收藏";
                                            		}
                                            	}
                                            	out.println("<span id=\"collectionText\">" + collectionText + "</span>");
                                            	out.println("<span id=\"collectionCount\">(" + model.getCollection() + ")</span>");
                                            	
                                            %>
                                        </a>
                                    </div>


                                </div>
                                <br><br>
                                <div class="row">
                                    <div class="span12">
                                    	<%
                                    		User uploader = UserService.getUserService().searchUserByID(model.getUser().getId());
                                    	%>
                                        <dl>
                                            <dt>
                                            <%=uploader.getName() %>
                                            </dt>
                                            <dd>
                                                注册时间：<%=uploader.getAddtime() %>
                                            </dd>
                                            <dd>
                                                联系方式(e-mail)：<%=uploader.getEmail() %>
                                            </dd>
                                        </dl>
                                    </div>
                                </div>
                                <br><br>
                                <div class="row">
                                    <div class="span8 container">
                                        <div class="control-group">
                                            <label class="control-label">发表新留言</label>
                                            <div class="controls">
                                                <textarea id="commentText" rows="3"></textarea>
                                                <p class="help-block">请不要超过100字！</p>
                                            </div>
                                        </div>
                                        <button class="btn" style="float: right;" onclick="userComment();">
                                            <i class="icon-ok"></i>
                                           	 提交
                                        </button>
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
		var isLogin = <%=user!=null %>;
		var likeText = '<%=likeText %>';
		var likeCount = <%=model.getUserlike()%>;
		var dislikeText = '<%=dislikeText %>';
		var dislikeCount = <%=model.getDislike()%>;
		var collectionText = '<%=collectionText%>';
		var collectionCount = <%=model.getCollection()%>;
		var modelID = '<%=model.getId()%>';

		function addtoShopcar(){
			if(!isLogin){
				alert('请先登录。');
				return;
			}
			$.ajax({
				type:'GET',
				url: 'ajax/addshopcar',
				data:{modelID:modelID},
				dataType:'json',
				async:false,
				success: function(data){
					if(data.success){
						alert('成功添加购物车。');
						location = '';
					}else{
						alert('该商品已在购物车中。');
					}
				},
				error: function(err){
					alert('网络故障');
				}
			});
		}

		/**
		 * 用户点击了页码中的某一项。
		 */
		function searchComment(page){
			var result = getComments(page);
			if(result == null){
				return;
			}

			var commentsDiv = document.getElementById('comments');
			commentsDiv.innerHTML = '';
			for(var i=0; i<result.comments.length; i++){
				commentsDiv.innerHTML += commentToHtml(result.comments[i]);
			}
			commentsDiv.innerHTML += pagecountToHtml(result.currentPage, result.maxPage);
		}

		function commentToHtml(comment){
			var commentHtml = '';
			commentHtml += '<div class="container-fluid">';
			commentHtml += '    <div class="span2">';
			commentHtml += '        <img alt="用户头像" src="userheadimage?userID=' + comment.userID + '" class="img-rounded" />';
			commentHtml += '    </div>';
			commentHtml += '    <div class="span8">';
			commentHtml += '        <p>' + comment.comment + '</p>';
			commentHtml += '    </div>';
			commentHtml += '    <div class="span8">';
			commentHtml += '        <div class="uBar">';
			commentHtml += '            <span class="f1" style="float: right">' + comment.userName + ' 发表于：' + comment.addtime + '</span>';
			commentHtml += '        </div>';
			commentHtml += '    </div>';
			commentHtml += '</div>';
			commentHtml += '<br>';
			return commentHtml;
		}

		function pagecountToHtml(currentPage, maxPage){
			var pageHtml = '';
			pageHtml += '<div class="pagination pagination-right pagination-large">';
			pageHtml += '<ul>';
       		var from = currentPage - 2;
       		var to = currentPage + 2;
       		from = from < 1 ? 1 : from;
       		to = to > maxPage ? maxPage : to;
       		if(currentPage == 1){
       			pageHtml += '<li class=\"disabled\"><a>首页</a></li>';
       			pageHtml += '<li class=\"disabled\"><a>上一页</a></li>';
       		}else{
       			pageHtml += '<li onclick=\"searchComment(\'1\');\"><a>首页</a></li>';
       			pageHtml += '<li onclick=\"searchComment(\'' + (currentPage-1) + '\');\"><a>上一页</a></li>';
       		}
       		if(from > 1){
       			pageHtml += '<li><a>...</a></li>';
       		}
       		for(var i=from; i<=to; i++){
       			if(currentPage == i){
       				pageHtml += '<li class=\"active\"><a>' + i + '</a></li>';
       			}else{
       				pageHtml += '<li onclick=\"searchComment(\'' + i + '\');\"><a>' + i + '</a><li>';
       			}
       		}
       		if(to < maxPage){
       			pageHtml += '<li><a>...</a></li>';
       		}
       		if(currentPage == maxPage){
       			pageHtml += '<li class=\"disabled\"><a>下一页</a></li>';
       			pageHtml += '<li class=\"disabled\"><a>末页</a></li>';
       		}else{
       			pageHtml += '<li onclick=\"searchComment(\'' + (currentPage+1) + '\');\"><a>下一页</a></li>';
       			pageHtml += '<li onclick=\"searchComment(\'' + (maxPage) + '\')\"><a>末页</a></li>';
       		}
       		pageHtml += '</ul>';
       		pageHtml += '</div>';
       		return pageHtml;
		}

		/**
		 * 用户点击评论按钮。
		 */
		function userComment(){
			
			// 要求用户先登录
			if(!isLogin){
				alert('请先登录。');
				return;
			}

			var commentText = document.getElementById('commentText').value;
			if(commentText == ''){
				alert('请输入评论内容。');
				return;
			}

			var result = addUserComment(commentText);
			if(result != null && result.success){
				alert('添加评论成功。');
				location = '';
			}
		}

		/**
		 * 用户点击收藏按钮。
		 */
		function userCollection(){
			// 要求用户先登录
			if(!isLogin){
				alert('请先登录。');
				return;
			}

			if(collectionText == '收藏'){ // 用户收藏
				if(addUserCollection()){
					collectionText = '已收藏';
					collectionCount += 1;
					document.getElementById('collectionText').innerHTML = collectionText;
					document.getElementById('collectionCount').innerHTML = '(' + collectionCount + ')'
				}
			}else if(collectionText == '已收藏'){ // 取消收藏
				if(cancelUserCollection()){
					collectionText = '收藏';
					collectionCount -= 1;
					document.getElementById('collectionText').innerHTML = collectionText;
					document.getElementById('collectionCount').innerHTML = '(' + collectionCount + ')'
				}
			}
		}

		/**
		 * 用户点击赞或差评按钮。
		 */
		function userlike(type){

			// 要求用户先登录
			if(!isLogin){
				alert('请先登录。');
				return;
			}
			
			if(type == 'userlike' && likeText == '点赞'){ // 用户点赞

				if(dislikeText == '取消'){
					alert('不能同时点赞和差评');
					return;
				}

				// 操作成功，更新UI
				if(addUserlike(true)){
					likeText = '取消';
					likeCount += 1;
					document.getElementById('userlikeText').innerHTML = likeText;
					document.getElementById('userlikeCount').innerHTML = '(' + likeCount + ')';  
				}
			}else if(type == 'userlike' && likeText == '取消'){ // 取消点赞

				// 操作成功，更新UI
				if(cancelUserlike()){
					likeText = '点赞';
					likeCount -= 1;
					document.getElementById('userlikeText').innerHTML = '点赞';
					document.getElementById('userlikeCount').innerHTML = '(' + likeCount + ')';  
				}
			}else if(type == 'dislike' && dislikeText == '差评'){ // 差评
				
				if(likeText == '取消'){
					alert('不能同时点赞和差评');
					return;
				}

				// 操作成功，更新UI
				if(addUserlike(false)){
					dislikeText = '取消';
					dislikeCount += 1;
					document.getElementById('dislikeText').innerHTML = dislikeText;
					document.getElementById('dislikeCount').innerHTML = '(' + dislikeCount + ')';  
				}
			}else if(type == 'dislike' && dislikeText == '取消'){ // 取消差评

				// 操作成功，更新UI
				if(cancelUserlike()){
					dislikeText = '差评';
					dislikeCount -= 1;
					document.getElementById('dislikeText').innerHTML = dislikeText;
					document.getElementById('dislikeCount').innerHTML = '(' + dislikeCount + ')';  
				}
			}
		}

		/**
		 * 用户收藏。
		 */
		function addUserCollection(){
			var success = false;
			$.ajax({
				type:'GET',
				url: 'ajax/usercollection',
				data:{modelID:modelID},
				dataType:'json',
				async:false,
				success: function(data){
					success = data.success;
				},
				error: function(err){
					alert('网络故障。');
				}
			});
			return success;
		}

		/**
		 * 用户取消收藏。
		 */
		function cancelUserCollection(){
			var success = false;
			$.ajax({
				type:'GET',
				url: 'ajax/cancelusercollection',
				data:{modelID:modelID},
				dataType:'json',
				async:false,
				success: function(data){
					success = data.success;
				},
				error: function(err){
					alert('网络故障。');
				}
			});
			return success;
		}

		/**
		 * 用户点赞或差评。
		 */
		function addUserlike(userlike){
			var success = false;
			$.ajax({
				type:'GET',
				url: 'ajax/userlike',
				data:{modelID:modelID, userlike:userlike},
				dataType:'json',
				async:false,
				success: function(data){
					success = data.success;
				},
				error: function(err){
					alert('网络故障。');
				}
			});
			return success;
		}

		/**
		 * 用户取消评价。
		 */
		function cancelUserlike(){
			var success = false;
			$.ajax({
				type:'GET',
				url: 'ajax/canceluserlike',
				data:{modelID:modelID},
				dataType:'json',
				async:false,
				success: function(data){
					success = data.success;
				},
				error: function(err){
					alert('网络故障。');
				}
			});
			return success;
		}

		/**
		 * 用户添加评论。
		 */
		function addUserComment(commentText){
			var result = null;
			$.ajax({
				type:'GET',
				url: 'ajax/usercomment',
				data:{modelID:modelID, commentText:commentText},
				dataType:'json',
				async:false,
				success: function(data){
					result = data;
				},
				error: function(err){
					alert('网络故障');
				}
			});
			return result;
		}

		/**
		 * 获取评论信息、页码信息。
		 */
		function getComments(page){
			var result = null;
			$.ajax({
				type:'GET',
				url: 'ajax/searchcomment',
				data:{modelID:modelID, page:page},
				dataType:'json',
				async:false,
				success: function(data){
					result = data;
				},
				error: function(err){
					alert('网络故障');
				}
			});
			return result;
		}

		function downloadModel(){
			console.log(modelID);
			var form=$("<form>");//定义一个form表单
			form.attr("style","display:none");
			form.attr("target","");
			form.attr("method","get");
			form.attr("action","downloadmodel");
			var input1=$("<input>");
			input1.attr("type","hidden");
			input1.attr("name","modelID");
			input1.attr("value",modelID);
			$("body").append(form);//将表单放置在web中
			form.append(input1);
			form.submit();//表单提交 
		}
	</script>
</body>
</html>