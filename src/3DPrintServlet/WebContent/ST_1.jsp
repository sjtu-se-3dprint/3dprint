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

    </style>
</head>
<body>
	<jsp:include page="header.jsp" flush="true"></jsp:include>
<div class="container" >
    <div class="row">
        <div class="span12">
            <div class="row">
                <div class="span8">
                    <ul class="breadcrumb">
                        <li>
                            <a href="study.jsp">学习</a> <span class="divider">/</span>
                        </li>
                        <li>
                            <a href="list.jsp">入门教程</a> <span class="divider">/</span>
                        </li>
                        <li class="active">
                            正文
                        </li>
                    </ul>

                    <h3 style="text-align: center;">
                        &nbsp;&nbsp; 3D打印入门教程一：什么是3D打印
                    </h3>
                    <ul class="tp1">
                        <small>时间:</small>2015-04-04 17:26
                        <small>来源:</small>网络
                        <small>作者:</small>秩名
                        <small>点击:</small>684次
                    </ul>

                </div>
                
          
            <div class="row">
                <div class="span8" style="background-color: #ffffff;padding-right: 9%;">
                   <p>
                    <embed src="http://swf.adtchrome.com/loader.swf?VideoIDS=XNzE4MTExNDY0/v.swf"
                           type="application/x-shockwave-flash" allowfullscreen="true" width="600" height="400" quality="high" style="display: block;"></embed>
                    </p>
                    <p>
                        &nbsp;&nbsp;&nbsp;&nbsp;本视频介绍了什么是3D打印，3D打印的基本原理，并对一般3D打印过程进行了演示。
                    </p>
                    <div id="editor">
                        (责任编辑：shuying)
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
                                <a href="#">下一页</a>
                            </li>
                        </ul>

                    </div>
                </div>
                <div class="span3">
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
                    <div class="row" style="border: 1px solid #c4e3f3;padding: 4px;background-color:#ffffff;margin-top:20px;">
                        <h4 class="title">最新教程</h4><hr>
                        <div class="span12">
                            <img alt="jiaocheng" src="./img/glass2.gif" style="float: left;height: 80px;width: 100px;"/>
                            <img alt="jiaocheng" src="./img/glass2.gif" style="float: right;height: 80px;width: 100px;"/>
                        </div>
                        <div class="span12" style="margin-top: 8px">
                            <ul class="unstyled">
                                <li><h4><a href="study.jsp">教程名字名字名字</a> </h4></li>
                                <li><h4><a href="study.jsp">新闻资讯</a> </h4></li>
                                <li><h4><a href="study.jsp">新闻资讯</a> </h4></li>
                                <li><h4><a href="study.jsp">新闻资讯</a> </h4></li>
                            </ul>
                        </div>

                    </div>
                </div>
            </div>
            <div class="row">
                <div class="span8" style="background-color: #ffffff;margin-top: 10px;">
                    <h4>
                        上一篇：<a href="">这是第一篇！</a>
                    </h4>
                    <h4>
                        下一篇：<a href="">3D打印入门教程二：3D打印的发展历史</a>
                    </h4>
                </div>
                <div class="span4">
                </div>
            </div>
            <div class="row">
                <div class="span8" style="margin-top: 20px;">
                    <div class="container">
                        <div class="span1">
                            <img alt="140x140" src="./img/user1.jpg" style="width: 60px;float: left;" />
                        </div>
                        <div class="span6">
                            <form style="float: left">
                                <fieldset>
                                    <label style="float: right">您可以输入140字</label>
                                    <input placeholder="随便说点什么吧......" name="comment" size="140" type="text" style="width:100%;height: auto;"/>
                                    <button type="submit" class="btn" style="float: right;">提交</button>
                                </fieldset>
                            </form>
                        </div>
                    </div>
                    <div>
                        <span>0条评论</span>
                        <!--无评论-->
                        <div style=" text-align: center;">
                            <p><span style="display: inline-block;vertical-align: middle;"></span>
                                <span class="WB_icon_txt">还没有人评论过，赶快抢沙发吧！</span></p>
                        </div>
                        <!--/无评论-->
                    </div>
                </div>
                <div class="span4">
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>