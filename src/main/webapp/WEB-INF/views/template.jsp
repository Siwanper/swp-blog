<%--
  Created by IntelliJ IDEA.
  User: shiwanpeng
  Date: 2018/7/3
  Time: 下午9:27
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/common/global.jsp" %>
<%@ include file="/common/include_common.jsp" %>
<html>
<head>
    <title>UI 模版</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
</head>
<body>
<div id="main">
    <%-- 栅格布局 --%>
    <div class="row">
        <div class="col-xs-1" style="background: #FFD2D2">col-xs-1</div>
        <div class="col-xs-2" style="background: #FFF8D7">col-xs-2</div>
        <div class="col-xs-4" style="background: #D2E9FF">col-xs-4</div>
        <div class="col-xs-5" style="background: #DFFFDF">col-xs-5</div>
    </div>
    <%-- 组件 --%>
    <div class="row" style="margin-top: 5px; margin-bottom: 5px">
        <div class="col-xs-4" style="background: #F5F5F5; line-height: 26px;text-align: center">
            <label style="margin-top: 5px; font-size: 14px; color: grey; ">一般输入框</label>
        </div>
        <div class="col-xs-8">
            <input type="text" class="form-control" placeholder="一般输入框" required>
        </div>
    </div>

    <div class="row" style="margin-top: 5px; margin-bottom: 5px">
        <div class="col-xs-4" style="background: #F5F5F5; line-height: 26px;text-align: center">
            <label style="margin-top: 5px; font-size: 14px; color: grey; ">内联输入框：</label>
        </div>
        <div class="col-xs-8">
            <div class="input-group">
                <div class="input-group-addon">$</div>
                <input type="text" class="form-control" placeholder="内联输入框" required>
                <div class="input-group-addon">.00</div>
            </div>
        </div>
    </div>

    <div class="row" style="margin-top: 5px; margin-bottom: 5px">
        <div class="col-xs-4" style="background: #F5F5F5; line-height: 26px;text-align: center">
            <label style="margin-top: 5px; font-size: 14px; color: grey; ">日期选择框</label>
        </div>
        <div class="col-xs-8">
            <div class="input-group date form_date col-md-16">
                <input id="astaleDate" class="form-control" size="16" type="text"
                       placeholder="请选择日期" readonly>
                <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
            </div>
            <script type="text/javascript">
                $(".form_date").datetimepicker({
                    language: 'zh-CN',
                    format: "yyyy-mm-dd",
                    todayBtn: true,
                    autoclose: true,
                    startView: 2,
                    minView: 2
                });
            </script>
        </div>
    </div>


</div>
</body>
</html>
