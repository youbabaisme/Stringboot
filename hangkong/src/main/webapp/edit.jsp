<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/11/26 0026
  Time: 10:43
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <title>Layui</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="layui/css/layui.css"  media="all">
    <!-- 注意：如果你直接复制所有代码到本地，上述css路径需要改成你本地的 -->
</head>
<body style="padding:15px;">


<form class="layui-form" action="/edit" lay-filter="example">

    <div class="layui-form-item">
        <label class="layui-form-label">id</label>
        <div class="layui-input-block">
            <input type="text" id="id" name="id" lay-verify="title" autocomplete="off" placeholder="请输入标题" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">账号</label>
        <div class="layui-input-block">
            <input type="text" id="username" name="username" lay-verify="title" autocomplete="off" placeholder="请输入标题" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">姓名</label>
        <div class="layui-input-block">
            <input type="text" id="name" name="name" lay-verify="title" autocomplete="off" placeholder="请输入标题" class="layui-input">
        </div>
    </div>
   <div class="layui-form-item">
    <label class="layui-form-label">年龄</label>
    <div class="layui-input-block">
        <input type="text" id="age" name="age" lay-verify="title" autocomplete="off" placeholder="请输入标题" class="layui-input">
    </div>
    </div>
    <div class="layui-form-item">
    <label class="layui-form-label">电话</label>
    <div class="layui-input-block">
        <input type="text" id="tel" name="tel" lay-verify="title" autocomplete="off" placeholder="请输入标题" class="layui-input">
    </div>
    </div>
    <div class="layui-form-item">
    <label class="layui-form-label">QQ</label>
    <div class="layui-input-block">
        <input type="text" id="qq" name="qq" lay-verify="title" autocomplete="off" placeholder="请输入标题" class="layui-input">
    </div>
    </div>
    <div class="layui-form-item">
    <label class="layui-form-label">角色</label>
    <div class="layui-input-block">
        <input type="text" id="rname" name="rname" lay-verify="title" autocomplete="off" placeholder="请输入标题" class="layui-input">
    </div>
    </div>




    <div class="layui-form-item">
        <div class="layui-input-block">
            <button type="submit" class="layui-btn" lay-submit="" lay-filter="demo1">立即提交</button>
        </div>
    </div>
</form>

</form>

<script src="layui/layui.js" charset="utf-8"></script>
<!-- 注意：如果你直接复制所有代码到本地，上述js路径需要改成你本地的 -->
<script>
    layui.use(['form', 'layedit', 'laydate'], function(){
        var form = layui.form
            ,layer = layui.layer
            ,layedit = layui.layedit
            ,laydate = layui.laydate;

        //日期
        laydate.render({
            elem: '#date'
        });
        laydate.render({
            elem: '#date1'
        });

        //创建一个编辑器
        var editIndex = layedit.build('LAY_demo_editor');

        //自定义验证规则


        //监听指定开关
        form.on('switch(switchTest)', function(data){
            layer.msg('开关checked：'+ (this.checked ? 'true' : 'false'), {
                offset: '6px'
            });
            layer.tips('温馨提示：请注意开关状态的文字可以随意定义，而不仅仅是ON|OFF', data.othis)
        });

        //监听提交
        form.on('submit(demo1)', function(data){
            /*layer.alert(JSON.stringify(data.field), {
                title: '最终的提交信息'
            })*/
            var index = parent.layer.getFrameIndex(window.name);
            parent.layer.close(index);
            $('.layui-form').submit();
            return false;
        });

        //表单赋值
        layui.$('#LAY-component-form-setval').on('click', function(){
            form.val('example', {
                "username": "贤心" // "name": "value"
                ,"password": "123456"
                ,"interest": 1
                ,"like[write]": true //复选框选中状态
                ,"close": true //开关状态
                ,"sex": "女"
                ,"desc": "我爱 layui"
            });
        });

        //表单取值
        layui.$('#LAY-component-form-getval').on('click', function(){
            var data = form.val('example');
            alert(JSON.stringify(data));
        });

    });
</script>

</body>
</html>