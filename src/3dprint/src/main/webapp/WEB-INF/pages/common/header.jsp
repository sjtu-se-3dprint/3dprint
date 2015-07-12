<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="security"
	uri="http://www.springframework.org/security/tags"%>

<!-- 为什么我用3.3.4版本的bootstrap不行，换回原来项目里的bootstrap样式就好了？ -->

<link rel="stylesheet"
	href="<%=request.getContextPath()%>/css/bootstrap-3.3.4-dist/css/bootstrap.min.css" />

<link rel="stylesheet"
	href="<%=request.getContextPath()%>/css/bootstrap-table-master/src/bootstrap-table.css" />

<script src="<%=request.getContextPath()%>/js/jquery-1.11.1.min.js"></script>
<script
	src="<%=request.getContextPath()%>/css/bootstrap-3.3.4-dist/js/bootstrap.min.js"></script>
<script
	src="<%=request.getContextPath()%>/css/bootstrap-table-master/src/bootstrap-table.js"></script>
<script
	src="<%=request.getContextPath()%>/css/bootstrap-table-master/src/locale/bootstrap-table-zh-CN.js"></script>

<script src="<%=request.getContextPath()%>/js/util.js"></script>

<nav class="navbar navbar-default">
	<div class="container-fluid">
		<div class="navbar-header">
			<a class="navbar-brand" href="<%=request.getContextPath()%>/view/index">
				<img alt="Brand" src="<%=request.getContextPath()%>/image/easyprint.png" width="140" height="20">
			</a>
		</div>

		<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav">
				<li class="dropdown">
                     <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">开始学习吧<span class="caret"></span></a>
                     <ul class="dropdown-menu">
                         <li><a href="#">了解3D打印</a></li>
                         <li><a href="#">打印机入门</a></li>                    
                         <li><a href="#">一起学设计</a></li>
                     </ul>
                 </li>
                 <li class="dropdown">
                     <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">资讯与交流<span class="caret"></span></a>
                     <ul class="dropdown-menu">
                         <li><a href="#">新闻资讯</a></li>
                         <li><a href="#">网站论坛</a></li>                    
                     </ul>
                 </li>
                 <li class="dropdown">
                     <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">3D打印服务<span class="caret"></span></a>
                     <ul class="dropdown-menu">
                     	 <li><a href="#">我们如何帮你实现</a></li>
                         <li><a href="#">工业打印机</a></li>
                         <li><a href="#">3D打印材料</a></li>       
                         <li><a href="#">3D模型上传</a></li>              
                     </ul>
                 </li>
                 <li class="dropdown">
                     <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">模型商城<span class="caret"></span></a>
                     <ul class="dropdown-menu">
                     	 <li><a href="#">全部</a></li>
                         <li><a href="#">艺术</a></li>
                         <li><a href="#">饰件</a></li>       
                         <li><a href="#">家居饰品</a></li>  
                         <li><a href="#">玩具</a></li>
                         <li><a href="#">更多</a></li>                
                     </ul>
                 </li>
                 <li class="dropdown">
                     <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">关于EasyPrint<span class="caret"></span></a>
                     <ul class="dropdown-menu">
                     	 <li><a href="#">3D打印平台</a></li>
                         <li><a href="#">如何运作</a></li>
                         <li><a href="#">设计团队</a></li>       
                         <li><a href="#">客服中心</a></li>
                         <li><a href="#">帮助中心</a></li>              
                     </ul>
                 </li>
			</ul>
			
			<!-- 导航栏的权限显示部分 -->
			<ul class="nav navbar-nav navbar-right">
				<!-- 权限检查，登录用户 -->
				<security:authorize access="!hasRole('ROLE_ANONYMOUS')">
					<li>
						<a href="#">
							<span class="text-primary">
								<security:authentication property="principal.username"></security:authentication>
							</span>
						</a>
					</li>
					<li class="dropdown">
						<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">用户管理
								<span class="caret"></span>
						</a>
						<ul class="dropdown-menu" role="menu">
							<security:authorize access="hasRole('ROLE_ADMIN')">
								<li><a href="<%=request.getContextPath()%>/view/admin/index">Admin中心</a></li>
							</security:authorize>
							<security:authorize access="hasRole('ROLE_MANAGER')">
								<li><a href="<%=request.getContextPath()%>/view/manager/index">Manager中心</a></li>
							</security:authorize>
							<security:authorize access="hasRole('ROLE_USER')">
								<li><a href="<%=request.getContextPath()%>/view/user/index">用户中心</a></li>
								<li><a href="#">购物车</a></li>
							</security:authorize>
							<li class="divider"></li>
							<li><a href="<%=request.getContextPath()%>/view/logout">注销</a></li>
						</ul>
					</li>
				</security:authorize>
				
				<!-- 未登录用户能够看见登录按钮 -->
				<security:authorize access="hasRole('ROLE_ANONYMOUS')">
					<li>
						<button type="button" class="btn btn-primary btn-sm"
							style="margin: 9px"
							onclick="javascript:window.location.href='<%=request.getContextPath()%>/view/login'">登录</button>
					</li>
				</security:authorize>
				<li><a href="<%=request.getContextPath()%>/view/register">注册</a></li>
			</ul>
		</div>
	</div>
</nav>