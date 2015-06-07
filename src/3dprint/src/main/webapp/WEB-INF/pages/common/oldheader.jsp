<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<link rel="stylesheet"
	href="<%=request.getContextPath()%>/css/old/bootstrap.min.css" />

<!-- 为什么我用3.3.4版本的bootstrap不行，换回原来项目里的bootstrap样式就好了？ -->

<!-- <link rel="stylesheet" -->
<%-- 	href="<%=request.getContextPath()%>/css/bootstrap-3.3.4-dist/css/bootstrap.min.css" /> --%>

<link rel="stylesheet"
	href="<%=request.getContextPath()%>/css/bootstrap-table-master/src/bootstrap-table.css" />

<script src="<%=request.getContextPath()%>/js/jquery-1.11.1.min.js"></script>
<script
	src="<%=request.getContextPath()%>/css/bootstrap-3.3.4-dist/js/bootstrap.min.js"></script>
<script
	src="<%=request.getContextPath()%>/css/bootstrap-table-master/src/bootstrap-table.js"></script>
<script
	src="<%=request.getContextPath()%>/css/bootstrap-table-master/src/locale/bootstrap-table-zh-CN.js"></script>

<div>
	<div class="row-fluid">
		<div class="span12">
			<div class="navbar">
				<div class="container row">
					<div class="span4 main_logo">
						<div class="pull-left l_margin_top_15">
							<a href=""> <img alt="logo"
								src="<%=request.getContextPath()%>/image/easyprint.png"
								style="height: 50px;">
							</a>
						</div>
					</div>
					<div class="span7 pull-right">
						<ul class="nav pull-right"
							style="font-weight: bold; font-size: 16px;">
							<li class="divider-vertical"></li>
							<li><a href="<%=request.getContextPath()%>/view/login">
									<div style="margin: 2px; padding: 0; display: inline">登录</div>
							</a></li>
							<li class="divider-vertical"></li>
							<li><a href="">
									<div style="margin: 2px; padding: 0; display: inline">注册</div>
							</a></li>
							<li class="divider-vertical"></li>
						</ul>
					</div>
				</div>
				<div class="navbar-inner">
					<div class="container-fluid">
						<a class="btn btn-navbar"
							data-target=".navbar-responsive-collapse" data-toggle="collapse"></a>
						<a class="brand" href="index.jsp">3D打印服务平台</a>
						<div class="nav-collapse collapse navbar-responsive-collapse">
							<ul class="nav pull-right">
								<li><a href="index.jsp" onClick="">首 页</a></li>
								<li class="divider-vertical"></li>
								<li class="dropdown"><a href="study.jsp" onClick="">入门指南</a>
								</li>
								<li class="dropdown"><a class="dropdown-toggle"
									data-toggle="dropdown"><span class="caret"></span> </a>
									<ul class="dropdown-menu">
										<li><a href="list.jsp" onClick="">入门教程</a></li>
										<li><a href="ST_1.jsp" onClick="">什么是3D打印</a></li>
										<li><a href="ST_3Dprint.jsp" onClick="">怎样建模</a></li>
										<li><a href="ST_print1.jsp" onClick="">手把手教程</a></li>
									</ul></li>
								<li class="dropdown"><a href="forum.jsp" onClick="">学习交流</a>
								</li>
								<li class="dropdown"><a class="dropdown-toggle"
									data-toggle="dropdown"><span class="caret"></span> </a>

									<ul class="dropdown-menu">
										<li><a href="news.jsp">新闻资讯</a></li>
										<li><a href="forum.jsp">论坛首页</a></li>
									</ul></li>

								<li class="dropdown"><a href="modellist.jsp" onClick="">模型展示</a>
								</li>
								<li class="dropdown"><a class="dropdown-toggle"
									data-toggle="dropdown"><span class="caret"></span> </a>

									<ul class="dropdown-menu">
										<li><a href="modellist.jsp?style=时尚" onClick="">时尚类</a></li>
										<li><a href="modellist.jsp?style=简约">简约类</a></li>
										<li><a href="modellist.jsp?style=实用">实用类</a></li>
										<li><a href="modellist.jsp?style=精细">精细类</a></li>
									</ul></li>
								<li class="dropdown"><a href="model_upload.jsp" onClick="">模型上传</a>
								</li>
								<li><a href="about.jsp" onClick="">了解更多</a></li>
								<li class="dropdown"><a class="dropdown-toggle"
									data-toggle="dropdown"><span class="caret"></span> </a>
									<ul class="dropdown-menu">
										<li><a href="show_material.jsp">打印材料说明</a></li>
										<li><a href="NR_printer.jsp">3D打印机</a></li>
										<li><a href="pay.jsp">支付说明</a></li>
										<li><a href="buyabout.jsp">定制打印说明</a></li>
									</ul></li>
							</ul>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>