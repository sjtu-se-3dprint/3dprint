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
             <ul class="breadcrumb">
                <li>
                    <a href="index.jsp">首页</a>
                    <span class="divider">/</span>
                </li>
                <li>
                    <a href="NR_learning.jsp">入门指南</a>
                    <span class="divider">/</span>
                </li>
                <li class="active">
                    学习入门
                </li>
            </ul>
        <div class="row-fluid">
            <div class="span12">
                <div class="carousel slide" id="carousel-794082">
                    <div class="carousel-inner">
                        <div class="item">
                            <img alt="" src="./img/bigpic/b1.jpg" />
                            <div class="carousel-caption">
                            </div>
                        </div>
                        <div class="item">
                            <img alt="" src="./img/bigpic/b2.jpg" />
                            <div class="carousel-caption">
                            </div>
                        </div>
                        <div class="item active">
                            <img alt="" src="./img/bigpic/b3.jpg" />
                            <div class="carousel-caption">
                            </div>
                        </div>
                    </div> <a data-slide="prev" href="#carousel-794082" class="left carousel-control">‹</a> <a data-slide="next" href="#carousel-794082" class="right carousel-control">›</a>
            </div>
        </div>
        <div class="row-fluid">
            <div class="span2">
                <ul style="margin-left:50px;margin-top: 50px;font-size:20px">
                    <li class="list-group-item"><a href="NR_princeple.jsp">3D打印原理</a></li>
                    <br>
                    <li class="list-group-item"><a href="NR_model.jsp">3D建模小贴士</a></li>
                    <br>
                    <li class="list-group-item"><a href="NR_example.jsp">3D打印案例</a></li>               
                    <img src='./img/knowledge/introduction/4.png' style='margin-top:100px;'>
                </ul>
                <ul style="text-align:center;">
                <img src='./img/knowledge/model/cube1.png' style='margin-top:260px;'>
                cube1
                <img src='./img/knowledge/model/cube2.png' style='margin-top:50px;'>
                cube2
                </ul>
            </div>
            <div class="span6" style="font-size:20px;font-family:'MFLangQian','Microsoft YaHei';background-color:#d9e8ed">
                <h2 style='margin-left:20px;margin-right:20px'>
                    3D建模小贴士
                </h2>
                <br>
                <br>
                <h4>如何模型可以站立</h4>
                <br>
                <br>
                <p style='margin-left:20px;margin-right:20px;line-height:30px'>
                    我们提供一些简单的经验方法，让您的设计更加稳定。
	如果想打印出来的模型能够很好站立，在3D软件上设计模型时，你需要对模型中质心的位置进行考虑。首先，大致的圈出模型与地面接触的面积，从模型的上侧向下俯瞰，比较接触面与模型的最大横断面积。如果，接触面积较小，则很有可能您设计的模型是不稳定的。
另一个注意的因素是高度，越高的模型越不容易稳定。综合来说，一个比较好的设计原则是模型与地面的接触面积与模型的横断面积大小一致。
                </p>
                <p style='margin-left:20px;margin-right:20px;line-height:30px'>
                    举例说明；
我们设计了一个大头肥猫，他两只脚着地。红色的部分是模型站立时与地面接触的部分。我们再从上往下看，可以发现接触面比物体的最大横断面要小得多。这样打印出来的物件站立时是不稳定的。
                </p>
                <p style='margin-left:20px;margin-right:20px;line-height:30px'>如图1</p>
                <p style='margin-left:20px;margin-right:20px;line-height:30px'>
          一个简单的方法让模型更稳定就是把它的尾巴设计成一个支撑物。从上往下看，我们可以发现与地面的接触面积就变大了，也更稳定了。
                </p>
                <p style='margin-left:20px;margin-right:20px;line-height:30px'>如图2</p>
                <br><br>
                <h4>为你的模型添加一个底座</h4>
                <br>
                <p style='margin-left:20px;margin-right:20px;line-height:30px'>
                    为了让打印出来的模型更加稳定，你可以在模型底部添加一个底座。这样可以降低质心的位置，大大的增加稳定性，减少你在设计的约束。这样做的缺点是，打印的费用会更高一些。
                </p>
                <p style='margin-left:20px;margin-right:20px;line-height:30px'>如图3</p>
                <br><br>
                <h4>如何节省成本</h4>
                <p style='margin-left:20px;margin-right:20px;line-height:30px'>
                    考虑到您的预算，在模型设计时，您可以通过使用空心结构代替不必要的实心结构，为您降低打印所需的费用。通常的做法是去除一个物体的内部。这样做的时候需要注意避免产生尖的转角，你可以对它进行光滑过渡处理。
                </p>
                <p style='margin-left:20px;margin-right:20px;line-height:30px'>
                   以一个立方体为例说明

我们没有必要打印出一个实心的立方体。
                </p>
                <p style='margin-left:20px;margin-right:20px;line-height:30px'>如图cube1</p>
                <p style='margin-left:20px;margin-right:20px;line-height:30px'>
                   在3D设计软件中，向内缩放，并去除内部立方体的外表面，这样便得到了一个空心模型。
                </p>
                <p style='margin-left:20px;margin-right:20px;line-height:30px'>如图cube2</p>
                <p style='margin-left:20px;margin-right:20px;line-height:30px'>
                    考虑到实际打印过程中，需要对打印出来的模型进行一定的清理工作，我们还需要留下一个小孔方便清理残余的材料。
最后设计
                </p>
                <p style='margin-left:20px;margin-right:20px;line-height:30px'>如图cube3</p>
            </div>
            <div class="span3" style="text-align:center;font-family:'Microsoft YaHei';font-size:14px">
                <img src='./img/knowledge/model/1.JPG' >
                图1
                <br>
                <br>
                <img src='./img/knowledge/model/2.JPG' style='margin-top:40px;'>
                图2
                <img src='./img/knowledge/model/3.JPG' style='margin-top:60px;'>
                图3
                <img src='./img/knowledge/model/cube3.png' style='margin-top:60px;'>
                cube3
            </div>
        </div>
        <!-- <div class="row-fluid">
            <div class="span12">
                <h3>
                    <em>相关链接</em>
                </h3>
            </div>
        </div> -->
    </div>
	<jsp:include page="footer.jsp" flush="true"></jsp:include>
</body>
</html>