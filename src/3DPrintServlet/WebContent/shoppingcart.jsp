<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="service.GetLoginUserService,entity.*, database.*, java.util.List" %>
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
	%>
    <div class="container">
        <div class="span12">
            <ul class="cartStep">
                <li class="step1" style="color: #FFF; background: #02cae2;">1.我的购物车</li>
                <li class="step2">2.选择打印材料</li>
                <li class="step3">3.提交订单信息</li>
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

                                <input type="checkbox" id="allShopcarCheckBox" onclick="selectAll();">
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
                            <p>操作</p>
                        </div>
                    </div>
                    <br>
                    <!-------购物单项 ------------>
                    <%
                    List<Shopcar> shopcars = ShoppingService.getShoppingService().searchShopcarsByUser(user.getId());
                    for(Shopcar shopcar:shopcars){
                    	Model model = ModelService.getModelService().searchModelByID(shopcar.getModel().getId());
                    	Boolean collection = UserLikeCollectionCommentService.getUserLikeCollectionCommentService()
                    			.isCollection(user.getId(), model.getId());
                    	out.println("<div class=\"row-fluid bdiv\">");
                    	out.println("    <div class=\"span1\" style=\"padding-top: 45px;\">");
                    	out.println("    <input type=\"checkbox\" class=\"shopcarCheckBox\" name=\"" + shopcar.getId() + "\"></div>");
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
                    	out.println("        <form>");
                    	out.println("            <input id=\"" + shopcar.getId() + "_number\" type=\"text\" class=\"form-control\"  value=\"" + shopcar.getNumber() + "\" style=\"width: 50px;\">");
                    	out.println("        </form>");
                    	out.println("    </div>");
                    	out.println("    <div class=\"span2 \">");
                    	out.println("        <br>");
                    	out.println("        <button class=\"btn\" type=\"button\" onclick=\"collection(" + collection + "," +  model.getId() + ");\">" + (collection?"取消收藏":"加入收藏") + "</button>");
                    	out.println("        <br><br>");
                    	out.println("        <button class=\"btn\" type=\"button\" onclick=\"deleteShopcar(" +shopcar.getId() + ");\">取消购买</button>");
                    	out.println("    </div>");
                    	out.println("</div>");
                    	out.println("<br><br>");

                    }
                    %>

                <div class="container-fluid">
                    <div class="row-fluid">
                        <br><br>
                        <div class="row-fluid">
                            <div class="span4"></div>

                            <div class="span2">
                                <a href="modellist.jsp">
                                    <button class="btn" type="button">返回商城</button>
                                </a>
                            </div>
                            <div class="span2">
                                <button class="btn" type="button" onclick="deleteShopcarAll();">全部清空</button>
                            </div>
                            <div class="span2">
                                <button class="btn" type="button" onclick="location='pay.jsp';">联系我们</button>
                            </div>
                            <!----------选择材料跳转至材料选择页面-------------->
                            <div class="span2">
                                <button class="btn" type="button" onclick="selectMaterial();">选择材料</button>
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

		function addOrders(){
			var boxs = document.getElementsByClassName('shopcarCheckBox');
			var modelIDs = '';
			var materialIDs = '';
			var numbers = '';
			for(var i=0; i<boxs.length; i++){
				if(boxs[i].checked){
					modelIDs += boxs[i].name + ';';
					var material = document.getElementById(boxs[i].name + '_material');
					var number = document.getElementById(boxs[i].name + '_number');
					var numberValue = parseInt(number.value);
					if(!(numberValue>0)){
						alert('请在数量栏填入正数');
						return;
					}
					materialIDs += material.value + ';';
					numbers += numberValue + ';';
				}
			}
			if(modelIDs == ''){
				alert('请选中模型。');
				return;
			}
			console.log(modelIDs);
			console.log(materialIDs);
			console.log(numbers);
			var count = addOrdersajax(modelIDs, materialIDs, numbers);
			if(count > 0){
				alert('成功添加' + count + '个订单。');
				location = 'user_shop.jsp?tab=2';
			}else{
				alert('添加订单失败。');
			}	
		}

		function addOrdersajax(modelIDs, materialIDs, numbers){
			var count = 0;
			$.ajax({
				type:'GET',
				url: 'ajax/addorders',
				data:{modelIDs:modelIDs, materialIDs:materialIDs, numbers:numbers},
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
		
		function selectAll(){
			console.log('selectAll')
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
			var shopcars = '';
			for(var i=0; i<boxs.length; i++){
				if(boxs[i].checked){
					shopcars += boxs[i].name + ';';
				}
			}
			if(shopcars == ''){
				alert('请选中模型。');
				return;
			}
			var count = deleteShopcars(shopcars);
			if(count > 0){
				alert('成功移出' + count + '个模型。');
				location = '';
			}else{
				alert('移出购物车失败。');
			}
		}

		function selectMaterial(){
			var boxs = document.getElementsByClassName('shopcarCheckBox');
			var shopcar = '';
			var count = 0;
			for(var i=0; i<boxs.length; i++){
				if(boxs[i].checked){
					shopcar = boxs[i].name;
					count += 1;
				}
			}
			if(count == 0){
				alert('请选中一个模型。');
				return;
			}
			if(count > 1){
				alert('一次只能为一个模型选择材料。');
				return;
			}
			var number = document.getElementById(shopcar+'_number').value;
			if(!(number > 0)){
				alert('请填入正确的数额。');
				return;
			}
			location = 'model_material.jsp?shopcarID=' + shopcar
				+ '&number=' + number;
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

		function deleteShopcars(shopcars){
			var count = 0;
			$.ajax({
				type:'GET',
				url: 'ajax/deleteshopcar',
				data:{shopcarIDs:shopcars},
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