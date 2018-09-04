<%--
  Created by IntelliJ IDEA.
  User: ios
  Date: 2018/9/3
  Time: 上午11:54
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/common/global.jsp" %>
<%@ include file="/common/include_common.jsp" %>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>角色资源添加或修改</title>
</head>
<body>

<div id="toolbar" class="toolbar" style="background: #F5F5F5" align="left">
    <button id="save-btn" class="waves-effect btn btn-success btn-sm" type="button" style="margin-left: 10px"
            href="javascript:;"><i class="zmdi zmdi-save"></i>保存
    </button>
    <c:if test="${role.roleType == 'role'}">
        <button id="resource-btn" class="waves-effect btn btn-info btn-sm" type="button" style="margin-left: 10px"
                data-toggle="modal" data-target="#menuModal" href="javascript:;"><i class="zmdi zmdi-save"></i>菜单资源
        </button>
    </c:if>
</div>
<form id="dataForm" method="post">
    <div class="container col-xs-11" style="margin-top: 30px; margin-left: 50px;">
        <div class="row" style="margin-top: 10px; margin-bottom: 10px">
            <div class="col-xs-4 text-left" style="background: #E6E6F2; line-height: 26px; vertical-align: middle">
                <label style="margin-top: 5px; font-size: 14px; color:grey">角色名称：</label>
            </div>
            <div class="col-xs-7">
                <input id="roleName" class="form-control" name="roleName" type="text" value="${role.roleName}"
                       placeholder="角色树显示的名称（必填）"/>
            </div>
        </div>
        <div class="row" style="margin-top: 10px; margin-bottom: 10px">
            <div class="col-xs-4 text-left" style="background: #E6E6F2; line-height: 26px; vertical-align: middle">
                <label style="margin-top: 5px; font-size: 14px; color:grey">排序：</label>
            </div>
            <div class="col-xs-7">
                <input id="roleIndex" class="form-control" name="roleIndex" type="text" value="${role.roleIndex}"
                       placeholder="整数，按从小到大顺序排列"/>
            </div>
        </div>
        <div class="row" style="margin-top: 10px; margin-bottom: 10px">
            <div class="col-xs-4 text-left" style="background: #E6E6F2; line-height: 26px; vertical-align: middle">
                <label style="margin-top: 5px; font-size: 14px; color:grey">域级次：</label>
            </div>
            <div class="col-xs-7">
                <c:if test="${role.roleLevel == 1}">
                <button disabled="disabled" class="btn btn-danger">level
                    </c:if>
                    <c:if test="${role.roleLevel == 2}">
                    <button disabled="disabled" class="btn btn-warning">level
                        </c:if>
                        <c:if test="${role.roleLevel == 3}">
                        <button disabled="disabled" class="btn btn-primary">level
                            </c:if>
                            <c:if test="${role.roleLevel != 1 && role.roleLevel != 2 && role.roleLevel != 3}">
                            <button disabled="disabled" class="btn btn-info">level
                                </c:if>
                                <span class="badge">${role.roleLevel}</span>
                            </button>
            </div>
        </div>
        <div class="row" style="margin-top: 10px; margin-bottom: 10px">
            <div class="col-xs-4 text-left" style="background: #E6E6F2; line-height: 26px; vertical-align: middle">
                <label style="margin-top: 5px; font-size: 14px; color:grey">类型：</label>
            </div>
            <div class="col-xs-7">
                <select id="roleType" name="roleType" class="selectpicker">
                    <option value="group">角色组</option>
                    <option value="role">角色</option>
                </select>
            </div>
        </div>
        <div class="row" style="margin-top: 10px; margin-bottom: 10px">
            <div class="col-xs-4 text-left" style="background: #E6E6F2; line-height: 26px; vertical-align: middle">
                <label style="margin-top: 5px; font-size: 14px; color:grey">状态：</label>
            </div>
            <div class="col-xs-7">
                <select id="roleValid" name="roleValid" class="selectpicker">
                    <option value="true">有效</option>
                    <option value="false">无效</option>
                </select>
            </div>
        </div>
        <div class="row" style="margin-top: 10px; margin-bottom: 10px; display: none">
            <input type="hidden" id="roleId" name="roleId" value="${role.roleId}">
            <input type="hidden" id="rolePid" name="rolePid" value="${role.rolePid}">
            <input type="hidden" id="roleLevel" name="roleLevel" value="${role.roleLevel}">
        </div>
    </div>
</form>

<div class="modal fade" id="menuModal" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    &times;
                </button>
                <h4>${role.roleName}拥有的菜单资源</h4>
            </div>
            <div class="modal-body">
                <div id="menuZtree" class="ztree"></div>
            </div>
            <div class="modal-footer">
                <button id="menuCloseBtn" class="btn btn-default btn-sm" type="button" data-dismiss="modal"><i
                        class="zmdi zmdi-close"></i>关闭
                </button>
                <button id="saveMenuBtn" class="btn btn-success btn-sm" type="button" href="javascript:;"><i
                        class="zmdi zmdi-save"></i>保存
                </button>
            </div>
        </div>
    </div>
</div>

</body>

<script type="text/javascript">
    $(function () {
        $("#roleType").selectpicker("val", "${role.roleType}");
        $("#roleValid").selectpicker("val", "${role.roleValid}");

        $("form").bootstrapValidator({
            container: "popover",
            message: "This value is not valid",
            feedbackIcons: {
                valid: 'glyphicon glyphicon-ok',
                invalid: 'glyphicon glyphicon-remove',
                alidating: 'glyphicon glyphicon-refresh'
            },
            fields: {
                "roleName": {
                    validators: {
                        notEmpty: {
                            message: "角色名称不能为空"
                        },
                        stringLength: {
                            min: 1,
                            max: 36
                        },
                    }
                },
                "roleIndex": {
                    validators: {
                        integer: {
                            message: "请输入整形类型"
                        }
                    }
                }
            }
        });

        // 保存提交
        $("#save-btn").click(function () {
            if ("" == $("#roleId").val() && "" == $("#rolePid").val()) {
                $.alert("请选择左侧角色节点");
                return;
            }
            // 进行表单验证
            var bv = $("#dataForm").data("bootstrapValidator");
            bv.validate();
            if (bv.isValid()) {
                var formData = $("#dataForm").serializeArray();
                $.post("${pageContext.request.contextPath}/commons/role/save", formData, function (data) {
                    if ("0" == data.status) {
                        parent.roleNodeRefresh();
                        resetForm();
                    } else {
                        parent.roleParentNodeRefresh();
                    }
                    $.alert(data.msg);
                });
            }
        });

        // 重置表单
        function resetForm() {
            // 清空 form 表单值
            $('#roleId').val('');
            $('#rolePid').val('');
            $('#roleName').val('');
            $('#roleIndex').val('');
            $('#roleLevel').val('');
            $('#roleValid').selectpicker('val', 'true');

            // 验证销毁
            $("#dataForm").data('bootstrapValidator').destroy();
            $('#dataForm').data('bootstrapValidator', null);

            // 警告提示框
            $('#noSelDiv').show();
        }

        // 菜单资源 tree 构建
        var treeObj;
        var settiing = {

            async: {
                enable: true,
                url: "${pageContext.request.contextPath}/commons/menu/menuCheckedTree",
                autoParam: ["id", "pid", "name", "level"],
                otherParam: {"roleId": $("#roleId").val()}
            },
            check: {
                enable: true,
                chkStyle: "checkbox",
                chkboxType: {"Y": "s", "N": "s"}
            },
            view : {
                fontCss: setFontCss
            }

        };
        treeObj = $.fn.zTree.init($("#menuZtree"), settiing);

        function setFontCss(treeId, treeNode) {
            return treeNode.valid == false ? {color : "red"} : {};
        }

        // 保存角色资源菜单
        $("#saveMenuBtn").click(function () {
           var nodes = treeObj.getCheckedNodes();
           var menuStr = "";
           $.map(nodes, function (item, index) {
               menuStr += "," + item.id;
           });
           $.post("${pageContext.request.contextPath}/commons/role/saveRoleMenu",{"roleId":$("#roleId").val(),"menuIds":menuStr.substr(1)},function (data) {
                $("#menuModal").modal("hide");
                $.alert(data.msg);
           });
        });

    });

</script>

</html>
