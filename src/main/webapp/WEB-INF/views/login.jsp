<%--
  Created by IntelliJ IDEA.
  User: shiwanpeng
  Date: 2018/7/15
  Time: 上午11:38
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="utf-8" %>
<%@ include file="/common/global.jsp"%>
<html lang="zh-cn">
<head>
    <meta charset="utf-8">
    <meta http-equiv="x-ua-compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>用户登陆</title>
    <link href="${pageContext.request.contextPath}/resources/css/login.css" rel="stylesheet">

</head>
<body>

    <div id="login-window">
        <div class="input-group m-b-20">
            <span class="input-group-addon"><i class="zmdi zmdi-account zmdi-hc-2x"></i></span>
            <div class="fg-line">
                <input id="username" class="form-control" name="username" type="text" placeholder="用户名" required autofocus>
            </div>
        </div>
        <div class="input-group m-b-20">
            <span class="input-group-addon"><i class="zmdi zmdi-lock zmdi-hc-2x"></i></span>
            <div class="fg-line">
                <input id="password" class="form-control" name="password" type="password" placeholder="密码" required>
            </div>
        </div>
        <div class="input-group m-b-20">
            <div class="checkbox checkbox-info">
                <input id="remember"  type="checkbox"><label for="remember">记住我</label>
            </div>
        </div>

        <a id="login-bt" href="javascript:;" class="waves-effect waves-button waves-float">
            <i class="zmdi zmdi-arrow-forward"></i>
        </a>
    </div>
    <script type="text/javascript">
        // Waves 初始化，点击动画效果
        Waves.displayEffect();

        // 输入框获取焦点显示下划线
        $(".form-control").focus(function(){
            $(this).parent().addClass("fg-toggled");
        }).blur(function(){
           $(this).parent().removeClass("fg-toggled");
        });

        if ($.cookie("loginCoookie") != null && $.cookie("loginCookie") != "null") {
            var loginCookies = $.cookie("loginCookie").split(",");
            $("#username").val(loginCookies[0]);
            $("#password").val(loginCookies[1]);
            $("#remember").attr("checked",loginCookies[2]);
        }

        // 登陆时间
        $("#login-bt").click(function(){
           $.post(
               "${pageContext.request.contextPath}/commons/login/signin",
               {
                   username : $("#username").val(),
                   password : $("#password").val(),
                   remember : $("#remember").is("checked")
               },
               function(data){
                   if (data.status == 0){
                       $.alert(data.msg);
                   } else {
                       if (data.remember){
                           var loginCookie = $("#username")+","+$("#password")+","+$("#remember").is("checked");
                           $.cookie("loginCookie",loginCookie);
                       } else {
                           $.cookie("loginCookie",null);
                       }
                       window.location.href = "${pageContext.request.contextPath}"+data.url;
                   }

               }
           );
        });


    </script>

</body>
</html>
