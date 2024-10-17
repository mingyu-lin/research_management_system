<%--
  Created by IntelliJ IDEA.
  User: 30281
  Date: 2024/9/8
  Time: 11:44
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>用户登录</title>
  <link rel="stylesheet" type="text/css"
        href="login_style.css"> <!-- 引入CSS文件 -->
</head>
<body>
<form action="/login" method="post" id="loginform">
  <div id="bigBox">
    <h1>LOGIN</h1>
    <div class="inputBox">
      <div class="inputText">
        <!-- 假设您已经正确引入了iconfont，并且这些类（icon-nickname, icon-visible）是有效的 -->
        <span class="iconfont icon-nickname">U</span>
        <input type="text" placeholder="Username" name="username" id="username" value="${messageModel.object.userName}"><br>
      </div>
      <div class="inputText">
        <span class="iconfont icon-visible">L</span>
        <input type="password" placeholder="Password" name="userpwd" id="userpwd" value="${messageModel.object.userPwd}"><br>
      </div>
      <span id="msg" style="font-size:12px;color:red">${messageModel.msg}</span> <br>
      <div class="role-options">
        <label>
          <input type="radio" name="role" id="roleuser" value="user" checked> 用户
        </label>
        <label>
          <input type="radio" name="role" id="roleadmin" value="admin"> 管理员
        </label>
      </div>

      <div class="forgotPwd">
        <a href="forgotPwd.jsp" style="text-decoration: none; color: #007bff;">忘记密码？</a>
      </div>
      <input class="loginBtn" type="button" id="loginBtn" value="登录" />
      <input class="registerBtn" type="button" id="regBtn" value="注册" />
    </div>
  </div>
</form>
</body>
<script type="text/javascript" src="js/jquery-3.4.1.js"></script>
<!-- 注意：以下JavaScript部分在图片中未直接显示，但基于常规操作可能会包含 -->
<script type="text/javascript">
  // 这里可以添加JavaScript代码来处理登录、注册等事件
  // 例如，给登录按钮添加点击事件
  $('#loginBtn').click(function() {
    var uname = $("#username").val();
    var upwd = $("#userpwd").val();
    if(isEmpty(uname)){
      $("#msg").html("用户姓名不能为空");
      return;
    }
    if(isEmpty(upwd)){
      $("#msg").html("用户密码不能为空");
      return;
    }
    $("#loginform").submit();
  });

  function isEmpty(str){
    if(str == null || str.trim()==""){
      return true;
    }
    return false;
  }
</script>
</html>
