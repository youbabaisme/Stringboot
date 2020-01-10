<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/11/28 0028
  Time: 14:22
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <link href="assets/css/bootstrap.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="css/style.css"/>
    <link rel="stylesheet" href="assets/css/ace.min.css" />
    <link rel="stylesheet" href="assets/css/font-awesome.min.css" />
    <link rel="stylesheet" href="layui/css/layui.css" media="all">
    <!--  <link rel="stylesheet" href="font/css/font-awesome.min.css" />-->

    <script type="text/javascript">
        window.jQuery || document.write("<script src='assets/js/jquery-2.0.3.min.js'>"+"<"+"/script>");
    </script>
    <script type="text/javascript">
        if("ontouchend" in document) document.write("<script src='assets/js/jquery.mobile.custom.min.js'>"+"<"+"/script>");
    </script>
    <!-- page specific plugin scripts -->

    <script src="assets/layer/layer.js" type="text/javascript" ></script>

    <title>用户列表</title>
</head>

<body>
<div class="page-content clearfix">
    <div id="Member_Ratings">
        <div class="d_Confirm_Order_style">
            <form class="search_style" id="search_form">
                <ul class="search_content clearfix">
                    <li>
                        <label class="l_f">用户账号：</label>
                        <input id="yh" type="text"  class="text_add" placeholder="输入用户账号"  />
                    </li>
                    <li>
                        <label class="l_f">用户姓名：</label>
                        <input id="xm" type="text"  class="text_add" placeholder="输入用户姓名"  />
                    </li>
                    <li>
                        <label class="l_f">手机号：</label>
                        <input id="sj" type="text"  class="text_add" placeholder="输入手机号"  />
                    </li>

                    <li style="width:90px;">
                        <button type="button" class="btn_search" onclick="querywhere()"><i class="icon-search"></i>查询</button>
                    </li>
                </ul>
            </form>
            <!---->

            <!---->
            <div class="table_menu_list">
                <table class="layui-hide" id="demo" lay-filter="test"></table>

                <script type="text/html" id="barDemo">
                    <a class="layui-btn layui-btn-primary layui-btn-xs" lay-event="detail">停用</a>
                    <a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
                    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
                </script>
            </div>
        </div>
    </div>
</div>
<!--添加用户图层-->

</body>
</html>
<script src="js/jquery-1.8.3.min.js"></script>
<script src="layui/layui.js"></script>
<script>
    /*用户-添加*/
    function querywhere(){
            var yh = $('#yh').val();
        var xm = $('#xm').val();
        var sj = $('#sj').val();
        layui.use(['table'], function() {
           var table = layui.table;
            table.render({
                elem: '#demo'
                ,height: 570
                ,url: '/selectuserwhere?yh='+yh+'&xm='+xm+"&sj="+sj //数据接口
                ,title: '用户表'
                ,page: true //开启分页
                ,toolbar: 'default' //开启工具栏，此处显示默认图标，可以自定义模板，详见文档
                ,totalRow: true //开启合计行
                ,cols: [[ //表头

                    {type: 'checkbox', fixed: 'left'}
                    ,{field: 'username', title: '账号',width:100 , sort: true, fixed: 'left', totalRowText: '合计：'}
                    ,{field: 'name', title: '姓名',width:120}
                    ,{field: 'age', title: '年龄',width:80,  sort: true, totalRow: true}
                    ,{field: 'tel', title: '电话', width:90, sort: true}
                    ,{field: 'qq', title: 'QQ', width:90, sort: true}
                    ,{field: 'rname', title: '角色', width:90, sort: true}
                    ,{field: 'add_time', title: '添加时间',  sort: true}
                    ,{field: 'state', title: '状态',width:80,  sort: true}
                    ,{field: 'id', title: 'id', hide:true}
                    ,{fixed: 'right',  align:'center', toolbar: '#barDemo'}
                ]]
            });
        })
    };
    $('#member_add').on('click', function(){
        layer.open({
            type: 1,
            title: '添加用户',
            maxmin: true,
            shadeClose: true, //点击遮罩关闭层
            area : ['800px' , ''],
            content:$('#add_menber_style'),
            btn:['提交','取消'],
            yes:function(index,layero){
                var num=0;
                var str="";
                $(".add_menber input[type$='text']").each(function(n){
                    if($(this).val()=="")
                    {

                        layer.alert(str+=""+$(this).attr("name")+"不能为空！\r\n",{
                            title: '提示框',
                            icon:0,
                        });
                        num++;
                        return false;
                    }
                });
                if(num>0){  return false;}
                else{
                    $('#add_menber_style').submit();
                    layer.alert('添加成功！',{
                        title: '提示框',
                        icon:1,
                    });
                    layer.close(index);
                }
            }
        });
    });
    /*用户-查看*/
    function member_show(title,url,id,w,h){
        layer_show(title,url+'#?='+id,w,h);
    }
    /*用户-停用*/
    function member_stop(obj,id){
        layer.confirm('确认要停用吗？',function(index){
            $(obj).parents("tr").find(".td-manage").prepend('<a style="text-decoration:none" class="btn btn-xs " onClick="member_start(this,id)" href="javascript:;" title="启用"><i class="icon-ok  bigger-120"></i></a>');
            $(obj).parents("tr").find(".td-status").html('<span class="label label-defaunt radius">已停用</span>');
            $(obj).remove();
            layer.msg('已停用!',{icon: 5,time:1000});
        });

    }
    /*用户查询*/
    function search_user(){
        $("#search_form").submit();

    }
    /*用户-启用*/
    function member_start(obj,id){
        layer.confirm('确认要启用吗？',function(index){
            $(obj).parents("tr").find(".td-manage").prepend('<a style="text-decoration:none" class="btn btn-xs btn-success" onClick="member_stop(this,id)" href="javascript:;" title="停用"><i class="icon-ok bigger-120"></i></a>');
            $(obj).parents("tr").find(".td-status").html('<span class="label label-success radius">已启用</span>');
            $(obj).remove();
            layer.msg('已启用!',{icon: 6,time:1000});
        });
    }
    /*用户-编辑*/
    function member_edit(id){
        layer.open({
            type: 1,
            title: '修改用户信息',
            maxmin: true,
            shadeClose:false, //点击遮罩关闭层
            area : ['800px' , ''],
            content:$('#add_menber_style'),
            btn:['提交','取消'],
            yes:function(index,layero){
                var num=0;
                var str="";
                $(".add_menber input[type$='text']").each(function(n){
                    if($(this).val()=="")
                    {

                        layer.alert(str+=""+$(this).attr("name")+"不能为空！\r\n",{
                            title: '提示框',
                            icon:0,
                        });
                        num++;
                        return false;
                    }
                });
                if(num>0){  return false;}
                else{
                    $('#add_menber_style').submit();
                    layer.alert('添加成功！',{
                        title: '提示框',
                        icon:1,
                    });
                    layer.close(index);
                }
            }
        });
    }
    /*用户-删除*/
    function member_del(obj,id){
        layer.confirm('确认要删除吗？',function(index){
            $(obj).parents("tr").remove();
            layer.msg('已删除!',{icon:1,time:1000});
        });
    }

    layui.use(['laydate', 'laypage', 'layer', 'table', 'carousel', 'upload', 'element', 'slider'], function(){

        var laydate = layui.laydate //日期
            ,laypage = layui.laypage //分页
            ,layer = layui.layer //弹层
            ,table = layui.table //表格
            ,carousel = layui.carousel //轮播
            ,upload = layui.upload //上传
            ,element = layui.element //元素操作
            ,slider = layui.slider //滑块


        //监听Tab切换
        element.on('tab(demo)', function(data){
            layer.tips('切换了 '+ data.index +'：'+ this.innerHTML, this, {
                tips: 1
            });
        });

        //执行一个 table 实例
         table.render({
             elem: '#demo'
             ,height: 570
             ,url: '/selectuser' //数据接口
             ,title: '用户表'
             ,page: true //开启分页
             ,toolbar: 'default' //开启工具栏，此处显示默认图标，可以自定义模板，详见文档
             ,totalRow: true //开启合计行
             ,cols: [[ //表头

                 {type: 'checkbox', fixed: 'left'}
                 ,{field: 'username', title: '账号',width:100 , sort: true, fixed: 'left', totalRowText: '合计：'}
                 ,{field: 'name', title: '姓名',width:120}
                 ,{field: 'age', title: '年龄',width:80,  sort: true, totalRow: true}
                 ,{field: 'tel', title: '电话', width:90, sort: true}
                 ,{field: 'qq', title: 'QQ', width:90, sort: true}
                 ,{field: 'rname', title: '角色', width:90, sort: true}
                 ,{field: 'add_time', title: '添加时间',  sort: true}
                 ,{field: 'state', title: '状态',width:80,  sort: true}
                 ,{field: 'id', title: 'id', hide:true}
                 ,{fixed: 'right',  align:'center', toolbar: '#barDemo'}
             ]]
         });

         //监听头工具栏事件
        table.on('toolbar(test)', function(obj){
            var checkStatus = table.checkStatus(obj.config.id)
                ,data = checkStatus.data; //获取选中的数据
            switch(obj.event){
                case 'add':
                    //layer.msg('添加');
                    //弹出添加窗体,加载添加页面
                    //ShowLay(标题,加载页面,宽,高)
                    ShowLay('添加','add.jsp',600,600);

                    break;
                case 'update':
                    if(data.length === 0){
                        layer.msg('请选择一行');
                    } else if(data.length > 1){
                        layer.msg('只能同时编辑一个');
                    } else {
                        layer.alert('编辑 [id]：'+ checkStatus.data[0].id);
                        //修改操作
                        EditLay('修改','edit.jsp',checkStatus.data[0].id,600,600);
                    }
                    break;
                case 'delete':
                    if(data.length === 0){
                        layer.msg('请选择一行');
                    } else {
                        layer.msg('删除');
                    }
                    break;
            };
        });

        //监听行工具事件
        table.on('tool(test)', function(obj){ //注：tool 是工具条事件名，test 是 table 原始容器的属性 lay-filter="对应的值"
            var data = obj.data //获得当前行数据
                ,layEvent = obj.event; //获得 lay-event 对应的值
            if(layEvent === 'detail'){
                layer.confirm('确认将该用户停用？', function(index){
                    layer.close(index);	//关闭窗口
                    var data = obj.data;
                    if(data.state=="正常"){
                        $.ajax({
                            url:"/stopuser?id="+data.id
                        })
                    }



                    //向服务端发送删除指令

                });
            } else if(layEvent === 'del'){
                layer.confirm('真的删除行么', function(index){
                    obj.del(); //删除对应行（tr）的DOM结构
                    layer.close(index);	//关闭窗口
                    var data = obj.data;
                    $.ajax({
                        url:"/deleteuser?id="+data.id
                    })


                    //向服务端发送删除指令

                });
            } else if(layEvent === 'edit'){
                layer.msg('编辑操作');
                //修改操作
                EditLay('修改','edit.jsp',data,600,600);
            }
        });

        //将日期直接嵌套在指定容器中
        var start = laydate.render({
            elem: '#start'
            ,position: 'static'
            ,calendar: true //是否开启公历重要节日
            ,mark: { //标记重要日子
              '0-10-14': '生日'
              ,'2018-08-28': '新版'
              ,'2018-10-08': '神秘'
            }
            ,done: function(value, date, endDate){
              if(date.year == 2017 && date.month == 11 && date.date == 30){
                dateIns.hint('一不小心就月底了呢');
              }
            }
            ,change: function(value, date, endDate){
              layer.msg(value)
            }
        });

        var end = laydate.render({
            elem: '#end'
        });

        //分页
        laypage.render({
            elem: 'pageDemo' //分页容器的id
            ,count: 100 //总页数
            ,skin: '#1E9FFF' //自定义选中色值
            //,skip: true //开启跳页
            ,jump: function(obj, first){
                if(!first){
                    layer.msg('第'+ obj.curr +'页', {offset: 'b'});
                }
            }
        });



        function FrameWH() {
            var h = $(window).height() - 164;
            $("iframe").css("height", h + "px");
        }
        $(window).resize(function() {
            FrameWH();
        });





        function ShowLay(title, url, w, h) {

            if(title == null || title == '') {
                title = false;
            };
            if(url == null || url == '') {
                url = "404.html";
            };
            if(w == null || w == '') {
                w = ($(window).width() * 0.9);
            };
            if(h == null || h == '') {
                h = ($(window).height() - 50);
            };
            layer.open({
                type: 2,
                area: [w + 'px', h + 'px'],
                fix: false, //不固定
                maxmin: true,
                shadeClose: true,
                shade: 0.4,
                title: title,
                content: url,
                end:function(layero, index) {
                    //向iframe页的id=house的元素传值  // 参考 https://yq.aliyun.com/ziliao/133150


                    table.render({
                        elem: '#demo'
                        ,height: 570

                        ,url: '/selectuser' //数据接口
                        ,title: '用户表'
                        ,page: true //开启分页
                        ,toolbar: 'default' //开启工具栏，此处显示默认图标，可以自定义模板，详见文档
                        ,totalRow: true //开启合计行
                        ,cols: [[ //表头

                            {type: 'checkbox', fixed: 'left'}
                            ,{field: 'username', title: '账号',width:100 , sort: true, fixed: 'left', totalRowText: '合计：'}
                            ,{field: 'name', title: '姓名',width:120}
                            ,{field: 'age', title: '年龄',width:80,  sort: true, totalRow: true}
                            ,{field: 'tel', title: '电话', width:90, sort: true}
                            ,{field: 'qq', title: 'QQ', width:90, sort: true}
                            ,{field: 'rname', title: '角色', width:90, sort: true}
                            ,{field: 'add_time', title: '添加时间',  sort: true}
                            ,{field: 'state', title: '状态',width:80,  sort: true}
                            ,{field: 'id', title: 'id', hide:true}
                            ,{fixed: 'right',  align:'center', toolbar: '#barDemo'}
                        ]]
                    });
                }
            });
        }

        /!*弹出层+传递ID参数*!/
        function EditLay(title, url,data, w, h) {

            if(title == null || title == '') {
                title = false;
            };
            if(url == null || url == '') {
                url = "404.html";
            };
            if(w == null || w == '') {
                w = ($(window).width() * 0.9);
            };
            if(h == null || h == '') {
                h = ($(window).height() - 50);
            };
            layer.open({
                type: 2,
                area: [w + 'px', h + 'px'],
                fix: false, //不固定
                maxmin: true,
                shadeClose: true,
                shade: 0.4,
                title: title,
                content: url,
                success:function(layero, index) {
                    var body = layer.getChildFrame('body', index);
                    body.contents().find("#id").val(data.id);
                    body.contents().find("#rname").val(data.rname);
                    body.contents().find("#name").val(data.name);
                    body.contents().find("#username").val(data.username);
                    body.contents().find("#tel").val(data.tel);
                    body.contents().find("#qq").val(data.qq);
                    body.contents().find("#age").val(data.age);
                },
                end:function(layero, index) {

                    table.render({
                        elem: '#demo'
                        ,height: 570

                        ,url: '/selectuser' //数据接口
                        ,title: '用户表'
                        ,page: true //开启分页
                        ,toolbar: 'default' //开启工具栏，此处显示默认图标，可以自定义模板，详见文档
                        ,totalRow: true //开启合计行
                        ,cols: [[ //表头

                            {type: 'checkbox', fixed: 'left'}
                            ,{field: 'username', title: '账号',width:100 , sort: true, fixed: 'left', totalRowText: '合计：'}
                            ,{field: 'name', title: '姓名',width:120}
                            ,{field: 'age', title: '年龄',width:80,  sort: true, totalRow: true}
                            ,{field: 'tel', title: '电话', width:90, sort: true}
                            ,{field: 'qq', title: 'QQ', width:90, sort: true}
                            ,{field: 'rname', title: '角色', width:90, sort: true}
                            ,{field: 'add_time', title: '添加时间',  sort: true}
                            ,{field: 'state', title: '状态',width:80,  sort: true}
                            ,{field: 'id', title: 'id', hide:true}
                            ,{fixed: 'right',  align:'center', toolbar: '#barDemo'}
                        ]]
                    });
                },
                error: function(layero, index) {
                    alert("异常错误！");
                }
            });
        }



    });
</script>