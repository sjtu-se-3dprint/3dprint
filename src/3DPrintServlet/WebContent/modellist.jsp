<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    
<%@ page import="service.*,entity.*, database.*, java.util.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>3D打印创作服务平台-模型展示</title>
</head>
<body>
	<jsp:include page="header.jsp" flush="true"></jsp:include>
	
	<%
		String style = request.getParameter("style");
		String candown = request.getParameter("candown");
		String sort = request.getParameter("sort");
		String pageNumber = request.getParameter("page");
		/* style = style==null ? null : new String(style.getBytes("ISO-8859-1"), "UTF-8");
		candown = candown==null ? null : new String(candown.getBytes("ISO-8859-1"), "UTF-8");
		sort = sort==null ? null : new String(sort.getBytes("ISO-8859-1"), "UTF-8");
		pageNumber = pageNumber==null ? null : new String(pageNumber.getBytes("ISO-8859-1"), "UTF-8"); */
	%>
	
    <div class="container">
        <div class="row">
            <div class="span12">
                <ul class="breadcrumb">
                    <li>
                        <a href="index.jsp">首页</a> <span class="divider">/</span>
                    </li>
                    <li>
                        <a href="">模型展示</a> <span class="divider">/</span>
                    </li>
                    <li class="active">
                       模型列表
                    </li>
                </ul>
                <div class="row">
                    <div class="tabbable tabs-left" id="tabs-157670">
                        <ul class="nav nav-tabs">
                        	<% 
                        		if(util.Util.isEmpty(style) || style.equals("all")){
                        			out.println("<li class=\"active\" onclick=\"searchModel('style', '" + "all" + "');\"><a  data-toggle=\"tab\">全部</a></li>");
                        		}else{
                        			out.println("<li onclick=\"searchModel('style', '" + "all" + "')\"><a  data-toggle=\"tab\">全部</a></li>");
                        		}
                        		String [] styles = new String[]{"时尚", "简约", "实用", "精细"};
                        		for(int i=0; i<styles.length; i++){
                        			if(styles[i].equals(style)){
                        				out.println("<li class=\"active\" onclick=\"searchModel('style', '" + styles[i] + "');\"><a  data-toggle=\"tab\">" + styles[i] + "</a></li>");
                        			}else{
                        				out.println("<li onclick=\"searchModel('style', '" + styles[i] + "')\"><a  data-toggle=\"tab\">" + styles[i] + "</a></li>");
                        			}
                        		}
                        	%>
                        </ul>

                        <div class="tab-content">
                            <div class="tab-pane active"  id="panel-102046">
                                <div class="span9">
                                    <div class="row-fluid">
                                        <div class="span6">
                                            <div class="row-fluid">
                                                <div class="span4">
                                                    <p>属性筛选</p>
                                                </div>
                                                <div class="checkbox">
                                                    <label>
                                                    	<%
                                                    		if("yes".equals(candown)){
                                                    			out.println("<input type=\"checkbox\" checked onclick=\"searchModel('candown');\">可下载</input>");
                                                    		}else{
                                                    			out.println("<input type=\"checkbox\" onclick=\"searchModel('candown');\">可下载</input>");
                                                    		}
                                                    	%>
                                                    </label>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="span6">
                                            <div class="row-fluid">
                                                <div class="span4">
                                                    <span>排序：</span>
                                                </div>

                                                <div class="span4">
                                                    <button class="btn btn-success" type="button" id="btnsize" onclick="searchModel('size');">
                                                    	<%
                                                    		if("size-down".equals(sort)){
                                                    			out.println("规模↓");
                                                    		}else if("size-up".equals(sort)){
                                                    			out.println("规模↑");
                                                    		}else{
                                                    			out.println("规模");
                                                    		}
                                                    	%>
                                                    </button>
                                                </div>
                                                <div class="span4">
                                                    <button class="btn btn-success" type="button" id="btntime" onclick="searchModel('time');">
                                                    	<%
                                                    		if("time-down".equals(sort)){
                                                    			out.println("上传时间↓");
                                                    		}else if("time-up".equals(sort)){
                                                    			out.println("上传时间↑");
                                                    		}else{
                                                    			out.println("上传时间");
                                                    		}
                                                    	%>
                                                    </button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="line"><br><br></div>
                                
                                <%
                                	int pageNumberInt = 1;
                                	try{
                                		pageNumberInt = Integer.parseInt(pageNumber);
                                	}catch(Exception e){
                                		
                                	}
                                	List<Model> models = ModelService.getModelService().searchModelsSort(style, "normal", candown, sort);
                                	int CountPerPage = 6;
                                	int maxPage = (models.size()-1)/CountPerPage + 1;
                                	pageNumberInt = Math.max(pageNumberInt, 1);
                                	pageNumberInt = Math.min(pageNumberInt, maxPage);
                                	int from = CountPerPage * (pageNumberInt-1);
                            		int end = from + CountPerPage;
                            		end = Math.min(end, models.size());
                                	int rowCount = 3;
                            		for(int i=from; i<end; i+=rowCount){
                            			out.println("<div class=\"row-fluid\">");
                            			for(int j=i; j<end && j<i+rowCount; j++){
                                			Model model = models.get(j);
                                			out.println("<div class=\"span4\">");
                                			out.println("	<a href=\"modeldetail.jsp?id=" + model.getId() + "\">");
                                			out.println("		<img src=\"modelimage?number=1&modelID=" + model.getId() + "\" class=\"img-rounded\" />");
                                			out.println("		<p class=\"text-left\">");
                                			out.println("			<strong>" + model.getName() + "</strong>");
                                			out.println("		</p>");
                                			out.println("	</a>");
                                			out.println("	<p class=\"text-left\">");
                                			User user = UserService.getUserService().searchUserByID(model.getUser().getId());
                                			out.println("		<strong>作者：" + user.getName() + "</strong>");
                                			out.println("	</p>");
                                			out.println("</div>");
                            			}
                                		out.println("</div>");
                            		}
                                %>
                                <div class="pagination pagination-right pagination-large">
                                    <ul>
                                    	<%
                                    		int pageFrom = pageNumberInt - 2;
                                    		int pageTo = pageNumberInt + 2;
                                    		pageFrom = pageFrom < 1 ? 1 : pageFrom;
                                    		pageTo = pageTo > maxPage ? maxPage : pageTo;
                                    		if(pageNumberInt == 1){
                                    			out.println("<li class=\"disabled\"><a>首页</a></li>");
                                    			out.println("<li class=\"disabled\"><a>上一页</a></li>");
                                    		}else{
                                    			out.println("<li onclick=\"searchModel('page', '1');\"><a>首页</a></li>");
                                    			out.println("<li onclick=\"searchModel('page','" + (pageNumberInt-1) + "');\"><a>上一页</a></li>");
                                    		}
                                    		if(pageFrom > 1){
                                    			out.println("<li><a>...</a></li>");
                                    		}
                                    		for(int i=pageFrom; i<=pageTo; i++){
                                    			if(pageNumberInt == i){
                                    				out.println("<li class=\"active\"><a>" + i + "</a></li>");
                                    			}else{
                                    				out.println("<li onclick=\"searchModel('page','" + i + "');\"><a>" + i + "</a><li>");
                                    			}
                                    		}
                                    		if(pageTo < maxPage){
                                    			out.println("<li><a>...</a></li>");
                                    		}
                                    		if(pageNumberInt == maxPage){
                                    			out.println("<li class=\"disabled\"><a>下一页</a></li>");
                                    			out.println("<li class=\"disabled\"><a>末页</a></li>");
                                    		}else{
                                    			out.println("<li onclick=\"searchModel('page','" + (pageNumberInt+1) + "');\"><a>下一页</a></li>");
                                    			out.println("<li onclick=\"searchModel('page','" + (maxPage) + "')\"><a>末页</a></li>");
                                    		}
                                    	%>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <jsp:include page="footer.jsp" flush="true"></jsp:include>
    <script>
    	var style = '<%=style%>';
    	var candown = '<%=candown%>';
    	var sort = '<%=sort%>';
    	var pageNumber = '<%=pageNumber%>';
		function searchModel(type, stl){
			if(type == 'candown'){
				candown = candown=='yes'? 'all' : 'yes';
			}
			if(type == 'size'){
				sort = sort=='size-up'? 'size-down' : 'size-up';
			}
			if(type == 'time'){
				sort = sort=='time-up'? 'time-down' : 'time-up';
			}
			if(type == 'style'){
				style = stl;
			}
			if(type == 'page'){
				pageNumber = stl;
			}
			var parameter = '';
			if(style != 'null'){
				parameter += (parameter=='' ? '' : '&') + 'style=' + style;
			}
			if(candown != 'null'){
				parameter += (parameter=='' ? '' : '&') + 'candown=' + candown;
			}
			if(sort != 'null'){
				parameter += (parameter=='' ? '' : '&') + 'sort=' + sort;
			}
			if(pageNumber != 'null'){
				parameter += (parameter=='' ? '' : '&') + 'page=' + pageNumber;
			}
			location = 'modellist.jsp?' + parameter;
		}
    </script>
</body>
</html>