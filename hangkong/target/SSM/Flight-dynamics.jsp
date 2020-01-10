<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/11/29 0029
  Time: 19:10
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

    <title>航班动态信息</title>
</head>
<style>
    .add_menber  li{width:33%;}
    .add_menber li .label_name, .member_content li .label_name{ width:100px !important;}
</style>
<body>
<div class="page-content clearfix">
    <div id="Member_Ratings">
        <div class="d_Confirm_Order_style">

            <form id="search_form" action="">
                <div class="search_style">
                    <ul class="search_content clearfix">
                        <li>
                            <label class="l_f">航班号：</label>
                            <input name="" type="text"  class="text_add" placeholder="输入航班号"  style=" width:190px"/>
                        </li>
                        <li>
                            <label class="l_f">机号：</label>
                            <input name="" type="text"  class="text_add" placeholder="输入航班号"  style=" width:190px"/>
                        </li>
                        <li>
                            <label class="l_f">时间：</label>
                            <input class="inline laydate-icon" id="start" style=" margin-left:10px;">
                        </li>
                        <li>
                            <button type="button" class="btn_search" onclick="search_flight()"><i class="icon-search"  ></i>查询</button>
                        </li>
                    </ul>
                </div>
                <div class="search_style">
                    <ul class="search_content clearfix">
                        <li>
                            <label class="l_f">所有航班：</label>
                            <select name="" style=" width:110px">
                                <option>---所有---</option>
                                <option>始发航班--</option>
                            </select>
                        </li>
                        <li>
                            <label class="l_f">进出港：</label>
                            <select name="" style=" width:110px">
                                <option>---所有---</option>
                                <option>进港</option>
                                </option>
                                <option>出港</option>
                            </select>
                        </li>
                        <li>
                            <label class="l_f">航空公司：</label>
                            <select name="" style=" width:110px">
                                <option>---航空公司---</option>
                                <option>东航</option>
                                <option>南航</option>
                                <option>江西南昌航空公司</option>
                            </select>
                        </li>
                        <li>
                            <label class="l_f">国内/外航班：</label>
                            <select name="" style=" width:110px">
                                <option>---所有---</option>
                                <option>国内航班</option>
                                <option>国外航班</option>
                            </select>
                        </li>
                        <li>
                            <label class="l_f">航班状态：</label>
                            <select name="" style=" width:110px">
                                <option>---所有---</option>
                                <option>延误</option>
                                <option>正常</option>
                                <option>取消</option>
                            </select>
                        </li>
                    </ul>
                </div>
            </form>
            <!---->

            <div class="table_menu_list">
                <table class="layui-hide" id="demo" lay-filter="test">

                </table>

                <script type="text/html" id="barDemo">
                    <a class="layui-btn layui-btn-primary layui-btn-xs" lay-event="detail">停用</a>
                    <a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
                    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
                </script>
            </div>
        </div>
    </div>
</div>
<!--修改图层-->


</body>
</html>

<script src="layui/layui.js"></script>
<script>
    /*查询*/
    function search_flight(){

        $("#search_form").submit();
    }

    /*-编辑*/
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
            ,url: '/flyapi' //数据接口
            ,title: '用户表'
            ,page: true //开启分页
            ,toolbar: 'default' //开启工具栏，此处显示默认图标，可以自定义模板，详见文档
            ,totalRow: true //开启合计行
            ,cols: [[ //表头


                {type: 'checkbox', fixed: 'left'}
                ,{field: 'airlineCompany', title: '航空公司',sort: true, fixed: 'left', totalRowText: '合计：'}
                ,{field: 'tkTime', title: '起飞时间'}
                ,{field: 'arTime', title: '降落时间',  sort: true, totalRow: true}
                ,{field: 'leaveCity', title: '出发城市',  sort: true}
                ,{field: 'arriveCity', title: '到达城市',  sort: true}
                ,{field: 'onTimeRate', title: '准点率',  sort: true}
                ,{field: 'flightNo', title: '航班号',  sort: true}
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
