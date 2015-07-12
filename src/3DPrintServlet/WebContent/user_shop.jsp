<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="service.GetLoginUserService,entity.*, database.*, java.util.List, java.util.ArrayList" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>3D打印创作服务平台-用户中心</title>
        <style>
            .bdiv{
                border: 1px solid #99bbbb;
                padding: 5px;
            }
        </style>
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
                                            <%=user.getName()%>！
                                        </span>
                                        <br>
                                        <br>
                                    </div>
                                    <ul class="nav nav-tabs nav-stacked" data-spy="affix" data-offset-top="125" >
                                        <li><a href="./user.jsp" >个人设置</a></li>
                                        <li><a href="./user_model.jsp">我的模型</a></li>
                                        <li class="active"><a href="./user_shop.jsp">我的购物</a></li>
                                        <li><a href="./user_collect.jsp">我的收藏</a></li>

                                        <li><a href="./user_forum.jsp">我的帖子</a></li>
                                    </ul>
                                </div>
                            </div>
                        </div>

                    </div>

                    <div class="span10">
                        <hr>
                        <div class="tabbable">
                            <ul class="nav nav-tabs">
                            	<%
                        		List<Order> waitingCheckOrders = ShoppingService.getShoppingService().searchOrdersByUserStatus(user.getId(), "waiting check");
                        		List<Order> checkedOrders = ShoppingService.getShoppingService().searchOrdersByUserStatus(user.getId(), "checked");
                        		List<Order> waitingReceiveOrders = ShoppingService.getShoppingService().searchOrdersByUserStatus(user.getId(), "waiting receive");
                        		List<Order> receivedOrders = ShoppingService.getShoppingService().searchOrdersByUserStatus(user.getId(), "received");
                        		List<Order> canceledOrders = ShoppingService.getShoppingService().searchOrdersByUserStatus(user.getId(), "canceled");
                        		List<Order> allOrders = new ArrayList<Order>();
                        		allOrders.addAll(waitingCheckOrders);
                        		allOrders.addAll(checkedOrders);
                        		allOrders.addAll(waitingReceiveOrders);
                        		allOrders.addAll(receivedOrders);
                        		allOrders.addAll(canceledOrders);
                            	%>
                                <li class="active">
                                    <a href="#panel-819612" data-toggle="tab">全部订单
                                        <span>(<%=allOrders.size() %>)</span>
                                    </a>
                                </li>
                                <li>
                                    <a href="#panel-390436" data-toggle="tab">待确认付款
                                        <span>(<%=waitingCheckOrders.size() %>)</span></a>
                                </li>
                                <li>
                                    <a href="#panel-390437" data-toggle="tab">待发货
                                        <span>(<%=checkedOrders.size() %>)</span></a>
                                </li>
                                <li>
                                    <a href="#panel-390438" data-toggle="tab">待确认收货
                                        <span>(<%=waitingReceiveOrders.size() %>)</span></a>
                                </li>
                                <li>
                                    <a href="#panel-390439" data-toggle="tab">已完成
                                        <span>(<%=receivedOrders.size() %>)</span></a>
                                </li>
                                <li>
                                    <a href="#panel-390440" data-toggle="tab">失败订单
                                        <span>(<%=canceledOrders.size() %>)</span></a>
                                </li>
                            </ul>
                            <div class="tab-content">
                                <div class="tab-pane active" id="panel-819612">
                                    <div class="container-fluid">
                                        <div class="row-fluid">
                                            <div class="span12">
                                                <div class="row-fluid bdiv">
                                                    <div class="span1">
                                                        <label>

                                                            &nbsp;&nbsp;&nbsp;订单号</label>
                                                    </div>
                                                    <div class="span2">
                                                        <p>&nbsp;购买模型</p>
                                                    </div>
                                                    <div class="span2">
                                                        <p>&nbsp;&nbsp;&nbsp;模型信息</p>
                                                    </div>
                                                    <div class="span1">
                                                        <p>材料</p>
                                                    </div>
                                                    <div class="span1">
                                                        <p>订购时间</p>
                                                    </div>
                                                    <div class="span1">
                                                        <p>&nbsp;数量</p>
                                                    </div>
                                                    <div class="span2">
                                                        <p>&nbsp;交易状态</p>
                                                    </div>
                                                    <div class="span1">
                                                        <p>&nbsp;操作</p>
                                                    </div>
                                                </div>
                                                <br>
												<%
												for(Order order:allOrders){
													out.println(createItem(order.getStatus(), order));
												}
												%>
                                            </div>

                                            <div class="container-fluid">
                                                <div class="row-fluid">
                                                    <br><br>
                                                    <div class="row-fluid">
                                                        <div class="span5"></div>

                                                        <div class="span2">
                                                            <a href="./modellist.jsp">
                                                                <button class="btn" type="button">返回商城</button>
                                                            </a>
                                                        </div>
                                                        <a href="./shoppingcart.jsp">
                                                            <button class="btn" type="button">返回购物车</button>
                                                        </a>
                                                        <div class="span2">
                                                            <button class="btn" type="button" onclick="location='pay.jsp';">联系卖家</button>
                                                        </div>
                                                        <!----------提交订单之后应该就是等待后台确认，卖家主动联系用户-------------->


                                                    </div>

                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="tab-pane" id="panel-390436">
                                    <div class="container-fluid">
                                        <div class="row-fluid">
                                            <div class="span12">
                                                <div class="row-fluid bdiv">
                                                    <div class="span1">
                                                        <label>

                                                            &nbsp;&nbsp;&nbsp;订单号</label>
                                                    </div>
                                                    <div class="span2">
                                                        <p>&nbsp;购买模型</p>
                                                    </div>
                                                    <div class="span2">
                                                        <p>&nbsp;&nbsp;&nbsp;模型信息</p>
                                                    </div>
                                                    <div class="span1">
                                                        <p>材料</p>
                                                    </div>
                                                    <div class="span1">
                                                        <p>订购时间</p>
                                                    </div>
                                                    <div class="span1">
                                                        <p>&nbsp;数量</p>
                                                    </div>
                                                    <div class="span2">
                                                        <p>&nbsp;交易状态</p>
                                                    </div>
                                                    <div class="span1">
                                                        <p>&nbsp;操作</p>
                                                    </div>
                                                </div>
                                                <br>
                                                <!-------购物单项 ------------>
                                                <%
												for(Order order:waitingCheckOrders){
													out.println(createItem(order.getStatus(), order));
												}
												%>
                                            </div>

                                            <div class="container-fluid">
                                                <div class="row-fluid">
                                                    <br><br>
                                                    <div class="row-fluid">
                                                        <div class="span5"></div>

                                                        <div class="span2">
                                                            <a href="./modellist.jsp">
                                                                <button class="btn" type="button">返回商城</button>
                                                            </a>
                                                        </div>
                                                        <a href="./shoppingcart.jsp">
                                                            <button class="btn" type="button">返回购物车</button>
                                                        </a>
                                                        <div class="span2">
                                                            <button class="btn" type="button" onclick="location='pay.jsp';">联系卖家</button>
                                                        </div>
                                                        <!----------提交订单之后应该就是等待后台确认，卖家主动联系用户-------------->

 
                                                    </div>

                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <!------------------------------------待发货订单- 有待管理员去确认-------------------------------------->
                                <div class="tab-pane" id="panel-390437">
                                    <div class="container-fluid">
                                        <div class="row-fluid">
                                            <div class="span12">
                                                <div class="row-fluid bdiv">
                                                    <div class="span1">
                                                        <label>

                                                            &nbsp;&nbsp;&nbsp;订单号</label>
                                                    </div>
                                                    <div class="span2">
                                                        <p>&nbsp;购买模型</p>
                                                    </div>
                                                    <div class="span2">
                                                        <p>&nbsp;&nbsp;&nbsp;模型信息</p>
                                                    </div>
                                                    <div class="span1">
                                                        <p>材料</p>
                                                    </div>
                                                    <div class="span1">
                                                        <p>订购时间</p>
                                                    </div>
                                                    <div class="span1">
                                                        <p>&nbsp;数量</p>
                                                    </div>
                                                    <div class="span1">
                                                        <p>成交价格</p>
                                                    </div>
                                                    <div class="span1">
                                                        <p>&nbsp;交易状态</p>
                                                    </div>
                                                    <div class="span1">
                                                        <p>&nbsp;操作</p>
                                                    </div>
                                                </div>
                                                <br>
                                                <!-------购物单项 ------------>
                                                <%
                                                for(Order order:checkedOrders){
                                                	out.println(createItem(order.getStatus(), order));
                                                }
                                                %>
                                            </div>

                                            <div class="container-fluid">
                                                <div class="row-fluid">
                                                    <br><br>
                                                    <div class="row-fluid">
                                                        <div class="span5"></div>

                                                        <div class="span2">
                                                            <a href="./modellist.jsp">
                                                                <button class="btn" type="button">返回商城</button>
                                                            </a>
                                                        </div>
                                                        <a href="./shoppingcart.jsp">
                                                            <button class="btn" type="button">返回购物车</button>
                                                        </a>
                                                        <div class="span2">
                                                            <button class="btn" type="button" onclick="location='pay.jsp';">联系卖家</button>
                                                        </div>
                                                        <!----------提交订单之后应该就是等待后台确认，卖家主动联系用户-------------->


                                                    </div>

                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <!-----------------------------------已发货的订单，待用户确认---------------------------------------->
                                <div class="tab-pane" id="panel-390438">
                                    <div class="container-fluid">
                                        <div class="row-fluid">
                                            <div class="span12">
                                                <div class="row-fluid bdiv">
                                                    <div class="span1">
                                                        <label>

                                                            &nbsp;&nbsp;&nbsp;订单号</label>
                                                    </div>
                                                    <div class="span2">
                                                        <p>&nbsp;购买模型</p>
                                                    </div>
                                                    <div class="span2">
                                                        <p>&nbsp;&nbsp;&nbsp;模型信息</p>
                                                    </div>
                                                    <div class="span1">
                                                        <p>材料</p>
                                                    </div>
                                                    <div class="span1">
                                                        <p>订购时间</p>
                                                    </div>
                                                    <div class="span1">
                                                        <p>&nbsp;数量</p>
                                                    </div>
                                                    <div class="span1">
                                                        <p>成交价格</p>
                                                    </div>
                                                    <div class="span1">
                                                        <p>&nbsp;交易状态</p>
                                                    </div>
                                                    <div class="span1">
                                                        <p>&nbsp;操作</p>
                                                    </div>
                                                </div>
                                                <br>
                                                <!-------购物单项 ------------>
                                                <%
                                                for(Order order:waitingReceiveOrders){
                                                	out.println(createItem(order.getStatus(), order));
                                                }
                                                %>
                                            </div>

                                            <div class="container-fluid">
                                                <div class="row-fluid">
                                                    <br><br>
                                                    <div class="row-fluid">
                                                        <div class="span5"></div>

                                                        <div class="span2">
                                                            <a href="./modellist.jsp">
                                                                <button class="btn" type="button">返回商城</button>
                                                            </a>
                                                        </div>
                                                        <a href="./shoppingcart.jsp">
                                                            <button class="btn" type="button">返回购物车</button>
                                                        </a>
                                                        <div class="span2">
                                                            <button class="btn" type="button" onclick="location='pay.jsp';">联系卖家</button>
                                                        </div>
                                                        <!----------提交订单之后应该就是等待后台确认，卖家主动联系用户-------------->

                                                    </div>

                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <!---------------------------------记录确认收货之后的已经完成的订单--------------------------------------------------------->
                                <div class="tab-pane" id="panel-390439">

                                    <div class="container-fluid">
                                        <div class="row-fluid">
                                            <div class="span12">
                                                <div class="row-fluid bdiv">
                                                    <div class="span1">
                                                        <label>

                                                            &nbsp;&nbsp;&nbsp;订单号</label>
                                                    </div>
                                                    <div class="span2">
                                                        <p>&nbsp;购买模型</p>
                                                    </div>
                                                    <div class="span2">
                                                        <p>&nbsp;&nbsp;&nbsp;模型信息</p>
                                                    </div>
                                                    <div class="span1">
                                                        <p>材料</p>
                                                    </div>
                                                    <div class="span1">
                                                        <p>订购时间</p>
                                                    </div>
                                                    <div class="span1">
                                                        <p>&nbsp;数量</p>
                                                    </div>
                                                    <div class="span1">
                                                        <p>成交价</p>
                                                    </div>
                                                    <div class="span1">
                                                        <p>&nbsp;交易状态</p>
                                                    </div>
                                                    <div class="span1">
                                                        <p>&nbsp;操作</p>
                                                    </div>
                                                </div>
                                                <br>
                                                <!-------购物单项 ------------>
                                                <%
                                                for(Order order:receivedOrders){
                                                	out.println(createItem(order.getStatus(), order));
                                                }
                                                %>
                                            </div>

                                            <div class="container-fluid">
                                                <div class="row-fluid">
                                                    <br><br>
                                                    <div class="row-fluid">
                                                        <div class="span5"></div>

                                                        <div class="span2">
                                                            <a href="./modellist.jsp">
                                                                <button class="btn" type="button">返回商城</button>
                                                            </a>
                                                        </div>
                                                        <a href="./shoppingcart.jsp">
                                                            <button class="btn" type="button">返回购物车</button>
                                                        </a>
                                                        <div class="span2">
                                                            <button class="btn" type="button" onclick="location='pay.jsp';">联系卖家</button>
                                                        </div>
                                                        <!----------提交订单之后应该就是等待后台确认，卖家主动联系用户-------------->

                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="tab-pane" id="panel-390440">
                                    <div class="container-fluid">
                                        <div class="row-fluid">
                                            <div class="span12">
                                                <div class="row-fluid bdiv">
                                                    <div class="span1">
                                                        <label>

                                                            &nbsp;&nbsp;&nbsp;订单号</label>
                                                    </div>
                                                    <div class="span2">
                                                        <p>&nbsp;购买模型</p>
                                                    </div>
                                                    <div class="span2">
                                                        <p>&nbsp;&nbsp;&nbsp;模型信息</p>
                                                    </div>
                                                    <div class="span1">
                                                        <p>材料</p>
                                                    </div>
                                                    <div class="span1">
                                                        <p>订购时间</p>
                                                    </div>
                                                    <div class="span1">
                                                        <p>&nbsp;数量</p>
                                                    </div>
                                                    <div class="span1">
                                                        <p>成交价</p>
                                                    </div>
                                                    <div class="span1">
                                                        <p>&nbsp;交易状态</p>
                                                    </div>
                                                    <div class="span1">
                                                        <p>&nbsp;操作</p>
                                                    </div>
                                                </div>
                                                <br>
                                                <!-------购物单项 ------------>
												<%
                                                for(Order order:canceledOrders){
                                                	out.println(createItem(order.getStatus(), order));
                                                }
                                                %>
                                            </div>

                                            <div class="container-fluid">
                                                <div class="row-fluid">
                                                    <br><br>
                                                    <div class="row-fluid">
                                                        <div class="span5"></div>

                                                        <div class="span2">
                                                            <a href="./modellist.jsp">
                                                                <button class="btn" type="button">返回商城</button>
                                                            </a>
                                                        </div>
                                                        <a href="./shoppingcart.jsp">
                                                            <button class="btn" type="button">返回购物车</button>
                                                        </a>
                                                        <div class="span2">
                                                            <button class="btn" type="button" onclick="location='pay.jsp';">联系卖家</button>
                                                        </div>
                                                        <!----------提交订单之后应该就是等待后台确认，卖家主动联系用户-------------->

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
        </div>
    </div>
	
	<%!
    	String createItem(String status, Order order){
			StringBuilder builder = new StringBuilder();
    		if("waiting check".equals(status)){
    			Model model = ModelService.getModelService().searchModelByID(order.getModel().getId());
            	User buyer = UserService.getUserService().searchUserByID(order.getUser().getId());
            	Material material = ShoppingService.getShoppingService().searchMaterialByID(order.getMaterial().getId());
				builder.append("<div class=\"row-fluid bdiv\">");
				builder.append("    <div class=\"span1\" style=\"padding-top: 45px;\"><input type=\"checkbox\">");
				builder.append("        <span>" + order.getId() + "</span>");
				builder.append("    </div>");
				builder.append("    <a class=\"span2\" href=\"modeldetail.jsp?id=" + model.getId() + "\">");
				builder.append("        <img alt=\"model\" src=\"modelimage?number=1&modelID=" + model.getId() + "\" />");
				builder.append("    </a>");
				builder.append("    <div class=\"span2\">");
				builder.append("        <br>");
				builder.append("        <span>" + model.getName() + "</span>");
				builder.append("        <br>");
				builder.append("        <span>" + model.getDescriptrion() + "</span>");
				builder.append("    </div>");
				builder.append("    <div class=\"span1 \">");
				builder.append("        <br>");
				builder.append("        <br>");
				builder.append("        <span>" + material.getName() + "</span>");
				builder.append("    </div>");
				builder.append("    <div class=\"span1 \">");
				builder.append("        <br> <br>");
				builder.append("        <span>" + order.getAddtime() + "</span>");
				builder.append("    </div>");
				builder.append("    <div class=\"span1 \">");
				builder.append("        <br><br>");
				builder.append("        <span>&nbsp;&nbsp;" + order.getNumber() + "</span>");
				builder.append("    </div>");
				builder.append("    <div class=\"span2 \">");
				builder.append("        <br><br>");
				builder.append("        <span>待确认付款</span>");
				builder.append("    </div>");
				builder.append("    <div class=\"span2\">");
				builder.append("        <br>");
				builder.append("        <button class=\"btn\" type=\"button\" onclick=\"cancelOrder(" + order.getId() + ");\">取消订单</button>");
				builder.append("        <br><br>");
				builder.append("        <button class=\"btn\" type=\"button\" onclick=\"location='modeldetail.jsp?id=" + model.getId() + "';\">评价模型</button>");
				builder.append("    </div>");
				builder.append("</div>");
				builder.append("<br><br>");
    		}else if("checked".equals(status)){
    			Model model = ModelService.getModelService().searchModelByID(order.getModel().getId());
            	User buyer = UserService.getUserService().searchUserByID(order.getUser().getId());
            	Material material = ShoppingService.getShoppingService().searchMaterialByID(order.getMaterial().getId());
            	builder.append("<div class=\"row-fluid bdiv\">");
				builder.append("    <div class=\"span1\" style=\"padding-top: 45px;\"><input type=\"checkbox\">");
				builder.append("        <span>" + order.getId() + "</span>");
				builder.append("    </div>");
				builder.append("    <a class=\"span2\" href=\"modeldetail.jsp?id=" + model.getId() + "\">");
				builder.append("        <img alt=\"model\" src=\"modelimage?number=1&modelID=" + model.getId() + "\" />");
				builder.append("    </a>");
				builder.append("    <div class=\"span2\">");
				builder.append("        <br>");
				builder.append("        <span>" + model.getName() + "</span>");
				builder.append("        <br>");
				builder.append("        <span>" + model.getDescriptrion() + "</span>");
				builder.append("    </div>");
				builder.append("    <div class=\"span1 \">");
				builder.append("        <br>");
				builder.append("        <br>");
				builder.append("        <span>" + material.getName() + "</span>");
				builder.append("    </div>");
				builder.append("    <div class=\"span1 \">");
				builder.append("        <br> <br>");
				builder.append("        <span>" + order.getAddtime() + "</span>");
				builder.append("    </div>");
				builder.append("    <div class=\"span1 \">");
				builder.append("        <br><br>");
				builder.append("        <span>&nbsp;&nbsp;" + order.getNumber() + "</span>");
				builder.append("    </div>");
            	builder.append("    <div class=\"span1 \">");
            	builder.append("        <br><br>");
            	builder.append("        <span>" + order.getPrice() + "元</span>");
            	builder.append("    </div>");
            	builder.append("    <div class=\"span1 \">");
            	builder.append("        <br><br>");
            	builder.append("        <span>已付款，待发货</span>");
            	builder.append("    </div>");
            	builder.append("    <div class=\"span2\">");
            	builder.append("        <br>");
            	builder.append("        <button class=\"btn\" type=\"button\" disabled>提醒发货</button>");
            	builder.append("        <br><br>");
				builder.append("        <button class=\"btn\" type=\"button\" onclick=\"location='modeldetail.jsp?id=" + model.getId() + "';\">评价模型</button>");
            	builder.append("    </div>");
            	builder.append("</div>");
            	builder.append("<br><br>");
    		}else if("waiting receive".equals(status)){
    			Model model = ModelService.getModelService().searchModelByID(order.getModel().getId());
            	User buyer = UserService.getUserService().searchUserByID(order.getUser().getId());
            	Material material = ShoppingService.getShoppingService().searchMaterialByID(order.getMaterial().getId());
            	builder.append("<div class=\"row-fluid bdiv\">");
				builder.append("    <div class=\"span1\" style=\"padding-top: 45px;\"><input type=\"checkbox\">");
				builder.append("        <span>" + order.getId() + "</span>");
				builder.append("    </div>");
				builder.append("    <a class=\"span2\" href=\"modeldetail.jsp?id=" + model.getId() + "\">");
				builder.append("        <img alt=\"model\" src=\"modelimage?number=1&modelID=" + model.getId() + "\" />");
				builder.append("    </a>");
				builder.append("    <div class=\"span2\">");
				builder.append("        <br>");
				builder.append("        <span>" + model.getName() + "</span>");
				builder.append("        <br>");
				builder.append("        <span>" + model.getDescriptrion() + "</span>");
				builder.append("    </div>");
				builder.append("    <div class=\"span1 \">");
				builder.append("        <br>");
				builder.append("        <br>");
				builder.append("        <span>" + material.getName() + "</span>");
				builder.append("    </div>");
				builder.append("    <div class=\"span1 \">");
				builder.append("        <br> <br>");
				builder.append("        <span>" + order.getAddtime() + "</span>");
				builder.append("    </div>");
				builder.append("    <div class=\"span1 \">");
				builder.append("        <br><br>");
				builder.append("        <span>&nbsp;&nbsp;" + order.getNumber() + "</span>");
				builder.append("    </div>");
            	builder.append("    <div class=\"span1 \">");
            	builder.append("        <br><br>");
            	builder.append("        <span>" + order.getPrice() + "元</span>");
            	builder.append("    </div>");
            	builder.append("    <div class=\"span1 \">");
            	builder.append("        <br><br>");
            	builder.append("        <span>待确认收货</span>");
            	builder.append("    </div>");
            	builder.append("    <div class=\"span2\">");
            	builder.append("        <br>");
            	builder.append("        <button class=\"btn\" type=\"button\" onclick=\"received(" + order.getId() + ");\">确认收货</button>");
            	builder.append("        <br><br>");
				builder.append("        <button class=\"btn\" type=\"button\" onclick=\"location='modeldetail.jsp?id=" + model.getId() + "';\">评价模型</button>");
            	builder.append("    </div>");
            	builder.append("</div>");
            	builder.append("<br><br>");
    		}else if("received".equals(status)){
    			Model model = ModelService.getModelService().searchModelByID(order.getModel().getId());
            	User buyer = UserService.getUserService().searchUserByID(order.getUser().getId());
            	Material material = ShoppingService.getShoppingService().searchMaterialByID(order.getMaterial().getId());
            	builder.append("<div class=\"row-fluid bdiv\">");
				builder.append("    <div class=\"span1\" style=\"padding-top: 45px;\"><input type=\"checkbox\">");
				builder.append("        <span>" + order.getId() + "</span>");
				builder.append("    </div>");
				builder.append("    <a class=\"span2\" href=\"modeldetail.jsp?id=" + model.getId() + "\">");
				builder.append("        <img alt=\"model\" src=\"modelimage?number=1&modelID=" + model.getId() + "\" />");
				builder.append("    </a>");
				builder.append("    <div class=\"span2\">");
				builder.append("        <br>");
				builder.append("        <span>" + model.getName() + "</span>");
				builder.append("        <br>");
				builder.append("        <span>" + model.getDescriptrion() + "</span>");
				builder.append("    </div>");
				builder.append("    <div class=\"span1 \">");
				builder.append("        <br>");
				builder.append("        <br>");
				builder.append("        <span>" + material.getName() + "</span>");
				builder.append("    </div>");
				builder.append("    <div class=\"span1 \">");
				builder.append("        <br> <br>");
				builder.append("        <span>" + order.getAddtime() + "</span>");
				builder.append("    </div>");
				builder.append("    <div class=\"span1 \">");
				builder.append("        <br><br>");
				builder.append("        <span>&nbsp;&nbsp;" + order.getNumber() + "</span>");
				builder.append("    </div>");
            	builder.append("    <div class=\"span1\">");
            	builder.append("        <br><br>");
            	builder.append("        <span>&nbsp;" + order.getPrice() + "</span>");
            	builder.append("    </div>");
            	builder.append("    <div class=\"span1 \">");
            	builder.append("        <br><br>");
            	builder.append("        <span>已完成</span>");
            	builder.append("    </div>");
            	builder.append("    <div class=\"span2\">");
            	builder.append("");
            	builder.append("        <br><br>");
				builder.append("        <button class=\"btn\" type=\"button\" onclick=\"location='modeldetail.jsp?id=" + model.getId() + "';\">评价模型</button>");
            	builder.append("    </div>");
            	builder.append("</div>");
            	builder.append("<br><br>");
    		}else if("canceled".equals(status)){
    			Model model = ModelService.getModelService().searchModelByID(order.getModel().getId());
            	User buyer = UserService.getUserService().searchUserByID(order.getUser().getId());
            	Material material = ShoppingService.getShoppingService().searchMaterialByID(order.getMaterial().getId());
            	builder.append("<div class=\"row-fluid bdiv\">");
				builder.append("    <div class=\"span1\" style=\"padding-top: 45px;\"><input type=\"checkbox\">");
				builder.append("        <span>" + order.getId() + "</span>");
				builder.append("    </div>");
				builder.append("    <a class=\"span2\" href=\"modeldetail.jsp?id=" + model.getId() + "\">");
				builder.append("        <img alt=\"model\" src=\"modelimage?number=1&modelID=" + model.getId() + "\" />");
				builder.append("    </a>");
				builder.append("    <div class=\"span2\">");
				builder.append("        <br>");
				builder.append("        <span>" + model.getName() + "</span>");
				builder.append("        <br>");
				builder.append("        <span>" + model.getDescriptrion() + "</span>");
				builder.append("    </div>");
				builder.append("    <div class=\"span1 \">");
				builder.append("        <br>");
				builder.append("        <br>");
				builder.append("        <span>" + material.getName() + "</span>");
				builder.append("    </div>");
				builder.append("    <div class=\"span1 \">");
				builder.append("        <br> <br>");
				builder.append("        <span>" + order.getAddtime() + "</span>");
				builder.append("    </div>");
				builder.append("    <div class=\"span1 \">");
				builder.append("        <br><br>");
				builder.append("        <span>&nbsp;&nbsp;" + order.getNumber() + "</span>");
				builder.append("    </div>");
            	builder.append("    <div class=\"span1\">");
            	builder.append("        <br><br>");
            	builder.append("        <span>&nbsp;" + order.getPrice() + "</span>");
            	builder.append("    </div>");
            	builder.append("    <div class=\"span1 \">");
            	builder.append("        <br><br>");
            	builder.append("        <span>已取消</span>");
            	builder.append("    </div>");
            	builder.append("    <div class=\"span2\">");
            	builder.append("");
            	builder.append("        <br><br>");
				builder.append("        <button class=\"btn\" type=\"button\" onclick=\"location='modeldetail.jsp?id=" + model.getId() + "';\">评价模型</button>");
            	builder.append("    </div>");
            	builder.append("</div>");
            	builder.append("<br><br>");
    		}
    		return builder.toString();
	    }
    %>
	<script>
		function selectAll(){
			var select = document.getElementById('allShopcarCheckBox').checked;
			var boxs = document.getElementsByClassName('shopcarCheckBox');
			for(var i=0; i<boxs.length; i++){
				boxs[i].checked = select;
			}
		}
		
		function collection(isCollection, modelID){
			if(isCollection){
				var success = cancelUserCollection(modelID);
				if(success){
					alert('取消收藏成功。');
					location = '';
				}else{
					alert('取消收藏失败。');
				}
			}else{
				var success = addUserCollection(modelID);
				if(success){
					alert('添加收藏成功。');
					location = '';
				}else{
					alert('添加收藏失败。');
				}
			}
		}

		function deleteShopcarAll(){
			document.getElementById('allShopcarCheckBox').checked = true;
			selectAll();
			deleteShopcarBatch();
		}

		function deleteShopcarBatch(){
			var boxs = document.getElementsByClassName('shopcarCheckBox');
			var modelIDs = '';
			for(var i=0; i<boxs.length; i++){
				if(boxs[i].checked){
					modelIDs += boxs[i].name + ';';
				}
			}
			if(modelIDs == ''){
				alert('请选中模型。');
				return;
			}
			var count = deleteShopcars(modelIDs);
			if(count > 0){
				alert('成功移出' + count + '个模型。');
				location = '';
			}else{
				alert('移出购物车失败。');
			}
		}

		function deleteShopcar(modelID){
			console.log('delete shopcar');
			if(deleteShopcars(modelID)==1){
				alert('1个商品已经移出购物车。');
				location = '';
			}else{
				alert('操作失败');
			}
		}

		/**
		 * 用户收藏。
		 */
		function addUserCollection(modelID){
			var success = false;
			$.ajax({
				type:'GET',
				url: 'ajax/usercollection',
				data:{modelID:modelID},
				dataType:'json',
				async:false,
				success: function(data){
					success = data.success;
				},
				error: function(err){
					alert('网络故障。');
				}
			});
			return success;
		}

		/**
		 * 用户取消收藏。
		 */
		function cancelUserCollection(modelID){
			var success = false;
			$.ajax({
				type:'GET',
				url: 'ajax/cancelusercollection',
				data:{modelID:modelID},
				dataType:'json',
				async:false,
				success: function(data){
					success = data.success;
				},
				error: function(err){
					alert('网络故障。');
				}
			});
			return success;
		}

		function received(orderID){
			receivedAjax(orderID);
		}

		function cancelOrder(orderID){
			cancelOrdersAjax(orderID);
		}

		function receivedAjax(orderIDs){
			console.log('取消订单');
			$.ajax({
				type: "GET",
				url: 'ajax/changeordersstatusbyuser',
				data: {status:'received',orderIDs:orderIDs},
				dataType: 'json',
				async: false,
				success: function(data){
					if(data.count > 0){
						alert(data.count + '个订单收货成功。');
						location = '';
					}else{
						alert('操作失败。');
					}
				},
				error: function(err){
					alert('网络故障');
				}
			});
		}

		function cancelOrdersAjax(orderIDs){
			console.log('取消订单');
			$.ajax({
				type: "GET",
				url: 'ajax/changeordersstatusbyuser',
				data: {status:'canceled',orderIDs:orderIDs},
				dataType: 'json',
				async: false,
				success: function(data){
					if(data.count > 0){
						alert('取消' + data.count + '订单成功。');
						location = '';
					}else{
						alert('取消订单失败。');
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