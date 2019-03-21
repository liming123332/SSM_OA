function pagination(pn,pageSize,object,url) {
    //alert(sysRole.roleName)
    object.pn=pn;
    object.pageSize=pageSize;
    //查询条件
    $.ajax({
        type: "POST",
        url: url,
        data: object,/*roleName:sysRole.roleName,flag:sysRole.flag*/
        dataType:"json",
        async: true,//这里设置为同步执行，目的是等数据加载完再调用layui分页组件，不然分页组件拿不到totalCount的值
        success: function (result) {
            //alert(result.list[0].roleName)
            for(var i=0;i<result.list.length;i++) {
                if (result.list[i].createTime != null) {
                    result.list[i].createTime = changeDate(result.list[i].createTime);
                }
                if (result.list[i].updateTime != null) {
                    result.list[i].updateTime = changeDate(result.list[i].updateTime);
                }
            }
            vue.pageInfo = result;
            totalCount = vue.pageInfo.total;

            //使用layui分页
            layui.use('laypage', function () {
                var laypage = layui.laypage;
                laypage.render({
                    elem: 'list'
                    //总条数
                    , curr:pn
                    , count: totalCount
                    , limit: pageSize
                    , limits: [2, 3, 4, 5]
                    , group: 4
                    , layout: ['count', 'prev', 'page', 'next', 'limit', 'refresh', 'skip']
                    , jump: function (obj, first) {
                        //点击非第一页页码时的处理逻辑。比如这里调用了ajax方法，异步获取分页数据
                        if (!first) {
                            pn = obj.curr;
                            pageSize = obj.limit;
                            pagination(obj.curr, obj.limit,object,url);//第二个参数不能用变量pageSize，因为当切换每页大小的时候会出问题
                        }
                    }
                });
            });
        }
    });
};

//日期格式化
function changeDate(datetimes){
    var date = new Date(datetimes);
    Y = date.getFullYear() + '-';
    M = (date.getMonth()+1 < 10 ? '0'+(date.getMonth()+1) : date.getMonth()+1) + '-';
    D = date.getDate() + ' ';
    h = date.getHours() + ':';
    m = date.getMinutes() + ':';
    s = date.getSeconds();
    //年 月 日 时 分 秒
    return Y+M+D+h+m+s;
}