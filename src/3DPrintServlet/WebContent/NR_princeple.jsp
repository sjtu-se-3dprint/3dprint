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
            </div>
            <div class="span6" style="font-size:20px;font-family:'MFLangQian','Microsoft YaHei';background-color:#d9e8ed">
                <h2 style='margin-left:20px;margin-right:20px'>
                    3D打印机原理揭秘，了解最为神奇的3D打印机原理
                </h2>
                <br>
                <br>
                <p style='margin-left:20px;margin-right:20px;line-height:30px'>
                    3D打印原理在于它是以一种数字模型文件为基础，运用粉末状金属或塑料等可粘合材料，通过逐层打印的方式来构造物体的技术。
                </p>
                <p style='margin-left:20px;margin-right:20px;line-height:30px'>
                    近些年来有一个新的词逐渐进入人们的视野，那就是“3D打印机”，其实这个词也挺好理解的，就是打印三维立体物件的机器，听起来像是只存在于科幻片里的东西，但是它其实已经存在很久了，3D打印机原理是什么呢？它能打印出这么多东西，汽车、步枪甚至有设计师准备有那个3D打印机造房子，看起来真是很不思议，今天就让我们一起来探究下3D打印机原理。
                </p>
                <p style='margin-left:20px;margin-right:20px;line-height:30px'>
          3D打印机原理是这样的，它其实是以一种数字模型文件为基础，运用粉末状金属或塑料等可粘合材料，通过逐层打印的方式来构造物体的技术。由于在3D打印机原理中把复杂的三维制造转化为一系列二维制造的叠加，因而可以在不用模具和工具的条件下生成几乎任意复杂的零部件，极大地提高了生产效率和制造柔性。3D打印机原理看着很简单，现在虽然有一些产品能直接打印出来，但要打印出精密产品还有很长的路要走。
                </p>
                <p style='margin-left:20px;margin-right:20px;line-height:30px'>
                3D打印并非是新鲜的技术，早在20世纪80年代就存在3D打印这项技术了，但是当时的机器非常巨型而且昂贵，经过20多年的发展，技术逐渐成熟，机器也渐渐小型化，二十一世纪年以来3D打印机的销售逐渐扩大，价格也开始下降。
                </p>
                <br><br>
                <h4>3D打印技术的基本原理</h4>
                <br>
                <p style='margin-left:20px;margin-right:20px;line-height:30px'>
                    首先得通过计算机辅助设计（CAD）或计算机动画建模软件建模，再将建成的三维模型“切片”成逐层的截面数据，并把这些信息传送到3D打印机上，3D打印机会把这些切片堆叠起来，直到一个固态物体成型。
                </p>
                <p style='margin-left:20px;margin-right:20px;line-height:30px'>
                    至于怎么堆叠这些“切片”，方式有很多种，小型3D打印机最为常用的就是用液态材料沉积成型，这个有点类似喷墨打印机，只不过喷头喷出的不是墨水而是热塑性塑料或共晶系统金属等可迅速固化的材料，工作方式如下面视频所示：
                </p>
                <p style='margin-left:20px;margin-right:20px;line-height:30px'>
                    根据所用材料的不同3D打印的工艺可以细分为许多种，每种技术都有各自的优缺点，目前3D打印技术的精度其实已经不错了，一般来说每层厚度可以达到0.1mm，当然也有部分打印机如Objet Connex 系列还有三维 Systems' ProJet 系列可以打印出16微米薄的一层，不过在弯曲的表面可能会比较粗糙，要获得光滑的物体可以打出一个稍微大一点的物体，然后再拿去打磨就可以了。
                </p>
                <br><br>
                <h4>3D打印机的应用</h4>
                <br>
                <p style='margin-left:20px;margin-right:20px;line-height:30px'>
                    利用3D打印机，工程师可以验证开发中的新产品，把手中的CAD数字模型用3D打印机造成实体模型，可以方便的对设计进行验证及时发现问题，相比传统的方法可以节约大量的时间和成本。
                </p>
                <p style='margin-left:20px;margin-right:20px;line-height:30px'>
                3D打印机也可以用于小批量产品的生产，这样就可以快速的把产品的样品提供给客户，或进行市场宣传，不用等模具造好后才造出成品，对于某些小批量定制的产品甚至连模具的成本都可以省去，比如电影中用到的各种定制道具。
                </p>
                <p style='margin-left:20px;margin-right:20px;line-height:30px'>
                在好莱坞大片《十二生肖》中，成龙佩戴了专业扫描手套来扫描剧中十二生肖铜像，另外一边通过专业设备将所扫描的铜像完美打印，这个看似科幻的东西，这个现实中利用3D扫描和3D打印技术其实是能实现的。
                </p>
                <p style='margin-left:20px;margin-right:20px;line-height:30px'>
                至于家用和个人市场方面，应用就应人而异了，不过要推广开的话可是困难重重，首先目前个人用3D打印机并不能说便宜，价格从几千到几万都有。3D打印的原材料也不便宜这些材料的价格便宜的几百元一公斤，最贵的要四万元左右。还有就是你想打印一个物体的时候你得首先得学会3D建模……
                </p>
            </div>
            <div class="span3" style="text-align:center;font-family:'Microsoft YaHei';font-size:14px">
                <img src='./img/knowledge/princeple/1.jpg' >
                    3D打印机
                <br>
                <br>
                <img src='./img/knowledge/princeple/2.jpg' style='margin-top:10px;'>
                    把三维模型“切片”
                <img src='./img/knowledge/princeple/3.jpg' style='margin-top:30px;'>
                    左边的是原型右边的是3D打印出来的复制品，还原度还真高呢
                <img src='./img/knowledge/princeple/4.jpg' style='margin-top:30px;'>
                    电影《机械公敌》中的奥迪RSQ汽车就是使用3D打印制作的
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