<%--
  Created by IntelliJ IDEA.
  User: ios
  Date: 2018/9/7
  Time: 上午10:32
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
    <title>日志记录页面</title>
</head>
<body>

<div class="main">
    <div id="toolbar">
        <a class="waves-effect btn btn-danger btn-sm" style="margin-left: 10px" href="javascript:deleteAction();" ><i class="zmdi zmdi-close"></i> 清空日志</a>
    </div>
    <table id="table"></table>
</div>
</body>

<script type="text/javascript">
    var $table = $("#table");
    $(function () {
       $table.bsTable({
           url:"${pageContext.request.contextPath}/commons/logging/list", // 请求后台的url
           idField:'eventId',
           search:true,
           classes:'table table-hover table-no-bordered',
           columns:[
               {field:'timestmp',title:'时间戳',align:"center"},
               {field:'levelString',title:'日志级别',align:"center"},
               {field:'callerFilename',title:'执行类',align:"center"},
               {field:'formattedMessage',title:'日志内容',align:"left",formatter:function (value, row, index) {
                       var res;
                       if(value.length > 72){
                           res = value.substring(0, 72)+'...';
                       }else{
                           res = value;
                       }
                       return res;
               }},
               {field:'action',title:'操作',align:"center",formatter:'actionFormatter',events:'actionEvents',clickToSelect:false},
           ]
       });
    });

    function actionFormatter(value, row, index) {
        return [
            '<a class="detail ml10" href="javascript:void(0)" data-toggle="tooltip" title="查看"><i class="glyphicon glyphicon-search"></i></a>　'
        ].join('');
    }

    window.actionEvents = {
        'click .detail': function (e, value, row, index) {
            alert(JSON.stringify(row.formattedMessage));
            //console.log(value, row, index);
        }
    };

    function detailFormatter(index, row) {
        var html = [];
        $.each(row, function (key, value) {
            html.push('<p><b>' + key + ':</b> ' + value + '</p>');
        });
        return html.join('');
    }

    // 删除
    function deleteAction() {
        $.confirm({
            type: 'red',
            animationSpeed: 300,
            title: false,
            content: '确认清空全部日志吗？',
            buttons: {
                confirm: {
                    text: '确认',
                    btnClass: 'waves-effect waves-button',
                    action: function () {
                        $.post('${pageContext.request.contextPath}/commons/logging/clear',null,function(data){
                            $table.bootstrapTable('refresh');
                        });
                    }
                },
                cancel: {
                    text: '取消',
                    btnClass: 'waves-effect waves-button'
                }
            }
        });
    }

</script>

</html>
