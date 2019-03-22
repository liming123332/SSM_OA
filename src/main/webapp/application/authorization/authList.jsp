<%--
  Created by IntelliJ IDEA.
  User: pp
  Date: 2019/3/22
  Time: 10:08
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <base href="<%=request.getContextPath()+"/"%>">
    <link href="static/css/H-ui.min.css" rel="stylesheet" type="text/css" />
    <link href="static/css/H-ui.admin.css" rel="stylesheet" type="text/css" />
    <link href="static/css/style.css" rel="stylesheet" type="text/css" />
    <link href="static/layui-v2.4.5/layui/css/layui.css" rel="stylesheet" type="text/css" />
    <link href="static/lib/Hui-iconfont/1.0.1/iconfont.css" rel="stylesheet" type="text/css" />
    <title>授权管理</title>
</head>
<body>
<nav class="breadcrumb"><i class="Hui-iconfont">&#xe67f;</i> 首页 <span class="c-gray en">&gt;</span> 管理员管理 <span class="c-gray en">&gt;</span> 管理员列表 <a class="btn btn-success radius r mr-20" style="line-height:1.6em;margin-top:3px" href="javascript:location.replace(location.href);" title="刷新" ><i class="Hui-iconfont">&#xe68f;</i></a></nav>
<div class="pd-20" id="authInfo">
    <div class="text-c">
        <div class="row cl ">
            <div class="formControls col-6">
                角色：
                <!--通过角色id找到所有角色-->
                <span class="select-box" style="width:150px;">
				<select class="select" v-model="roleId" name="roleId" id="roleId" size="1">
					<option value="-1">请选择</option>
                    <option v-for="role in roles" v-bind:value="role.roleId">{{role.roleName}}</option>
				</select>
				</span>
            </div>
            <div class="formControls col-6">
                类型：
                <!--通过角色id找到所有角色-->
                <span class="select-box" style="width:150px;">
				<select class="select" v-model="type" name="type" id="type" size="1">
                    <option value="-1">请选择</option>
					<option value="1">用户</option>
                    <option value="2">菜单</option>
				</select>
				</span>
            </div>
        </div>
        <div class="row cl">
            <div class="cl pd-5">
                <button type="button" @click="select()"
                        class="btn btn-success radius" id="" name="">
                    <i class="Hui-iconfont">&#xe665;</i> 搜用户
                </button>
            </div>
        </div>
    </div>
    <div class="cl pd-5 bg-1 bk-gray mt-20">
        <span class="l">
        <a href="javascript:;" @click="addUserToRole(vue.roleId)" class="btn btn-primary radius">
            <i class="Hui-iconfont">&#xe6e2;</i> 授权新用户</a>
        <a href="javascript:;" @click="addMenuToRole(vue.roleId)" class="btn btn-primary radius">
            <i class="Hui-iconfont">&#xe6e2;</i> 授权新菜单</a>
        </span>
    </div>
    <table class="table table-border table-bordered table-bg" v-if="authUser">
        <thead>
        <tr>
            <th scope="col" colspan="8">角色授权的用户信息</th>
        </tr>
        <tr class="text-c">
            <th width="25"><input type="checkbox" value="" name=""></th>
            <th width="40">用户ID</th>
            <th width="100">用户名称</th>
            <th width="100">联系电话</th>
            <th width="100">邮件</th>
            <th width="100">出生日期</th>
            <th width="100">个人简介</th>
            <th width="70">操作</th>
        </tr>

        <tr class="text-c" v-for="(sysUser,index) in pageInfo.list">
            <td><input type="checkbox" v-bind:value="sysUser.userId" v-model="check" name=""></td>
            <td>{{sysUser.userId}}</td>
            <td>{{sysUser.userName}}</td>
            <td>{{sysUser.phone}}</td>
            <td>{{sysUser.email}}</td>
            <td>
                {{changeDate(sysUser.birthday)}}
            </td>
            <td>{{sysUser.introduce}}</td>
            <td class="f-14">
               <%-- <a title="编辑" href="javascript:;" @click="toUpdate(sysUser.userId)" &lt;%&ndash;onclick="admin_role_edit('组织编辑','admin-role-add.html','1')"&ndash;%&gt; style="text-decoration:none"><i class="Hui-iconfont">&#xe6df;</i></a> --%>
                   <a title="取消授权" href="javascript:;" @click="deleteUserToRole(sysUser.userId)" class="ml-5" style="text-decoration:none"><i class="Hui-iconfont">&#xe6e2;</i></a></td>
        </tr>

        </tbody>
    </table>
    <table class="table table-border table-bordered table-bg" v-if="roleMenu">
        <thead>
        <tr>
            <th scope="col" colspan="8">角色对应的菜单信息</th>
        </tr>
        <tr class="text-c">
            <th width="25"><input type="checkbox" value="" name=""></th>
            <th width="40">菜单ID</th>
            <th width="40">父菜单名称</th>
            <th width="100">菜单名称</th>
            <th width="100">菜单类型</th>
            <th width="100">菜单描述</th>
            <th width="100">是否发布</th>
          <%--  <th width="70">操作</th>--%>
        </tr>

        <tr class="text-c" v-for="(sysMenu,index) in pageInfo.list">
            <td><input type="checkbox" v-bind:value="sysMenu.menuId" v-model="check" name=""></td>
            <td>{{sysMenu.menuId}}</td>
            <td>{{sysMenu.menuParentId}}</td>
            <td>{{sysMenu.menuName}}</td>
            <td>{{sysMenu.menuType}}</td>
            <td>{{sysMenu.menuDesc}}</td>
            <td>{{publish(sysMenu.isPublish)}}</td>
           <%-- <td class="f-14"><a title="编辑" href="javascript:;" @click="toUpdate(sysMenu.menuId)" &lt;%&ndash;onclick="admin_role_edit('组织编辑','admin-role-add.html','1')"&ndash;%&gt; style="text-decoration:none"><i class="Hui-iconfont">&#xe6df;</i></a> <a title="删除" href="javascript:;" @click="deleteSysMenu(sysMenu.menuId)" &lt;%&ndash;onclick="admin_role_del(this,'1')" &ndash;%&gt;class="ml-5" style="text-decoration:none"><i class="Hui-iconfont">&#xe6e2;</i></a></td>--%>
        </tr>

        </tbody>
    </table>
    <!--分页容器-->
    <div id="list"></div>
</div>
<script type="text/javascript" src="static/lib/jquery/1.9.1/jquery.min.js"></script>
<script type="text/javascript" src="static/js/vue.min.js"></script>
<script type="text/javascript" src="static/lib/layer/1.9.3/layer.js"></script>
<script type="text/javascript" src="static/js/vue.min.js"></script>
<script type="text/javascript" src="static/layui-v2.4.5/layui/layui.js"></script>
<script type="text/javascript" src="static/lib/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript" src="static/js/H-ui.js"></script>
<script type="text/javascript" src="static/js/H-ui.admin.js"></script>
<script type="text/javascript" src="static/commonPage/page.js"></script>
<script type="text/javascript">
    var vue=new Vue({
        el:"#authInfo",
        data:{
            roleId:-1,
            type:-1,
            roles:[],
            authUser:false,
            roleMenu:false,
            pageInfo:{},
            check:[]
        },
        //查询所有角色
        created:function () {
            $.ajax({
                type:"post",
                url:"authorization/getRole",
                success:function (result) {
                    vue.roles=result;
                }
            })
        },
        methods:{
            //根据条件查询 角色下的用户，角色下的菜单
            select:function () {
                if(vue.roleId==-1){
                    alert("请选择角色!");
                    return;
                }
                if(vue.type==-1){
                    alert("请选择类型!");
                    return;
                }
                if(vue.type==1){
                    var pn = 1;
                    var pageSize = 3;
                    var totalCount = 0;
                    var object={
                        roleId: vue.roleId
                    }
                    var url="authorization/selectUserByRoleId";
                    //调用分页ajax查询
                    pagination(pn,pageSize,object,url);
                    vue.check=[];
                    vue.authUser=true;
                    vue.roleMenu=false;
                }
                if(vue.type==2){
                    var pn = 1;
                    var pageSize = 3;
                    var totalCount = 0;
                    var object={
                        roleId: vue.roleId
                    }
                    var url="authorization/selectMenuByRoleId";
                    //调用分页ajax查询
                    pagination(pn,pageSize,object,url);
                    vue.check=[];
                    vue.authUser=false;
                    vue.roleMenu=true;

                }

            },
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
            publish:function(isPublish){
                if(isPublish==0){
                    return '否';
                }else if(isPublish==1){
                    return '是';
                }
            },
            //授权新用户
            addUserToRole:function (roleId) {
                if(vue.roleId==-1){
                    alert("请选择角色！")
                    return;
                }
                if(vue.type==-1){
                    alert("请选择类型!");
                    return;
                }
                if(vue.type==1) {
                    var url = "authorization/addUserToRole?roleId=" + roleId;
                    layer_show("授权新用户", url, 1000, 500);
                }else{
                    alert("请选择用户类型!");
                }
            },
            //解除用户授权
            deleteUserToRole: function (userId) {
                layer.confirm('取消授权须谨慎，确认要取消吗？',function() {
                    //console.log("del");
                    $.ajax({
                        type: "get",
                        url: "authorization/deleteUserToRole",
                        data: {userId:userId,roleId:vue.roleId},
                        async: false,
                        success: function (result) {
                            if (result.msg == "成功") {
                                for (var i = 0; i < vue.pageInfo.list.length; i++) {
                                    if (vue.pageInfo.list[i].userId == userId) {
                                        vue.pageInfo.list.splice(i, 1);
                                        break;
                                    }
                                }
                                layer.msg('已取消授权!', {icon: 1, time: 1000}, function () {
                                    //发送ajax再次查询 调用select方法
                                    this.$options.methods.select();
                                });
                            }else if(result.msg=="失败"){
                                layer.msg('该用户不能删除！!', {icon: 1, time: 1000})
                            }

                        }
                    })
                });
            },
            //授权新菜单
            addMenuToRole:function (roleId) {
                if(vue.roleId==-1){
                    alert("请选择角色！")
                    return;
                }
                if(vue.type==-1){
                    alert("请选择类型!");
                    return;
                }
                if(vue.type==2){
                    var url = "authorization/addMenuToRole?roleId=" + roleId;
                    layer_show("授权新菜单", url, 1000, 500);
                }else{
                    alert("请选择菜单类型!");
                    return;
                }
            }
        }
    });
    /*
        参数解释：
        title	标题
        url		请求的url
        id		需要操作的数据id
        w		弹出层宽度（缺省调默认值）
        h		弹出层高度（缺省调默认值）
    */
    /*管理员-增加*/
    function admin_add(title,url,w,h){
        layer_show(title,url,w,h);
    }
    /*管理员-删除*/
    function admin_del(obj,id){
        layer.confirm('确认要删除吗？',function(index){
            //此处请求后台程序，下方是成功后的前台处理……

            $(obj).parents("tr").remove();
            layer.msg('已删除!',{icon:1,time:1000});
        });
    }
    /*管理员-编辑*/
    function admin_edit(title,url,id,w,h){
        layer_show(title,url,w,h);
    }
    /*管理员-停用*/
    function admin_stop(obj,id){
        layer.confirm('确认要停用吗？',function(index){
            //此处请求后台程序，下方是成功后的前台处理……

            $(obj).parents("tr").find(".td-manage").prepend('<a onClick="admin_start(this,id)" href="javascript:;" title="启用" style="text-decoration:none"><i class="Hui-iconfont">&#xe615;</i></a>');
            $(obj).parents("tr").find(".td-status").html('<span class="label label-default radius">已禁用</span>');
            $(obj).remove();
            layer.msg('已停用!',{icon: 5,time:1000});
        });
    }

    /*管理员-启用*/
    function admin_start(obj,id){
        layer.confirm('确认要启用吗？',function(index){
            //此处请求后台程序，下方是成功后的前台处理……


            $(obj).parents("tr").find(".td-manage").prepend('<a onClick="admin_stop(this,id)" href="javascript:;" title="停用" style="text-decoration:none"><i class="Hui-iconfont">&#xe631;</i></a>');
            $(obj).parents("tr").find(".td-status").html('<span class="label label-success radius">已启用</span>');
            $(obj).remove();
            layer.msg('已启用!', {icon: 6,time:1000});
        });
    }
</script>
</body>
</html>
