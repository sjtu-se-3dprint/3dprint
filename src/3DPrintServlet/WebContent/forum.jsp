<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="service.GetLoginUserService" %>
<%@ page import="entity.*" %>
<%@ page import="database.*" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>论坛首页</title>
</head>
<body>
	<jsp:include page="header.jsp" flush="true"></jsp:include>
<div class="container-fluid">
    <div class="row-fluid">
    <div class="span12">
                  <ul class="breadcrumb">
                    <li>
                        <a href="index.jsp">首页</a> <span class="divider">/</span>
                    </li>
                    <li>
                        <a href="NR_learning.jsp">学习交流</a> <span class="divider">/</span>
                    </li>
                   <li class='active'>
                   论坛首页
                   </li>
                </ul>
    </div>
        <div class="span3">
            <div class="row-fluid">
                <div class="span12">
         
                    <h3>
                        热帖排行
                    </h3>
                </div>
            </div>
            <div class="row-fluid">
                <table class="table">
                    <tbody>
                    <%
                    	List<Post> posts = PostService.getPostService().searchPostByStatusSortByResponse("normal");
                    	int sz = Math.min(10, posts.size());
                    	for(int i=0; i<sz; i++){
                    		Post post = posts.get(i);
                    		out.println("<tr><td><a href=\"forum_content.jsp?id=" + post.getId()
                    				+ "&first=" + post.getFirstCategory() + "&second=" + post.getSecondCategory()+ "\">" + post.getTitle() + "</a>(" + post.getResponse() + ")</td></tr>");
                    	}
                    %>
                    </tbody>
                </table>
            </div>
            <!--<div class="row-fluid">
                <ul style="margin-left: 50px;margin-top: 100px">
                    <li class="list-group-item"><a href="javascript:void(0)">3D打印设计</a></li>
                    <li class="list-group-item"><a href="javascript:void(0)">3D打印模型展示</a></li>
                    <li class="list-group-item"><a href="javascript:void(0)">3D打印最新资讯</a></li>
                </ul>
            </div>-->
        </div>
        <div class="span8">
            <div class="row-fluid">
                <div class="span12">
                    <h3>
                        论坛模块
                    </h3>
                </div>
            </div>
            <div class="panel-heading"><h4>3D打印机</h4>
            </div>
            <table class="table" contenteditable="false">
                <tbody>
                <tr class="success">
                    <td width="60px"><img src="./img/tmp1.jpg" /></td>
                    <td><a href="forum_list_3Dprinter.jsp?first=3D打印机&second=EasyPrint使用的打印机" style="margin-left: 50px">EasyPrint使用的打印机</a><br>
                        <span style="margin-left: 80px">本网站使用3种3D打印机</span></td>
                </tr>
                <tr class="success">
                    <td width="60px"><img src="./img/tmp2.jpg" /></td>
                    <td><a href="forum_list_3Dprinter.jsp?first=3D打印机&second=我的打印机" style="margin-left: 50px">我的打印机</a><br>
                        <span style="margin-left: 80px">展示一下各位3D打印发烧友的个人打印机，分享你的经验</span></td>
                </tr>
                <tr class="success">
                    <td width="60px"><img src="./img/tmp3.jpg" /></td>
                    <td><a href="forum_list_3Dprinter.jsp?first=3D打印机&second=打印机软件和硬件" style="margin-left: 50px">打印机软件和硬件</a><br>
                        <span style="margin-left: 80px">帮助更多的人学习3D打印技术，分享你的学习新的和收藏吧5</span></td>
                </tr>
                </tbody>
            </table><br><br>

            <div class="panel-heading"><h4>3D模型设计</h4>
            </div>
            <table class="table" contenteditable="false">
                <tbody>
                <tr class="error">
                    <td width="60px"><img src="./img/tmp4.jpg" /></td>
                    <td><a href="forum_list_3Dprinter.jsp?first=3D模型设计&second=模型制作" style="margin-left: 50px">模型制作</a><br>
                        <span style="margin-left: 80px">3D建模技术是由想法idea在软件上实现建模</span></td>
                </tr>
                <tr class="error">
                    <td width="60px"><img src="./img/tmp5.jpg" /></td>
                    <td><a href="forum_list_3Dprinter.jsp?first=3D模型设计&second=模型分享" style="margin-left: 50px">模型分享</a><br>
                        <span style="margin-left: 80px">各种饰品，零件，工艺品，其他模型，应有尽有。</span></td>
                </tr>
                <tr class="error">
                    <td width="60px"><img src="./img/tmp6.jpg" /></td>
                    <td><a href="forum_list_3Dprinter.jsp?first=3D模型设计&second=软件推荐" style="margin-left: 50px">软件推荐</a><br>
                        <span style="margin-left: 80px">3dsmax，maya，c4d等软件</span></td>
                </tr>
                </tbody>
            </table><br><br>

            <div class="panel-heading"><h4>3D产品服务</h4>
            </div>
            <table class="table" contenteditable="false">
                <tbody>
                <tr class="warning">
                    <td width="60px"><img src="./img/tmp7.jpg" /></td>
                    <td><a href="forum_list_3Dprinter.jsp?first=3D产品服务&second=打印服务" style="margin-left: 50px">打印服务</a><br>
                        <span style="margin-left: 80px">各种打印服务的求助与解答之处</span></td>
                </tr>
                <tr class="warning">
                    <td width="60px"><img src="./img/tmp8.jpg" /></td>
                    <td><a href="forum_list_3Dprinter.jsp?first=3D产品服务&second=3D打印体验" style="margin-left: 50px">3D打印体验</a><br>
                        <span style="margin-left: 80px">线下体验</span></td>
                </tr>
                </tbody>
            </table><br><br>

            <div class="panel-heading"><h4>综合讨论区</h4>
            </div>
            <table class="table" contenteditable="false">
                <tbody>
                <tr class="info">
                    <td width="60px"><img src="./img/tmp9.jpg" /></td>
                    <td><a href="forum_list_3Dprinter.jsp?first=综合讨论区&second=问答" style="margin-left: 50px">问答</a><br>
                        <span style="margin-left: 80px">对于各种3D打印有关的技术难题，提供交流解答</span></td>
                </tr>
                <tr class="info">
                    <td width="60px"><img src="./img/tmp10.jpg" /></td>
                    <td><a href="forum_list_3Dprinter.jsp?first=综合讨论区&second=寻找素材" style="margin-left: 50px">寻找素材</a><br>
                        <span style="margin-left: 80px">找一找你的idea吧！</span></td>
                </tr>
                <tr class="info">
                    <td width="60px"><img src="./img/tmp11.jpg" /></td>
                    <td><a href="forum_list_3Dprinter.jsp?first=综合讨论区&second=灌水区" style="margin-left: 50px">灌水区</a><br>
                        <span style="margin-left: 80px">闲聊，讨论</span></td>
                </tr>
                </tbody>
            </table><br><br>
        </div>
        <div class="span2">
        </div>
    </div>
</div>
	<jsp:include page="footer.jsp" flush="true"></jsp:include>
</body>
</html>