<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>3D打印创作服务平台-入门指南</title>
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
                        <a href="NR_learning.jsp">入门指南</a> <span class="divider">/</span>
                    </li>
                   <li class='active'>
                   学习流程
                   </li>
                </ul>
          
                <div class="carousel slide" id="carousel-745221">
                    <div class="carousel-inner">
                        <div class="item active">
                            <img alt="" src="./img/bigpic/2.jpg" />
                            <div class="carousel-caption">
                                <h4>
                                    3D打印最后的成品
                                </h4>
                            </div>
                        </div>
                        <div class="item">
                            <img alt="" src="./img/bigpic/3.jpg" />
                            <div class="carousel-caption">
                                <h4>
                                    学会如何3D打印
                                </h4>
                            </div>
                        </div>
                        <div class="item">
                            <img alt="" src="./img/bigpic/4.jpg" />
                            <div class="carousel-caption">
                                <h4>
                                    设计自己的3D打印模型
                                </h4>
                            </div>
                        </div>
                    </div> <a data-slide="prev" href="#carousel-745221" class="left carousel-control">‹</a> <a data-slide="next" href="#carousel-745221" class="right carousel-control">›</a>
                </div>
            </div>
        </div>
        <div class="row-fluid">
            <div class="span12">
                <ul class="thumbnails">
                    <li class="span4">
                        <div class="thumbnail">
                            <img alt="300x200" src="./img/mu_1.gif" />
                            <div class="caption">
                               <a href="NR_3Dprint.jsp"><h3>
                                    了解3D打印
                                </h3>
                                </a>
                                <p>
                                    3D打印技术的起点是三维数字模型。三维数字模型可以使用各种3D软件程序来创建。在工业领域，你可以使用CAD，对生产商和消费者有简单可用，更容易获得的程序或3D扫描仪直接获得三维数字模型。
	三维数字模型被“切片”成层，从而将设计转换成一个三维打印机可读的文件。文件的格式有.stl、.obj等。将可读文件导入机器中，由3D打印机根据分层模型将材料进行处理。不同类型的三维打印技术，它们使用的是不同的材料，以不同的方式来创建最终的对象。官能塑料、金属、陶瓷和沙子是常用于工业原型制造和生产应用中的材料。可3D打印的生物、食物材料研究也在进行中。一般来说，虽然，广泛进入市场使用的材料种类是有限。目前，塑料是唯一被广泛使用的材料。通常是ABS、PLA。但现在也有别克选择打入市场使用的材料，包括尼龙，以及应用于食品领域的糖和巧克力原料。
                                </p>
                            </div>
                        </div>
                    </li>
                    <li class="span4">
                        <div class="thumbnail">
                            <img alt="300x200" src="./img/mu_2.jpg" />
                            <div class="caption">
                                <h3>
                                    如何学习3D打印
                                </h3>
                                <p>
                                    <a href="NR_princeple.jsp">3D打印原理</a>
                                    <a href="NR_model.jsp">3D建模小贴士</a>
                                    <a href="NR_example.jsp">3D打印案例</a>
                                </p>
                                <span>三维设计是新一代数字化、虚拟化、智能化设计平台的基础。它是建立在平面和二维设计的基础上，让设计目标更立体化，更形象化的一种新兴设计方法。传统的方法，我们是在一个平面的二维空间内考虑布局，也就是上下左右四个方向。如果我们把每个模块抽象成为一个平面，从三维的角度来看，有了前后的关系，一个页面就可以看做N个层的重叠，通过层之间的互相透视，二维上形成一个页面。这种抽象只是在设计页面布局的角度，和最终呈现给用户的二维视觉没有影响。二维布局越复杂，制作难度越大，在三维空间内，再复杂的布局也就是更多个层的叠加，同时根据浏览器解析代码自上而下的特性，可以随意调整各模块的显示顺序，很多存在于二维布局方法的难题迎刃而解。</span>
                            </div>
                        </div>
                    </li>
                    <li class="span4">
                        <div class="thumbnail">
                            <img alt="300x200" src="./img/mu_3.jpg" />
                            <div class="caption">
                                <h3>
                                    <a href='help.jsp'>我们如何帮你实现</a>
                                    <p>如果您还不大了解我们的网站功能，那就点击这里，我们真诚的为您服务</p>
                                </h3>
                            </div>
                        </div>
                    </li>
                </ul>
            </div>
        </div>
        <div class="row-fluid">
            <div class="span12">
                <h3>
                    相关链接
                </h3>
                <div class="media">
                    <a href="http://www.letv.com/ptv/vplay/20910846.html" class="pull-left" target="_blank"><img src="./img/mv_1.png" class="media-object" alt='' /></a>
                    <div class="media-body">
                        <h4 class="media-heading">
                            3D打印炫酷小车
                        </h4>
                    </div>
                </div>
            </div>
        </div>
    </div>
	<jsp:include page="footer.jsp" flush="true"></jsp:include>
</body>
</html>