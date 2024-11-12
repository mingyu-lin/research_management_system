<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>用户登录</title>
  <link rel="stylesheet" type="text/css" href="login_style.css">
</head>
<body>
<%
  // 设置响应头，禁止浏览器缓存页面
  response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1.
  response.setHeader("Pragma", "no-cache"); // HTTP 1.0.
  response.setDateHeader("Expires", 0); // Proxies.
%>
<form action="/login" method="post" id="loginform">
  <h2 class="system-title">科研管理系统</h2>
  <div id="bigBox">
    <h1>LOGIN</h1>
    <div class="inputBox">
      <div class="inputText">
        <span class="iconfont icon-nickname">U</span>
        <input type="text" placeholder="Username" name="username" id="username" maxlength="20">
      </div>
      <div class="inputText">
        <span class="iconfont icon-visible">P</span>
        <input type="password" placeholder="Password" name="userpwd" id="userpwd" maxlength="20">
      </div>
      <div class="inputText role">
        <span class="iconfont icon-role">R</span>
        <select name="role" id="roleSelect">
          <option value="user" selected>用户</option>
          <option value="admin">管理员</option>
        </select>
      </div>
      <div class="inputText captcha">
        <span class="iconfont icon-visible">C</span>
        <input type="text" placeholder="请输入验证码" name="captcha" id="captcha">
        <img src="img/captcha.jpg" class="captcha-img">
      </div>
      <span id="msg" style="font-size:12px;color:red"></span>

      <input class="loginBtn" type="button" id="loginBtn" value="登录" />
      <div class="links">
        <a href="forgotPwd.jsp" class="forgotPwd">忘记密码？</a>
        <a href="register.jsp" class="registerLink">注册账号</a>
      </div>
    </div>
  </div>
</form>
</body>
<script type="text/javascript" src="js/jquery-3.4.1.js"></script>
<script type="text/javascript">
  $('#loginBtn').click(function() {
    var uname = $("#username").val();
    var upwd = $("#userpwd").val();
    var captcha = $("#captcha").val();
    if(isEmpty(uname)){
      $("#msg").html("用户名不能为空");
      return;
    }
    if(isEmpty(upwd)){
      $("#msg").html("密码不能为空");
      return;
    }
    if(isEmpty(captcha) || captcha !== '7364'){
      $("#msg").html("验证码错误");
      return;
    }
    $.ajax({
      url: "/login",
      type: "POST",
      data: {
        username: uname,
        userpwd: upwd,
        role: $("#roleSelect").val()
      },
      success: function(response) {
        if (response.code === 1) {
          window.location.href = '/main.jsp';
        } else {
          $("#msg").html(response.msg);
        }
      },
      error: function() {
        $("#msg").html("网络错误，请检查您的网络连接！");
      }
    });
  });

  function isEmpty(str){
    return !str.trim();
  }
</script>
</html>
