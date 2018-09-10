<%--
  Created by IntelliJ IDEA.
  User: ios
  Date: 2018/9/10
  Time: 上午9:41
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/common/global.jsp"%>
<%@ include file="/common/include_common.jsp"%>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>系统设置</title>
</head>
<body>
    <form id="dataForm" method="post">
        <div class="container col-xs-11" style="margin-top: 30px ;margin-left: 30px">
            <div class="row" style="margin-top: 10px;margin-bottom: 10px" align="left">
                <div class="col-xs-4" style="background: #E6E6F2;line-height: 26px;vertical-align: center">
                    <label>文件上传路径：</label>
                </div>
                <div class="col-xs-7">
                    <input id="uploadPath" type="text" class="form-control" name="uploadPath" value="${uploadPath}" placeholder="请输入文件上传路径"/>
                </div>
            </div>
            <div class="row" style="margin-top: 10px;margin-bottom: 10px" align="center">
                <button id="saveBtn" class="waves-effect btn btn-success btn-sm" type="button"><i class="zmdi zmdi-save"></i> 保存</button>
            </div>
        </div>
    </form>
</body>

<script type="text/javascript">

    $(function () {
       $('#dataForm').bootstrapValidator({
          container:"popover",
          message:"This value is not valid",
          feedbackIcons: {
              valid : 'glyphicon glyphicon-ok',
              invalid : 'glyphicon glyphicon-remove',
              validating : 'glyphicon glyphicon-refresh'
          },
          fields : {
              'uploadPath' : {
                  validators : {
                      notEmpty : {
                          message: '上传路径不能为空'
                      },
                      regexp : {
                          regexp : /^[a-zA-Z0-9_/\.]+$/,
                          message : '请输入正确的路径地址'
                      }
                  }
              }
          }

       });

       $("#saveBtn").click(function () {
           var bv = $("#dataForm").data("bootstrapValidator");
           bv.validate();
           if (bv.isValid()) {
               $.post("${pageContext.request.contextPath}/commons/setting/save",{"uploadPath":$("#uploadPath").val()},function (data) {
                  $.alert(data.msg);
               });
           }
       });

    });

</script>

</html>
