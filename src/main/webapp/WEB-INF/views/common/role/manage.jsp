<%--
  Created by IntelliJ IDEA.
  User: ios
  Date: 2018/8/27
  Time: 下午2:06
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
    <title>角色管理</title>
    <style type="text/css">
        .layout-left {
            position: fixed;
            width: 320px;
            background: #FFFFFF;
            height: 100%;
            -webkit-transition: all;
            -moz-transition: all ;
            -ms-transition: all ;
            -o-transition: all ;
            transition: all ;
            transition-duration: .3s;
            z-index: 10;
            overflow-y: auto;
            box-shadow: 1px 0 4px rgba(0,0,0,.3);
        }
        .layout-right{
            position: fixed;
            width: calc(100% - 320px);
            background: #FFFFFF;
            left: 320px;
            height: 100%;
        }
    </style>
</head>
<body>
    <div class="layout-left">
        <div id="toolbar" align="right" style="background: #f5f5f5">
            <a id="add-btn" class="waves-effect btn btn-info btn-sm" style="margin-right: 5px;" href="javascript:roleAdd();"><i class="zmdi zmdi-plus"></i>添加</a>
            <a id="delete-btn" class="waves-effect btn btn-danger btn-sm" style="margin-right: 5px;" href="javascript:roleDelete();"><i class="zmdi zmdi-delete"></i>删除</a>
            <a id="edit-btn" class="waves-effect btn btn-warning btn-sm" style="margin-right: 5px;" href="javascript:roleAllRefresh();"><i class="zmdi zmdi-refresh"></i>刷新</a>
        </div>
        <div id="ztree" class="ztree"></div>
    </div>
    <div class="layout-right">
        <iframe id="content_iframe" class="tab_iframe" frameborder="0" width="740" height="800" scrolling="no"></iframe>
    </div>
</body>

<script type="text/javascript">
    var treeObj;
    var setting = {
        async: {
            enable:true,
            url:"${pageContext.request.contextPath}/commons/role/roleTree",
            autoParam:["id","pid","name","level"]
        },
        view: {
            fontCss:setFontCss,
        },
        callback:{
            onClick: zTreeOnClick
        }
    };
    treeObj = $.fn.zTree.init($("#ztree"),setting);
    function setFontCss(treeId, treeNode) {
        return treeNode.valid == false ? {color:"red"}:{};
    }

    var lastSelected;
    var lastChecked;

    // tree 点击事件
    function zTreeOnClick(event, treeId, treeNode) {
        if (0 == treeNode.level) {
            $("#delete-btn").hide();
        } else {
            $("#delete-btn").show();
        }
        if (lastSelected != treeNode.id || lastChecked != 'click') {
            $("#content_iframe").attr("src","${pageContext.request.contextPath}/commons/role/"+treeNode.id+"/edit");
        }
        lastSelected = treeNode.id;
        lastChecked = "click";
    }

</script>

</html>
