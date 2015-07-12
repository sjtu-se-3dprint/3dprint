<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page import="service.GetLoginUserService"%>
<%@ page import="entity.*"%>
<%@ page import="database.*"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Stack"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>3D打印创作服务平台-在线定制</title>
</head>
<body>
	<jsp:include page="header.jsp" flush="true"></jsp:include>
	<%
		String postIDStr = request.getParameter("id");
			int postID = 0;
			try{
		postID = Integer.parseInt(postIDStr);
			}catch(Exception e){
		return;
			}
			User user = GetLoginUserService.service(request);
	%>

	<script type="text/javascript" charset="utf-8"
		src="ueditor1_4_3-utf8-jsp/ueditor.config.js"></script>
	<script type="text/javascript" charset="utf-8"
		src="ueditor1_4_3-utf8-jsp/ueditor.all.min.js">
		
	</script>
	<div class="container-fluid">
		<div class="container">
			<div class="span12">
				<div class="panel-heading">
					<h4></h4>
				</div>
				<ul class="breadcrumb" style="">
					<li><a href="forum.jsp">论坛首页</a> <span class="divider">/</span>
					</li>
					<%
						Post post = PostService.getPostService().searchPostById(postID);
					%>
					<li><a
						href="forum_list_3Dprinter.jsp?first=<%=post.getFirstCategory()%>&second=<%=post.getSecondCategory()%>"><%=post.getFirstCategory() + "-" + post.getSecondCategory()%></a>
						<span class="divider">/</span></li>
					<li class="active"><%=post.getTitle()%></li>
				</ul>

				<%
					User poster = UserService.getUserService().searchUserByID(post.getUser().getId());
					Boolean isSupport = null;
					if (user != null) {
						isSupport = PostService.getPostService().isSupportPost(
								user.getId(), postID);
					}
					out.println("<div class=\"row-fluid\">");
					out.println("	<div class=\"span12\">");
					out.println("	<div class=\"thumbnail\">");
					out.println("		<div class=\"row-fluid\">");
					out.println("			<div class=\"span2\">");
					out.println("				<img alt=\"140x140\" src=\"userheadimage?userID="
							+ poster.getId() + "\" width=\"100\" height=\"100\" />");
					out.println("				<p>");
					out.println("					<a href=\"#\">" + poster.getName() + "</a>");
					out.println("				</p>");
					out.println("				<p>");
					out.println("					" + poster.getAddtime() + "");
					out.println("				</p>");
					out.println("			</div>");
					out.println("			<div class=\"span10\">");
					out.println("				" + post.getContent() + "");
					out.println("			</div>");
					out.println("		</div>");
					out.println("	</div>");
					out.println("	</div>");
					out.println("</div>");
					out.println("");
					out.println("");
					out.println("");

					List<Postcomment> postcomments = PostService.getPostService()
							.searchPostcommentByPostStatus(postID, "normal");
					for (Postcomment postcomment : postcomments) {
						User commenter = UserService.getUserService().searchUserByID(
								postcomment.getUser().getId());
						List<Postcommentcomment> postcommentcomments = PostService
								.getPostService().searchPostcommentcomment(
										postcomment.getId());
						out.println("<div class=\"row-fluid\">");
						out.println("	<div class=\"span12\">");
						out.println("	<div class=\"thumbnail\">");
						out.println("		<div class=\"row-fluid\">");
						out.println("			<div class=\"span2\">");
						out.println("				<img alt=\"140x140\" src=\"userheadimage?userID="
								+ commenter.getId()
								+ "\" width=\"100\" height=\"100\" />");
						out.println("				<p>");
						out.println("					<a href=\"#\">" + commenter.getName()
								+ "</a>");
						out.println("				</p>");
						out.println("				<p>");
						out.println("					" + postcomment.getAddtime().toLocaleString()
								+ "");
						out.println("				</p>");
						out.println("			</div>");
						out.println("			<div class=\"span10\">");
						String content = postcomment.getContent();
						/* content = content.replaceAll(" ", "&nbsp;");
						content = content.replaceAll("\"", "&quot;");
						content = content.replaceAll(">", "&gt;");
						content = content.replaceAll("<", "&lt;");
						content = content.replaceAll("\n", "<br>");
						content = new Parser().parser(content); */
						out.println("				" + content + "");

						out.println("<br>");
						out.println("<br>");
						out.println("<br>");
						out.println("<br>");
						out.println("<div class=\"row-fluid\">");
						out.println("	<div class=\"span1\">");
						out.println("	</div>");
						out.println("	<div class=\"span11\">");
						out.println("		<table class=\"table\">");

						if (postcommentcomments.size() > 0) {

							for (Postcommentcomment postcommentcomment : postcommentcomments) {
								User commentcommenter = UserService.getUserService()
										.searchUserByID(
												postcommentcomment.getUser().getId());

								out.println("<tr><td>");
								out.println("	<div class=\"row-fluid\">");
								out.println("		<div class=\"span1\">");
								out.println("			<a href=\"#\">"
										+ commentcommenter.getName() + "</a>");
								out.println("		</div>");
								out.println("		<div class=\"span11\">");
								out.println("			<span>:"
										+ postcommentcomment.getContent() + "</span>");
								out.println("		</div>");
								out.println("	</div>");
								out.println("</td></tr>");

							}
						}
						out.println("<tr><td>");
						out.println("	<div class=\"row-fluid\">");
						out.println("		<div class=\"span10\">");
						out.println("			<textarea type=\"text\" required rows=\"1\" class=\"span12\" id=\"comment_text_"
								+ postcomment.getId() + "\"></textarea>");
						out.println("		</div>");
						out.println("		<div class=\"span2\">");
						out.println("			<button class=\"btn\" type=\"button\" onclick=\"comment_add("
								+ postcomment.getId() + ");\">回复</button>");
						out.println("		</div>");
						out.println("	</div>");
						out.println("</td></tr>");

						out.println("		</table>");
						out.println("	</div>");
						out.println("</div>");
						out.println("");
						out.println("");

						out.println("			</div>");
						out.println("		</div>");
						out.println("	</div>");
						out.println("	</div>");
						out.println("</div>");
					}
				%>

				<div style="margin-top: 30px">
					<div style="margin-bottom: 5px">回复帖子：</div>
					<script id="editor" type="text/plain" style="height:250px;"></script>
				</div>
				<script>
					var ue = UE.getEditor('editor');
				</script>
				<div style="margin-top: 20px;">
					<input style="background: darkred" class="btn btn-primary"
						value="提交" type="button" onclick="reply();">
				</div>
			</div>
		</div>
	</div>
	<jsp:include page="footer.jsp" flush="true"></jsp:include>
	<script>
		function comment_show(comment_id) {
			var text_ele = document
					.getElementById("comment_text_" + comment_id);
			var add_ele = document.getElementById("comment_add_" + comment_id);
			var show_ele = document
					.getElementById("comment_show_" + comment_id);
			console.log(text_ele);
			console.log(add_ele);
			if (!add_ele || !text_ele) {
				return;
			}
			if (text_ele.style.display == 'none') {
				text_ele.style.display = '';
				add_ele.style.display = '';
				show_ele.value = '收起';
			} else {
				text_ele.style.display = 'none';
				add_ele.style.display = 'none';
				show_ele.value = '回复';
			}
		}

		function comment_add(comment_id) {
			var text_ele = document
					.getElementById("comment_text_" + comment_id);
			if (!text_ele) {
				return;
			}
			var text = text_ele.value;
			if (text.length < 5) {
				alert('不能少于5个字');
				return;
			}
			addCommentAjax(comment_id, text);
		}

		function addCommentAjax(comment_id, content) {
			$.ajax({
				type : "POST",
				url : 'ajax/addpostcommentcomment',
				data : {
					comment_id : comment_id,
					content : content
				},
				dataType : 'json',
				async : false,
				success : function(data) {
					if (data.success) {
						alert('回复成功。');
						location = '';
					} else {
						alert('操作失败。');
					}
				},
				error : function(err) {
					alert('请先登录');
				}
			});
		}

		function reply() {
			var contentTxt = ue.getContentTxt();
			//var content = document.getElementById('content').value;
			if (!ue.hasContents()) {
				alert('回复内容不能为空。');
				return;
			}
			var content = ue.getContent();
			console.log(content);
			replyAjax(content);
		}

		function support(support) {
			supportAjax(support);
		}

		function supportAjax(support) {
			$.ajax({
				type : "GET",
				url : 'ajax/addpostsupport',
				data : {
					postID :
	<%=postID%>
		,
					support : support
				},
				dataType : 'json',
				async : false,
				success : function(data) {
					if (data.success) {
						alert('操作成功。');
						location = '';
					} else {
						alert('操作失败。');
					}
				},
				error : function(err) {
					alert('请先登录');
				}
			});
		}

		function replyAjax(content) {
			$.ajax({
				type : "POST",
				url : 'ajax/addpostcomment',
				data : {
					postID :
	<%=postID%>
		,
					content : content
				},
				dataType : 'json',
				async : false,
				success : function(data) {
					if (data.success) {
						alert('回复成功。');
						location = '';
					} else {
						alert('回复失败。');
					}
				},
				error : function(err) {
					alert('请先登录');
				}
			});
		}
	</script>
</body>
</html>