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
    
    // 添加角色
    function roleAdd() {
        var nodes = treeObj.getSelectedNodes();
        if (nodes.length > 0) {
            if (lastSelected != nodes[0].id || lastSelected != "add") {
                $("#content_iframe").attr("src","${pageContext.request.contextPath}/commons/role/"+nodes[0].id+"/add");
            }
            lastSelected = nodes[0].id;
            lastChecked = "add";
        }else {
            $.alert("请选择对应的父节点");
        }
    }

    // 删除角色
    function roleDelete() {
        var nodes = treeObj.getSelectedNodes();
        if (nodes.length > 0) {
            $.confirm({
               type:"red",
                animationSpeed:300,
                title:false,
                content: "确认删除【"+nodes[0].name+"】角色吗？",
               buttons: {
                   confirm: {
                       text: "确认",
                       btnClass : "waves-effect waves-button",
                       action : function () {
                           $.post("${pageContext.request.contextPath}/commons/role/delete",{roleId:nodes[0].id,rolePid:nodes[0].pid},function (data) {
                               if (data.status == "1") {
                                   roleParentsNodeRefresh();
                               }else {
                                   roleParentNodeRefresh();
                               }
                               $.alert(data.msg);
                           });
                       }
                   },
                   cancle: {
                       text : "取消",
                       btnClass: "waves-effect waves-button"
                   }
               }
            });
        } else {
            $.alert("请选择对应的父节点");
        }
    }

    // 全部刷新
    function roleAllRefresh() {
        treeObj.reAsyncChildNodes(null, "refresh");
        lastChecked = "";
        lastSelected = "";
    }

    // 选中 tree 节点 父节点 的父节点刷新
    function roleParentsNodeRefresh() {
        var nodes = treeObj.getSelectedNodes();
        if (nodes.length > 0) {
            treeObj.reAsyncChildNodes(nodes[0].getParentNode().getParentNode(),"refresh");
        }
        lastChecked = "";
        lastSelected = "";
    }

    // 选中 tree 节点 父节点刷新
    function roleParentNodeRefresh() {
        var nodes = treeObj.getSelectedNodes();
        if (nodes.length > 0) {
            treeObj.reAsyncChildNodes(nodes[0].getParentNode(),"refresh");
        }
        lastChecked = "";
        lastSelected = "";
    }

    // 选中 tree 节点刷新
    function roleNodeRefresh() {
        var nodes = treeObj.getSelectedNodes();
        if (nodes.length > 0) {
            treeObj.reAsyncChildNodes(nodes[0],"refresh");
        }
        lastChecked = "";
        lastSelected = "";
    }

</script>

</html>
