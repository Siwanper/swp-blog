<%@ page language="java" contentType="text/html;charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ include file="/common/global.jsp" %>
<%@ include file="/common/include_common.jsp" %>
<html lang="zh-cn">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>用户管理</title>
</head>
<body>
<div id="main">
    <div id="toolbar">
        <a class="waves-effect btn btn-info btn-sm" href="javascript:addAction();" ><i class="zmdi zmdi-plus"></i> 新增用户</a>
        <a class="waves-effect btn btn-warning btn-sm" href="javascript:editAction();" ><i class="zmdi zmdi-edit"></i> 编辑用户</a>
        <a class="waves-effect btn btn-danger btn-sm" href="javascript:deleteAction();" ><i class="zmdi zmdi-delete"></i> 删除用户</a>
        <a class="waves-effect btn btn-primary btn-sm" href="javascript:roleAction();" ><i class="zmdi zmdi-male"></i> 用户角色</a>
    </div>
    <table id="table"></table>
</div>

</body>

<script type="text/javascript">

    var $table = $('#table');
    var treeObj;
    var userId;
    $(function() {

        $table.bsTable({
            url: '${pageContext.request.contextPath}/commons/user/list',
            idField: 'userCode',// 指定主键列
            singleSelect: true,
            search: true,
            columns: [
                {field: 'state', checkbox: true},
                {field: 'userCode', title: '用户名', align: 'center'},
                {field: 'userName', title: '姓名', align: 'center'},
                {field: 'userAddress', title: '地址', align: 'center'},
                {field: 'userEmail', title: '邮箱', align: 'center'},
                {field: 'userPhone', title: '电话', align: 'center'},
                {field: 'userBirthday', title: '生日', align: 'center'},
                {field: 'userJoindate', title: '注册时间', align: 'center'},
                {field: 'userPhoto', title: '照片', align: 'center'},
                {field: 'userType', title: '用户类型', align: 'center'},
                {field: 'userValid', title: '是否有效', align: 'center', formatter: function(value, row, index){
                        if(value){
                            return '<span class="label label-info">正常</span>';
                        }else {
                            return '<span class="label label-danger">失效</span>';
                        }
                    }}
            ]
        });

    });

</script>

</html>