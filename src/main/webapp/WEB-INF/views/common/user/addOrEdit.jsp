<%--
  Created by IntelliJ IDEA.
  User: ios
  Date: 2018/9/4
  Time: 下午4:11
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/common/global.jsp" %>
<%@ include file="/common/include_common.jsp" %>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>添加或编辑用户</title>
</head>
<body>

<div class="container col-md-11" style="margin-top: 10px;margin-left: 55px;display: table">
    <div class="row" style="margin-top: 10px; margin-bottom: 10px">
        <div class="col-md-4 text-left" style="background-color: #D2E9FF; line-height: 26px;vertical-align: middle">
            <label style="margin-top: 5px;font-size: 14px;color: grey;">用户名:</label>
        </div>
        <div class="col-md-7">
            <div class="form-group">
                <input type="text" id="userCode" name="userCode" class="form-control" placeholder="用户名（必填）">
            </div>
        </div>
    </div>
    <div class="row" style="margin-top: 10px; margin-bottom: 10px">
        <div class="col-md-4 text-left" style="background-color: #D2E9FF; line-height: 26px;vertical-align: middle">
            <label style="margin-top: 5px;font-size: 14px;color: grey;">姓名:</label>
        </div>
        <div class="col-md-7">
            <div class="form-group">
                <input type="text" id="userName" name="userName" class="form-control" placeholder="姓名（必填）">
            </div>
        </div>
    </div>
    <div class="row" style="margin-top: 10px; margin-bottom: 10px">
        <div class="col-md-4 text-left" style="background-color: #D2E9FF; line-height: 26px;vertical-align: middle">
            <label style="margin-top: 5px;font-size: 14px;color: grey;">密码:</label>
        </div>
        <div class="col-md-7">
            <div class="form-group">
                <input type="password" id="userPassword" name="userPassword" class="form-control" placeholder="密码（必填）">
            </div>
        </div>
    </div>
    <div class="row" style="margin-top: 10px; margin-bottom: 10px">
        <div class="col-md-4 text-left" style="background-color: #D2E9FF; line-height: 26px;vertical-align: middle">
            <label style="margin-top: 5px;font-size: 14px;color: grey;">地址:</label>
        </div>
        <div class="col-md-7">
            <div class="form-group">
                <input type="text" id="userAddress" name="userAddress" class="form-control" placeholder="地址">
            </div>
        </div>
    </div>
    <div class="row" style="margin-top: 10px; margin-bottom: 10px">
        <div class="col-md-4 text-left" style="background-color: #D2E9FF; line-height: 26px;vertical-align: middle">
            <label style="margin-top: 5px;font-size: 14px;color: grey;">邮箱:</label>
        </div>
        <div class="col-md-7">
            <div class="form-group">
                <input type="text" id="userEmail" name="userEmail" class="form-control" placeholder="邮箱">
            </div>
        </div>
    </div>
    <div class="row" style="margin-top: 10px; margin-bottom: 10px">
        <div class="col-md-4 text-left" style="background-color: #D2E9FF; line-height: 26px;vertical-align: middle">
            <label style="margin-top: 5px;font-size: 14px;color: grey;">联系电话:</label>
        </div>
        <div class="col-md-7">
            <div class="form-group">
                <input type="text" id="userPhone" name="userPhone" class="form-control" placeholder="联系电话">
            </div>
        </div>
    </div>
    <div class="row" style="margin-top: 10px; margin-bottom: 10px">
        <div class="col-md-4 text-left" style="background-color: #D2E9FF; line-height: 26px;vertical-align: middle">
            <label style="margin-top: 5px;font-size: 14px;color: grey;">出生日期:</label>
        </div>
        <div class="col-md-7">
            <div class="form-group">
                <div class="input-group date form_date">
                    <input id="userBirthday" class="form-control" type="text"
                           placeholder="请选择日期" readonly> <span
                        class="input-group-addon"><span
                        class="glyphicon glyphicon-remove"></span></span> <span
                        class="input-group-addon"><span
                        class="glyphicon glyphicon-calendar"></span></span>
                </div>
                <script type="text/javascript">
                    //	日历组件选择
                    $(".form_datetime").datetimepicker({
                        language: 'zh-CN',
                        format: "yyyy-mm-dd hh:ii",
                        autoclose: true,
                        todayBtn: true,
                        minuteStep: 10
                    });
                    $('.form_date').datetimepicker({
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
        <div class="row" style="margin-top: 10px; margin-bottom: 10px;">
            <div class="col-md-4 text-left"
                 style="background-color: #D2E9FF; line-height: 26px; vertical-align: middle;">
                <label style="margin-top: 5px; font-size: 14px; color: grey;">照片：</label>
            </div>
            <div class="col-md-7">
                <div class="form-group">
                    <input id="userPhoto" type="file" style="display:block;">
                </div>
            </div>
        </div>
        <div class="row" style="margin-top: 10px; margin-bottom: 10px;">
            <div class="col-md-4 text-left"
                 style="background-color: #D2E9FF; line-height: 26px; vertical-align: middle;">
                <label style="margin-top: 5px; font-size: 14px; color: grey;">有效值：</label>
            </div>
            <div class="col-md-7">
                <div class="form-group">
                    <select id="userValid" name="userValid" class="selectpicker">
                        <option value="true">有效</option>
                        <option value="false">无效</option>
                    </select>
                </div>
            </div>
        </div>
    </div>
</div>

</body>
</html>
