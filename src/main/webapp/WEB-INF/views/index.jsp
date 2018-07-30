<%--
  Created by IntelliJ IDEA.
  User: shiwanpeng
  Date: 2018/7/3
  Time: 下午9:27
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/common/global.jsp" %>
<%@ include file="/common/include_index.jsp" %>
<html>
<head>
    <title>Siwanper Blog</title>
</head>
<body>
<%-- 页面头部 --%>
<header id="header">
    <ul id="menu">
        <li id="guide" class="line-trigger">
            <div class="line-wrap">
                <div class="line top"></div>
                <div class="line center"></div>
                <div class="line bottom"></div>
            </div>
        </li>
        <li id="logo" class="hidden-xs">
            <span id="system_title">Siwanper Blog</span>
        </li>
        <li class="pull-right">
            <ul class="hi-menu">
                <%-- 搜索 --%>
                <li class="dropdown">
                    <a class="waves-effect waves-light" data-toggle="dropdown" href="javascript:;">
                        <i class="him-icon zmdi zmdi-search"></i>
                    </a>
                    <ul class="dropdown-menu dm-icon pull-right">
                        <form id="search-from" class="form-inline">
                            <div class="input-group">
                                <input id="keywords" type="text" name="keywords" class="form-control" placeholder="search">
                                <div class="input-group-btn">
                                    <button type="submit" class="btn btn-default"><span class="glyphicon glyphicon-search"></span></button>
                                </div>
                            </div>
                        </form>
                    </ul>
                </li>
                <%-- 切换角色 --%>
                <li class="dropdown">
                    <a class="waves-effect waves-light" data-toggle="dropdown" href="javascript:;">
                        <i class="him-icon zmdi zmdi-transform"></i>
                    </a>
                    <ul class="dropdown-menu dm-icon pull-right">
                        <li class="skin-switch">
                            <p class="zmdi zmdi-swap" style="font-size: 16px"></p>&nbsp;&nbsp;&nbsp;角色切换
                        </li>
                        <li class="divider"></li>
                        <%-- jstl/core 判断 --%>
                        <c:if test="${user.userType == 'admin' }">
                            <li style="text-align: center">
                                <a class="waves-effect" href="javascript:;">管理员角色</a>
                            </li>
                        </c:if>
                        <c:if test="${user.userType == 'general' }">
                            <c:forEach items="${user.userRoles}" var="item">
                                <li style="text-align: center">
                                    <c:if test="${user.userRoles.size() <= 1}">
                                        <a class="waves-effect" href="javascript:;">${item.ROLE_NAME}</a>
                                    </c:if>
                                    <c:if test="${user.userRoles.size() > 1}">
                                        <a class="waves-effect" href="javascript:changeRole('${item.ROLE_ID}')">${item.ROLE_NAME}</a>
                                    </c:if>
                                </li>
                            </c:forEach>
                        </c:if>
                    </ul>
                </li>
                <%-- 系统设置 --%>
                <li class="dropdown">
                    <a class="waves-effect waves-light" data-toggle="dropdown" href="javascript:;">
                        <i class="him-icon zmdi zmdi-more-vert"></i>
                    </a>
                    <ul class="dropdown-menu pull-right dm-icon">
                        <li class="hidden-xs">
                            <a class="waves-effect" href="javascript:fullPage();">
                                <i class="zmdi zmdi-fullscreen"></i>全屏模式
                            </a>
                        </li>
                        <li>
                            <a class="waves-effect" href="javascript:Tab.addTab('模版查看','${pageContext.request.contextPath}/common/template');">
                                <i class="zmdi zmdi-account"></i>个人资料
                            </a>
                        </li>
                        <li>
                            <a class="waves-effect" href="javascript:Tab.addTab('模版查看','${pageContext.request.contextPath}/common/setting/manager');">
                                <i class="zmdi zmdi-settings"></i>系统设置
                            </a>
                        </li>
                        <li>
                            <a class="waves-effect waves-light" href="javascript:logout();">
                                <i class="zmdi zmdi-run"></i>退出登录
                            </a>
                        </li>
                    </ul>
                </li>
            </ul>
        </li>
    </ul>


</header>

<%-- 页面内容部分 --%>
<section id="main">
    <%-- 左边栏 --%>
    <aside id="sidebar"></aside>

    <%-- 内容区域--%>
    <section id="content"></section>
</section>
</body>
</html>
