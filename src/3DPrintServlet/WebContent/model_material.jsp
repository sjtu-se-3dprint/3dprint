<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="service.GetLoginUserService,entity.*, database.*, java.util.List" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<style>
        .bdiv{
            border: 1px solid #99bbbb;
            padding: 5px;
        }
</style>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>3D打印创作服务平台-在线定制</title>
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
		int shopcarIDValue = 0;
		int numberValue = 0;
		try{
			shopcarIDValue = Integer.parseInt(shopcarID);
			numberValue = Integer.parseInt(number);
		}catch(Exception e){
			return;
		}
	%>
    <div class="container-fluid">
        <div class="container">
                <div class="row-fluid bdiv">
                    <div class="span1">
                        <span>操作</span>
                    </div>
                    <div class="span2">
                        <p>图片展示</p>
                    </div>
                    <div class="span2">
                        <p>材料名称</p>
                    </div>
                    <div class="span3">
                        <p>材料属性</p>
                    </div>
                    <div class="span4">
                        <p>材料描述</p>
                    </div>
                </div>
                <br>
                <!-- <div class="row-fluid bdiv">
                    <div class="span1">
                        <input type='checkbox' />
                    </div>
                    <div class="span2">
                        <img src='img/materials/m1.jpg' height=80px/>
                    </div>
                    <div class="span2">
                        <p>石膏粉末</p>
                    </div>
                    <div class="span3">
                        <span>强度：低</span>
                        <br>
                		<span>精细度：中</span>
                		<br>
                		<span>光滑度：低</span>
                		<br>
                		<span>价格：低</span>
                    </div>
                    <div class="span4" style='margin-left:15px;margin-top:10px;margin-right:15px;'>
                        <p>石膏粉末是一种优质复合材料，颗粒均匀细腻，颜色超白，使用我们的材料打印的模型可磨光、钻孔、攻丝、上色并电镀，实现更高的灵活性。利用彩
喷打印技术（CJP）和VisitJet? PXL?材料以构建坚固的，高分辨率的，全彩色的概念模型，组件和原型，适用于重现设计，增进沟通以及降低研发和生产成本
。打印模型的应用行业包括：运输、能源、消费品、娱乐、医疗保健、教育以及其他垂直市场。所生成的零件可以打 材料本身基于石膏的，易碎，坚固，色彩
清晰。材料感觉起来很像岩石</p>
                    </div>
                </div>
                <div class="row-fluid bdiv">
                    <div class="span1">
                        <input type='checkbox' />
                    </div>
                    <div class="span2">
                        <img src='img/materials/m2.jpg' height=80px/>
                    </div>
                    <div class="span2">
                        <p>檀香木</p>
                    </div>
                    <div class="span3">
                        <span>强度：高</span>
                        <br>
                		<span>精细度：中</span>
                		<br>
                		<span>光滑度：中</span>
                		<br>
                		<span>价格：高</span>
                    </div>
                    <div class="span4" style='margin-left:15px;margin-top:10px;margin-right:15px;'>
                        <p>檀香木雕刻出来的工艺品更可谓珍贵无比。家中摆放芳馨经久。檀香木置于橱柜之中有熏衣的作用，使你的衣物带有淡淡天然高贵的香味。能驱邪避小
人，提高你的亲和力，有助你的事业。檀香木极其珍贵，品质好的檀香木的市价在千元/斤以上。我国天然檀香树早在明清时期就已经被砍伐殆尽。国内的檀香
原木都依赖进口。因檀香木生长条件苛刻，产量极低。全球仅存的天然檀香木只有印度、斐济和澳大利亚。且严格的保护措施和高额关税限制出口。市面上的
檀香木已是难得一见。</p>
                    </div>
                </div>
                <div class="row-fluid bdiv">
                    <div class="span1">
                        <input type='checkbox' />
                    </div>
                    <div class="span2">
                        <img src='img/materials/m1.jpg' height=80px/>
                    </div>
                    <div class="span2">
                        <p>PLA塑料</p>
                    </div>
                    <div class="span3">
                        <span>强度：高</span>
                        <br>
                		<span>精细度：中</span>
                		<br>
                		<span>光滑度：高</span>
                		<br>
                		<span>价格：中</span>
                    </div>
                    <div class="span4" style='margin-left:15px;margin-top:10px;margin-right:15px;'>
                        <p>PC材料是真正的热塑性材料，具备工程塑料的所有特性。高强度，耐高温，抗冲击，抗弯曲，可以作为最终零部件使用。使用PC材料制作的样件，可以
直接装配使用，广泛应用于交通工具及家电行业。PC的强度比ABS材料高出60%左右，具备超强的工程材料属性！ PC材料具备很强的机械性能，拉伸强度、抗弯
曲强度都非常好，耐温性高达140℃。</p>
                    </div>
                </div> -->
                <%
                	List<Material> materials = ShoppingService.getShoppingService().searchMaterialsByStatus("normal");
                	for(Material material : materials){
                		out.println("<div class=\"row-fluid bdiv\">");
                		out.println("    <div class=\"span1\" style=\"padding-top: 45px;\">");
                		out.println("        <button onclick=\"selectMaterial(" + material.getId() + ");\">选中</button>");
                		out.println("    </div>");
                		out.println("    <div class=\"span2\">");
                		out.println("        <img alt=\"model\" src=\"./img/materials/m1.jpg\" />");
                		out.println("    </div>");
                		out.println("    <div class=\"span2\">");
                		out.println("       <br>");
                		out.println("       <span></span>");
                		out.println("       <br>");
                		out.println("       <span>" + material.getName() + "</span>");
                		out.println("    </div>");
                		out.println("    <div class=\"span3 \">");
                		out.println("       <br>");
                		out.println("       <span>强度：" + material.getIntensity() + "</span>");
                		out.println("       <br>");
                		out.println("       <span>精细度：" + material.getAccuracy() + "</span>");
                		out.println("       <br>");
                		out.println("       <span>光滑度：" + material.getSmooth() + "</span>");
                		out.println("       </div>");
                		out.println("    <div class=\"span4 \">");
                		out.println("       <br>");
                		out.println("       <span>" + material.getDescription() + "</span>");
                		out.println("    </div>");
                		out.println("</div>");
                		out.println("<br><br>");

                	}
                %>
               
        </div>
    </div>
	<jsp:include page="footer.jsp" flush="true"></jsp:include>
	<script type="text/javascript">
		function selectMaterial(id){
			var shopcarID = <%=shopcarIDValue%>;
			var number = <%=numberValue%>;
			console.log(shopcarID);
			console.log(number);
			console.log(id);
			location = 'submitorder.jsp?shopcarID=' + shopcarID
				+ '&number=' + number
				+ '&materialID=' + id;
		}
	</script>
</body>
</html>