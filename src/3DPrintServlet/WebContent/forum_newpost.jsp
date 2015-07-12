<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="service.GetLoginUserService,entity.*, database.*" %>
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
	
		String first = request.getParameter("first");
		String second = request.getParameter("second");
		if(first == null || second == null){
			return;
		}
		/* first = new String(first.getBytes("ISO-8859-1"), "UTF-8");
		second = new String(second.getBytes("ISO-8859-1"), "UTF-8");  */
	%>
<div class="container-fluid">
<form class="form-horizontal">
    <center><legend></legend></center>
    <div class="controls">
        <div class="row-fluid">
            <div class="span12">
                <div class="control-group">
                    <label class="control-label">新帖模块: </label>

                    <div class="controls">
                        <select class="input-xlarge span11" style="width: auto" required disabled>
                            <option value="<%=first%>"><%=first%></option>
                        </select>
                        &nbsp;
                        <select class="input-xlarge span11" style="width: auto" required disabled>
                            <option value="<%=second%>"><%=second%></option>
                        </select>
                    </div>
                </div>
            </div>
        </div>
        <div class="row-fluid">
            <div class="span12">
                <div class="control-group"><!-- Select Basic -->
                    <label class="control-label">主题: </label>
                    <div class="controls">
                        <input id="title" name="parentPlanCode" type="text" class="input-xlarge span8">
                    </div>
                </div>
            </div>
        </div>
        <div class="row-fluid">
            <div class="span12">
                <div class="control-group"><!-- Select Basic -->
                    <label class="control-label">内容: </label>

                    <div class="controls">
                        <textarea id="content" type="text" required rows="5" class="span8"></textarea>
                    </div>
                </div>
            </div>
        </div>
        <div class="row-fluid">
            <div class="span12">
                <div class="control-group"><!-- Select Basic -->
                    <div class="controls">
                        <input onclick="submitpost();" style="background: darkred" class="btn btn-primary" value="提交" type="button">
                    </div>
                </div>
            </div>
        </div>
    </div>
</form>
</div>
	<jsp:include page="footer.jsp" flush="true"></jsp:include>
	<script>
		function submitpost(){
			var title = document.getElementById('title').value;
			var content = document.getElementById('content').value;
			if(title == ''){
				alert('请填写主题。');
				return;
			}
			if(content == ''){
				alert('请填写内容。');
				return;
			}
			addpostAjax(title,content);
		}

		function addpostAjax(title, content){
			$.ajax({
				type: "POST",
				url: 'ajax/addpost',
				data: {first:'<%=first%>',second:'<%=second%>',title:title,content:content},
				dataType: 'json',
				async: false,
				success: function(data){
					if(data.success){
						alert('发帖成功。');
						location = 'forum_list_3Dprinter.jsp?first=<%=first%>&second=<%=second%>';
					}else{
						alert('发帖失败。');
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