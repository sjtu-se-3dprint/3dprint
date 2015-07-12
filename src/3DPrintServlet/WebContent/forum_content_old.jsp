<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="service.GetLoginUserService" %>
<%@ page import="entity.*" %>
<%@ page import="database.*" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Stack" %>
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
		
		/*String first = request.getParameter("first");
		String second = request.getParameter("second");
		if(first == null || second == null){
			return;
		}
		first = new String(first.getBytes("ISO-8859-1"), "UTF-8");
		second = new String(second.getBytes("ISO-8859-1"), "UTF-8"); 
		*/
		User user = GetLoginUserService.service(request);
	%>
<div class="container-fluid">
<div class="container">
    <div class="span12">
        <div class="panel-heading"><h4></h4>
        </div>
        <ul class="breadcrumb" style="">
                    <li>
                        <a href="forum.jsp">论坛首页</a> 
                        <span class="divider">/</span>
                    </li>
                    <%
                	Post post = PostService.getPostService().searchPostById(postID);
                    %>
                    <li>
                        <a href="forum_list_3Dprinter.jsp?first=<%=post.getFirstCategory()%>&second=<%=post.getSecondCategory()%>"><%=post.getFirstCategory() + "-" + post.getSecondCategory() %></a>
                        <span class="divider">/</span>
                    </li>
                    <li class="active">
                    	<%=post.getTitle() %>
                    </li>
                </ul>
        <table class="table" contenteditable="false" border="1px">
            <tbody>
            
            <%
class Item{
	private String content;
	private String head;
	private String htmlCode;
	
	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getHead() {
		return head;
	}

	public void setHead(String head) {
		this.head = head;
	}

	public String getHtmlCode() {
		return htmlCode;
	}

	public void setHtmlCode(String htmlCode) {
		this.htmlCode = htmlCode;
	}

	public String toString(){
		return "【" + head + "】【" + htmlCode + "】【" + content + "】";
	}
}
        class Parser{
            public String parser(String origin){
        		Stack<Item> stack = new Stack<Item>();
        		int left = 0;
        		int right = 0;
        		String html = "";
        		for( ; right < origin.length(); right++){
        			if('[' == origin.charAt(right)){
        				int nextR = origin.indexOf(']', right);
        				if(nextR == -1 || nextR-right > 30){
        					continue;
        				}
        				String i = origin.substring(right, nextR+1);
        				if(i.indexOf("[color=") == 0){
        					String color = i.substring("[color=".length(), i.length()-1);
        					if("red".equals(color)){
        						
        					}else if("green".equals(color)){
        						
        					}else if("blue".equals(color)){
        						
        					}else if("white".equals(color)){
        						
        					}else if("black".equals(color)){
        						
        					}else{
        						continue;
        					}
        					Item item = new Item();
        					item.setContent(html + origin.substring(left, right));
        					html = "";
        					item.setHead(i);
        					item.setHtmlCode("<span style=\"color:" + color + "\">");
        					right += i.length()-1;
        					left = right+1;
        					stack.push(item);
        				}else if(i.indexOf("[size=") == 0){
        					String size = i.substring("[size=".length(), i.length()-1);
        					if("small".equals(size) || "medium".equals(size) || "large".equals(size)){
        						
        					}else{
        						continue;
        					}
        					Item item = new Item();
        					item.setContent(html + origin.substring(left, right));
        					html = "";
        					item.setHead(i);
        					item.setHtmlCode("<span style=\"font-size:" + size + "\">");
        					right += i.length()-1;
        					left = right+1;
        					stack.push(item);
        				}else if("[u]".equals(i) || "[i]".equals(i) || "[b]".equals(i)){
        					Item item = new Item();
        					item.setContent(html + origin.substring(left, right));
        					html = "";
        					item.setHead(i);
        					item.setHtmlCode(i.replace('[', '<').replace(']', '>'));
        					right += i.length()-1;
        					left = right+1;
        					stack.push(item);
        				}else if("[/color]".equals(i)){
        					if(stack.isEmpty()){
        						continue;
        					}
        					Item item = stack.lastElement();
        					if(item == null || item.getHead().indexOf("[color=") != 0){
        						continue;
        					}
        					html = item.getContent() + item.getHtmlCode() + html + origin.substring(left, right) + "</span>";
        					stack.pop();
        					right += i.length()-1;
        					left = right+1;
        				}else if("[/size]".equals(i)){
        					if(stack.isEmpty()){
        						continue;
        					}
        					Item item = stack.lastElement();
        					if(item == null || item.getHead().indexOf("[size=") != 0){
        						continue;
        					}
        					html = item.getContent() + item.getHtmlCode() + html + origin.substring(left, right) + "</span>";
        					stack.pop();
        					right += i.length()-1;
        					left = right+1;
        				}else if("[/u]".equals(i) || "[/i]".equals(i) || "[/b]".equals(i)){
        					if(stack.isEmpty()){
        						continue;
        					}
        					Item item = stack.lastElement();
        					if(item == null || !item.getHead().equals(i.replace("/", ""))){
        						continue;
        					}
        					html = item.getContent() + item.getHtmlCode() + html + origin.substring(left, right) + i.replace('[', '<').replace(']', '>');
        					stack.pop();
        					right += i.length()-1;
        					left = right+1;
        				}
        			}
        		}
        		String allHtml = html + origin.substring(left);
        		while(!stack.isEmpty()){
        			Item i = stack.pop();
        			allHtml = i.getContent() + i.getHead() + allHtml;
        		}
        		return allHtml;
        	}
        }
            	User poster = UserService.getUserService().searchUserByID(post.getUser().getId());
            	Boolean isSupport = null;
            	if(user!=null){
            		isSupport = PostService.getPostService().isSupportPost(user.getId(), postID);
            	}
	            out.println("<tr>");
	            out.println("     <td width=\"100px\">");
	            out.println("         <p><b>发帖人：" + poster.getName() + "</b></p>");
	            out.println("         <p><b>发帖时间：" + post.getAddtime() + "</b></p>");
	            out.println("         <img src=\"userheadimage?userID=" + poster.getId() + "\" /></td>");
	            out.println("     <td style=\"position: relative\"><br>");
	            out.println("         <span style=\"margin-left: 0px\">" + post.getContent().replaceAll("\n", "<br>") + "</span>");
	            out.println("         <p align=\"right\" style=\"position:absolute;bottom:5px;right: 10px\">");
	            if(user != null && isSupport != null){
	            	out.println("           <button disabled onclick=\"support(true" + ");\">" + (isSupport?"已":"") + "支持(" + post.getSupport() + ")</button>");
		            out.println("           &nbsp");
		            out.println("           <button disabled onclick=\"support(false" + ");\">" + (isSupport?"":"已") + "反对(" + post.getOpposite() + ")</button>");
	            }else if(user != null){
	            	out.println("           <button onclick=\"support(true" + ");\">支持(" + post.getSupport() + ")</button>");
		            out.println("           &nbsp");
		            out.println("           <button onclick=\"support(false" + ");\">反对(" + post.getOpposite() + ")</button>");
	            }else{
	            	out.println("           <button disabled onclick=\"support(true" + ");\">支持(" + post.getSupport() + ")</button>");
		            out.println("           &nbsp");
		            out.println("           <button disabled onclick=\"support(false" + ");\">反对(" + post.getOpposite() + ")</button>");
	            }
	            out.println("           ");
	            out.println("         </p>");
	            out.println("     </td>");
	            out.println(" </tr>");
	            
	            List<Postcomment> postcomments = PostService.getPostService().searchPostcommentByPostStatus(postID, "normal");
	            for(Postcomment postcomment:postcomments){
	            	User commenter = UserService.getUserService().searchUserByID(postcomment.getUser().getId());
	            	List<Postcommentcomment> postcommentcomments = PostService.getPostService().searchPostcommentcomment(postcomment.getId());
	            	out.println("<tr>");
	            	out.println("    <td width=\"100px\">");
	            	out.println("        <p><b>楼层：" + postcomment.getFloor() + "</b></p>");
	            	out.println("        <p><b>回复人：" + commenter.getName() + "</b></p>");
	            	out.println("        <p><b>回复时间：" + postcomment.getAddtime() + "</b></p>");
	            	out.println("        <img src=\"userheadimage?userID=" + commenter.getId() + "\" /></td>");
	            	out.println("    <td style=\"position: relative\"><br>");
	            	String content = postcomment.getContent();
	            	content = content.replaceAll(" ", "&nbsp;");
	            	content = content.replaceAll("\"", "&quot;");
	            	content = content.replaceAll(">", "&gt;");
	            	content = content.replaceAll("<", "&lt;");
	            	content = content.replaceAll("\n", "<br>");
	            	content = new Parser().parser(content);
	            	out.println("        <span style=\"margin-left: 0px\">" + content + "</span><br>");
	            	if(postcommentcomments.size() > 0){
		            	out.println("<div style=\"margin-bottom:50px;margin-left:20px;margin-right:60px;padding:10px;background-color:#F5F5F5\">");
		            	out.println("<table class=\"table\">");
		            	for(Postcommentcomment postcommentcomment:postcommentcomments){
		            		User commentcommenter = UserService.getUserService().searchUserByID(postcommentcomment.getUser().getId());
		            		out.println("<tr>");
		            		out.println("<td><span style='color:blue'>" + commentcommenter.getName() + "</span>:");
		            		out.println("<span style=''>" + postcommentcomment.getContent() + "</span></td>");
		            		out.println("</tr>");
		            	}
		            	out.println("</table>");
		            	out.println("</div>");
	            	}
	            	out.println("        <p align=\"right\" style=\"position:absolute;bottom:5px;right: 10px\">");
	            	out.println("            <input style=\"display:none\" type=\"button\" value=\"发表\" onclick=\"comment_add(" + postcomment.getId() + ");\" id=\"comment_add_" + postcomment.getId() + "\">");
	            	out.println("            <input type=\"button\" value=\"回复\" onclick=\"comment_show(" + postcomment.getId() + ");\" id=\"comment_show_" + postcomment.getId() + "\">");
	            	out.println("        </p>");
	            	out.println("        <textarea style=\"display:none;position:absolute;width:80%;left:5%; bottom:0px;\" id=\"comment_text_" + postcomment.getId() + "\"></textarea>");
	            	out.println("");
	            	out.println("    </td>");
	            	out.println("</tr>");
	            }
            %>
            </tbody>
        </table><br><br><br>

        <div class="panel-heading"><h4>回复帖子</h4>
        </div>
        <table class="table" contenteditable="true" border="1px">
            <tbody>
            <!-- <tr>
                <b>回帖人：</b><b style="margin-left: 150px">回帖时间：</b>
            </tr> -->
            <tr>
                <div class="row-fluid">
                    <div class="span12">
                        <div class="control-group"><!-- Select Basic --><br>
                            <label class="control-label">内容: </label>
 
                            <div class="controls">
                                <textarea id="content" type="text" required rows="5" class="span9"></textarea>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row-fluid">
                    <div class="span12">
                        <input onclick="reply();" class="btn btn-primary" value="回复他" type="submit">
                    </div>
                </div>
            </tr>
            </tbody>
        </table>
    </div>
</div>
</div>
	<jsp:include page="footer.jsp" flush="true"></jsp:include>
	<script>
	
		function comment_show(comment_id){
			var text_ele = document.getElementById("comment_text_" + comment_id);
			var add_ele = document.getElementById("comment_add_" + comment_id);
			var show_ele = document.getElementById("comment_show_" + comment_id);
			console.log(text_ele);
			console.log(add_ele);
			if(!add_ele || !text_ele){
				return;
			}
			if(text_ele.style.display == 'none'){
				text_ele.style.display = '';
				add_ele.style.display = '';
				show_ele.value = '收起';
			}else{
				text_ele.style.display = 'none';
				add_ele.style.display = 'none';
				show_ele.value = '回复';
			}
		}
		
		function comment_add(comment_id){
			var text_ele = document.getElementById("comment_text_" + comment_id);
			if(!text_ele){
				return;
			}
			var text = text_ele.value;
			if(text.length < 5){
				alert('不能少于5个字');
				return;
			}
			addCommentAjax(comment_id, text);
		}
		
		function addCommentAjax(comment_id, content){
			$.ajax({
				type: "POST",
				url: 'ajax/addpostcommentcomment',
				data: {comment_id:comment_id,content:content},
				dataType: 'json',
				async: false,
				success: function(data){
					if(data.success){
						alert('回复成功。');
						location = '';
					}else{
						alert('操作失败。');
					}
				},
				error: function(err){
					alert('请先登录');
				}
			});
		}
	
		function reply(){
			var content = document.getElementById('content').value;
			if(content == ''){
				alert('回复内容不能为空。');
				return;
			}
			replyAjax(content);
		}

		function support(support){
			supportAjax(support);
		}

		function supportAjax(support){
			$.ajax({
				type: "GET",
				url: 'ajax/addpostsupport',
				data: {postID:<%=postID%>,support:support},
				dataType: 'json',
				async: false,
				success: function(data){
					if(data.success){
						alert('操作成功。');
						location = '';
					}else{
						alert('操作失败。');
					}
				},
				error: function(err){
					alert('请先登录');
				}
			});
		}

		function replyAjax(content){
			$.ajax({
				type: "POST",
				url: 'ajax/addpostcomment',
				data: {postID:<%=postID%>,content:content},
				dataType: 'json',
				async: false,
				success: function(data){
					if(data.success){
						alert('回复成功。');
						location = '';
					}else{
						alert('回复失败。');
					}
				},
				error: function(err){
					alert('请先登录');
				}
			});
		}
	</script>
</body>
</html>