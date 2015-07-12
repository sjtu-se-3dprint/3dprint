<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>3D打印创作服务平台-在线定制</title>
</head>
<body>
	<jsp:include page="header.jsp" flush="true"></jsp:include>
    <div class="row-fluid" style='font-size:20px'>
        <div class="container">
            <div class="span1">
            </div>
            <div class="span2" align='center'>
                <p>3D设计</p>
            </div>
            <div class="span2" align='center'>
                <p>上传模型</p>
            </div>
            <div class="span2" align='center'  style='background-color:#CFF'>
                <p>完善模型信息</p>
            </div>
            <div class="span2" align='center'>
                <p>选择材料</p>
            </div>
            <div class="span2" align='center'>
                <p>快速支付</p>
            </div>
            <div class="span1" align='center'>
            </div>
        </div>
    </div>
    <div class="container-fluid">
        <div class="container">
            <div class="row-fluid">
                <div class="span12">
                    <h3>
                        上传成功
                    </h3>
                    <div class="row-fluid" style='border:double;font-size:14px;'>
                        <h3>
                            模型编辑
                        </h3>
                    </div>
                    <div class="row-fluid" style='border:double'>
                        <div class="span6">
                            <div class="row-fluid">
                                <div class="span12">
                                    <h3>
                                        1.模型名称
                                        <input type='text'>
                                    </h3>
                                </div>
                            </div>
                            <div class="row-fluid">
                                <div class="span12">
                                    <h3> 模型规格 </h3>
                                    <div class="row-fluid">
                                        <div class="span3">
                                        </div>
                                        <div class="span9">
                                            <ul  style='margin-left:20%'>
                                                长：<input type='text' style='width:60px;margin-top:20px;'/>
                                            </ul>
                                            <ul  style='margin-left:20%'>
                                                宽：<input type='text' style='width:60px'/>
                                            </ul>
                                            <ul  style='margin-left:20%'>
                                                高：<input type='text' style='width:60px'/>
                                            </ul>
                                            <ul style='font-size:16px;'>
                                                <input type='radio' name='单位'/>毫米
                                                <input type='radio' name='单位' checked/>厘米
                                                <input type='radio' name='单位'/>英寸
                                            </ul>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="row-fluid">
                                <div class="span12">
                                    <h3>
                                        3.模型预览图
                                    </h3>
                                    <div class="row-fluid">
                                        <div class="span3">
                                            <button class="btn" type="button">预览图</button>
                                        </div>
                                        <div class="span3">
                                            <button class="btn" type="button">顶视图</button>
                                        </div>
                                        <div class="span3">
                                            <button class="btn" type="button">侧视图</button>
                                        </div>
                                        <div class="span3">
                                            <button class="btn" type="button">正视图</button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="row-fluid">
                                <div class="span12">
                                    <h3>
                                        4.添加模型描述和说明
                                    </h3>
                                    <input type='text' style='width:300px;height:30px;' />
                                </div>
                            </div>
                            <div class="row-fluid">
                                <div class="span12">
                                    <h3>
                                        5.添加类型
                                    </h3>
                                    <li>
                                        <select name="模型标签" id="ID">
                                            <option value="1">时尚</option>
                                            <option value="2">简约</option>
                                            <option value="3">实用</option>
                                            <option value="4">精细</option>
                                            <option value="5">高强度</option>
                                        </select>
                                    </li>
                                </div>
                            </div>
                        </div>
                        <div class="span6">
                            <h3>
                                h3. 这是一套可视化布局系统.
                            </h3>
                            <div class="row-fluid">
                                <div class="span12">
                                    <img alt="400x400" src="./img/31.png"/>
                                    <li>
                                        <img alt="140x140" src="./img/31.png" width="140"/>
                                        <img alt="140x140" src="./img/32.png" width="140"/>
                                        <img alt="140x140" src="./img/33.png" width="140"/>
                                    </li>
                                </div>
                            </div> <button class="btn" type="button">提交信息</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
	<jsp:include page="footer.jsp" flush="true"></jsp:include>
</body>
</html>