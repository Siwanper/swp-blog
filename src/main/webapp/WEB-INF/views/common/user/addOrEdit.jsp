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

<form id="dataForm" method="post" style="margin-left: 20px">
    <div class="row" style="margin-top: 10px; margin-bottom: 10px;">
        <div class="col-md-4"
             style="background-color: #D2E9FF; line-height: 26px;vertical-align: middle">
            <label style="margin-top: 5px;font-size: 14px;color: grey;">用户名:</label>
        </div>
        <div class="col-md-7">
            <div class="form-group">
                <input type="text" id="userCode" name="userCode" class="form-control"
                       placeholder="用户名（必填）" value="${userBean.userCode}">
            </div>
        </div>
    </div>
    <div class="row" style="margin-top: 10px; margin-bottom: 10px">
        <div class="col-md-4 text-left"
             style="background-color: #D2E9FF; line-height: 26px;vertical-align: middle">
            <label style="margin-top: 5px;font-size: 14px;color: grey;">姓名:</label>
        </div>
        <div class="col-md-7">
            <div class="form-group">
                <input type="text" id="userName" name="userName" class="form-control"
                       placeholder="姓名（必填）" value="${userBean.userName}">
            </div>
        </div>
    </div>
    <div class="row" style="margin-top: 10px; margin-bottom: 10px">
        <div class="col-md-4 text-left"
             style="background-color: #D2E9FF; line-height: 26px;vertical-align: middle">
            <label style="margin-top: 5px;font-size: 14px;color: grey;">密码:</label>
        </div>
        <div class="col-md-7">
            <div class="form-group">
                <input type="password" id="userPassword" name="userPassword" class="form-control"
                       placeholder="密码（必填）" value="${userBean.userPassword}">
            </div>
        </div>
    </div>
    <div class="row" style="margin-top: 10px; margin-bottom: 10px">
        <div class="col-md-4 text-left"
             style="background-color: #D2E9FF; line-height: 26px;vertical-align: middle">
            <label style="margin-top: 5px;font-size: 14px;color: grey;">地址:</label>
        </div>
        <div class="col-md-7">
            <div class="form-group">
                <input type="text" id="userAddress" name="userAddress" class="form-control"
                       placeholder="地址" value="${userBean.userAddress}">
            </div>
        </div>
    </div>
    <div class="row" style="margin-top: 10px; margin-bottom: 10px">
        <div class="col-md-4 text-left"
             style="background-color: #D2E9FF; line-height: 26px;vertical-align: middle">
            <label style="margin-top: 5px;font-size: 14px;color: grey;">邮箱:</label>
        </div>
        <div class="col-md-7">
            <div class="form-group">
                <input type="text" id="userEmail" name="userEmail" class="form-control"
                       placeholder="邮箱" value="${userBean.userEmail}">
            </div>
        </div>
    </div>
    <div class="row" style="margin-top: 10px; margin-bottom: 10px">
        <div class="col-md-4 text-left"
             style="background-color: #D2E9FF; line-height: 26px;vertical-align: middle">
            <label style="margin-top: 5px;font-size: 14px;color: grey;">联系电话:</label>
        </div>
        <div class="col-md-7">
            <div class="form-group">
                <input type="text" id="userPhone" name="userPhone" class="form-control"
                       placeholder="联系电话" value="${userBean.userPhone}">
            </div>
        </div>
    </div>
    <div class="row" style="margin-top: 10px; margin-bottom: 10px">
        <div class="col-md-4 text-left"
             style="background-color: #D2E9FF; line-height: 26px;vertical-align: middle">
            <label style="margin-top: 5px;font-size: 14px;color: grey;">出生日期:</label>
        </div>
        <div class="col-md-7">
            <div class="form-group">
                <div class="input-group date form_date">
                    <input id="userBirthday" class="form-control" type="text"
                           placeholder="请选择日期" name="birthday" value="${userBean.userBirthday}" readonly> <span
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
    </div>
    <div>
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
                <label style="margin-top: 5px; font-size: 14px; color: grey;" value="${userBean.userValid}">有效值：</label>
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
</form>
</body>

<script type="text/javascript">
    $(function () {
        // 验证添加用户
        $("#dataForm").bootstrapValidator({
            container: "popover",
            message: 'This value is not valid',
            feedbackIcons: {
                valid: 'glyphicon glyphicon-ok',
                invalid: 'glyphicon glyphicon-remove',
                validating: 'glyphicon glyphicon-refresh'
            },
            fields: {
                'userCode': {
                    validators: {
                        notEmpty: {
                            message: '用户名称不能为空'
                        },
                        stringLength: {
                            min: 1,
                            max: 36
                        },
                    }
                },
                'userName': {
                    validators: {
                        notEmpty: {
                            message: '姓名不能为空'
                        },
                        stringLength: {
                            min: 1,
                            max: 36
                        },
                    }
                },
                'userPassword': {
                    validators: {
                        notEmpty: {
                            message: '密码不能为空'
                        },
                        stringLength: {
                            min: 1,
                            max: 36
                        },
                    }
                },
                'userPhone': {
                    validators: {
                        integer: {
                            message: '请输入整数类型'
                        }
                    }
                }
            }
        });
    });
</script>


</html>
