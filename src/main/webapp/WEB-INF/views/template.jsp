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

    <div class="row" style="margin-top: 5px; margin-bottom: 5px">
        <div class="col-xs-4" style="background: #F5F5F5; line-height: 64px; text-align: center">
            <label style="margin-top: 5px; font-size: 14px; color: grey">文本输入框</label>
        </div>
        <div class="col-xs-8">
            <textarea class="form-control" rows="3"></textarea>
        </div>

    </div>

    <div class="row" style="margin-top: 5px; margin-bottom: 5px">
        <div class="col-xs-4" style="background: #F5F5F5; line-height: 26px; text-align: center">
            <label style="margin-top: 5px; font-size: 14px; color: grey">输入框参考</label>
        </div>
        <div class="col-xs-8">
            <label style="color: #0f0f0f;font-size: 14px; margin-top: 5px"><a href="http://v3.bootcss.com/css/?#forms">http://v3.bootcss.com/css/?#forms</a></label>
        </div>
    </div>
    <%-- 下拉选择框 --%>
    <div class="row" style="margin-top: 5px; margin-bottom: 5px">
        <div class="col-xs-4" style="background: #F5F5F5; line-height: 26px; text-align: center">
            <label style="margin-top: 5px;font-size: 14px; margin-top: 5px; color: grey">单选下拉框</label>
        </div>
        <div class="col-xs-8">
            <select class="selectpicker" title="单选下拉框">
                <option>Mustard</option>
                <option>Ketchup</option>
                <option>Relish</option>
            </select>
            <select class="selectpicker" data-style="btn-info" title="带样式的下拉框">
                <option>Mustard</option>
                <option>Ketchup</option>
                <option>Relish</option>
            </select>
            <select class="selectpicker" title="多选下拉框">
                <optgroup label="Picnic">
                    <option>Mustard</option>
                    <option>Ketchup</option>
                    <option>Relish</option>
                </optgroup>
                <optgroup label="Camping">
                    <option>Tent</option>
                    <option>Flashlight</option>
                    <option>Toilet Paper</option>
                </optgroup>
            </select>
        </div>
    </div>
    <div class="row" style="margin-top: 5px; margin-bottom: 5px">
        <div class="col-xs-4" style="background: #F5F5F5; line-height: 26px; text-align: center">
            <label style="margin-top: 5px;font-size: 14px; margin-top: 5px; color: grey">多单选下拉框</label>
        </div>
        <div class="col-xs-8">
            <select class="selectpicker" title="多单选下拉框" multiple>
                <option>Mustard</option>
                <option>Ketchup</option>
                <option>Relish</option>
            </select>
            <select class="selectpicker" data-max-options="2" title="限制个数多选下拉框" multiple>
                <option>Mustard</option>
                <option>Ketchup</option>
                <option>Relish</option>
            </select>
            <select class="selectpicker" data-max-options="2" title="限制个数多选下拉框" multiple>
                <optgroup label="Picnic">
                    <option>Mustard</option>
                    <option>Ketchup</option>
                    <option>Relish</option>
                </optgroup>
                <optgroup label="Camping">
                    <option>Tent</option>
                    <option>Flashlight</option>
                    <option>Toilet Paper</option>
                </optgroup>
            </select>
        </div>
    </div>

    <div class="row" style="margin-top: 5px; margin-bottom: 5px">
        <div class="col-xs-4" style="background: #F5F5F5; line-height: 26px; text-align: center">
            <label style="margin-top: 5px;font-size: 14px; margin-top: 5px; color: grey">搜索下拉框</label>
        </div>
        <div class="col-xs-8">
            <select class="selectpicker" data-live-search="true">
                <option data-tokens="ketchup mustard">Hot Dog, Fries and a
                    Soda
                </option>
                <option data-tokens="mustard">Burger, Shake and a Smile</option>
                <option data-tokens="frosting">Sugar, Spice and all things
                    nice
                </option>
            </select>
        </div>
    </div>


</div>
</body>
</html>
