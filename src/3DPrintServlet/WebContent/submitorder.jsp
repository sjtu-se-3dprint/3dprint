<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="service.GetLoginUserService, entity.*, database.*, java.util.List" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>3D打印创作服务平台-购物车</title>
        <style>
            .bdiv{
                border: 1px solid #99bbbb;
                padding: 5px;
            }
            .cartStep .step {
                color: #FFF;
                background: #02cae2;
            }
            .cartStep .step,.cartStep .step1, .cartStep .step2, .cartStep .step3 {
                width: 145px;
                height: 30px;
                float: left;
                display: block;
                font: 14px/30px '';
                font-weight: bold;
                color: #000;
                background: #dee2e3;
                text-align: center;
                text-indent: 2em;
            }
            li {
                list-style: none;
            }
            .cartStep {
                float: right;
                width: 440px;
                padding-top: 20px;
            }
            body, div, ul, ol, li, dl, dt, dd, h1, h2, h3, h4, h5, h6, p, form {
                margin: 0px auto;
                padding: 0px;
            }
            ul {
                display: block;
                list-style-type: disc;
                -webkit-margin-before: 1em;
                -webkit-margin-after: 1em;
                -webkit-margin-start: 0px;
                -webkit-margin-end: 0px;
                -webkit-padding-start: 40px;
            }
            .cartStep .step2,.cartStep .step3{
                background: url(../img/shop/bg_cart_setup.gif) no-repeat left -30px #dee2e3;
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
		String shopcarID = request.getParameter("shopcarID");
		String number = request.getParameter("number");
		String materialID = request.getParameter("materialID");
		int shopcarIDValue = 0;
		int numberValue = 0;
		int materialIDValue = 0;
		try{
			shopcarIDValue = Integer.parseInt(shopcarID);
			numberValue = Integer.parseInt(number);
			materialIDValue = Integer.parseInt(materialID);
		}catch(Exception e){
			return;
		}
		Shopcar shopcar = ShoppingService.getShoppingService().searchShopcarByID(shopcarIDValue);
		Material material = ShoppingService.getShoppingService().searchMaterialByID(materialIDValue);
		if(shopcar == null || material == null){
			return;
		}
	%>
    <div class="container">
        <div class="span12">
            <ul class="cartStep">
                <li class="step1">1.我的购物车</li>
                <li class="step2">2.选择打印材料</li>
                <li class="step3" style="color: #FFF; background: #02cae2;">3.提交订单信息</li>
            </ul>
        </div>
        <div class="span4">
            <h3>我的购物车</h3>
        </div>
        <div class="container-fluid">
            <div class="row-fluid">
                <div class="span12">
                    <div class="row-fluid bdiv">
                        <div class="span1">
                            <label>
                                &nbsp;

                                <input checked type="checkbox" id="allShopcarCheckBox" disabled />
                                &nbsp;&nbsp;&nbsp;全选</label>
                        </div>
                        <div class="span2">
                            <button class="btn" onclick="deleteShopcarBatch();">删除选中</button>
                        </div>
                        <div class="span3">
                            <p>&nbsp;&nbsp;&nbsp;模型信息</p>
                        </div>
                        <div class="span2">
                            <p>加入时间</p>
                        </div>
                        <div class="span2">
                            <p>数量</p>
                        </div>
                        <div class="span2">
                            <p>材料</p>
                        </div>
                    </div>
                    <br>
                    <!-------购物单项 ------------>
                    <%
                    	Model model = ModelService.getModelService().searchModelByID(shopcar.getModel().getId());
                    	Boolean collection = UserLikeCollectionCommentService.getUserLikeCollectionCommentService()
                    			.isCollection(user.getId(), model.getId());
                    	out.println("<div class=\"row-fluid bdiv\">");
                    	out.println("    <div class=\"span1\" style=\"padding-top: 45px;\">");
                    	out.println("    <input checked type=\"checkbox\" class=\"shopcarCheckBox\" name=\"" + shopcar.getId() + "\" disabled></div>");
                    	out.println("    <a href=\"modeldetail.jsp?id=" + model.getId() + "\" class=\"span2\">");
                    	out.println("        <img alt=\"model\" src=\"modelimage?number=1&modelID=" + shopcar.getModel().getId() + "\" />");
                    	out.println("    </a>");
                    	out.println("    <div class=\"span3\">");
                    	out.println("        <br>");
                    	out.println("        <span>" + model.getName() + "</span>");
                    	out.println("        <br>");
                    	out.println("        <span>" + model.getDescriptrion() + "</span>");
                    	out.println("    </div>");
                    	out.println("    <div class=\"span2 \">");
                    	out.println("        <br>");
                    	out.println("");
                    	out.println("        <br>");
                    	out.println("        <span>" + shopcar.getAddtime() + "</span>");
                    	out.println("    </div>");
                    	out.println("    <div class=\"span2 \">");
                    	out.println("        <br>");
                    	out.println("        <br>");
                    	out.println("        <form>");
                    	out.println("            <span>" + number + "</span>");
                    	out.println("        </form>");
                    	out.println("    </div>");
                    	out.println("    <div class=\"span2 \">");
                    	out.println("        <br>");
                    	out.println("        <br>"); 
                    	out.println("            <span>" + material.getName() + "</span>");
                    	out.println("    </div>");
                    	out.println("</div>");
                    	out.println("<br><br>");
                    %>

                <div class="container-fluid">
                    <div class="row-fluid">
                        <br><br>
                        <div class="row-fluid">
                            <div class="span4"></div>

                            <div class="span2">
                            </div>
                            <div class="span2">
                                <a href="modellist.jsp">
                                    <button class="btn" type="button">返回商城</button>
                                </a>
                            </div>
                            <div class="span2">
                                <button class="btn" type="button">联系我们</button>
                            </div>
                            <!----------选择材料跳转至材料选择页面-------------->
                            <div class="span2">
                                <button class="btn" type="button" onclick="submitOrder();">提交订单</button>
                            </div>

                        </div>

                    </div>
                </div>
                <div class="container-fluid">
                    <div class="row-fluid">
                        <br><br>
                        <div class="row-fluid">
                            <label>提示：</label>
                            <p>&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;选定购物车中需要购买的模型，点击选择材料，选定打印所用的材料，方可提交订单，待卖家联系您，价格需在订单确认时商定。</p>
                        </div>

                    </div>
                </div>
            </div>
        </div>
    </div>
	<jsp:include page="footer.jsp" flush="true"></jsp:include>
	<script>
		function submitOrder(){
			var shopcarID = <%=shopcarIDValue%>;
			var materialID = <%=materialIDValue%>;
			var number = <%=numberValue%>
			if(!(number > 0)){
				alert('数额不正常。');
				return;
			}
			if(1 == addOrdersajax(shopcarID,materialID,number)){
				alert('提交订单成功。');
				location = 'user_shop.jsp';
			}else{
				alert('提交订单失败。');
			}
		}

		function addOrdersajax(shopcarIDs, materialIDs, numbers){
			var count = 0;
			$.ajax({
				type:'GET',
				url: 'ajax/addorders',
				data:{shopcarIDs:shopcarIDs, materialIDs:materialIDs, numbers:numbers},
				dataType:'json',
				async:false,
				success: function(data){
					count = data.count;
				},
				error: function(err){
					alert('网络故障。');
				}
			});
			return count;
		}
	</script>
</body>
</html>