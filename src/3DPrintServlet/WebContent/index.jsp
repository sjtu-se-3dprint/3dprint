<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="entity.*, database.*" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>3D打印创作服务平台</title>
</head>
<body>
	<jsp:include page="header.jsp" flush="true"></jsp:include>
    <div class="container-fluid">
        <div class="carousel slide" id="carousel-370313">
            <div class="carousel-inner">
                <div class="item active">
                    <img alt="" src="./img/slider-bg-1.jpg" />
                    <div class="carousel-caption">
                        <h4>

                            

                            EasyPrint

                        </h4>
                        <p>
           

                           为设计师和消费者提供3D打印学习、创意设计以及模型欣赏等个性化定制服务。通过线下智能3D打印高效实现个性定制家用，为您打造专属的个性化消费品！

                        </p>
                    </div>
                </div>
                <div class="item">
                    <img alt="" src="./img/slider-bg-2.jpg" />
                    <div class="carousel-caption">
                        <h4>

                            

                            3D打印

                        </h4>
                        <p>
            

                           即快速成型技术的一种，它是一种以数字模型文件为基础，运用粉末状金属或塑料等可粘合材料，通过逐层打印的方式来构造物体的技术。

                        </p>
                    </div>
                </div>
                <div class="item">
                    <img alt="" src="./img/slider-bg-3.jpg" />
                    <div class="carousel-caption">
                        <h4>

                            

                            多样材料

                        </h4>
                        <p>
                    
                          多种材料选择  打印更多专业模型  新材料是3D打印技术的重要推动力

                        </p>
                    </div>
                </div>
                <div class="item">
                    <img alt="" src="./img/slider-bg-4.jpg" />
                    <div class="carousel-caption">
                        <h4>

                            多样打印机

                        </h4>
                        <p>

                           可靠的桌面3D打印机   雕刻机

                        </p>
                    </div>
                </div>
            </div> <a data-slide="prev" href="#carousel-370313" class="left carousel-control">‹</a> <a data-slide="next" href="#carousel-370313" class="right carousel-control">›</a>
        </div>
    </div>

    <div class="container">
        <div class="row-fluid">
            <div class="span12">
                <h3 class="text-center text-success">
                    创意生活，只需点击鼠标，所见即所得
                </h3>
            </div>
        </div>
        <%
        	List<Model> models = ModelService.getModelService().searchModelsSort("all", "normal", "all", "time-down");
                	int sz = Math.min(8, models.size());
        	        for(int i=0; i<sz; i+=4){
        	    		out.println("<div class=\"row-fluid\">");
        	    		for(int j=i; j<sz && j<i+4; j++){
        	    			Model model = models.get(j);
        	    			out.println("<div class=\"span3\">");
                			out.println("<a href=\"modeldetail.jsp?id=" + model.getId() + "\">");
                			out.println("<img alt=\"140x140\" src=\"modelimage?modelID=" + model.getId() + "&number=1" + "\" class=\"img-rounded\" />");
                			out.println("<p class=\"text-left\">");
                			out.println("<strong>" + model.getName() + "</strong>");
                			out.println("</p>");
                			out.println("</a>");
                			User uploader = UserService.getUserService().searchUserByID(model.getUser().getId());
        	    			out.println("<strong>作者：" + uploader.getName() + "</strong>");
        	    			out.println("</p>");
        	    			out.println("</div>");
        	    		}
        	    		out.println("</div>");
        	    	}
        %>
    </div>
	<jsp:include page="footer.jsp" flush="true"></jsp:include>
</body>
</html>