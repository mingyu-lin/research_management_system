<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>发送私信</title>
  <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap" rel="stylesheet">
  <link rel="stylesheet" type="text/css" href="sendmessage_style.css"> <!-- 引入CSS文件 -->
</head>
<body>
<div class="container">
  <div class="sidebar">
    <div class="logo">
      <img src="img/logo.png" alt="网站Logo">
    </div>
    <div class="system-name">科研管理系统</div>
    <a href="#">首页</a>
    <a href="#">检索</a>
    <a href="#">私信</a>
    <a href="#">个人信息</a>
    <a href="#">我的论文</a>
    <a href="#">我的项目</a>
  </div>
  <div class="content-container">
    <div class="header">
      <div class="breadcrumb">
        <a href="#" class="back-home">返回首页</a>
      </div>
      <div class="user-info">
        <span class="username">用户名</span>(<span class="role">身份</span>)
        <a href="#" class="logout">退出登录</a>
      </div>
    </div>

    <div class="main-area">
      <h2>发送私信</h2>
      <form id="messageForm">
        <label for="receiverName">接收者:</label>
        <input type="text" id="receiverName" name="receiverName">

        <label for="messageContent">消息内容:</label>
        <textarea id="messageContent" name="messageContent" rows="4" required></textarea>


        <button type="submit" id="sendBtn">发送</button>

      </form>
    </div>
  </div>
</div>

<script type="text/javascript" src="js/jquery-3.4.1.js"></script>
<script type="text/javascript">
  $(document).ready(function() {
    // 从 URL 中获取接收者姓名并填充到输入框中
    var urlParams = new URLSearchParams(window.location.search);
    var receiverName = urlParams.get('receiverName');
    if (receiverName) {
      $('#receiverName').val(receiverName);
    }

    // 处理表单提交
    $('#messageForm').on('submit', function(event) {
      event.preventDefault(); // 防止表单默认提交

      var messageContent = $('#messageContent').val();
      var receiverName = $('#receiverName').val();

      $.ajax({
        url: '/sendMessage', // 发送消息的后端接口
        method: 'POST',

        data: {
          receiverName: receiverName,
          content: messageContent
        },
        success: function(response) {
          if (response.code === 1) {
            alert('消息发送成功!');
            // 可选择重定向或清空表单
            $('#messageForm')[0].reset();
          } else {
            alert('消息发送失败: ' + response.msg);
          }
        },
        error: function() {
          alert('发送请求时出错，请稍后重试。');
        }
      });
    });
  });
</script>
</body>
</html>
