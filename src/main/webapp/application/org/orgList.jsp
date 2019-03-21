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
<div id="orgInfo">
    <nav class="breadcrumb"><i class="Hui-iconfont">&#xe67f;</i> 首页 <span class="c-gray en">&gt;</span> 管理员管理 <span class="c-gray en">&gt;</span> 组织管理 <a class="btn btn-success radius r mr-20" style="line-height:1.6em;margin-top:3px" href="javascript:location.replace(location.href);" title="刷新" ><i class="Hui-iconfont">&#xe68f;</i></a></nav>
    <div class="text-c">
        <div class="row cl ">
            <div class="formControls col-4">
                组织名称: <input type="text" v-model="sysOrgC.orgName" class="input-text" style="width: 250px">
            </div>
            <div class="formControls col-4">
                父组织名称： <input type="text" v-model="sysOrgC.orgParentName" class="input-text" style="width: 250px">
            </div>
            <div class="formControls col-4">
                是否有效：
                <span class="select-box" style="width:150px;">
				<select class="select" v-model="sysOrgC.flag" name="flag" id="flag" size="1">
					<option value="0">否</option>
					<option value="1">是</option>
				</select>
				</span>
            </div>
        </div>
            <div class="cl pd-5">
                <button type="button"
                        class="btn btn-success radius" @click="jump()" id="" name="">
                    <i class="Hui-iconfont">&#xe665;</i> 搜索组织
                </button>
            </div>
    </div>
    <div  class="pd-20">
        <div class="cl pd-5 bg-1 bk-gray"> <span class="l"> <a href="javascript:;" @click="batchdel()" <%--onclick="datadel()"--%> class="btn btn-danger radius"><i class="Hui-iconfont">&#xe6e2;</i> 批量删除</a> <a class="btn btn-primary radius" href="javascript:;" onclick="admin_role_add('添加组织','sysOrg/toAdd','800')"><i class="Hui-iconfont">&#xe600;</i> 添加组织</a> </span> <span class="r">共有数据：<strong>54</strong> 条</span> </div>
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

            <tr class="text-c" v-for="(sysOrg,index) in pageInfo.list">
                <td><input type="checkbox" v-bind:value="sysOrg.orgId" v-model="check" name=""></td>
                <td>{{sysOrg.orgId}}</td>
                <td>{{sysOrg.orgName}}</td>
                <td>{{sysOrg.orgParentName}}</td>
                <td>
                    {{sysOrg.createTime}}
                </td>
                <td>{{sysOrg.orgDesc}}</td>
                <td class="f-14"><a title="编辑" href="javascript:;" @click="toUpdate(sysOrg.orgId)" <%--onclick="admin_role_edit('组织编辑','admin-role-add.html','1')"--%> style="text-decoration:none"><i class="Hui-iconfont">&#xe6df;</i></a> <a title="删除" href="javascript:;" @click="deleteSysOrg(sysOrg.orgId)" <%--onclick="admin_role_del(this,'1')" --%>class="ml-5" style="text-decoration:none"><i class="Hui-iconfont">&#xe6e2;</i></a></td>
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
    var url="sysOrg/select";
    var sysOrg={
        orgName:'',
        orgParentName:'',
        flag:'1'
    }
    pagination(pn,pageSize,sysOrg,url);

    var vue=new Vue({
        el:"#orgInfo",
        data:{
            pageInfo:{},
            check:[],
            sysOrgC:{
                orgName:'',
                orgParentName:'',
                flag:'1'
            }
        },
        methods:{
            deleteSysOrg: function (id) {
                layer.confirm('组织删除须谨慎，确认要删除吗？',function() {
                    console.log("del");
                    $.ajax({
                        type: "get",
                        url: "sysOrg/deleteOrg",
                        data: {id:id},
                        async: false,
                        success: function (result) {
                            if (result.msg == "成功") {
                                for (var i = 0; i < vue.pageInfo.list.length; i++) {
                                    if (vue.pageInfo.list[i].orgId == id) {
                                        vue.pageInfo.list.splice(i, 1);
                                        break;
                                    }
                                }
                                layer.msg('已删除!', {icon: 1, time: 1000}, function () {
                                    //发送ajax再次查询
                                    pagination(pn, pageSize,sysOrg,url);
                                });
                            }else if(result.msg=="失败"){
                                layer.msg('该组织为父组织不能删除！!', {icon: 1, time: 1000})
                             }

                    }
                    })
                });
            },
            toUpdate: function (id) {
                var url="sysOrg/toUpdate/"+id;
                layer_show("修改页面",url,800,500);
            },
            batchdel:function () {
               if(vue.check.length==0) {
                   layer.msg('请选中以后再点击！!', {icon: 1, time: 1000})
               }else{
                   $.ajax({
                       type:"post",
                       url:"sysOrg/batchDel?idList="+vue.check,
                       success:function (result) {
                           if (result.msg == "成功") {
                               vue.check.forEach(function (item,index) {
                                   vue.pageInfo.list.forEach(function (sysOrg,i) {
                                       if(sysOrg.orgId==item){
                                           vue.pageInfo.list.splice(i,1);
                                       }
                                   });
                               });
                               vue.check=[];
                               layer.msg('已删除!', {icon: 1, time: 1000}, function () {
                                   //发送ajax再次查询
                                   pagination(pn, pageSize,sysOrg,url);
                               });
                           }else if(result.msg=="失败"){
                               layer.msg('该组织为父组织不能删除！!', {icon: 1, time: 1000})
                           }
                       }
                   })
               }

            },
            jump:function () {
                //alert(vue.sysOrgC.orgName)
                var pn = 1;
                var pageSize = 3;
                var totalCount = 0;
                var url="sysOrg/select";
                pagination(pn,pageSize,vue.sysOrgC,url)
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
