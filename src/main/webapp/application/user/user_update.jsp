<%--
  Created by IntelliJ IDEA.
  User: asus
  Date: 2019/3/19
  Time: 11:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<base href="<%=request.getContextPath()+"/"%>">
<link href="static/css/H-ui.min.css" rel="stylesheet" type="text/css" />
<link href="static/css/H-ui.admin.css" rel="stylesheet" type="text/css" />
<link href="static/lib/icheck/icheck.css" rel="stylesheet" type="text/css" />
<link href="static/lib/Hui-iconfont/1.0.1/iconfont.css" rel="stylesheet" type="text/css" />
<link href="static/lib/zTree/v3/css/zTreeStyle/zTreeStyle.css" rel="stylesheet" type="text/css" />
<head>
    <title>Title</title>
</head>
<body>
<div id="bb">
<div class="pd-20">
    <form action="" method="post" class="form form-horizontal" id="form-user-update">
    <div class="row cl">
        <label class="form-label col-3"><span class="c-red">*</span>用户名称：</label>
        <div class="formControls col-5">
            <input type="hidden" value="${sysUser.userId}" name="userId">
            <input type="text" class="input-text" value="${sysUser.userName}" placeholder="" id="userName" name="userName" datatype="*2-16" nullmsg="用户名称不能为空">
        </div>
        <div class="col-4"> </div>
    </div>
    <div class="row cl">
        <label class="form-label col-3"><span class="c-red">*</span>密码：</label>
        <div class="formControls col-5">
            <input type="password" class="input-text" value="${sysUser.userPassword}" placeholder="" id="userPassword" name="userPassword" datatype="*2-16" nullmsg="密码不能为空">
        </div>
        <div class="col-4"> </div>
    </div>
    <%--<div class="row cl">
        <label class="form-label col-3"><span class="c-red">*</span>组织名称：</label>
        <div class="formControls col-5">
            <input type="text" id="orgParentName" name="" value="" class="input-text" datatype="*" nullmsg="组织名称不能为空" readonly="readonly">
            <input type="hidden" id="orgParentId" name="orgId" value="1">
            <input class="btn btn-primary radius" type="button" value="选择组织" onclick="selectOrgParent()">
        </div>

        <div class="col-4"> </div>
    </div>--%>
    <div class="row cl">
        <label class="form-label col-3"><span class="c-red">*</span>联系电话：</label>
        <div class="formControls col-5">
            <input type="text" class="input-text" value="${sysUser.phone}" placeholder="" id="phone" name="phone" datatype="m" nullmsg="联系电话不能为空">
        </div>
        <div class="col-4"> </div>
    </div>
    <div class="row cl">
        <label class="form-label col-3"><span class="c-red">*</span>email：</label>
        <div class="formControls col-5">
            <input type="text" class="input-text" value="${sysUser.email}" placeholder="" id="email" name="email" datatype="*2-30" nullmsg="email不能为空">
        </div>
        <div class="col-4"> </div>
    </div>
    <div class="row cl">
        <label class="form-label col-3"><span class="c-red">*</span>出生日期：</label>
        <div class="formControls col-5">
            <input type="text" onClick="WdatePicker()" class="input-text Wdate" value="<fmt:formatDate value="${sysUser.birthday}" pattern="yyyy-MM-dd"/>" placeholder="" id="birthday" name="birthday" datatype="*2-16" nullmsg="birthday不能为空">
        </div>
        <div class="col-4"> </div>
    </div>
    <div class="row cl">
        <label class="form-label col-3">是否有效：</label>
        <div class="formControls col-5">
                <span class="select-box" style="width:150px;">
				<select class="select" name="flag" id="flag" size="1">
                    <option <c:if test="${!sysUser.flag}">selected="selected"</c:if> value="0">否</option>
					<option <c:if test="${sysUser.flag}">selected="selected"</c:if> value="1">是</option>
				</select>
				</span>
        </div>
    </div>
    <div class="row cl">
        <label class="form-label col-3">备注：</label>
        <div class="formControls col-5">
            <textarea name="introduce" id="introduce" cols="" rows="" class="textarea"  placeholder="说点什么...100个字符以内" dragonfly="true" onKeyUp="textarealength(this,100)">${sysUser.introduce}</textarea>
            <p class="textarea-numberbar"><em class="textarea-length">0</em>/100</p>
        </div>
        <div class="col-4"> </div>
    </div>
    <div class="row cl">
        <div class="col-9 col-offset-3">
            <input class="btn btn-primary radius" type="submit" value="&nbsp;&nbsp;提交&nbsp;&nbsp;">
        </div>
    </div>
</form>
</div>
</div>
<!--组织树结构-->
<div id="orgParentTree" style="display: none">
    <div id="treeDemo" class="ztree"></div>
</div>
<script type="text/javascript" src="static/js/vue.min.js"></script>
<script type="text/javascript" src="static/lib/jquery/1.9.1/jquery.min.js"></script>
<script type="text/javascript" src="static/lib/icheck/jquery.icheck.min.js"></script>
<script type="text/javascript" src="static/lib/Validform/5.3.2/Validform.min.js"></script>
<script type="text/javascript" src="static/lib/layer/1.9.3/layer.js"></script>
<script type="text/javascript" src="static/js/H-ui.js"></script>
<script type="text/javascript" src="static/js/H-ui.admin.js"></script>
<script type="text/javascript" src="static/lib/zTree/v3/js/jquery.ztree.all-3.5.js"></script>
<script type="text/javascript" src="/static/lib/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript">
   /* function selectOrgParent(){
        var index = layer.open({
            title:"选择组织",
            type:1,
            content: $("#orgParentTree"),
            area: ['500px', '300px'],
            btn:"确定"
        });
        $.ajax({
            url:"sysOrg/list",
            type:"post",
            success:function (result) {
                //alert(result)
                var zTreeObj;
                // zTree 的参数配置，深入使用请参考 API 文档（setting 配置详解）
                var setting = {
                    data: {
                        simpleData: {
                            enable: true,
                            idKey: "orgId",
                            pIdKey: "orgParentId",
                        },
                        key: {
                            name: "orgName"
                        }
                    },
                    callback: {
                        onClick: function (event, treeId, treeNode) {
                            $("#orgParentName").val(treeNode.orgName);
                            $("#orgParentId").val(treeNode.orgId);
                        }
                    }
                };
                // zTree 的数据属性，深入使用请参考 API 文档（zTreeNode 节点数据详解）
                var zNodes = result;
                $(document).ready(function(){
                    zTreeObj = $.fn.zTree.init($("#treeDemo"), setting, zNodes);
                });

            }
        })
        return false;
    }*/


    $(function(){
        $('.skin-minimal input').iCheck({
            checkboxClass: 'icheckbox-blue',
            radioClass: 'iradio-blue',
            increaseArea: '20%'
        });

        $("#form-user-update").Validform({
            tiptype:2,
            callback:function(form){
                //表单验证通过之后，点击添加才会进入这个方法
                //通过ajax请求提交表单数据
                //alert($("#birthday").val())
                $.ajax({
                    url:"sysUser/updateUser",
                    type:"POST",
                    data:$("#form-user-update").serialize(),
                    success:function (data) {
                        layer.msg(data.msg, {icon: 1, time: 1000});
                        //关闭弹出框
                        var index = parent.layer.getFrameIndex(window.name);
                        parent.$('.btn-refresh').click();
                        parent.layer.close(index);
                        parent.location.reload();
                    }
                })
                return false;
            }
        });
    });
</script>
</body>
</html>
