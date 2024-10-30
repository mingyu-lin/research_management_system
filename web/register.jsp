<%--
  Created by IntelliJ IDEA.
  User: 30281
  Date: 2024/10/19
  Time: 12:57
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>注册界面</title>
    <link rel="stylesheet" type="text/css" href="register_style.css"> <!-- 引入CSS文件 -->
</head>
<body>
<div id="bigBox">
    <h1>REGISTER</h1>
    <form id="registrationForm" action="/register" method="POST">
        <div class="inputBox">
            <div class="inputText">
                <span class="iconfont icon-nickname">U</span>
                <input type="text" id="userName" name="userName" placeholder="用户名" required />
            </div>
            <div class="inputText">
                <span class="iconfont icon-visible">P</span>
                <input type="password" id="userPwd" name="userPwd" placeholder="密码" required />
            </div>
            <div class="inputText">
                <span class="iconfont icon-mail">M</span>
                <input type="email" id="userEmail" name="userEmail" placeholder="邮箱" required />
            </div>
            <div class="inputText">
                <span class="iconfont icon-phone">T</span>
                <input type="text" id="userPhone" name="userPhone" placeholder="电话号码" required />
            </div>
            <!-- 添加身份选择下拉列表 -->
            <div class="inputText">
                <span class="iconfont icon-role">R</span>
                <select id="userRole" name="userRole" required>
                    <option value="admin">管理员</option>
                    <option value="teacher">教师</option>
                </select>
            </div>
            <div class="inputText">
                <span class="iconfont icon-phone">T</span>
                <input type="text" id="userPostscript" name="userPostscript" placeholder="备注" />
            </div>
            <!-- 可以根据需要添加更多的输入字段，如确认密码、昵称等 -->
        </div>
        <div class="backToLogin">
            <a href="login.html" style="text-decoration: none; color: #007bff;">返回登录</a>
        </div>
        <input class="registerButton" type="submit" value="注册" />
    </form>
</div>
</body>
<script type="text/javascript" src="js/jquery-3.4.1.js"></script>
<script type="text/javascript">
    // 这里可以添加JavaScript代码来处理注册事件
    // 例如，给注册按钮添加点击事件

    // 定义一个用于显示消息的元素
    if ($('#msg').length === 0) {
        $('body').append('<div id="msg" style="position: absolute; top: 50%; left: 50%; transform: translate(-50%, -50%); font-size: 12px; color: red;"></div>');
    }

    $('#registrationForm').on('submit', function(event) {
        event.preventDefault(); // 阻止表单默认提交行为

        var userName = $("#userName").val();
        var userPwd = $("#userPwd").val();
        var userEmail = $("#userEmail").val();
        var userPhone = $("#userPhone").val();
        var userRole = $("#userRole").val();
        var userPostscript = $("#userPostscript").val();

        // 验证必填字段
        if (isEmpty(userName)) {
            $("#msg").html("用户名不能为空");
            return;
        }
        if (isEmpty(userPwd)) {
            $("#msg").html("密码不能为空");
            return;
        }
        if (isEmpty(userEmail)) {
            $("#msg").html("邮箱不能为空");
            return;
        }
        if (isEmpty(userPhone)) {
            $("#msg").html("电话号码不能为空");
            return;
        }
        if (isEmpty(userRole)) {
            $("#msg").html("请选择身份");
            return;
        }

        // 发送 AJAX 请求
        $.ajax({
            url: "/register",
            type: "POST",
            data: {
                userName: userName,
                userPwd: userPwd,
                userEmail: userEmail,
                userPhone: userPhone,
                userRole: userRole,
                userPostscript: userPostscript
            },
            success: function(response) {
                if (response.code === 1) {
                    window.location.href = '/index.jsp';
                } else {
                    $("#msg").html(response.msg);
                }
            },
            error: function() {
                $("#msg").html("网络错误，请检查您的网络连接！");
            }
        });
    });

    function isEmpty(str) {
        return !str.trim();
    }
</script>
</html>