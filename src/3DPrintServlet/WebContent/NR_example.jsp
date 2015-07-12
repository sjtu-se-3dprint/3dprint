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
                    <li class="list-group-item"><a href="NR_model.jsp">3D建模</a></li>
                    <br>
                    <li class="list-group-item"><a href="NR_example.jsp">3D打印案例</a></li>               
                    <img src='./img/knowledge/introduction/4.png' style='margin-top:100px;'>
                </ul>
            </div>
            <div class="span6" style="font-size:20px;font-family:'MFLangQian','Microsoft YaHei';background-color:#d9e8ed">
                <h2 style='margin-left:20px;margin-right:20px'>
                    如何设计骷髅戒指
                </h2>
                <br>
                <br>
                <h4 style='margin-left:20px;margin-right:20px;'>1. 准备工作</h4>
                <br>
                <p style='margin-left:20px;margin-right:20px;line-height:30px'>软件部分：我们需要开源的3D建模软件，相互配合使用。本例中，使用的3D建模软件为：Blender/Zbrush/Rhino。</p>
                <p style='margin-left:20px;margin-right:20px;line-height:30px'>*Blender  : 低次项建模出轮廓</p>
                <p style='margin-left:20px;margin-right:20px;line-height:30px'>*Zbrush   ：提升细节、锐化</p>
                <p style='margin-left:20px;margin-right:20px;line-height:30px'>*Rhino    ：精确的比例调整</p>
                <p style='margin-left:20px;margin-right:20px;line-height:30px'>参考文件：为了设计骷髅头戒指，我们利用已有的头骨的3D医学扫描图像数据，导入Blender中进行建模。</p>
                <p style='margin-left:20px;margin-right:20px;line-height:30px'>如图1</p>
                <br><br>
                <h4 style='margin-left:20px;margin-right:20px;'>2. 开始建模</h4>
                <br>
                <p style='margin-left:20px;margin-right:20px;line-height:30px'>数据导入成功后，我们开始大体轮廓的建模。所谓低次项建模，指的是先利用小的平面来代替或者说近似原有的曲面，这样便可建立起最初的轮廓模型。这一步的演示结果：</p>
                <p style='margin-left:20px;margin-right:20px;line-height:30px'>如图2</p>
                <p style='margin-left:20px;margin-right:20px;line-height:30px'>具体操作时的建议：</p>
                <p style='margin-left:20px;margin-right:20px;line-height:30px'>建议1：选定基准网格线，打开Blender的“object”面板，“display”下选择最大绘图风格的“wire”选项。这样低次项网格模型变得透明，方便与参考模型比对。</p>
                <p style='margin-left:20px;margin-right:20px;line-height:30px'>建议2：头骨模型本身是对称的，我们只需要对它的一半进行建模便可。所以，建议使用镜像编辑器，这样可简化我们的工作量。</p>
                <p style='margin-left:20px;margin-right:20px;line-height:30px'>初步对面部建模完成后，关闭Blender。我们还需要还需要为面部模型粘结上一个圆柱空腔。在3DSmax中可以添加一个圆柱体，通过适当的弯曲粘结两部分。为了保证两部分官话的过渡连接，需要“Alt+m”选择“at center”</p>
                <p style='margin-left:20px;margin-right:20px;line-height:30px'>如图3</p>
                <p style='margin-left:20px;margin-right:20px;line-height:30px'>做到这里，我们已经完成了外表面的设计，接下来我们需要添加内表面。我们可以通过添加简单12点圆柱。</p>
                <p style='margin-left:20px;margin-right:20px;line-height:30px'>如图4</p>
                <p style='margin-left:20px;margin-right:20px;line-height:30px'>接下来，我们需要将内外表面进行粘合。通过给两个面上的点添加新的平面便可完成。（选择节点，再按F键）这些连接小平面最好选择矩形或者三角形。连接完成后，利用镜像工具与表面处理工具，你将得到这样的结果：</p>
                <p style='margin-left:20px;margin-right:20px;line-height:30px'>如图5</p>
                <br><br>
                <h4 style='margin-left:20px;margin-right:20px;'>3. 雕刻细节</h4>
                <br>
                <p style='margin-left:20px;margin-right:20px;line-height:30px'>将Blender中的模型导出成.obj文件，再将其导入Zbrush中。在Zbrush中，我们也是用镜像工具降低工作量。对模型的某个小平面区域ctrl+鼠标左键，便可将平面转化为光滑曲面。但是，实际打印出的物品的表面不会像模型这样光滑，总会留有打印材料特有的纹理。光滑后的模拟。还需要注意的是过密的网格线会使文件太多，所以我们可以使用Zbrush插件进行适当的降采样抽取。</p>
                <p style='margin-left:20px;margin-right:20px;line-height:30px'>如图6</p>
                <br><br>
                <h4 style='margin-left:20px;margin-right:20px;'>4. 调整比例</h4>
                <br>
                <p style='margin-left:20px;margin-right:20px;line-height:30px'>最后，我们使用CAD中的Rhino对模型进行高精度的比例调整。将戒指内径参数进行适当调整，导出文件即可。这样，我们就完成了模型的设计与3D建模过程。我们便可以上传模型文件，让3D打印服务平台为我们打印出自己设计的模型。如图7</p>
                <br><br>
                <h4 style='margin-left:20px;margin-right:20px;'>5. 上传模型，选择材料，等待打印。</h4>
                <br>
                <p style='margin-left:20px;margin-right:20px;line-height:30px'>进入3D打印网站，注册登入自己的账号，上传模型。选择好打印材料，支付服务网站相应的费用，接下来等待。另外，上传模型时，如果你愿意在网上公开自己作品，你也可以上传模型的几张图片向其他3D打印爱好者更好的展示自己的idea。
我们的设计成品：</p>
                <p style='margin-left:20px;margin-right:20px;line-height:30px'>如图8</p>
                <li style='text-align:center;list-style-type:none'>
                <img src='./img/knowledge/procedure/7.png' style='margin-top:'>
                <h5>图7</h5>
                </li>
            </div>
            <div class="span3" style="text-align:center;font-family:'Microsoft YaHei';font-size:14px">
                <img src='./img/knowledge/procedure/1.png' style='margin-top:'>
                图1
                <img src='./img/knowledge/procedure/2.png' style='margin-top:'>
                图2
                <img src='./img/knowledge/procedure/3.png' style='margin-top:'>
                图3
                <img src='./img/knowledge/procedure/4.png' style='margin-top:'>
                图4
                <img src='./img/knowledge/procedure/5.png' style='margin-top:'>
                图5
                <img src='./img/knowledge/procedure/6.png' style='margin-top:'>
                图6
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