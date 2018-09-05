<%@ page language="java" contentType="text/html;charset=UTF-8"
         pageEncoding="UTF-8" %>
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
        <a class="waves-effect btn btn-info btn-sm" href="javascript:addAction();"><i class="zmdi zmdi-plus"></i> 新增用户</a>
        <a class="waves-effect btn btn-warning btn-sm" href="javascript:editAction();"><i class="zmdi zmdi-edit"></i>
            编辑用户</a>
        <a class="waves-effect btn btn-danger btn-sm" href="javascript:deleteAction();"><i class="zmdi zmdi-delete"></i>
            删除用户</a>
        <a class="waves-effect btn btn-primary btn-sm" href="javascript:roleAction();"><i class="zmdi zmdi-male"></i>
            用户角色</a>
    </div>
    <table id="table"></table>
</div>

<div class="modal fade" id="addUserModal" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    &times;
                </button>
                <h4>添加用户</h4>
            </div>
            <div class="modal-body">
                <iframe id="content_iframe" class="tab_iframe" frameborder="0" width="740" height="800" scrolling="no"></iframe>
            </div>
            <div class="modal-footer">
                <button class="btn btn-default btn-sm" type="button" data-dismiss="modal"><i
                        class="zmdi zmdi-close"></i> 关闭
                </button>
                <button id="saveUserBtn" class="btn btn-success btn-sm" type="button" href="javascript:;"><i
                        class="zmdi zmdi-save"></i> 确定
                </button>
            </div>
        </div>
    </div>
</div>

<%--用户角色--%>
<div class="modal fade" id="roleModal" tabindex="-1" role="dialog" aria-hidden="true" data-backdrop='static'>
    <div class="modal-dialog">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                x
            </button>
            <h4 id="roleModalTitle" class="modal-title">
                用户拥有的角色
            </h4>
        </div>
        <div class="modal-body">
            <div id="roleZtree" class="ztree"></div>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-default btn-sm" data-dismiss="modal">
                <i class="zmdi zmdi-close"></i>关闭
            </button>
            <button id="roleSaveBtn" class="waves-effect btn btn-success btn-sm" style="margin-left: 10px;"
                    type="button" href="javascript:;">
                <i class="zmdi zmdi-save"></i> 保存
            </button>
        </div>
    </div>
</div>


</body>

<script type="text/javascript">

    var $table = $('#table');
    var treeObj;
    var userId;
    $(function () {
        // 列表数据
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
                {
                    field: 'userValid', title: '是否有效', align: 'center', formatter: function (value, row, index) {
                        if (value) {
                            return '<span class="label label-info">正常</span>';
                        } else {
                            return '<span class="label label-danger">失效</span>';
                        }
                    }
                }
            ]
        });

        $("#saveUserBtn").click(function () {
            var bv = $("#dataForm").data("bootstrapValidator");
            bv.validate();
            if(bv.isValid()) {
                var formData = $("#dataForm").serializeArray();
                $.post("${pageContext.request.contextPath}/commons/user/save",formData,function (data) {
                    $table.bootstrapTable("refresh");
                    resetForm();
                    $("#addUserModal").modal("hide");
                    $.alert(data.msg);
                });
            }
        });

    });

    function addAction() {
        $.post("${pageContext.request.contextPath}/commons/user/add",function () {
            $("#dataForm").refresh();
            $("#content_iframe").attr("src","${pageContext.request.contextPath}")
            $("#addUserModal").modal("show");
        });
    }

    // 编辑用户
    function editAction() {
        var rows = $table.bootstrapTable('getSelections');
        if (rows.length == 0) {
            $.confirm({
                title:false,
                content:'请选择需要编辑的用户',
                autoClose:'cancel|3000',
                backgroundDismiss:true,
                buttons:{
                    cancel:{
                        text:'取消',
                        btnClass:'waves-effect waves-button'
                    }
                }
            });
        } else {
            var user = rows[0];
            $.post("${pageContext.request.contextPath}/commons/user/edit",{"userId":user.userId},function () {
                $("#dataForm").refresh();
                $("#addUserModal").modal("show");
            });
        }
    }

    // 删除
    function deleteAction() {
        var rows = $table.bootstrapTable('getSelections');
        if (rows.length == 0) {
            $.confirm({
               title:false,
               content:'请至少选择一条记录',
                autoClose:'cancel|3000',
                backgroundDismiss:true,
                buttons:{
                   cancel:{
                       text:'取消',
                       btnClass:'waves-effect waves-button'
                   }
                }
            });
        } else {
            var idArray = new Array();
            for(var i in rows){
                idArray.push(rows[i].userId);
                var userType = rows[i].userType;
                if (userType == "admin"){
                    $.alert("不能删除admin用户");
                    return;
                }
            }
            $.confirm({
                type:'red',
                animationSpeed:300,
                title:false,
                content:'确认删除该用户吗?',
                buttons:{
                    confirm:{
                        text:'确认',
                        btnClass:'waves-effect waves-button',
                        action:function () {
                            var ids = idArray.join(',');
                            $.post('${pageContext.request.contextPath}/commons/user/delete',{'ids':ids},function (data) {
                                $table.bootstrapTable("refresh");
                            });
                        }
                    },
                    cancel: {
                        text: '取消',
                        btnClass: 'waves-effect waves-button'
                    }
                }
            })
        }
    }

    // 用户角色
    // function roleAction() {
    //     var rows = $table.bootstrapTable('getSelections');
    //     if (rows.length == 0) {
    //         $.confirm({
    //            title:false,
    //            content:'请至少选择一条记录',
    //            autoClose:'cancel|3000',
    //            backgroundDismiss:true,
    //             buttons:{
    //                cancel:{
    //                    text:'取消',
    //                    btnClass:'waves-effect waves-button'
    //                }
    //             }
    //         });
    //     } else {
    //         var row = rows[0];
    //         if ('admin' == row.userType) {
    //             $.alert('您不能编辑管理员的角色');
    //         }else {
    //             userId = row.userId;
    //             $('#roleModalTitle').html('用户['+row.userName+']拥有的角色');
    //             loadRoleTree();
    //         }
    //     }
    // }

    // 加载用户角色tree结构
    <%--function loadRoleTree() {--%>
    <%--var setting = {--%>
    <%--async : {--%>
    <%--enable:true,--%>
    <%--url:'${pageContext.request.contextPath}/common/role/roleCheckedTree',--%>
    <%--autoParam:['id','pid','name','level'],--%>
    <%--otherParam:{'userId':userId}--%>
    <%--},--%>
    <%--check: {--%>
    <%--enable:true,--%>
    <%--chkStyle:'checkbox',--%>
    <%--chkboxStype:{'Y':'s',"N":'s'}--%>
    <%--},--%>
    <%--view:{--%>
    <%--fontCss:setFontCss--%>
    <%--}--%>
    <%--}--%>
    <%--treeObj = $.fn.zTree.init($('#roleZtree'),setting);--%>
    <%--// 设置样式--%>
    <%--function setFontCss(treeId, treeNode) {--%>
    <%--return treeNode.valid == false ? {color:"red"} : {};--%>
    <%--};--%>
    <%--$('#roleModal').modal('show');--%>
    <%--}--%>

    // 重置表单
    function resetForm() {
        // 清空 form 表单值
        $('#userCode').val('');
        $('#userName').val('');
        $('#userPassword').val('');
        $('#userAddress').val('');
        $('#userEmail').val('');
        $("#userPhone").val("");
        $('#userBirthday').val('');
        $('#userPhoto').val('');
        $('#userValid').selectpicker('val', 'true');

        // 验证销毁
        $("#dataForm").data('bootstrapValidator').destroy();
        $('#dataForm').data('bootstrapValidator', null);
    }



</script>

</html>