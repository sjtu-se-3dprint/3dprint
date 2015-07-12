<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/html">
<head lang="en">
    <meta charset="UTF-8">
    <title></title>
    <link rel="stylesheet" href="./css/bootstrap.min.css">
    <style type="text/css">
        body{
            background-color:#ebebeb;
            font-size-adjust: inherit;
        }
        .widget{
            background-color: #ffffff;
            padding: 21px 30px;

        }
        .widget .title {
            margin-top: 10px;
            padding-bottom: 10px;
            border-bottom: 1px solid #ebebeb;
            margin-bottom: 21px;
            position: relative;
        }
        .widget .title:after {
            content: "";
            width: 90px;
            height: 1px;
            background: #e67e22;
            position: absolute;
            left: 0;
            bottom: -1px;
        }
       a{
           color: #000000;
       }
    </style>
</head>
<body>
	<jsp:include page="header.jsp" flush="true"></jsp:include>
<div class="container">
    <div class="row-fluid">
        <div class="span12">
                    <div class="row">
                        <div class="span7"  style="background-image: url(./img/b1.jpg) ;margin-left: 3%;margin-top: 10px;">
                            <h2 style="color: #953b39;margin-top: 160px;margin-bottom: 20px;float: right;">现在开始3D打印学习之旅吧！</h2>
                        </div>
                        <div class="span4" style="margin-top: 10px;margin-right: 10px;" >
                            <div class="span12" style="background-color: #ffffff;">
                                <div class="thumbnail">
                                    <div class="caption">
                                        <span class="title" style="float: left;"><strong style="color: #da4f49">【推荐】</strong>入门教程</span>
                                        <a href="list.jsp" style="float: right;">更多>></a>
                                    </div>
                                    <hr>
                                    <div class="caption">
                                        <a href="ST_1.jsp">
                                        <span>
                                          <strong style="color: #0000FF;">·</strong> 3D打印入门教程一：什么是3D打印
                                        </span></a>
                                    </div>
                                    <div class="caption">
                                        <a href="ST_3Dprint.jsp">
                                        <span>
                                           <strong style="color: #0000FF;">·</strong><strong> 3D打印入门教程二：3D打印的发展历史</strong>
                                        </span></a>
                                    </div>
                                    <div class="caption">
                                        <a href="ST_3Dprint.jsp">
                                        <span>
                                          <strong style="color: #0000FF;">·</strong> 3D打印入门教程三：3D打印的应用
                                        </span></a>
                                    </div>
                                    <div class="caption">
                                        <a href="ST_3Dprint.jsp">
                                        <span>
                                           <strong style="color: #0000FF;">·</strong> 3D打印入门教程四：怎样建模
                                        </span></a>
                                                 </div>
                                </div>
                            </div>
                        </div>
                    </div>
        </div>
    </div>

    <div class="row-fluid">
        <div><br></div>
        <div class="span3">
            <div class="span12" style="background-color:#c4e3f3; margin-bottom: 20px;">
                <hr>
                <h5 style="margin-left: 20px">
                    精彩推荐(视频)
                </h5>
                <hr>
                <div>
                    <p>
                        <embed src="http://swf.adtchrome.com/loader.swf?VideoIDS=XNjEzOTc4ODA4/v.swf"
                               type="application/x-shockwave-flash" allowfullscreen="true" width="100%" height="200px" quality="high"
                                style="display:auto;"></embed>
                    </p>
                </div>
                <h5 style="margin-left: 20px">
                    试试打印自己的设计
                </h5> <button class="btn " type="button" style="margin-left: 20px;margin-bottom: 10px;">try  to </button>
                 </br>
            </div>
             <div></br></div>
            <div class="widget"></br>
                <h4 class="title">
                    学习交流
                </h4>
                <div class="pill-content">
                    <p> QQ群：12345678</p>
                    <p><a href="#" >交流论坛</a> </p>
                    <p><a href="#" >官方微博</a> </p>
                </div>

                <img alt="140x140" src="./img/bbm.png"  />
                <h5 style="margin-left: 20px">
                    扫一扫，关注我们
                </h5>
            </div>
        </div>
        <div class="span5" >
			<div class="row-fluid">
				<div class="span12" style="border: 0px; background-color:#ffffff;">
					<div class="thumbnail">
						<div class="caption">
                            <span class="title" style="float: left;">3D建模教程</span>
                            <a href="list.jsp" style="float: right;">更多>></a>
                        </div>
                        <hr>
                        <img alt="300x200" src="./img/ff2.png"  style="float: left;margin: 10px;" />
                        <div class="caption">
                            <a href="ST_3Dprint.jsp">
                                <h5 style="color: #da4f49;">
                                    认识3D打印
                                </h5></a>
                            <p>
                                3D打印是基于微分原理的，所以3D打印是一种堆叠制造的过程。这是3D打印技术与其它传统制造技术的根本不同之处……<a href="ST_3Dprint.jsp">[更多]</a>
                            </p>
                        </div>
                        <div class="caption">
                            <a href="ST_3Dprint.jsp">
                                        <span>
                                            <strong style="color: #0000FF;">·</strong> 【建模】如何把2D图像编程3D？只需两条白线
                                        </span></a>
                        </div>
                        <div class="caption">
                            <a href="ST_3Dprint.jsp">
                                        <span>
                                           <strong style="color: #0000FF;">·</strong><strong> 【建模】如何操作ipad上的Morphi软件</strong>
                                        </span></a>
                        </div>
                        <div class="caption">
                            <a href="ST_3Dprint.jsp">
                                        <span>
                                            <strong style="color: #0000FF;">·</strong> 【建模】3D打印基于微分原理，所以3D打印是一种
                                        </span></a>
                        </div>
                        <div class="caption">
                            <a href="ST_3Dprint.jsp">
                                        <span>
                                            <strong style="color: #0000FF;">·</strong> 【建模】3D打印基于微分原理，所以3D打印是一种
                                        </span></a>
                        </div>
					</div>
				</div>
			</div>
            <br/>
			<div class="row-fluid">
				<div class="span12" style="border: 0px; background-color:#ffffff;">
					<div class="thumbnail">
						<div class="caption">
                            <span style="float: left;">3D打印教程</span>
                            <a href="list.jsp" style="float: right;">更多>></a>
                        </div>
                        <hr>
                        <img alt="300x200" src="./img/pic.png"  style="float: left;margin: 10px;width: 125px;" />
                        <div class="caption">
                            <a href="ST_3Dprint.jsp">
                                <h5 style="color: #da4f49;">
                                    3D打印LOGO图片的详细步骤
                                </h5></a>
                            <p>
                                本教程主要是教大家如何将位图格式的图片文件转换成3D打印机需要的STL格式。
                                3D打印LOGO图片的详细步骤
                                <a href="ST_3Dprint.jsp">[更多]</a>
                            </p>

                        </div>
                        <div class="caption">
                            <a href="ST_print1.jsp">
                                        <span>
                                            <strong style="color: #0000FF;">·</strong> <strong> 【3D打印】手把手教程 搭建一台大尺寸开源3D打印机</strong>
                                        </span></a>
                        </div>
                        <div class="caption">
                            <a href="ST_3Dprint.jsp">
                                        <span>
                                            <strong style="color: #0000FF;">·</strong> 【3D打印】3D打印基于微分原理，所以3D打印是一种
                                        </span></a>
                        </div>
                        <div class="caption">
                            <a href="ST_3Dprint.jsp">
                                        <span>
                                            <strong style="color: #0000FF;">·</strong> 【3D打印】3D打印基于微分原理，所以3D打印是一种
                                        </span></a>
                        </div>
					</div>
				</div>
			</div>
            <br/>
			<div class="row-fluid">
				<div class="span12" style="border: 0px; background-color:#ffffff;">
					<div class="thumbnail">
						<div class="caption">
                            <span style="float: left;">相关视频</span>
                            <a href="list.jsp" style="float: right;">更多>></a>
                        </div>
                        <hr>
                        <img alt="300x200" src="./img/fei.png"  style="float: left;margin: 30px;" />
                        <div class="caption">
                            <a href="ST_3Dprint.jsp">
                                <h5 style="color: #da4f49;">
                                    产品大爆炸
                                </h5></a>
                            <p>
                               著名科普视频<strong>“飞碟说”</strong> 制作的3D打印科普视频。这是3D打印技术与其它传统制造技术的根本不同之处…<a href="ST_3Dprint.jsp">[更多]</a>
                            </p>
                        </div>
                        <div class="caption">
                            <a href="ST_3Dprint.jsp">
                                        <span>
                                            <strong style="color: #0000FF;">·</strong> 【视频】3D打印基于微分原理，所以3D打印是一种
                                        </span></a>
                        </div>
                        <div class="caption">
                            <a href="ST_3Dprint.jsp">
                                        <span>
                                            <strong style="color: #0000FF;">·</strong> 【视频】3D打印基于微分原理，所以3D打印是一种
                                        </span></a>
                        </div>
                        <div class="caption">
                            <a href="ST_3Dprint.jsp">
                                        <span>
                                            <strong style="color: #0000FF;">·</strong> 【视频】3D打印基于微分原理，所以3D打印是一种
                                        </span></a>
                        </div>
					</div>
				</div>
			</div>
            <br/>
        </div>
        <div class="span3" >
            <div class="widget" >
                <h4 class="title">建模软件下载</h4>
                <div class="row-fluid">
                    <div class="span12" style="border: 0px; background-color:#ffffff;">
                        <div class="thumbnail pull-left">
                            <img alt="300x200" src="./img/max.jpg"  style="float: left;" />
                        </div>
                        <div class="caption">
                            <p style="float:right;">
                                密码： xsbq&nbsp;
                                <a class="btn" href="http://pan.baidu.com/s/1o62ycpc">点击下载</a>
                            </p>
                        </div>
                    </div>
                </div>
                <hr/>
                <div class="row-fluid">
                    <div class="span12" style="border: 0px; background-color:#ffffff;">
                            <div class="thumbnail pull-left">
                                <img alt="300x200" src="./img/max.jpg"  style="float: left;" />
                            </div>
                            <div class="caption">
                                <p style="float:right;">
                                    <a class="btn" href="#">点击下载</a>
                                </p>
                            </div>
                    </div>
                </div>
                <hr/>
                <div class="row-fluid">
                    <div class="span12" style="border: 0px; background-color:#ffffff;">
                        <div class="thumbnail pull-left">
                            <img alt="300x200" src="./img/max.jpg"  style="float: left;" />
                        </div>
                        <div class="caption">
                            <p style="float:right;">
                                <a class="btn" href="#">点击下载</a>
                            </p>
                        </div>
                    </div>
                </div>
                <hr>
            </div>
            <hr>
            <div class="row-fluid" style="border: 1px solid #c4e3f3;padding: 4px;background-color:#ffffff;">
                <h4 class="title">最新教程</h4><hr>
                <div class="span12" style="padding-right: 8px;">
                    <img alt="jiaocheng" src="./img/glass2.gif" style="float: left;height: 80px;width: 125px;"/>
                    <img alt="jiaocheng" src="./img/glass2.gif" style="float: right;height: 80px;width: 125px;"/>
                </div>
                <div class="span12" style="margin-top: 8px">
                <ul class="unstyled" >
                    <li><h5><strong style="color: #0000FF;">·</strong> <a href="study.jsp">【视频】“飞碟说”产品大爆炸</a> </h5></li>
                    <li><h5><strong style="color: #0000FF;">·</strong> <a href="study.jsp">【视频】“罗辑思维”3D打印的未来</a> </h5></li>
                    <li><h5><strong style="color: #0000FF;">·</strong> <a href="study.jsp">【视频】“飞碟说”产品大爆炸</a> </h5></li>
                    <li><h5><strong style="color: #0000FF;">·</strong> <a href="study.jsp">【视频】“飞碟说”产品大爆炸</a> </h5></li>
                </ul>
                </div>

            </div>

        </div>
    </div>

</div>
</body>
</html>