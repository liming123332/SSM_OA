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
<link href="static/layui-v2.4.5/layui/css/layui.css" rel="stylesheet" type="text/css" />
<link href="static/lib/zTree/v3/css/zTreeStyle/zTreeStyle.css" rel="stylesheet" type="text/css" />
<head>
    <title>Title</title>
</head>
<body>
<div id="bb">
<div class="pd-20">
    <form action="" method="post" class="form form-horizontal" id="form-purchase-add">
        <div class="row cl">
            <label class="form-label col-3"><span class="c-red">*</span>采购标题：</label>
            <div class="formControls col-5">
                <input type="text" class="input-text" v-model="sysPurchase.title" value="" placeholder="" id="title" name="title" datatype="*2-16" nullmsg="采购标题不能为空">
            </div>
            <div class="col-4"> </div>
        </div>
        <div class="row cl">
            <label class="form-label col-3"><span class="c-red">*</span>金额：</label>
            <div class="formControls col-5">
                <input type="text" id="money" v-model="sysPurchase.money"  name="money" value="" class="input-text" datatype="*" nullmsg="金额不能为空" >
            </div>

            <div class="col-4"> </div>
        </div>
        <div class="row cl">
            <label class="form-label col-3">备注：</label>
            <div class="formControls col-5">
                <textarea name="content" id="content" v-model="sysPurchase.content"  cols="" rows="" class="textarea"  placeholder="说点什么...100个字符以内" dragonfly="true" onKeyUp="textarealength(this,100)"></textarea>
                <p class="textarea-numberbar"><em class="textarea-length">0</em>/100</p>
            </div>
            <div class="col-4"> </div>
        </div>
        <div class="row cl">
            <div class="col-9 col-offset-3">
                <%--<input class="btn btn-primary radius"  type="submit" value="&nbsp;&nbsp;提交&nbsp;&nbsp;">--%>
                    <button type="button"
                            class="btn btn-success radius" @click="jump()" id="" name="">
                             添加
                    </button>
            </div>
        </div>
    </form>
</div>

    <div  class="pd-20">
        <table class="table table-border table-bordered table-hover table-bg">
            <thead>
            <tr>
                <th scope="col" colspan="7">采购信息</th>
            </tr>
            <tr class="text-c">
                <th width="25"><input type="checkbox" value="" name=""></th>
                <th width="40">采购id</th>
                <th width="100">采购标题</th>
                <th width="100">采购内容</th>
                <th width="100">金额</th>
                <th width="200">采购人</th>
                <th width="70">创建时间</th>
            </tr>
            </thead>
            <tbody>

            <tr class="text-c" v-for="(sysPurchase,index) in pageInfo.list">
                <td><input type="checkbox" v-bind:value="sysPurchase.id" v-model="check" name=""></td>
                <td>{{sysPurchase.id}}</td>
                <td>{{sysPurchase.title}}</td>
                <td>{{sysPurchase.content}}</td>
                <td>
                    {{sysPurchase.money}}
                </td>
                <td>{{sysPurchase.userName}}</td>
                <td>{{sysPurchase.createTime}}</td>
            </tr>

            </tbody>
        </table>
    </div>


</div>
<!--分页容器-->
<div id="list"></div>
<script type="text/javascript" src="static/js/vue.min.js"></script>
<script type="text/javascript" src="static/lib/jquery/1.9.1/jquery.min.js"></script>
<script type="text/javascript" src="static/lib/icheck/jquery.icheck.min.js"></script>
<script type="text/javascript" src="static/lib/Validform/5.3.2/Validform.min.js"></script>
<script type="text/javascript" src="static/lib/layer/1.9.3/layer.js"></script>
<script type="text/javascript" src="static/js/H-ui.js"></script>
<script type="text/javascript" src="static/js/H-ui.admin.js"></script>
<script type="text/javascript" src="static/layui-v2.4.5/layui/layui.js"></script>
<script type="text/javascript" src="static/lib/zTree/v3/js/jquery.ztree.all-3.5.js"></script>
<!--抽取公共分页-->
<script type="text/javascript" src="static/commonPage/page.js"></script>

<script type="text/javascript">
    var pn = 1;
    var pageSize = 3;
    var totalCount = 0;
    var url="purchase/select";
    var object={

    }

    pagination(pn,pageSize,object,url);
    var vue=new Vue({
        el:"#bb",
        data:{
            pageInfo:{},
            check:[],
            sysPurchase:{
                title:'',
                money:'',
                content:'',
            }
        },
        methods:{
            jump:function () {
               // alert(vue.sysPurchase.title)
                var pn = 1;
                var pageSize = 3;
                var totalCount = 0;
                var url="purchase/add";
                pagination(pn,pageSize,vue.sysPurchase,url)
            }
        }
    })

    $(function(){
        $('.skin-minimal input').iCheck({
            checkboxClass: 'icheckbox-blue',
            radioClass: 'iradio-blue',
            increaseArea: '20%'
        });

        /*$("#form-org-add").Validform({
            tiptype:2,
            callback:function(form){
                //表单验证通过之后，点击添加才会进入这个方法
                //通过ajax请求提交表单数据
                $.ajax({
                    url:"sysOrg/addOrg",
                    type:"POST",
                    data:$("#form-org-add").serialize(),
                    success:function (data) {
                        alert(data.msg);
                        //关闭弹出框
                        var index = parent.layer.getFrameIndex(window.name);
                        parent.$('.btn-refresh').click();
                        parent.layer.close(index);
                        parent.location.reload();
                    }
                })

            }
        });*/
    });
</script>
</body>
</html>
