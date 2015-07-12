<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="service.GetLoginUserService" %>
<%@ page import="entity.*" %>
<%@ page import="database.*" %>
<%@ page import="java.util.List" %>
<link rel="stylesheet" href="./css/bootstrap.min.css" />
<div>
    <div class="row-fluid">
        <div class="span12">
            <div class="navbar">
                <div class="container row">
                    <div class="span4 main_logo">
                        <div class="pull-left l_margin_top_15">
                            <a href="">
                                <img alt="logo" src="./img/easyprint.png" style="height: 50px;">

                            </a>
                        </div>
                    </div>
                    <%
	            		User user = GetLoginUserService.service(request);
                    	if(user == null){
                            out.println("<div class=\"span7 pull-right\">");
                            out.println("    <ul class=\"nav pull-right\">");
                            out.println("        <li class=\"divider-vertical\"></li>");
                            out.println("        <li style=\"font-weight: bold; font-size: 16px;\">");
                            out.println("            <a href=\"javascript: void(0);\" onclick=\"toLoginPage();\" >");
                            out.println("                <div style=\"margin:2px;padding:0;display:inline\">");
                            out.println("                    	登录");
                            out.println("                </div>");
                            out.println("            </a>");
                            out.println("        </li>");
                            out.println("        <li class=\"divider-vertical\"></li>");
                            out.println("        <li>");
                            out.println("            <a href=\"register.jsp\" >");
                            out.println("                <div style=\"margin:2px;padding:0;display:inline\">");
                            out.println("						注册");
                            out.println("                </div>");
                            out.println("           </a>");
                            out.println("        </li>");
                            out.println("        <li class=\"divider-vertical\"></li>");
                            out.println("    </ul>");
                            out.println("</div>");
                    	}else{
                    		List<Shopcar> shopcars = ShoppingService.getShoppingService().searchShopcarsByUser(user.getId());
                    		out.println("<div class=\"span8 pull-right\">");
                    		out.println("    <ul class=\"nav pull-right\">");
                    		if("user".equals(user.getAuthority())){
	                    		out.println("        <li>");
	                    		out.println("            <a href=\"shoppingcart.jsp\" >");
	                    		out.println("                <div style=\"margin:2px;padding:0;display:inline\">");
	                    		out.println("                    购物车");
	                    		out.println("                    <span>(" + shopcars.size() + ")</span>");
	                    		out.println("                </div>");
	                    		out.println("            </a>");
	                    		out.println("        </li>");
                    		}
                    		out.println("        <li class=\"divider-vertical\"></li>");
                    		out.println("        <li>");
                    		if("user".equals(user.getAuthority())){
	                    		out.println("            <a href=\"user.jsp\" >");
	                    		out.println("                <div style=\"margin:2px;padding:0;display:inline\">");
	                    		out.println("                    <i class=\"icon-user\"></i>");
	                    		out.println("                    个人中心");
	                    		out.println("                </div>");
	                    		out.println("            </a>");
                    		}else if("manager".equals(user.getAuthority())){
                    			out.println("            <a href=\"manager.jsp\" >");
	                    		out.println("                <div style=\"margin:2px;padding:0;display:inline\">");
	                    		out.println("                    <i class=\"icon-user\"></i>");
	                    		out.println("                    manager page");
	                    		out.println("                </div>");
	                    		out.println("            </a>");
                    		}else if("admin".equals(user.getAuthority())){
                    			out.println("            <a href=\"admin.jsp\" >");
	                    		out.println("                <div style=\"margin:2px;padding:0;display:inline\">");
	                    		out.println("                    <i class=\"icon-user\"></i>");
	                    		out.println("                    admin page");
	                    		out.println("                </div>");
	                    		out.println("            </a>");
                    		}
                    		out.println("        </li>");
                    		out.println("        <li class=\"divider-vertical\"></li>");
                    		out.println("        <li>");
                    		out.println("            <a href=\"#\" onclick=\"logout();\">");
                    		out.println("                <div style=\"margin:2px;padding:0;display:inline\">");
                    		out.println("                    <i class=\"icon-off\"></i>");
                    		out.println("                    注销");
                    		out.println("                </div>");
                    		out.println("            </a>");
                    		out.println("        </li>");
                    		out.println("        <li class=\"divider-vertical\"></li>");
                    		out.println("    </ul>");
                    		out.println("</div>");
                    	}
					%>
                </div>
                <div class="navbar-inner">
                    <div class="container-fluid">
                        <a class="btn btn-navbar" data-target=".navbar-responsive-collapse" data-toggle="collapse"></a> <a class="brand" href="index.jsp">3D打印服务平台</a>
                        <div class="nav-collapse collapse navbar-responsive-collapse">
                            <ul class="nav pull-right">
                                <li>
                                    <a href="index.jsp" onClick="">首 页</a>
                                </li>
                                <li class="divider-vertical">
                                </li>
                                <li class="dropdown">
                                    <a href="study.jsp" onClick="" >入门指南</a>
                                </li>
                                <li class="dropdown">
                                    <a class="dropdown-toggle" data-toggle="dropdown"><span class="caret"></span> </a>
                                    <ul class="dropdown-menu">
                                <!--  <li>
                                            <a href="NR_3Dprint.jsp" onClick="">了解3D打印</a>
                                        </li>
                                        <li>
                                            <a href="NR_princeple.jsp" onClick="">学习如何打印</a>
                                        </li>
                                        <li>
                                            <a href="help.jsp" onClick="">我们帮您实现</a>
                                        </li>
                                        <li>
                                            <a href="study.jsp" onClick="">学习指南</a>
                                        </li>
                                        -->
                                        <li>
                                            <a href="list.jsp" onClick="">入门教程</a>
                                        </li>
                                        <li>
                                            <a href="ST_1.jsp" onClick="">什么是3D打印</a>
                                        </li>
                                        <li>
                                            <a href="ST_3Dprint.jsp" onClick="">怎样建模</a>
                                        </li>
                                        <li>
                                            <a href="ST_print1.jsp" onClick="">手把手教程</a>
                                        </li>
                                    </ul>
                                </li>
                                <li class="dropdown">
                                    <a href="forum.jsp" onClick="" >学习交流</a>
                                </li>
                                <li class="dropdown">
                                    <a class="dropdown-toggle" data-toggle="dropdown"><span class="caret"></span> </a>

                                    <ul class="dropdown-menu">
                                        <li>
                                            <a href="news.jsp">新闻资讯</a>
                                        </li>
                                        <li>
                                            <a href="forum.jsp">论坛首页</a>
                                        </li>
                                    </ul>
                                </li>

                                <li class="dropdown">
                                    <a href="modellist.jsp" onClick="">模型展示</a>
                                </li>
                                <li class="dropdown">
                                    <a class="dropdown-toggle" data-toggle="dropdown"><span class="caret"></span> </a>

                                    <ul class="dropdown-menu" >
                                        <li>
                                            <a  href="modellist.jsp?style=时尚" onClick="">时尚类</a>
                                        </li>
                                        <li>
                                            <a href="modellist.jsp?style=简约">简约类</a>
                                        </li>
                                        <li>
                                            <a href="modellist.jsp?style=实用">实用类</a>
                                        </li>
                                         <li>
                                            <a href="modellist.jsp?style=精细">精细类</a>
                                        </li>
                                    </ul>
                                </li>
                                <li class="dropdown">
                                    <a href="model_upload.jsp" onClick="" >模型上传</a>
                                </li>
                                <li>
                                    <a href="about.jsp" onClick="" >了解更多</a>
                                </li>
                                <li class="dropdown">
                                    <a class="dropdown-toggle" data-toggle="dropdown"><span class="caret"></span> </a>
                                    <ul class="dropdown-menu" >
                                        <li>
                                            <a href="show_material.jsp">打印材料说明</a>
                                        </li>
                                        <li>
                                            <a href="NR_printer.jsp">3D打印机</a>
                                        </li>
                                        <li>
                                            <a href="pay.jsp">支付说明</a>
                                        </li>
                                        <li>
                                            <a href="buyabout.jsp">定制打印说明</a>
                                        </li>
                                    </ul>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
	function logout(){
		$.ajax({
			type: "GET",
			url: 'ajax/logout',
			data: {},
			dataType: 'json',
			async: false,
			success: function(data){
				if(data.success){
					location = '';
				}else{
					alert('注销失败。');
				}
			},
			error: function(err){
				alert('网络故障');
			}
		});
	}
	function toLoginPage(){
		var encoded = encodeURIComponent(window.location.href);
		if(window.location.href.indexOf('/login.jsp') != -1){
			location = '';
		}else if(window.location.href.indexOf('/register.jsp') != -1){
			location = 'login.jsp';
		}else{
			location = 'login.jsp?lastpage=' + encoded;
		}
	}
</script>

<script src="./js/jquery-1.11.1.min.js"></script>
<script src="./js/bootstrap.min.js"></script>
<%
	if(user!=null && "user".equals(user.getAuthority())){
		List<Mail> mails = MailService.getMailService().selectMails(user.getId(), false);
		if(mails != null && mails.size() > 0){
			for(Mail mail:mails){
				%>
				<script>
					alert('<%=mail.getTitle() +"：" + mail.getContent()%>');
				</script>
				<%
				MailService.getMailService().changeReadStatus(mail.getId(), true);
			}
		}
	}
%>