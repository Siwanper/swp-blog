<%--
  Created by IntelliJ IDEA.
  User: ios
  Date: 2018/8/30
  Time: 下午5:07
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/common/global.jsp"%>
<%@ include file="/common/include_common.jsp"%>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>菜单管理</title>
    <style type="text/css">
        .layout_left {
            position: fixed;
            width: 320px;
            height: 100%;
            background: #FFFFFF;
            box-shadow: 1px 0px 4px rgba(0,0,0,0.3);
            -webkit-transition: all;
            -moz-transition: all ;
            -ms-transition: all ;
            -o-transition: all ;
            transition: all ;
            transition-duration: .3s;
            overflow-y: auto;
            z-index: 10;
        }

        .layout_right {
            position: fixed;
            width: calc(100% - 320px);
            height: 100%;
            background: #FFFFFF;
            left: 320px;
        }
    </style>
</head>
<body>
    <div class="layout_left" >
        <div class="toolBar" align="right" style="background: #F5F5F5">
            <a id="add-btn" class="waves-effect btn btn-info btn-sm" style="margin-left: 5px" href="javascript:menuAdd();"><i class="zmdi zmdi-plus"></i>添加</a>
            <a id="delete-btn" class="waves-effect btn btn-danger btn-sm" style="margin-left: 5px" href="javascript:menudelete();"><i class="zmdi zmdi-delete"></i>删除</a>
            <a id="fresh-btn" class="waves-effect btn btn-warning btn-sm" style="margin-left: 5px" href="javascript:menuAllRefresh();"><i class="zmdi zmdi-refresh"></i>刷新</a>
        </div>
        <div id="ztree" class="ztree"></div>
    </div>
    <div class="layout_right">
        <iframe id="content_iframe" class="tab_iframe"  frameborder="0" width="100%" height="800" scrolling="no"></iframe>
    </div>
</body>

<script type="text/javascript">

    var treeObj;
    var setting = {
        async: {
            enable:true,
            url:"${pageContext.request.contextPath}/commons/menu/menuTree",
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
            $("#content_iframe").attr("src","${pageContext.request.contextPath}/commons/menu/"+treeNode.id+"/edit");
        }
        lastSelected = treeNode.id;
        lastChecked = "click";
    }

    // 添加节点
    function menuAdd() {
        var nodes = treeObj.getSelectedNodes();
        if ("" == nodes) {
            $.alert("请选择对应的父菜单");
        } else {
            if (lastSelected != nodes[0].id || lastChecked != "add") {
                $("#content_iframe").attr("src","${pageContext.request.contextPath}/commons/menu/"+nodes[0].id+"/add");
            }
            lastSelected = nodes[0].id;
            lastChecked = "add";
        }
    }

    // 删除节点
    function menudelete() {
        var nodes = treeObj.getSelectedNodes();
        if ("" != nodes) {

            $.confirm({
                type:"red",
                animationSpeed:300,
                title:false,
                content:"确认删除["+nodes[0].name+"]菜单吗?",
                buttons : {
                    confirm : {
                        text : "确认",
                        btnClass: "waves-effect waves-button",
                        action: function () {
                            $.post("${pageContext.request.contextPath}/commons/menu/delete",{menuId:nodes[0].id, menuPid:nodes[0].pid},function (data) {
                                if('1' == data.status){
                                    menuParentsNodeRefresh();
                                }else{
                                    menuParentNodeRefresh();
                                }
                                $.alert(data.msg);
                            });
                        }
                    },
                    cancle: {
                        text: "取消",
                        btnClass: "waves-effect waves-button"
                    }
                }
            });

        } else {
            $.confirm({
                title: false,
                content: "请选择需要删除的菜单 ！",
                autoClose : "canle|3000",
                backgroundDismiss: true,
                buttons: {
                    cancle: {
                        text: "取消",
                        btnClass: "waves-effect waves-button"
                    }
                }
            });
        }
    }

    // 全部 tree 刷新
    function menuAllRefresh() {
        treeObj.reAsyncChildNodes(null,"refresh");
        lastChecked = "";
        lastSelected = "";
    }

    // 选中节点的父节点的父节点刷新
    function menuParentsNodeRefresh() {
        var nodes = treeObj.getSelectedNodes();
        if (nodes.length > 0) {
            treeObj.reAsyncChildNodes(nodes[0].getParentNode().getParentNode(),"refresh");
        }
        lastChecked = "";
        lastSelected = "";
    }

    // 选中节点的父节点刷新
    function menuParentNodeRefresh() {
        var nodes = treeObj.getSelectedNodes();
        if (nodes.length > 0) {
            treeObj.reAsyncChildNodes(nodes[0].getParentNode(),"refresh");
        }
        lastChecked = "";
        lastSelected = "";
    }

    // 选中节点的刷新
    function menuNodeRefresh() {
        var nodes = treeObj.getSelectedNodes();
        if (nodes.length > 0) {
            treeObj.reAsyncChildNodes(nodes[0],"refresh");
        }
        lastChecked = "";
        lastSelected = "";
    }

</script>

</html>
