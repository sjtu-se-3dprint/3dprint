<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="service.GetLoginUserService,entity.*, database.*, java.util.List" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; ">
<title>3D打印创作服务平台-管理员中心</title>
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
                                        <li class="active"><a href="./ma_shop.jsp">订单管理</a></li>
                                        <li><a href="./ma_print.jsp">打印控制</a></li>
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
                        		List<Order> waitingCheckOrders = ShoppingService.getShoppingService().searchOrdersByStatus("waiting check");
                        		List<Order> checkedOrders = ShoppingService.getShoppingService().searchOrdersByStatus("checked");
                        		List<Order> waitingReceiveOrders = ShoppingService.getShoppingService().searchOrdersByStatus("waiting receive");
                        		List<Order> receivedOrders = ShoppingService.getShoppingService().searchOrdersByStatus("received");
                        		List<Order> canceledOrders = ShoppingService.getShoppingService().searchOrdersByStatus("canceled");
                            	%>
                                <li class="active">
                                    <a href="#panel-819612" data-toggle="tab">待处理订单
                                        <span>(<%=waitingCheckOrders.size() %>)</span></a>
                                </li>
                                <li>
                                    <a href="#panel-390433" data-toggle="tab">等待发货
                                        <span>(<%=checkedOrders.size() %>)</span>
                                    </a>
                                </li>
                                <li>
                                    <a href="#panel-819619" data-toggle="tab">已发货<span>(<%=waitingReceiveOrders.size() %>)</span></a>
                                </li>
                                <li>
                                    <a href="#panel-390435" data-toggle="tab">成功订单<span>(<%=receivedOrders.size() %>)</span></a>
                                </li>
                                <li>
                                    <a href="#panel-390436" data-toggle="tab">失败订单<span>(<%=canceledOrders.size() %>)</span></a>
                                </li>
                            </ul>
                            <div class="tab-content">
                                <!-----------待处理订单---------------->
                                <div class="tab-pane active" id="panel-819612">
                                    <div class="container-fluid">
                                        <div class="row-fluid">
                                            <div class="span12">
                                                <div class="row-fluid bdiv">
                                                    <div class="span2">
                                                        <label>
                                                            &nbsp;

                                                            <input type="checkbox" id="handlingAllCheckBox" onclick="selectAllHandling();">
                                                            &nbsp;&nbsp;&nbsp;全选</label>
                                                    </div>

                                                    <div class="span2">
                                                        <p>&nbsp;定制商品</p>
                                                    </div>
                                                    <div class="span1">
                                                        <p>购买者</p>
                                                    </div>
                                                    <div class="span2">
                                                        <p>下单时间</p>
                                                    </div>
                                                    <div class="span1">
                                                        <p>材料</p>
                                                    </div>
                                                    <div class="span1">
                                                        <p>数量</p>
                                                    </div>
                                                    <div class="span1">
                                                        <p>价格(元)</p>
                                                    </div>
                                                    <div class="span2">
                                                        <!-----------------点击批量完成之后，订单就完成，待处理列表中删除，出现在已完成的列表中-------------------->
                                                        <p>操作
                                                            <button class="btn" onclick="handlingFinishs();">批量通过审核</button></p>
                                                    </div>
                                                </div>
                                                <br>
                                                <%
                                                for(Order order: waitingCheckOrders){
                                                	Model model = ModelService.getModelService().searchModelByID(order.getModel().getId());
                                                	User buyer = UserService.getUserService().searchUserByID(order.getUser().getId());
                                                	Material material = ShoppingService.getShoppingService().searchMaterialByID(order.getMaterial().getId());
                                                	out.println("<div class=\"row-fluid bdiv\">");
                                                	out.println("    <div class=\"span2 \">");
                                                	out.println("        <input type=\"checkbox\" class=\"handlingCheckBox\" name=\"" + order.getId() + "\">");
                                                	out.println("        <br><br>");
                                                	out.println("        <span>订单号：" + order.getId() + "</span>");
                                                	out.println("");
                                                	out.println("    </div>");
                                                	out.println("    <a href=\"modeldetail.jsp?id=" + model.getId() + "\" class=\"span2\">");
                                                	out.println("        <br>");
                                                	out.println("        <span>" + model.getName() + "</span>");
                                                	out.println("        <br>");
                                                	out.println("        <span>" + model.getDescriptrion() + "</span>");
                                                	out.println("    </a>");
                                                	out.println("    <div class=\"span1 \">");
                                                	out.println("        <!--------------点击用户名到用户管理界面，最好能focus到该用户那一栏----------------->");
                                                	out.println("        <br>");
                                                	out.println("        <div href=\"./ma_users.jsp\">");
                                                	out.println("            <span>" + buyer.getName() + "</span>");
                                                	out.println("");
                                                	out.println("        </div>");
                                                	out.println("        <br>");
                                                	out.println("        <label>联系买家</label>");
                                                	out.println("    </div>");
                                                	out.println("    <div class=\"span2\">");
                                                	out.println("        <br>");
                                                	out.println("        <span>" + order.getAddtime().toString().split(" ")[0] + "</span>");
                                                	out.println("        <br>");
                                                	out.println("        <span>" + order.getAddtime().toString().split(" ")[1] + "</span>");
                                                	out.println("    </div>");
                                                	out.println("    <div class=\"span1\">");
                                                	out.println("        <br>");
                                                	out.println("        <span>" + material.getName() + "</span>");
                                                	out.println("    </div>");
                                                	out.println("    <div class=\"span1 \">");
                                                	out.println("        <br>");
                                                	out.println("        <span>" + order.getNumber() + "</span>");
                                                	out.println("    </div>");
                                                	out.println("    <div class=\"span1 \">");
                                                	out.println("");
                                                	out.println("        <span>请填写</span>");
                                                	out.println("        <form>");
                                                	out.println("            <input type=\"text\" class=\"form-control\" id=\"priceinput_" + order.getId() + "\" value=\"" + order.getPrice() + "\" style=\"width: 50px;\">");
                                                	out.println("        </form>");
                                                	out.println("    </div>");
                                                	out.println("    <div class=\"span2 \">");
                                                	out.println("        <br>");
                                                	out.println("");
                                                	out.println("        <button class=\"btn\" type=\"button\" onclick=\"handlingFinish(" + order.getId() + ");\">审核通过</button>");
                                                	out.println("        <br><br>");
                                                	out.println("        <button class=\"btn\" type=\"button\" onclick=\"cancelOrder(" + order.getId() + ");\">取消订单</button>");
                                                	out.println("    </div>");
                                                	out.println("</div>");
                                                	out.println("</br>");
                                                }
                                                %>


                                                <div class="span10">
                                                    <br>
                                                    <span>提示：</span>
                                                    <p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                        用户提交订单之后，需您进行线下联系确认，在用户付款之后，点击“审核通过”，订单状态转为“等待发货”。
                                                    </p>
                                                    <br>
                                                    <label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;系统对订单管理现只提供订单状态记录功能，供您与买家双方处理。支付，退款等均暂为线下完成，谢谢！</label>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <!--------待发货订单------------>
                                <div class="tab-pane" id="panel-390433">
                                    <div class="container-fluid">
                                        <div class="row-fluid">
                                            <div class="span12">
                                                <div class="row-fluid bdiv">
                                                    <div class="span2">
                                                        <label>
                                                            &nbsp;

                                                            <input type="checkbox" id="waitingSendAllCheckBox" onclick="selectAllWaitingSend();">
                                                            &nbsp;&nbsp;&nbsp;全选</label>
                                                    </div>

                                                    <div class="span2">
                                                        <p>&nbsp;定制商品</p>
                                                    </div>
                                                    <div class="span1">
                                                        <p>购买者</p>
                                                    </div>
                                                    <div class="span2">
                                                        <p>下单时间</p>
                                                    </div>
                                                    <div class="span1">
                                                        <p>材料</p>
                                                    </div>
                                                    <div class="span1">
                                                        <p>数量</p>
                                                    </div>
                                                    <div class="span1">
                                                        <p>价格(元)</p>
                                                    </div>
                                                    <div class="span2">
                                                        <!-----------------点击批量完成之后，订单就完成，待处理列表中删除，出现在已完成的列表中-------------------->
                                                        <p>操作
                                                            <button class="btn" onclick="sendingFinishs();">批量已发货</button></p>
                                                    </div>
                                                </div>
                                                <br>
                                                <%
                                                for(Order order : checkedOrders){
                                                	Model model = ModelService.getModelService().searchModelByID(order.getModel().getId());
                                                	User buyer = UserService.getUserService().searchUserByID(order.getUser().getId());
                                                	Material material = ShoppingService.getShoppingService().searchMaterialByID(order.getMaterial().getId());
                                                	out.println("<div class=\"row-fluid bdiv\">");
                                                	out.println("    <div class=\"span2 \">");
                                                	out.println("        <input type=\"checkbox\" class=\"waitingSendCheckBox\" name=\"" + order.getId() + "\">");
                                                	out.println("        <br><br>");
                                                	out.println("        <span>订单号：" + order.getId() + "</span>");
                                                	out.println("");
                                                	out.println("    </div>");
                                                	out.println("    <a href=\"modeldetail.jsp?id=" + model.getId() + "\" class=\"span2\">");
                                                	out.println("        <br>");
                                                	out.println("        <span>" + model.getName() + "</span>");
                                                	out.println("        <br>");
                                                	out.println("        <span>" + model.getDescriptrion() + "</span>");
                                                	out.println("    </a>");
                                                	out.println("    <div class=\"span1 \">");
                                                	out.println("        <!--------------点击用户名到用户管理界面，最好能focus到该用户那一栏----------------->");
                                                	out.println("        <br>");
                                                	out.println("        <div href=\"./ma_users.jsp\">");
                                                	out.println("            <span>" + buyer.getName() + "</span>");
                                                	out.println("");
                                                	out.println("        </div>");
                                                	out.println("        <br>");
                                                	out.println("        <label>联系买家</label>");
                                                	out.println("    </div>");
                                                	out.println("    <div class=\"span2\">");
                                                	out.println("        <br>");
                                                	out.println("        <span>" + order.getAddtime().toString().split(" ")[0] + "</span>");
                                                	out.println("        <br>");
                                                	out.println("        <span>" + order.getAddtime().toString().split(" ")[1] + "</span>");
                                                	out.println("    </div>");
                                                	out.println("    <div class=\"span1\">");
                                                	out.println("        <br>");
                                                	out.println("        <span>" + material.getName() + "</span>");
                                                	out.println("    </div>");
                                                	out.println("    <div class=\"span1 \">");
                                                	out.println("        <br>");
                                                	out.println("        <span>" + order.getNumber() + "</span>");
                                                	out.println("    </div>");
                                                	out.println("    <div class=\"span1 \">");
                                                	out.println("        <br>");
                                                	out.println("        <span>" + order.getPrice() + "</span>");
                                                	out.println("    </div>");
                                                	out.println("    <div class=\"span2 \">");
                                                	out.println("        <br>");
                                                	out.println("");
                                                	out.println("        <button class=\"btn\" type=\"button\" onclick=\"sendingFinish(" + order.getId() + ");\">已经发货</button>");
                                                	out.println("        <br><br>");
                                                	out.println("        <button class=\"btn\" type=\"button\" onclick=\"cancelOrder(" + order.getId() + ");\">取消订单</button>");
                                                	out.println("    </div>");
                                                	out.println("</div>");
                                                	out.println("<br>");
                                                }
                                                %>
                                                <div class="span10">

                                                    <span>提示：</span>
                                                    <p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                        该栏下显示的是已与用户确认，用户付款成功后，待您发货的订单。</p>
                                                    <p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                        请您在制作完成确认无误并发货之后，点击“已发货”。如出现问题需取消订单，可点击“取消订单”。
                                                    </p>

                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <!----------已发货订单-------------------->
                                <div class="tab-pane" id="panel-819619">
                                    <div class="container-fluid">
                                        <div class="row-fluid">
                                            <div class="span12">
                                                <div class="row-fluid bdiv">
                                                    <div class="span2">
                                                        <label>
                                                            &nbsp;

                                                            <input disabled type="checkbox" id="waitingReceiveAllCheckBox" onclick="selectAllWaitingReceive();">
                                                            &nbsp;&nbsp;&nbsp;全选</label>
                                                    </div>

                                                    <div class="span2">
                                                        <p>&nbsp;定制商品</p>
                                                    </div>
                                                    <div class="span1">
                                                        <p>购买者</p>
                                                    </div>
                                                    <div class="span2">
                                                        <p>下单时间</p>
                                                    </div>
                                                    <div class="span1">
                                                        <p>材料</p>
                                                    </div>
                                                    <div class="span1">
                                                        <p>数量</p>
                                                    </div>
                                                    <div class="span1">
                                                        <p>价格(元)</p>
                                                    </div>
                                                    <div class="span2">
                                                        <!-----------------点击批量完成之后，订单就完成，待处理列表中删除，出现在已完成的列表中-------------------->
                                                        <p>操作
                                                            <button class="btn" disabled>批量完成</button></p>
                                                    </div>
                                                </div>
                                                <br>
                                                <!-------购物单项 ------------>
                                                <%
                                                for(Order order: waitingReceiveOrders){
                                                	Model model = ModelService.getModelService().searchModelByID(order.getModel().getId());
                                                	User buyer = UserService.getUserService().searchUserByID(order.getUser().getId());
                                                	Material material = ShoppingService.getShoppingService().searchMaterialByID(order.getMaterial().getId());
                                                	out.println("<div class=\"row-fluid bdiv\">");
                                                	out.println("    <div class=\"span2 \">");
                                                	out.println("        <input type=\"checkbox\" class=\"waitingReceiveCheckBox\" name=\"" + order.getId() + "\">");
                                                	out.println("        <br><br>");
                                                	out.println("        <span>订单号：" + order.getId() + "</span>");
                                                	out.println("");
                                                	out.println("    </div>");
                                                	out.println("    <a href=\"modeldetail.jsp?id=" + model.getId() + "\" class=\"span2\">");
                                                	out.println("        <br>");
                                                	out.println("        <span>" + model.getName() + "</span>");
                                                	out.println("        <br>");
                                                	out.println("        <span>" + model.getDescriptrion() + "</span>");
                                                	out.println("    </a>");
                                                	out.println("    <div class=\"span1 \">");
                                                	out.println("        <!--------------点击用户名到用户管理界面，最好能focus到该用户那一栏----------------->");
                                                	out.println("        <br>");
                                                	out.println("        <div href=\"./ma_users.jsp\">");
                                                	out.println("            <span>" + buyer.getName() + "</span>");
                                                	out.println("");
                                                	out.println("        </div>");
                                                	out.println("        <label>联系买家</label>");
                                                	out.println("    </div>");
                                                	out.println("    <div class=\"span2\">");
                                                	out.println("        <br>");
                                                	out.println("        <span>" + order.getAddtime().toString().split(" ")[0] + "</span>");
                                                	out.println("        <br>");
                                                	out.println("        <span>" + order.getAddtime().toString().split(" ")[1] + "</span>");
                                                	out.println("    </div>");
                                                	out.println("    <div class=\"span1\">");
                                                	out.println("        <br>");
                                                	out.println("        <span>" + material.getName() + "</span>");
                                                	out.println("    </div>");
                                                	out.println("    <div class=\"span1 \">");
                                                	out.println("        <br>");
                                                	out.println("        <span>" + order.getNumber() + "</span>");
                                                	out.println("    </div>");
                                                	out.println("    <div class=\"span1 \">");
                                                	out.println("        <br>");
                                                	out.println("        <span>" + order.getPrice() + "</span>");
                                                	out.println("    </div>");
                                                	out.println("    <div class=\"span2 \">");
                                                	out.println("");
                                                	out.println("        <br>");
                                                	out.println("        <button class=\"btn\" type=\"button\" onclick=\"cancelOrder(" + order.getId() + ");\">取消订单</button>");
                                                	out.println("    </div>");
                                                	out.println("</div>");;
                                                	out.println("<br/>");
                                                }
                                                %>
                                                <div class="span10">
                                                    <br>
                                                    <span>提示：</span>
                                                    <p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                        该栏下，显示已经发货的订单，等待购买用户确认收货，最后完成此次订单交易。
                                                    </p>
                                                </div>
                                            </div>

                                        </div>

                                    </div>
                                </div>
                                <!-----------成功订单-------------->
                                <div class="tab-pane" id="panel-390435">
                                    <div class="container-fluid">
                                        <div class="row-fluid">
                                            <div class="span12">
                                                <div class="row-fluid bdiv">

                                                    <div class="span2">
                                                        <label>
                                                            &nbsp; 已完成订单列表
                                                        </label>
                                                    </div>
                                                    <div class="span2">
                                                        <p>&nbsp;定制商品</p>
                                                    </div>
                                                    <div class="span2">
                                                        <p>购买者</p>
                                                    </div>

                                                    <div class="span2">
                                                        <p>材料</p>
                                                    </div>
                                                    <div class="span1">
                                                        <p>数量</p>
                                                    </div>
                                                    <div class="span1">
                                                        <p>价格(元)</p>
                                                    </div>
                                                    <div class="span2">
                                                        <p>完成时间</p>
                                                    </div>
                                                </div>
                                                <br>
                                                <!-------购物单项 ------------>
                                                <%
                                                int i = 0;
                                                for(Order order: receivedOrders){
                                                	Model model = ModelService.getModelService().searchModelByID(order.getModel().getId());
                                                	User buyer = UserService.getUserService().searchUserByID(order.getUser().getId());
                                                	Material material = ShoppingService.getShoppingService().searchMaterialByID(order.getMaterial().getId());
                                                	out.println("<div class=\"row-fluid bdiv\">");
                                                	out.println("    <div class=\"span2 \">");
                                                	out.println("        <label>" + ++i + "</label>");
                                                	out.println("");
                                                	out.println("        <span>订单号：" + order.getId() + "</span>");
                                                	out.println("");
                                                	out.println("    </div>");
                                                	out.println("    <a href=\"modeldetail.jsp?id=" + model.getId() + "\" class=\"span2\">");
                                                	out.println("        <br>");
                                                	out.println("        <span>" + model.getName() + "</span>");
                                                	out.println("        <br>");
                                                	out.println("        <span>" + model.getDescriptrion() + "</span>");
                                                	out.println("    </a>");
                                                	out.println("    <div class=\"span2 \">");
                                                	out.println("        <!--------------点击用户名到用户个人信息页面------------------>");
                                                	out.println("        <br>");
                                                	out.println("        <div>");
                                                	out.println("            <span>" + buyer.getName() + "</span>");
                                                	out.println("");
                                                	out.println("        </div>");
                                                	out.println("        <label>联系买家</label>");
                                                	out.println("    </div>");
                                                	out.println("    <div class=\"span2\">");
                                                	out.println("        <br>");
                                                	out.println("        <span>" + material.getName() + "</span>");
                                                	out.println("    </div>");
                                                	out.println("    <div class=\"span1 \">");
                                                	out.println("        <br>");
                                                	out.println("        <span>" + order.getNumber() + "</span>");
                                                	out.println("    </div>");
                                                	out.println("    <div class=\"span1 \">");
                                                	out.println("        <br>");
                                                	out.println("        <span>" + order.getPrice() + "</span>");
                                                	out.println("    </div>");
                                                	out.println("    <div class=\"span2\">");
                                                	out.println("        <br>");
                                                	out.println("        <span>2014-12-01</span>");
                                                	out.println("        <br>");
                                                	out.println("        <span>18:50</span>");
                                                	out.println("    </div>");
                                                	out.println("</div>");
                                                	out.println("<br/>");
                                                }
                                                %>
                                                <div class="span10">
                                                    <br>
                                                    <span>提示：</span>
                                                    <p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                        用户确认收货订单后，交易成功完成的订单。
                                                    </p>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <!---------失败订单----------------->
                                <div class="tab-pane" id="panel-390436">
                                    <div class="container-fluid">
                                        <div class="row-fluid">
                                            <div class="span12">
                                                <div class="row-fluid bdiv">

                                                    <div class="span2">
                                                        <label>
                                                            &nbsp; 失败订单列表
                                                        </label>
                                                    </div>
                                                    <div class="span2">
                                                        <p>&nbsp;定制商品</p>
                                                    </div>
                                                    <div class="span2">
                                                        <p>购买者</p>
                                                    </div>

                                                    <div class="span2">
                                                        <p>材料</p>
                                                    </div>
                                                    <div class="span1">
                                                        <p>数量</p>
                                                    </div>
                                                    <div class="span1">
                                                        <p>价格(元)</p>
                                                    </div>
                                                    <div class="span2">
                                                        <p>取消时间</p>
                                                    </div>
                                                </div>
                                                <br>
                                                <!-------购物单项 ------------>
                                                <%
                                                i = 0;
                                                for(Order order: canceledOrders){
                                                	Model model = ModelService.getModelService().searchModelByID(order.getModel().getId());
                                                	User buyer = UserService.getUserService().searchUserByID(order.getUser().getId());
                                                	Material material = ShoppingService.getShoppingService().searchMaterialByID(order.getMaterial().getId());
                                                	out.println("<div class=\"row-fluid bdiv\">");
                                                	out.println("    <div class=\"span2 \">");
                                                	out.println("        <label>" + ++i + "</label>");
                                                	out.println("");
                                                	out.println("        <span>订单号：" + order.getId() + "</span>");
                                                	out.println("");
                                                	out.println("    </div>");
                                                	out.println("    <a href=\"modeldetail.jsp?id=" + model.getId() + "\" class=\"span2\">");
                                                	out.println("        <br>");
                                                	out.println("        <span>" + model.getName() + "</span>");
                                                	out.println("        <br>");
                                                	out.println("        <span>" + model.getDescriptrion() + "</span>");
                                                	out.println("    </a>");
                                                	out.println("    <div class=\"span2 \">");
                                                	out.println("        <!--------------点击用户名到用户个人信息页面------------------>");
                                                	out.println("        <br>");
                                                	out.println("        <div>");
                                                	out.println("            <span>" + buyer.getName() + "</span>");
                                                	out.println("");
                                                	out.println("        </div>");
                                                	out.println("        <br>");
                                                	out.println("        <label>联系买家</label>");
                                                	out.println("    </div>");
                                                	out.println("    <div class=\"span2\">");
                                                	out.println("        <br>");
                                                	out.println("        <span>" + material.getName() + "</span>");
                                                	out.println("    </div>");
                                                	out.println("    <div class=\"span1 \">");
                                                	out.println("        <br>");
                                                	out.println("        <span>" + order.getNumber() + "</span>");
                                                	out.println("    </div>");
                                                	out.println("    <div class=\"span1 \">");
                                                	out.println("        <br>");
                                                	out.println("        <span>" + order.getPrice() + "</span>");
                                                	out.println("    </div>");
                                                	out.println("    <div class=\"span2\">");
                                                	out.println("        <br>");
                                                	out.println("        <span>2014-12-01</span>");
                                                	out.println("        <br>");
                                                	out.println("        <span>18:50</span>");
                                                	out.println("    </div>");
                                                	out.println("</div>");
                                                	out.println("<br/>");
                                                }
                                                %>
                                            </div>
                                            <div class="span10">
                                                <br>
                                                <span>提示：</span>
                                                <p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                    该栏“失败订单”，存的是在“完成订单”之前，出现任何问题而导致被取消的订单。
                                                </p>
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
	
	<script type="text/javascript">
	function selectAllHandling(){
		var select = document.getElementById('handlingAllCheckBox').checked;
		var boxs = document.getElementsByClassName('handlingCheckBox');
		for(var i=0; i<boxs.length; i++){
			boxs[i].checked = select;
		}
	}
	function selectAllWaitingSend(){
		var select = document.getElementById('waitingSendAllCheckBox').checked;
		var boxs = document.getElementsByClassName('waitingSendCheckBox');
		for(var i=0; i<boxs.length; i++){
			boxs[i].checked = select;
		}
	}
	function selectAllWaitingReceive(){
		var select = document.getElementById('waitingReceiveAllCheckBox').checked;
		var boxs = document.getElementsByClassName('waitingReceiveCheckBox');
		for(var i=0; i<boxs.length; i++){
			boxs[i].checked = select;
		}
	}

	function sendingFinishs(){
		var orderIDs = '';
		var boxs = document.getElementsByClassName('waitingSendCheckBox');
		for(var i=0; i<boxs.length; i++){
			if(boxs[i].checked){
				orderIDs += boxs[i].name + ';';
			}
		}
		if(orderIDs == ''){
			alert('请勾选订单。');
			return;
		}
		sendingFinishAjax(orderIDs);
	}

	function sendingFinish(orderID){
		sendingFinishAjax(orderID);
	}

	function handlingFinishs(){
		var orderIDs = '';
		var prices = '';
		var boxs = document.getElementsByClassName('handlingCheckBox');
		for(var i=0; i<boxs.length; i++){
			if(boxs[i].checked){
				orderIDs += boxs[i].name + ';';
				var price = document.getElementById('priceinput_' + boxs[i].name).value;
				if(price > 0){
					prices += price + ';';
				}else{
					alert('请输入正确的价格。');
					return;
				}
			}
		}
		if(orderIDs == ''){
			alert('请勾选订单。');
			return;
		}
		handlingFinishAjax(orderIDs, prices);
	}

	function handlingFinish(orderID){
		var price = document.getElementById('priceinput_' + orderID).value;
		if(price > 0){
			handlingFinishAjax(orderID, price);
		}else{
			alert('请输入正确的价格。');
		}
	}

	function cancelOrder(orderID){
		cancelOrdersAjax(orderID);
	}

	function cancelOrdersAjax(orderIDs){
		console.log('取消订单');
		$.ajax({
			type: "GET",
			url: 'ajax/changeordersstatus',
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

	function handlingFinishAjax(orderIDs, prices){
		console.log('确认订单');
		$.ajax({
			type: "GET",
			url: 'ajax/changeordersstatus',
			data: {status:'checked',orderIDs:orderIDs,prices:prices},
			dataType: 'json',
			async: false,
			success: function(data){
				if(data.count > 0){
					alert('成功确认' + data.count + '个订单。');
					location = '';
				}else{
					alert('确认订单失败。');
				}
			},
			error: function(err){
				alert('网络故障');
			}
		});
	}

	function sendingFinishAjax(orderIDs){
		console.log('确认发货');
		$.ajax({
			type: "GET",
			url: 'ajax/changeordersstatus',
			data: {status:'waiting receive',orderIDs:orderIDs},
			dataType: 'json',
			async: false,
			success: function(data){
				if(data.count > 0){
					alert(data.count + '个订单已经成功发货。');
					location = '';
				}else{
					alert('发货失败。');
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