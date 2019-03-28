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
    <form action="process/add" enctype="multipart/form-data" method="post" class="form form-horizontal" id="form-process-add">
        <div class="row cl">
            <label class="form-label col-3"><span class="c-red">*</span>流程名称：</label>
            <div class="formControls col-5">
                <input type="text" class="input-text" value="" placeholder="" id="processName" name="processName" datatype="*2-16" nullmsg="组织名称不能为空">
            </div>
            <div class="col-4"> </div>
        </div>
        <div class="row cl">
            <label class="form-label col-3"><span class="c-red">*</span>流程文件：</label>
            <div class="formControls col-5">
                <input type="file" id="processFile" name="processFile" value="" class="input-text" datatype="*" nullmsg="流程文件不能为空" readonly="readonly">
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

    $(function() {
        $('.skin-minimal input').iCheck({
            checkboxClass: 'icheckbox-blue',
            radioClass: 'iradio-blue',
            increaseArea: '20%'
        });
    })
</script>
</body>
</html>
