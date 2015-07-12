<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="service.GetLoginUserService,entity.*, database.*,java.util.List" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html;">
<title>3D打印创作服务平台-用户中心</title>
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
                                        <li><a href="./user_collect.jsp">我的收藏</a></li>

                                        <li class="active"><a href="./user_forum.jsp">我的帖子</a></li>
                                    </ul>
                                </div>
                            </div>
                        </div>

                    </div>

                    <div class="span10">
                        <hr>

	                  <div class="span10">
	                        <hr>
	                        <div class="tabbable">
	                            <ul class="nav nav-tabs">
	                                <li class="active">
	                                    <a href="#panel-819618" data-toggle="tab">正常帖子</a>
	                                </li>
	
	                                <li >
	                                    <a href="#panel-819619" data-toggle="tab">已删除</a>
	                                </li>
	                            </ul>
	
	                            <div class="tab-content">
	                                <div class="tab-pane active" id="panel-819618">
	                                    <div class="container-fluid">
	                                        <div class="row-fluid">
	                                            <table class="table table-hover">
	                                                <thead>
	                                                    <tr>
	                                                        <th>标题</th>
	                                                        <th>板块</th>
	                                                        <th>内容</th>
	                                                        <th>发表时间</th>
	                                                        <th>操作</th>
	                                                    </tr>
	                                                </thead>
	                                                <tbody>
	                                                	<%
	                                            			List<Post> posts = PostService.getPostService().searchPostByUserStatus(user.getId(), "normal");
	                                                		for(Post post: posts){
	                                                			out.println("<tr>");
	                                                			out.println("    <td><a href=\"forum_content.jsp?id=" + post.getId() + "\">" + (post.getTitle().length()>14?post.getTitle().subSequence(0,14)+"...":post.getTitle()) + "(" + post.getResponse() + ")" + "</a></td>");
	                                                			out.println("    <td>" + post.getFirstCategory() + "-" + post.getSecondCategory() + "</td>");
	                                                			out.println("    <td>" + (post.getContent().length()>20?post.getContent().subSequence(0,19)+"...":post.getContent()) + "</td>");
	                                                			out.println("    <td>" + post.getAddtime() + "</td>");
	                                                			out.println("    <td><button class=\"btn-danger\" onclick=\"deletePost('" + post.getId() + "')\">删除帖子</button> </td>");
	                                                			out.println("</tr>");
	                                                		}
	                                                	%>
	                                                </tbody>
	                                            </table>
	                                        </div>
	                                    </div>
	                                </div>
	
	                                <div class="tab-pane" id="panel-819619">
	                                    <div class="container-fluid">
	                                        <div class="row-fluid">
	                                            <div class="span12">
	                                                <table class="table table-hover">
	                                                    <thead>
	                                                        <tr>
	                                                            <th>标题</th>
		                                                        <th>板块</th>
		                                                        <th>内容</th>
		                                                        <th>发表时间</th>
		                                                        <th>操作</th>
	                                                        </tr>
	                                                    </thead>
	                                                    <tbody>
	                                                    <%
	                                            			posts = PostService.getPostService().searchPostByUserStatus(user.getId(), "deleted");
	                                                		for(Post post: posts){
	                                                			out.println("<tr>");
	                                                			out.println("    <td>" + (post.getTitle().length()>14?post.getTitle().subSequence(0,14)+"...":post.getTitle()) + "(" + post.getResponse() + ")" + "</td>");
	                                                			out.println("    <td>" + post.getFirstCategory() + "-" + post.getSecondCategory() + "</td>");
	                                                			out.println("    <td>" + (post.getContent().length()>20?post.getContent().subSequence(0,19)+"...":post.getContent()) + "</td>");
	                                                			out.println("    <td>" + post.getAddtime() + "</td>");
	                                                			out.println("    <td><button disabled >已经删除</button> </td>");
	                                                			out.println("</tr>");
	                                                		}
	                                                	%>
	                                                    </tbody>
	                                                </table>
	                                                <br><br>
	                                            </div>
	                                            <br><br>
	                                        </div>
	                                    </div>
	                                </div>
	                            </div>
	                        </div>
	                    </div>

                    </div>
                </div>
            </div>
        </div>
    </div>
	
	<script>
	function deletePost(id){
		$.ajax({
			type: "GET",
			url: 'ajax/deletepost',
			data: {postID: id},
			dataType: 'json',
			async: false,
			success: function(data){
				if(data.success){
					alert('删除成功。');
					location = '';
				}else{
					alert('删除失败。');
				}
			},
			error: function(err){
				alert('网络故障。');
			}
		});
	}
	</script>
</body>
</html>