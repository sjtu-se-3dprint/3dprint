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
                <h3>
                    <em><span>学习入门</span></em>
                </h3>
                <div class="carousel slide" id="carousel-794082">
                    <div class="carousel-inner">
                        <div class="item">
                            <img alt="" src="./img/ms_1.jpg" />
                            <div class="carousel-caption">
                                <h4>
                                    三维设计
                                </h4>
                            </div>
                        </div>
                        <div class="item">
                            <img alt="" src="./img/ms_2.jpg" />
                            <div class="carousel-caption">
                                <h4>
                                    3D建模
                                </h4>
                            </div>
                        </div>
                        <div class="item">
                            <img alt="" src="./img/ms_3.png" />
                            <div class="carousel-caption">
                                <h4>
                                    切片处理
                                </h4>
                            </div>
                        </div>
                        <div class="item active">
                            <img alt="" src="./img/ms_4.png" />
                            <div class="carousel-caption">
                                <h4>
                                    完成打印
                                </h4>
                            </div>
                        </div>
                    </div> <a data-slide="prev" href="#carousel-794082" class="left carousel-control">‹</a> <a data-slide="next" href="#carousel-794082" class="right carousel-control">›</a>
                </div>1.三维设计<hr />2.3D建模<hr />3.切片处理<hr />4.完成打印<hr />
            </div>
        </div>
        <div class="row-fluid">
            <div class="span12">
                <h3 class="text-center">
                    <em>1.三维设计</em>
                </h3>
                <div class="lead">
                    三维打印的设计过程是：先通过计算机建模软件建模，再将建成
                    的三维模型“分区”成逐层的截面，即切片，从而指导打印机逐层打印。设计软
                    件和打印机之间协作的标准文件格式是STL文件格式。一个STL文件使用三角面来
                    近似模拟物体的表面。三角面越小其生成的表面分辨率越高。PLY是一种通过扫描
                    产生的三维文件的扫描器，其生成的VRML或者WRL文件经常被用作全彩打印的输入文件。
                </div>
            </div>
        </div>
        <div class="row-fluid">
            <div class="span12">
                <h3 class="text-center">
                    <em>2.3D建模</em>
                </h3>
                <div class="lead">
                    3D建模通俗来讲就是通过三维制作软件通过虚拟三维空间构建出具有三维数据的
                    模型。3D建模大概可分为:NURBS和多边形网格。 NURBS对要求精细、弹性与复杂的
                    模型有较好的应用，适合量化生产用途 。多边形网格建模是靠拉面方式，适合做
                    效果图与复杂场景动画.综合说来各有长处。
                </div>
            </div>
        </div>
        <div class="row-fluid">
            <div class="span12">
                <h3 class="text-center">
                    <em>3.切片处理</em>
                </h3>
                <div class="lead">
                    打印机通过读取文件中的横截面信息，用液体状、粉状或片状的材料将这些截面逐层地打印
                    出来，再将各层截面以各种方式粘合起来从而制造出一个实体。这种技术的特点在于其几乎
                    可以造出任何形状的物品。打印机打出的截面的厚度（即Z方向）以及平面方向即X-Y方向的
                    分辨率是以dpi（像素每英寸）或者微米来计算的。一般的厚度为100微米，即0.1毫米，也有
                    部分打印机如ObjetConnex 系列还有三维 Systems' ProJet 系列可以打印出16微米薄的一
                    层。而平面方向则可以打印出跟激光打印机相近的分辨率。打印出来的“墨水滴”的直径通
                    常为50到100个微米。 用传统方法制造出一个模型通常需要数小时到数天，根据模型的尺寸
                    以及复杂程度而定。而用三维打印的技术则可以将时间缩短为数个小时，当然其是由打印机
                    的性能以及模型的尺寸和复杂程度而定的。传统的制造技术如注塑法可以以较低的成本大量
                    制造聚合物产品，而三维打印技术则可以以更快，更有弹性以及更低成本的办法生产数量相
                    对较少的产品。一个桌面尺寸的三维打印机就可以满足设计者或概念开发小组制造模型的需要。
                </div>
            </div>
        </div>
        <div class="row-fluid">
            <div class="span12">
                <h3 class="text-center">
                    <em>4.完成打印</em>
                </h3>
                <div class="lead">
                    三维打印机的分辨率对大多数应用来说已经足够（在弯曲的表面可能会比较粗糙，像图像
                    上的锯齿一样），要获得更高分辨率的物品可以通过如下方法：先用当前的三维打印机打
                    出稍大一点的物体，再稍微经过表面打磨即可得到表面光滑的“高分辨率”物品。
                    有些技术可以同时使用多种材料进行打印。有些技术在打印的过程中还会用到支撑物，比
                    如在打印出一些有倒挂状的物体时就需要用到一些易于除去的东西（如可溶的东西）作为支撑物。
                </div>
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