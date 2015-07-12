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
                    了解3D打印
                </li>
            </ul>
            <div class="span2">
                <ul style="margin-left:50px;margin-top: 50px;font-size:20px">
                    <li class="list-group-item"><a href="NR_3Dprint.jsp">认识3D打印</a></li>
                    <br>
                    <li class="list-group-item"><a href="NR_history.jsp">3D打印的历史</a></li>
                    <br>
                    <li class="list-group-item"><a href="NR_character.jsp">3D打印特点</a></li>
                    <br>
                    <li class="list-group-item"><a href="NR_application.jsp">3D打印的应用</a></li>
                    <br>
                    <li class="list-group-item"><a href="NR_news.jsp">3D打印资讯</a></li>                   
                    <img src='./img/knowledge/introduction/4.png' style='margin-top:100px;'>
                </ul>
            </div>
            <div class="span6" style="font-size:20px;font-family:'MFLangQian','Microsoft YaHei';background-color:#d9e8ed">
                <h2 style='margin-left:20px;margin-right:20px'>
                    3D打印历史
                </h2>
                <br>
                <br>
                <h4>1983年</h4>
                <p style='margin-left:20px;margin-right:20px;line-height:30px'>
                      查尔斯·赫尔发明了stereolithography（SLA）。

查尔斯 赫尔是最早利用CAD/ CAM文件打印固件的人，于1983年，他将这样的打印过程定义为“stereolithography（SLA）”。SLA的工作原理是通过紫外激光固化液态感光树脂树脂，进行连续层的堆叠，完成立体打印。从此，“堆积制造”，“快速原型制造”和“3D打印”的概念诞生。   
                </p>
                <h4>1986年</h4>
                <p style='margin-left:20px;margin-right:20px;line-height:30px'>
                    查尔斯·赫尔创立3D System公司
1986年，3D Systems公司开发的第一个商业三维打印机SLA-1，并开发了标准STL文件格式。STL文件是一种将CAD / CAM模型转换成三维打印的信息的文件格式。3D System公司截至2014年7月，已经市值59亿美元。
                </p>
                <h4>1993年</h4>
                <p style='margin-left:20px;margin-right:20px;line-height:30px'>
                    MIT 3DP技术
1993年MIT的三维打印（3DP）技术在平板上平铺一层薄薄的粉状材料（原陶瓷），利用细小的打印喷头进行连续的层固化。它不需要支撑结构，打印对象生成时是埋在在粉末材料中。 MIT授权其3DP技术给了其它几家公司。              
                </p>
                <h4>1997年</h4>
                <p style='margin-left:20px;margin-right:20px;line-height:30px'>
                   3D Systems公司收购EOS公司SLA业务
1997年8月德国EOS GmbH公司， 3D Systems公司在欧洲最大的竞争对手，与1997年将SLA 3D打印业务转手3D Systems公司。作为交易的一部分，3D Systems公司与EOS公司就专利纠纷与不正当竞争诉讼达成和解。               
                </p>
                <h4>1999年</h4>
                <p style='margin-left:20px;margin-right:20px;line-height:30px'>
                   生物打印：膀胱
1999年，安东尼·阿塔拉，维克森林大学医学院再生医学研究所主任，领导的一个研究小组，成功地将实验室培养的膀胱植入了人类患者。该人工器官是用3D打印膀胱细胞支架生长而成的。因为细胞来自患者，所以该植入器官并不会产生排斥反应。
                </p>
                <h4>2002年</h4>
                <p style='margin-left:20px;margin-right:20px;line-height:30px'>
                    3D打印肾
2002年，维克森林大学医学院再生医学研究所开展了一个研究项目，这个项目计划设计一台器官3D打印机。它利用肾细胞以及生物支持材料打印出3D肾脏，也可以构造出耳朵这样的器官。根据患者CT扫描数据，在计算机中创建出要打印的器官的模型文件。这个模型文件然后将引导打印机，逐层的打印3D器官模型。
                </p>
                <h4>2005年</h4>
                <p style='margin-left:20px;margin-right:20px;line-height:30px'>
                    RepRap计划
2005年，，英国大学巴斯分校的博士、机械工程讲师阿德里安·鲍耶创办了一个开源项目RepRap（Replicating Rapid Prototyper）。这个项目旨在建立可以打印大多数自身组件的三维打印机，在很大程度上自我复制。
                </p>
                <h4>2007年</h4>
                <p style='margin-left:20px;margin-right:20px;line-height:30px'>
                    Shapeways：3D打印的DIY时代
2007年，Shapeways成立。它是一个综合提供3D打印服务、3D打印产品设计与3D市场的结合体。它的出现，让更多的可以接触、设计自己的3D打印产品。
                </p>
                <h4>2008年</h4>
                <p style='margin-left:20px;margin-right:20px;line-height:30px'>
                    RepRap1.0发布
2008年，RepRap公司推出了第一台可“自我复制”的3D打印机，它以著名的生物学家Drwin的名字命名。它可以制造出自己50％的结构。
                </p>
                <h4>2010年</h4>
                <p style='margin-left:20px;margin-right:20px;line-height:30px'>
                    Urbee：第一个3D打印汽车
2010年11月Urbee是一台3D打印部件作为车身的原型车。所有外部组件材料为ABS塑料，它们是在Dimension 3D打印机和Stratasys红眼公司的Fortus 3D系统生产服务线制造的。
                </p>
                <h4>2011年</h4>
                <p  style='margin-left:20px;margin-right:20px;line-height:30px'>
                    第一台3D打印飞机模型
2011年8月在南安普敦大学的上空起飞了世界上第一个3D打印飞机， SULSA（南安普敦大学激光烧结打印飞机）。飞机的整个结构：机翼，内部控制面和舱门均在一台叫做EOS EOSINT P730尼龙激光烧结打印机上完成的。飞机零部件的组装过程中不需要任何工具，只需要简单的扣合在一起。
                </p>
                <h4>2014年</h4>
                <p  style='margin-left:20px;margin-right:20px;line-height:30px'>
                    数字化牙科：VeroGlaze
2014年2月，“数字化牙科”是一个3D打印快速增长的应用，并在这一领域，Stratasys公司表现突出。一种新材料，VeroGlaze，可以精确3D打印出自然的牙齿模型的颜色、阴影。 Stratasys公司拥有一系列的应用于牙科方向的3D打印机，包括Objet EdenV和OrthoDesk系列。
                </p>
                <p  style='margin-left:20px;margin-right:20px;line-height:30px'>
                    3D打印与医疗
2014年3月
在斯旺西的Morriston医院，一辆被摩托车碰伤的患者接收了8小时脸部修复手术，术中使用了3D打印植入物。这个复杂的项目是由科CARTIS中心主持的。他们利用患者的脸部的三维扫描数据，医用级钛材料3D打印出来的植入物和板以保持骨头固定正确。
                </p>
            </div>
            <div class="span3">
                <img src='./img/knowledge/history/3.png' style='margin-top:10px;'>
                <img src='./img/knowledge/history/4.png' style='margin-top:10px;'>
                <img src='./img/knowledge/history/5.png' style='margin-top:10px;'>
                <img src='./img/knowledge/history/7.png' style='margin-top:10px;'>
                <img src='./img/knowledge/history/8.png' style='margin-top:10px;'>
            </div>
        </div>
    </div>
	<jsp:include page="footer.jsp" flush="true"></jsp:include>
</body>
</html>