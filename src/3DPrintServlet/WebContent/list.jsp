<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <title></title>
    <link rel="stylesheet" href="./css/bootstrap.min.css">
    <style type="text/css">
        body{
            background-color: #f5f5f5;
        }
    </style>
    <style type="text/css">
        .tp1 {
            text-align: center;
            color: #666;
            line-height: 30px;
            padding-bottom: 10px;
        }
        p {
            display: block;
            -webkit-margin-before: 1em;
            -webkit-margin-after: 1em;
            -webkit-margin-start: 0px;
            -webkit-margin-end: 0px;
            background-color: #ffffff;
        }
        #editor {
            font-size: 11pt;
            line-height: 30px;
            color: #313131;
            margin-bottom: 20px;
            margin-top: 20px;
            height: 30px;
            text-align: right;
        }
        a{
            color: #000000;
        }
    </style>
</head>
<body>
	<jsp:include page="header.jsp" flush="true"></jsp:include>
<div class="container" >
    <div class="row">
        <div class="span12">
            <div class="row">
                <div class="span8" style="background-color: #ffffff">
                    <ul class="breadcrumb">
                        <li>
                            <a href="study.jsp">学习</a> <span class="divider">/</span>
                        </li>
                        <li>
                            <a href="list.jsp">入门教程</a> <span class="divider">/</span>
                        </li>
                        <li class="active">
                            列表
                        </li>
                    </ul>
                    <div class="row-fluid" style="padding-left: 8px;">
                        <div class="span4" >
                            <img alt="140x140" src="./img/ff.gif"  style="width: 170px;height: 120px;" />
                            <p>
                                <a href="ST_1.jsp">入门教程一：什么是3D打印</a>
                            </p>
                        </div>
                        <div class="span4">
                            <img alt="140x140" src="./img/st0.png"  style="width: 170px;height: 120px;" />
                            <p>
                                <a href="ST_1.jsp">入门教程二：3D打印的发展历史</a>
                            </p>

                        </div>
                        <div class="span4">
                            <img alt="140x140" src="./img/ff.gif"  style="width: 170px;height: 120px;" />
                            <p>
                                <a href="ST_3Dprint.jsp">入门教程三：3D打印的应用</a>
                            </p>
                        </div>
                    </div>
                    <div class="row-fluid" style="padding-left: 8px;">
                        <div class="span4">
                            <img alt="140x140" src="./img/st1.png"  style="width: 170px;height: 120px;" />
                            <p>
                                <a href="ST_3Dprint.jsp">入门教程四：怎样建模</a>
                            </p>
                        </div>
                        <div class="span4">
                            <img alt="140x140" src="./img/ff.gif"  style="width: 170px;height: 120px;" />
                            <p>
                                <a href="ST_3Dprint.jsp">入门教程九：打印吧来吧</a>
                            </p>

                        </div>
                        <div class="span4">
                            <img alt="140x140" src="./img/st2.png"  style="width: 170px;height: 120px;" />
                            <p>
                                <a href="ST_3Dprint.jsp">入门教程九：打印吧来吧</a>
                            </p>
                        </div>
                    </div>
                    <div class="row-fluid" style="padding-left: 8px;">
                        <div class="span4">
                            <img alt="140x140" src="./img/ff.gif"  style="width: 170px;height: 120px;" />
                            <p>
                                <a href="ST_3Dprint.jsp">入门教程九：建模</a>
                            </p>
                        </div>
                        <div class="span4">
                            <img alt="140x140" src="./img/ff.gif"  style="width: 170px;height: 120px;" />
                            <p>
                                <a href="ST_3Dprint.jsp">入门教程九：建模</a>
                            </p>

                        </div>
                        <div class="span4">
                            <img alt="140x140" src="./img/ff.gif"  style="width: 170px;height: 120px;" />
                            <p>
                                <a href="ST_3Dprint.jsp">入门教程九：建模</a>
                            </p>
                        </div>
                    </div>
                    <div class="pagination" style="float: right;">
                        <ul>
                            <li>
                                <a href="#">上一页</a>
                            </li>
                            <li>
                                <a href="#">1</a>
                            </li>
                            <li>
                                <a href="#">2</a>
                            </li>
                            <li>
                                <a href="#">3</a>
                            </li>
                            <li>
                                <a href="#">3</a>
                            </li>
                            <li>
                                <a href="#">3</a>
                            </li>
                            <li>
                                <a href="#">下一页</a>
                            </li>
                        </ul>

                    </div>
                </div>
                <div class="span4">
                    <div class="thumbnail" style="background-color:#a9dba9">
                        <div class="caption">
                            <span class="title" style="float: left;">系列教程</span>
                            <a href="ST_3Dprint.jsp" style="float: right;">更多>></a>
                        </div>
                        <hr>
                        <div class="caption">
                            <a href="ST_3Dprint.jsp">
                                        <span>
                                            3D打印基于微分原理
                                        </span></a>
                        </div>
                        <div class="caption">
                            <a href="ST_3Dprint.jsp">
                                        <span>
                                            3D打印基于微分原理
                                        </span></a>
                        </div>
                        <div class="caption">
                            <a href="ST_3Dprint.jsp">
                                        <span>
                                            3D打印基于微分原理
                                        </span></a>
                        </div>
                        <div class="caption">
                            <a href="ST_3Dprint.jsp">
                                        <span>
                                            3D打印基于微分原理
                                        </span></a>
                        </div>
                    </div>
                    <div class="row" style="border: 1px solid #c4e3f3;margin-top: 24px;background-color:#ffffff;">
                        <h4 class="title">&nbsp;&nbsp;精彩推荐</h4><hr>
                        <div>
                            <img alt="jiaocheng" src="./img/glass2.gif" style="float: left;height: 80px;width: 120px;"/>
                            <img alt="jiaocheng" src="./img/glass2.gif" style="float: right;height: 80px;width: 120px;"/>
                        </div>
                        <div class="span12" style="margin-top: 8px">
                            <ul class="unstyled" >
                                <li><h4><a href="study.jsp">教程名字名字名字</a> </h4></li>
                                <li><h4><a href="study.jsp">新闻资讯</a> </h4></li>
                                <li><h4><a href="study.jsp">新闻资讯</a> </h4></li>
                                <li><h4><a href="study.jsp">新闻资讯</a> </h4></li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>


        </div>
    </div>
</div>
</body>
</html>