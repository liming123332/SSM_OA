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
    <script type="text/javascript" src="static/js/vue.min.js"></script>
    <title>Title</title>
</head>
<body>
<div id="orgInfo">
<nav class="breadcrumb"><i class="Hui-iconfont">&#xe67f;</i> 首页 <span class="c-gray en">&gt;</span> 管理员管理 <span class="c-gray en">&gt;</span> 组织管理 <a class="btn btn-success radius r mr-20" style="line-height:1.6em;margin-top:3px" href="javascript:location.replace(location.href);" title="刷新" ><i class="Hui-iconfont">&#xe68f;</i></a></nav>
<div  class="pd-20">
    <div class="cl pd-5 bg-1 bk-gray"> <span class="l"> <a href="javascript:;" onclick="datadel()" class="btn btn-danger radius"><i class="Hui-iconfont">&#xe6e2;</i> 批量删除</a> <a class="btn btn-primary radius" href="javascript:;" onclick="admin_role_add('添加组织','admin-role-add.html','800')"><i class="Hui-iconfont">&#xe600;</i> 添加组织</a> </span> <span class="r">共有数据：<strong>54</strong> 条</span> </div>
    <table class="table table-border table-bordered table-hover table-bg">
        <thead>
        <tr>
            <th scope="col" colspan="7">组织管理</th>
        </tr>
        <tr class="text-c">
            <th width="25"><input type="checkbox" value="" name=""></th>
            <th width="40">组织ID</th>
            <th width="100">组织名称</th>
            <th width="100">父组织名称</th>
            <th width="100">创建时间</th>
            <th width="200">描述</th>
            <th width="70">操作</th>
        </tr>
        </thead>
        <tbody>

            <tr class="text-c" :key="sysOrg.orgId" v-for="(sysOrg,index) in pageInfo.list">
                <td><input type="checkbox" value="" name=""></td>
                <td>{{sysOrg.orgId}}</td>
                <td>{{sysOrg.orgName}}</td>
                <td>{{sysOrg.orgParentName}}</td>
                <td>
                    {{sysOrg.createTime}}
                </td>
                <td>{{sysOrg.orgDesc}}</td>
                <td class="f-14"><a title="编辑" href="javascript:;" onclick="admin_role_edit('组织编辑','admin-role-add.html','1')" style="text-decoration:none"><i class="Hui-iconfont">&#xe6df;</i></a> <a title="删除" href="javascript:;" @click="deleteSysOrg(sysOrg.orgId)" <%--onclick="admin_role_del(this,'1')" --%>class="ml-5" style="text-decoration:none"><i class="Hui-iconfont">&#xe6e2;</i></a></td>
            </tr>

        </tbody>
    </table>
</div>
    <div id="list"></div>
</div>
<script type="text/javascript" src="static/lib/jquery/1.9.1/jquery.min.js"></script>
<script type="text/javascript" src="static/lib/layer/1.9.3/layer.js"></script>
<script type="text/javascript" src="static/lib/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript" src="static/js/H-ui.js"></script>
<script type="text/javascript" src="static/js/H-ui.admin.js"></script>
<script type="text/javascript">
    var vue=new Vue({
        el:"#orgInfo",
        data:{
            pageInfo:{},
            list:[]
        },
        created:function(){
            $.ajax({
                type:"get",
                url: "sysOrg/orgList/",
                data:{pn:1},
                success: function (result) {
                    for(var i=0;i<result.list.length;i++) {
                        if (result.list[i].createTime != null) {
                            result.list[i].createTime = changeDate(result.list[i].createTime);
                        }
                        if (result.list[i].updateTime != null) {
                            result.list[i].updateTime = changeDate(result.list[i].updateTime);
                        }
                    }
                    vue.pageInfo=result;
                }
            });
        },
        methods:{
            deleteSysOrg: function (id) {
                layer.confirm('组织删除须谨慎，确认要删除吗？',function() {
                    $.ajax({
                        type: "get",
                        url: "sysOrg/deleteOrg",
                        data: {id:id},
                        success: function (result) {
                            console.log(vue.pageInfo)
                            for (var i = 0; i <vue.pageInfo.list.length; i++) {
                                if (vue.pageInfo.list[i].orgId == id) {
                                    vue.pageInfo.list.splice(i, 1);
                                    break;
                                }
                            }
                            layer.msg('已删除!',{icon:1,time:1000});
                            /*for(var i=0;i<result.list.length;i++) {
                                if (result.list[i].createTime != null) {
                                    result.list[i].createTime = changeDate(result.list[i].createTime);
                                }
                                if (result.list[i].updateTime != null) {
                                    result.list[i].updateTime = changeDate(result.list[i].updateTime);
                                }
                            }
                            vue.pageInfo= result;*/

                        }
                    })
                });
            },
        }

    })
    //日期格式化
    function changeDate(datetimes){
        var date = new Date(datetimes);
        Y = date.getFullYear() + '-';
        M = (date.getMonth()+1 < 10 ? '0'+(date.getMonth()+1) : date.getMonth()+1) + '-';
        D = date.getDate() + ' ';
//      h = date.getHours() + ':';
//      m = date.getMinutes() + ':';
//      s = date.getSeconds();
//      年 月 日 时 分 秒
        return Y+M+D;
    }

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
