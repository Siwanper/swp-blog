<%--
  Created by IntelliJ IDEA.
  User: ios
  Date: 2018/9/12
  Time: 下午4:05
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
    <title>产品管理</title>
</head>
<body>
    <div id="main">
        <div id="toolbar">
            <a class="waves-effect btn btn-info btn-sm" href="javascript:addAction();"><i class="zmdi zmdi-plus"></i>添加产品</a>
            <a class="waves-effect btn btn-success btn-sm" href="javascript:saveAction();"><i class="zmdi zmdi-save"></i>保存产品</a>
            <a class="waves-effect btn btn-warning btn-sm" href="javascript:editAction();"><i class="zmdi zmdi-edit"></i>编辑产品</a>
            <a class="waves-effect btn btn-danger btn-sm" href="javascript:deleteAction();"><i class="zmdi zmdi-delete"></i>删除产品</a>
        </div>
        <table id="table"></table>
    </div>

    <!-- 新增 -->
    <div id="createDialog" class="crudDialog" hidden>
        <form>
            <div class="form-group">
                <label for="input1">标题</label>
                <input id="input1" type="text" class="form-control">
            </div>
            <div class="form-group">
                <label for="input2">名称</label>
                <input id="input2" type="text" class="form-control">
            </div>
            <div class="form-group">
                <label for="input3">根目录</label>
                <input id="input3" type="text" class="form-control">
            </div>
            <div class="form-group">
                <label for="input4">图标</label>
                <input id="input4" type="text" class="form-control">
            </div>
        </form>
    </div>
</body>

<script type="text/javascript">
    var $table = $("#table");
    $(function () {
        $table.bsTable({
            toolbar:"#toolbar",
            idField:"productCode",
            search:true,
            url:"${pageContext.request.contextPath}/module/product/list",
            columns : [
                {field : 'state', checkbox:true},
                {field: 'productName', title: '产品名称', align: 'center'},
                {field: 'productPrice', title: '产品价格', align: 'center'},
                {field: 'productNum', title: '产品数量', align: 'center'},
                {field: 'productUser', title: '操作人员', align: 'center'},
                {field: 'productDate', title: '操作时间', align: 'center'},
                {field: 'productType', title: '产品类型', align: 'center'},
                {field: 'productStatus', title: '产品状态', align: 'center', formatter : function (value, row, index) {
                    if (value) {
                        return '<span class="label label-sm label-info">有效</span>';
                    } else {
                        return '<span class="label label-sm label-info">无效</span>';
                    }
                } },
                {field: 'action', title:"操作", align:"center",formatter:"actionFormatter",events:"actionEvents",clickToSelect:false}
            ],
        });
    });
    function actionFormatter(value, row, index) {
        return [
            '<a class="edit ml10" href="javascript:void(0)" data-toggle="tooltip" title="编辑"><i class="glyphicon glyphicon-edit"></i></a>　',
            '<a class="remove ml10" href="javascript:void(0)" data-toggle="tooltip" title="删除"><i class="glyphicon glyphicon-remove"></i></a>'
        ].join('');
    }
    window.actionEvents = {
        'click .edit': function (e, value, row, index) {
            alert('You click edit icon, row: ' + JSON.stringify(row));
            console.log(value, row, index);
        },
        'click .remove': function (e, value, row, index) {
            alert('You click remove icon, row: ' + JSON.stringify(row));
            console.log(value, row, index);
        }
    };
    // 新增
    function addAction() {
        $.confirm({
            type: 'dark',
            animationSpeed: 300,
            title: '新增系统',
            content: $('#createDialog').html(),
            buttons: {
                confirm: {
                    text: '确认',
                    btnClass: 'waves-effect waves-button',
                    action: function () {
                        $.alert('确认');
                    }
                },
                cancel: {
                    text: '取消',
                    btnClass: 'waves-effect waves-button'
                }
            }
        });
    }
    // 编辑
    function editAction() {
        var rows = $table.bootstrapTable('getSelections');
        if (rows.length == 0) {
            $.confirm({
                title: false,
                content: '请至少选择一条记录！',
                autoClose: 'cancel|3000',
                backgroundDismiss: true,
                buttons: {
                    cancel: {
                        text: '取消',
                        btnClass: 'waves-effect waves-button'
                    }
                }
            });
        } else {
            $.confirm({
                type: 'blue',
                animationSpeed: 300,
                title: '编辑系统',
                content: $('#createDialog').html(),
                buttons: {
                    confirm: {
                        text: '确认',
                        btnClass: 'waves-effect waves-button',
                        action: function () {
                            $.alert('确认');
                        }
                    },
                    cancel: {
                        text: '取消',
                        btnClass: 'waves-effect waves-button'
                    }
                }
            });
        }
    }
    // 删除
    function deleteAction() {
        var rows = $table.bootstrapTable('getSelections');
        if (rows.length == 0) {
            $.confirm({
                title: false,
                content: '请至少选择一条记录！',
                autoClose: 'cancel|3000',
                backgroundDismiss: true,
                buttons: {
                    cancel: {
                        text: '取消',
                        btnClass: 'waves-effect waves-button'
                    }
                }
            });
        } else {
            $.confirm({
                type: 'red',
                animationSpeed: 300,
                title: false,
                content: '确认删除该系统吗？',
                buttons: {
                    confirm: {
                        text: '确认',
                        btnClass: 'waves-effect waves-button',
                        action: function () {
                            var ids = new Array();
                            for (var i in rows) {
                                ids.push(rows[i].systemId);
                            }
                            $.alert('删除：id=' + ids.join("-"));
                        }
                    },
                    cancel: {
                        text: '取消',
                        btnClass: 'waves-effect waves-button'
                    }
                }
            });
        }
    }

</script>

</html>
