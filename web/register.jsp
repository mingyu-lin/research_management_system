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
<!-- 注意：以下JavaScript部分在图片中未直接显示，但基于常规操作可能会包含 -->
<script type="text/javascript">
    // 这里可以添加JavaScript代码来处理登录、注册等事件
    // 例如，给登录按钮添加点击事件
    $('#loginBtn').click(function() {
        var uname = $("#userName").val();
        var upwd = $("#userPwd").val();
        if(isEmpty(uname)){
            $("#msg").html("用户姓名不能为空");
            return;
        }
        if(isEmpty(upwd)){
            $("#msg").html("用户密码不能为空");
            return;
        }
        $("#registrationForm").submit();
    });

    function isEmpty(str){
        if(str == null || str.trim()==""){
            return true;
        }
        return false;
    }
</script>
</html>