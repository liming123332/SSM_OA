<%--
  Created by IntelliJ IDEA.
  User: asus
  Date: 2019/3/19
  Time: 11:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
    <form action="" method="post" class="form form-horizontal" id="form-menu-add">
        <div class="row cl">
            <label class="form-label col-3"><span class="c-red">*</span>菜单名称：</label>
            <div class="formControls col-5">
                <input type="text" class="input-text" value="" placeholder="" id="menuName" name="menuName" datatype="*2-16" nullmsg="菜单名称不能为空">
            </div>
            <div class="col-4"> </div>
        </div>
        <div class="row cl">
            <label class="form-label col-3"><span class="c-red">*</span>父菜单名称：</label>
            <div class="formControls col-5">
                <input type="text" id="orgParentName" name="" value="" class="input-text" datatype="*" nullmsg="父菜单名称不能为空" readonly="readonly">
                <input type="hidden" id="orgParentId" name="menuParentId" value="1">
                <input class="btn btn-primary radius" type="button" value="选择父组织" onclick="selectOrgParent()">
            </div>

            <div class="col-4"> </div>
        </div>

        <div class="row cl">
            <label class="form-label col-3"><span class="c-red">*</span>菜单类型：</label>
            <div class="formControls col-5">
                <select class="select" name="menuType" id="menuType" size="1">
                    <option value="1">目录</option>
                    <option value="2">菜单</option>
                    <option value="3">操作</option>
                </select>
            </div>

            <div class="col-4"> </div>
        </div>

        <div class="row cl">
            <label class="form-label col-3">是否发布：</label>
            <div class="formControls col-5">
                <span class="select-box" style="width:150px;">
				<select class="select" name="isPublish" id="isPublish" size="1">
					<option value="0">否</option>
					<option value="1">是</option>
				</select>
				</span>
            </div>
        </div>
        <div class="row cl">
            <label class="form-label col-3">描述：</label>
            <div class="formControls col-5">
                <textarea name="menuDesc" id="menuDesc" cols="" rows="" class="textarea"  placeholder="说点什么...100个字符以内" dragonfly="true" onKeyUp="textarealength(this,100)"></textarea>
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
<script type="text/javascript">
    function selectOrgParent(){
        var index = layer.open({
            title:"选择父菜单",
            type:1,
            content: $("#orgParentTree"),
            area: ['500px', '300px'],
            btn:"确定"
        });
        $.ajax({
            url:"sysMenu/list",
            type:"post",
            success:function (result) {
                //alert(result)
                var zTreeObj;
                // zTree 的参数配置，深入使用请参考 API 文档（setting 配置详解）
                var setting = {
                    data: {
                        simpleData: {
                            enable: true,
                            idKey: "menuId",
                            pIdKey: "menuParentId",
                        },
                        key: {
                            name: "menuName"
                        }
                    },
                    callback: {
                        onClick: function (event, treeId, treeNode) {
                            $("#orgParentName").val(treeNode.menuName);
                            $("#orgParentId").val(treeNode.menuId);
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
    }


    $(function(){
        $('.skin-minimal input').iCheck({
            checkboxClass: 'icheckbox-blue',
            radioClass: 'iradio-blue',
            increaseArea: '20%'
        });

        $("#form-menu-add").Validform({
            tiptype:2,
            callback:function(form){
                //表单验证通过之后，点击添加才会进入这个方法
                //通过ajax请求提交表单数据
                $.ajax({
                    url:"sysMenu/addMenu",
                    type:"POST",
                    data:$("#form-menu-add").serialize(),
                    success:function (data) {
                        alert(data.msg);

                    }
                })
                //关闭弹出框
                var index = parent.layer.getFrameIndex(window.name);
                parent.$('.btn-refresh').click();
                parent.layer.close(index);
                parent.location.reload();

            }
        });
    });
</script>
</body>
</html>
