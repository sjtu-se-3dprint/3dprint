<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="service.GetLoginUserService" %>
<%@ page import="entity.*" %>
<%@ page import="database.*" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>3D打印机板块</title>
</head>
<body>
	<jsp:include page="header.jsp" flush="true"></jsp:include>
	<%
		String first = request.getParameter("first");
		String second = request.getParameter("second");
		if(first == null || second == null){
			return;
		}
		/* first = new String(first.getBytes("ISO-8859-1"), "UTF-8");
		second = new String(second.getBytes("ISO-8859-1"), "UTF-8"); */ 
	%>
<div class="container-fluid">
<div class='container'>
<div class="row-fluid">
    <div class="span2">
    </div>
    <div class="span12">
        <div class="panel-heading">
		<ul class="breadcrumb" style="">
                    <li>
                        <a href="forum.jsp">论坛首页</a> <span class="divider">/</span>
                    </li>
                    <li class="active">
                        <%=first + "-" + second %>
                    </li>
                    <li style="float:right">
        				<input style="float: right;background: #000000" onclick="postMessage()"
                                              class="btn btn-primary" value="发帖" type="button">
					</li>
                </ul>
        </div>
            <table class="table" contenteditable="false">
                <thead>
                <tr>
                    <td>序号</td>
                    <td>帖子名</td>
                    <td>发帖人</td>
                    <td>时间</td>
                    <td>回复数</td>
                </tr>
                </thead>
                <tbody>
                <%
                	List<Post> posts = PostService.getPostService().searchPostByCategoryStatus(first, second, "normal");
                	int i = 1;
                	for(Post post: posts){
                		User user = UserService.getUserService().searchUserByID(post.getUser().getId());
                		out.println("<tr class=\"one-row\" onclick=\"loadMessage(" + post.getId() + ")\">");
                		out.println("    <td>" + i++ + "</td>");
                		out.println("    <td>" + post.getTitle() + "</td>");
                		out.println("    <td>" + user.getName() + "</td>");
                		out.println("    <td>"+ post.getAddtime() + "</td>");
                		out.println("    <td>" + post.getResponse() + "</td>");
                		out.println("</tr>");
                	}
                %>
                </tbody>
            </table><br><br>
    </div>
    <div class="span2">
    </div>
</div>
</div>
</div>
<script>
    function loadMessage(id){
        window.location.href = "forum_content.jsp?first=<%=first%>&second=<%=second%>&id=" + id;
    }
    function postMessage(){
        window.location.href = "forum_newpost.jsp?first=<%=first%>&second=<%=second%>";
    }
</script>
	
</body>
</html>