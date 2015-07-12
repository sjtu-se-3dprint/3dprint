<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="service.GetLoginUserService,entity.*, database.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; ">
<title>3D打印创作服务平台-管理员中心</title>
</head>
<body>
	<jsp:include page="header.jsp" flush="true"></jsp:include>
	<%
		User user = GetLoginUserService.service(request);
		if(user == null || !"manager".equals(user.getAuthority())){
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
                                    <img alt="user_pic" src="./img/users/user2.jpg" class="img-polaroid" />
                                    <div class="span12">
                                        <br>
                                        <span>
                                            &nbsp;&nbsp;你 好，</span>
                                        <span>
                                            <%=user.getName()%>！
                                        </span>
                                        <br>
                                        <br>
                                    </div>
                                    <ul class="nav nav-tabs nav-stacked" data-spy="affix" data-offset-top="125" >
                                        <li><a href="./manager.jsp" >个人设置</a></li>
                                        <li><a href="./ma_model.jsp">模型管理</a></li>
                                        <li><a href="./ma_shop.jsp">订单管理</a></li>
                                        <li class="active"><a href="./ma_print.jsp">打印控制</a></li>
                                    </ul>
                                </div>
                            </div>
                        </div>

                    </div>

                    <div class="span10">
                        <hr>

                 
                        <!--<a hre="http://202.120.40.25:5000"><button class="btn" type="button">3D打印在线控制</button></a>-->
                        <a href="http://202.120.40.25:40085/" class="pull-left" target="_blank"><button class="btn" type="button">3D打印在线控制</button></a>
                    </div>
                </div>
            </div>
        </div>
    </div>
	
</body>
</html>