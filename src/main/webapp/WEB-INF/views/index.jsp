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
    <style>
        .s-profile > a {
            background: url(${pageContext.request.contextPath}/resources/images/background.png) left top no-repeat;
        }
    </style>
</head>
<body>

<%-- 角色选择 --%>
<div id="selRoleModal" class="modal fade" tabindex="-1" role="dialog" aria-hidden="true" data-backdrop="static">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h4 id="selRolModalTitle" class="modal-title">
                    请选择用户角色
                </h4>
            </div>
            <div class="modal-body">
                <select id="userRole" name="userRole" class="selectpicker">
                    <c:forEach items="${user.userRoles}" var="item">
                        <option value="${item.ROLE_ID}">${item.ROLE_NAME}</option>
                    </c:forEach>
                </select>
            </div>
            <div class="modal-footer">
                <button id="selRole-btn" type="button" class="waves-effect btn btn-success btn-sm"
                        style="margin-left: 10px"
                        href="javascript:void(0)">
                    <i class="zmdi zmdi-save"></i> 确定
                </button>
            </div>
        </div>
    </div>
</div>

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
                                <input id="keywords" type="text" name="keywords" class="form-control"
                                       placeholder="search">
                                <div class="input-group-btn">
                                    <button type="submit" class="btn btn-default"><span
                                            class="glyphicon glyphicon-search"></span></button>
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
                                        <a class="waves-effect"
                                           href="javascript:changeRole('${item.ROLE_ID}')">${item.ROLE_NAME}</a>
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
                            <a class="waves-effect"
                               href="javascript:Tab.addTab('模版查看','${pageContext.request.contextPath}/common/template');">
                                <i class="zmdi zmdi-account"></i>个人资料
                            </a>
                        </li>
                        <li>
                            <a class="waves-effect"
                               href="javascript:Tab.addTab('模版查看','${pageContext.request.contextPath}/common/setting/manager');">
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
    <aside id="sidebar">
        <%--个人资料区--%>
        <div class="s-profile">
            <a class="waves-effect waves-light" href="javascript:;">
                <div class="sp-pic">
                    <img src="${pageContext.request.contextPath}/resources/images/avatar.png">
                </div>
                <div class="sp-info">
                    ${user.userName},hello!
                    <i class="zmdi zmdi-caret-down"></i>
                </div>
            </a>
            <ul class="main-menu">
                <li>
                    <a class="waves-effect"
                       href="javascript:Tab.addTab('模版查看','${pageContext.request.contextPath}/common/personal/manage')">
                        <i class="zmdi zmdi-account"></i>个人资料
                    </a>
                    <a class="waves-effect"
                       href="javascript:Tab.addTab('模版查看','${pageContext.request.contextPath}/common/setting/manage')">
                        <i class="zmdi zmdi-settings"></i>系统设置
                    </a>
                    <a class="waves-effect" href="javascript:logout()">
                        <i class="zmdi zmdi-run"></i>退出登录
                    </a>
                </li>
            </ul>
        </div>
        <%--/个人资料区--%>

        <%-- 菜单区 --%>
        <ul id="main-menu" class="main-menu">
            <li>
                <a class="waves-effect" href="javascript:Tab.addTab('首页','home');">
                    <i class="zmdi zmdi-home"></i>首页
                </a>
            </li>
            <li class="sub-menu system_menus">
                <a class="waves-effect" href="javascript:;"><i class="zmdi zmdi-accounts"></i>角色用户管理 </a>
                <ul>
                    <li>
                        <a class="waves-effect" href="javascript:Tab.add('角色管理','${pageContext.request.contextPath}/manage/role/index');">
                            角色管理
                        </a>
                    </li>
                    <li>
                        <a class="waves-effect" href="javascript:Tab.add('用户管理','${pageContext.request.contextPath}/common/user/init');">
                            用户管理
                        </a>
                    </li>
                    <li>
                        <a class="waves-effect" href="javascript:Tab.add('产品管理','${pageContext.request.contextPath}/demo/product/init');">
                            产品管理
                        </a>
                    </li>
                </ul>
            </li>
            <li class="sub-menu system_menus">
                <a class="waves-effect" href="javascript:;"><i class="zmdi zmdi-lock-outline"></i>权限资源管理 </a>
                <ul>
                    <li>
                        <a class="waves-effect" href="javascript:Tab.add('权限管理','${pageContext.request.contextPath}/manage/resoures/index');">
                            权限管理
                        </a>
                    </li>
                    <li>
                        <a class="waves-effect" href="javascript:Tab.add('菜单管理','${pageContext.request.contextPath}/common/menu/init');">
                            菜单管理
                        </a>
                    </li>
                </ul>
            </li>
            <li class="sub-menu system_menus">
                <a class="waves-effect" href="javascript:;"><i class="zmdi zmdi-more"></i>其他数据管理 </a>
                <ul>
                    <li>
                        <a class="waves-effect" href="javascript:Tab.add('日志记录','${pageContext.request.contextPath}/common/logging/init');">
                            日志记录
                        </a>
                    </li>
                    <li>
                        <a class="waves-effect" href="javascript:Tab.add('模版查看','${pageContext.request.contextPath}/common/template');">
                            模版查看
                        </a>
                    </li>
                </ul>
            </li>
            <div class="upms-version">
                &copy;Siwanper Blog V1.0.0
            </div>
        </ul>
        <%-- /菜单区 --%>
    </aside>

    <%-- 内容区域--%>
    <section id="content">
        <div class="content_tab">
            <div class="tab_left">
                <a class="waves-effect waves-light" href="javascript:;"><i class="zmdi zmdi-chevron-left"></i></a>
            </div>
            <div class="tab_right">
                <a class="waves-effect waves-light" href="javascript:;"><i class="zmdi zmdi-chevron-right"></i></a>
            </div>
            <ul id="tabs" class="tabs">
                <li id="tab_home" data-index="home" data-closeable="false" class="cur">
                    <a class="waves-effect waves-light">首页</a>
                </li>
            </ul>
        </div>
        <div class="content_main">
            <div id="iframe_home" class="iframe_cur">
                <p><h4>Siwanper</h4></p>
                <p><b>本项目是一个整合 SpringMVC+Spring+MyBatis（SSM）框架的Demo</b></p>
                <p><b>拥有高效率便捷开发模式，使开发人员更专注于业务，达到面向业务开发</b></p>
                <p><b>项目使用 Maven 构建，便于项目管理，支持 Oracle、MySql 等主流数据库</b></p>
                <p><b>前端展示界面采用基于 Boostrap 实现的响应式布局，并集成了一系列的动画效果插件，整体界面简洁、美观大方并可优雅的与后台完成交互操作</b></p>
                <p><b>项目封装了一系列常用方法、部署运行简单，便于个人或企业进行高效开发</b></p>
                <p><b>代码已托管至<a href="https://github.com/Siwanper/swp-blog" target="_blank"> github</a>可下载进行查看</b></p>
                <p>Created by Siwanper Since 2017</p>
            </div>
        </div>
    </section>
</section>

<%-- 页面尾部 --%>
<footer class="footer"></footer>

<script type="text/javascript">
    var roleSize = '${user.userRoles.size() }';
    if (roleSize > 1) {
        $('#selRoleModal').modal('show');
    } else {
        loadMenu(null);
    }
    $('#selRole-btn').click(function () {
        var roleId = $('#userRole').val();
        loadMenu(roleId);
        $('#selRoleModal').modal('hide');
    });

    function changeRole(roleId) {
        loadMenu(roleId);
    }

    function logout() {
        $.confirm({
            type:'grey',
            animationSpeed:300,
            title:false,
            content:'您确认要退出系统吗?',
            buttons:{
                confirm: {
                    text:'确认',
                    btnClass:"waves-effect waves-button",
                    action: function () {
                        location.href = "${pageContext.request.contextPath}/common/login/signout";
                    }
                },
                cancel:{
                    text:'取消',
                    btnClass:'waves-effect waves-button'
                }
            }
        });
    }

    function loadMenu(roleId) {
        // Yan左侧菜单数据初始化
        var menuHtml = "<li><a class='waves-effect' href='javascript:Tab.addTab(\"首页\", \"home\");'><i class='zmdi zmdi-home'></i> 首页</a></li>";
        $.post('${pageContext.request.contextPath}/' + roleId + '/menu', null, function (data) {

            $.each(data, function (index, item) {
                menuHtml += "<li class='sub-menu system_menus'><a class='waves-effect'><i class='" + item.icon + "'></i> " + item.name + "</a><ul>";
                $.each(item.children, function (ids, itm) {
                    menuHtml += "<li><a class='waves-effect' href='javascript:Tab.addTab(\"" + itm.name + "\", \"${pageContext.request.contextPath}" + itm.url + "\");'>" + itm.name + "</a></li>";
                });
                menuHtml += "</ul></li>";
            });
            menuHtml += "<li><div class='upms-version'>&copy; YAN FRAME V1.0</div></li>";
            alert(menuHtml);
            $('#main-menu').html(menuHtml);
        });
    }
</script>

</body>
</html>
