<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page import="entity.*, database.*"%>
<%@ page import="java.util.List"%>
<!DOCTYPE html>
<html>
<head lang="en">
<meta charset="UTF-8">
<title></title>
<link rel="stylesheet" href="./css/bootstrap.min.css">
<style type="text/css">
body {
	background-color: #f5f5f5;
}
</style>
<style type="text/css">
.tp1 {
	text-align: center;
	color: #666;
	line-height: 30px;
	padding-bottom: 10px;
}

p {
	display: block;
	-webkit-margin-before: 1em;
	-webkit-margin-after: 1em;
	-webkit-margin-start: 0px;
	-webkit-margin-end: 0px;
	background-color: #ffffff;
}

#editor {
	font-size: 11pt;
	line-height: 30px;
	color: #313131;
	margin-bottom: 20px;
	margin-top: 20px;
	height: 30px;
	text-align: right;
}
</style>
</head>
<body>
	<jsp:include page="header.jsp" flush="true"></jsp:include>
	<%
		// 获取模型信息
		String lessonID = request.getParameter("id");
		int id = 0;
		try {
			id = Integer.parseInt(lessonID);
		} catch (Exception e) {
			return;
		}
		Lesson lesson = LessonService.getModelService()
				.selectLessonById(id);
		System.out.println(lesson.getAddtime());
		System.out.println(lesson.getId());
		System.out.println(lesson.getUserID());
		System.out.println(lesson.getContent());
		User user = UserService.getUserService().searchUserByID(
				lesson.getUserID());
	%>
	<div class="container">
		<div class="row">
			<div class="span12">
				<div class="row">
					<div class="span8" style="padding-left: 10px;">
						<ul class="breadcrumb">
							<li><a href="study.jsp">学习</a> <span class="divider">/</span>
							</li>
							<li><a href="list.jsp">入门教程</a> <span class="divider">/</span>
							</li>
							<li class="active">正文</li>
						</ul>

						<h3 style="text-align: center;">
							&nbsp;&nbsp;
							<%=lesson.getTitle()%></h3>
						<ul class="tp1">
							<small>时间:</small><%=lesson.getAddtime().toLocaleString()%>
							<!-- <small>来源:</small>网络 -->
							<small>作者:</small><%=user.getName()%>
							<!-- <small>点击:</small>684次 -->
						</ul>

					</div>
					<div class="span4"></div>
				</div>
				<div class="row">
					<div class="span8"
						style="background-color: #ffffff; padding-left: 15px; padding-right: 15px;">
						<div><%=lesson.getContent()%></div>
						<div id="editor">
							(责任编辑：<%=user.getName()%>)
						</div>
					</div>
					<div class="span3">
						<div class="thumbnail" style="background-color: #a9dba9">
							<div class="caption">
								<span class="title" style="float: left;">随便读读</span> <a
									href="ST_3Dprint.jsp" style="float: right;">更多>></a>
							</div>
							<hr>
							<%
								List<Lesson> randLessons = LessonService.getModelService()
										.selectRandomLessons();
								if (randLessons != null) {
									for (Lesson l : randLessons) {
							%>
							<div class="caption">
								<a href="lessons_new.jsp?id=<%=l.getId()%>"> <span> <%=l.getTitle() %> </span></a>
							</div>
							<%
								}
								}
							%>
						</div>
						<div class="row"
							style="border: 1px solid #c4e3f3; padding: 4px; background-color: #ffffff; margin-top: 20px;">
							<h4 class="title">最新教程</h4>
							<hr>
							<div class="span12" style="margin-top: 8px">
								<ul class="unstyled" style="margin-left: 40px;">
									<%
										List<Lesson> newLessons = LessonService.getModelService()
												.selectNewLessons();
										if (newLessons != null) {
											for (Lesson l : newLessons) {
									%><li><h4>
											<a href="lessons_new.jsp?id=<%=l.getId()%>"><%=l.getTitle()%></a>
										</h4></li>
									<%
										}
										}
									%>
								</ul>
							</div>

						</div>
					</div>
				</div>
				<div class="row">
					<div class="span8"
						style="background-color: #ffffff; margin-top: 10px;">
						<h4>
							上一篇：
							<%
							Lesson previousLesson = LessonService.getModelService()
									.selectPreviousLessonById(id);
							if (previousLesson != null) {
						%><a href="lessons_new.jsp?id=<%=previousLesson.getId()%>"><%=previousLesson.getTitle()%></a>
							<%
								} else {
							%>已经是第一篇了<%
								}
							%>
						</h4>
						<h4>
							下一篇：
							<%
							Lesson nextLesson = LessonService.getModelService()
									.selectNextLessonById(id);
							if (nextLesson != null) {
						%><a href="lessons_new.jsp?id=<%=nextLesson.getId()%>"><%=nextLesson.getTitle()%></a>
							<%
								} else {
							%>已经是最后一篇了<%
								}
							%>
						</h4>
					</div>
					<div class="span4"></div>
				</div>
				<!-- <div class="row">
					<div class="span8" style="margin-top: 20px;">
						<div class="container">
							<div class="span1">
								<img alt="140x140" src="./img/user1.jpg"
									style="width: 60px; float: left;" />
							</div>
							<div class="span6">
								<form style="float: left">
									<fieldset>
										<label style="float: right">您可以输入140字</label> <input
											placeholder="随便说点什么吧......" name="comment" size="140"
											type="text" style="width: 100%; height: auto;" />
										<button type="submit" class="btn" style="float: right;">提交</button>
									</fieldset>
								</form>
							</div>
						</div>
						<div>
							<span>0条评论</span>
							无评论
							<div style="text-align: center;">
								<p>
									<span style="display: inline-block; vertical-align: middle;"></span>
									<span class="WB_icon_txt">还没有人评论过，赶快抢沙发吧！</span>
								</p>
							</div>
							/无评论
						</div>
					</div>
					<div class="span4"></div>
				</div> -->
			</div>
		</div>
	</div>
</body>
</html>