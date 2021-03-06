<%--
  Created by IntelliJ IDEA.
  User: asus
  Date: 2019/3/18
  Time: 17:03
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <base href="<%=request.getContextPath()+"/"%>">
    <link href="static/css/H-ui.min.css" rel="stylesheet" type="text/css" />
    <link href="static/css/H-ui.admin.css" rel="stylesheet" type="text/css" />
    <link href="static/css/style.css" rel="stylesheet" type="text/css" />
    <link href="static/lib/Hui-iconfont/1.0.1/iconfont.css" rel="stylesheet" type="text/css" />
    <link href="static/layui-v2.4.5/layui/css/layui.css" rel="stylesheet" type="text/css" />
    <title>Title</title>
</head>
<body>
<div id="taskInfo">
    <nav class="breadcrumb"><i class="Hui-iconfont">&#xe67f;</i> 首页 <span class="c-gray en">&gt;</span> 采购管理 <span class="c-gray en">&gt;</span> 待办事项 <a class="btn btn-success radius r mr-20" style="line-height:1.6em;margin-top:3px" href="javascript:location.replace(location.href);" title="刷新" ><i class="Hui-iconfont">&#xe68f;</i></a></nav>
    <div  class="pd-20">
    <table class="table table-border table-bordered table-hover table-bg">
        <thead>
        <tr>
            <th scope="col" colspan="7">审核管理</th>
        </tr>
        <tr class="text-c">
            <th width="25"><input type="checkbox" value="" name=""></th>
            <th width="40">任务ID</th>
            <th width="100">任务名称</th>
            <th width="100">流程实例id</th>
            <th width="200">创建时间</th>
            <th width="70">操作</th>
        </tr>
        </thead>
        <tbody>

        <tr class="text-c" v-for="(task,index) in pageInfo.list">
            <td><input type="checkbox" v-bind:value="task.id" v-model="check" name=""></td>
            <td>{{task.id}}</td>
            <td>{{task.name}}</td>
            <td>{{task.processInstanceId}}</td>
            <td>
                {{changeDate(task.date)}}
            </td>
            <td class="f-14"><a title="编辑" href="javascript:;" @click="purchaseEdit(task.id)" <%--onclick="admin_role_edit('组织编辑','admin-role-add.html','1')"--%> style="text-decoration:none"><i class="Hui-iconfont">&#xe6df;</i></a> <a title="删除" href="javascript:;" @click="deleteSysOrg(sysOrg.orgId)" <%--onclick="admin_role_del(this,'1')" --%>class="ml-5" style="text-decoration:none"><i class="Hui-iconfont">&#xe6e2;</i></a></td>
        </tr>

        </tbody>
    </table>
</div>
</div>
<!--分页容器-->
<div id="list"></div>
<script type="text/javascript" src="static/lib/jquery/1.9.1/jquery.min.js"></script>
<script type="text/javascript" src="static/js/vue.min.js"></script>
<script type="text/javascript" src="static/lib/layer/1.9.3/layer.js"></script>
<script type="text/javascript" src="static/js/vue.min.js"></script>
<script type="text/javascript" src="static/layui-v2.4.5/layui/layui.js"></script>
<script type="text/javascript" src="static/lib/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript" src="static/js/H-ui.js"></script>
<script type="text/javascript" src="static/js/H-ui.admin.js"></script>
<!--抽取公共分页-->
<script type="text/javascript" src="static/commonPage/page.js"></script>
<script type="text/javascript">
    var pn = 1;
    var pageSize = 3;
    var totalCount = 0;
    var url="task/select";
    var object={

    }
    pagination(pn,pageSize,object,url);

    var vue=new Vue({
        el:"#taskInfo",
        data:{
            pageInfo:{},
            check:[],
            object:{

            }
        },
        methods:{
            jump:function () {
                //alert(vue.sysOrgC.orgName)
                var pn = 1;
                var pageSize = 3;
                var totalCount = 0;
                var url="task/object";
                pagination(pn,pageSize,vue.object,url)
            },
            //日期格式化
            changeDate:function(datetimes){
                var date = new Date(datetimes);
                Y = date.getFullYear() + '-';
                M = (date.getMonth()+1 < 10 ? '0'+(date.getMonth()+1) : date.getMonth()+1) + '-';
                D = date.getDate() + ' ';
                h = date.getHours() + ':';
                m = date.getMinutes() + ':';
                s = date.getSeconds();
                //年 月 日 时 分 秒
                return Y+M+D;
            },
            purchaseEdit:function (taskId) {
                var url="purchase/toShenpi/"+taskId;
                layer_show("审核",url,800,500);
            }
        }
    })

    /*管理员-组织-添加*/
    function admin_role_add(title,url,w,h){
        layer_show(title,url,w,h);
    }
    /*管理员-组织-编辑*/
    function admin_role_edit(title,url,id,w,h){
        layer_show(title,url,w,h);
    }
    /*管理员-组织-删除*/
    function admin_role_del(obj,id){
        layer.confirm('组织删除须谨慎，确认要删除吗？',function(index){
            //此处请求后台程序，下方是成功后的前台处理……
            $(obj).parents("tr").remove();
            layer.msg('已删除!',{icon:1,time:1000});
        });
    }
</script>
</body>
</html>
