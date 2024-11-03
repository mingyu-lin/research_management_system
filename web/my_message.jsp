<%@ page import="java.util.List" %>
<%@ page import="xxxx.entity.Message" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>我的私信</title>
  <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap" rel="stylesheet">
  <link rel="stylesheet" type="text/css" href="my_message_style.css"> <!-- 引入CSS文件 -->
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
    <a href="my_message.jsp">私信</a>
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
      <h1>我的私信</h1>
      <div id="messages">
        <ul class="messages-list">
          <!-- 私信列表将在这里动态加载 -->
        </ul>
      </div>
    </div>

  </div>
</div>

<script type="text/javascript" src="js/jquery-3.4.1.js"></script>
<script type="text/javascript">
  $(document).ready(function() {
    $.ajax({
      url: '/getMessages', // 假设有一个接口可以获取私信
      method: 'GET',
      success: function(response) {
        console.log('Received response:', response);
        if (response.code === 1 && response.list && response.list.length > 0) {
          var $messagesList = $('#messages .messages-list');
          $messagesList.empty(); // 清空现有列表项

          response.list.forEach(function(item) {
            console.log(item);

            // 使用 jQuery 动态创建私信项
            var $messageItem = $('<li class="message-item"></li>')
                    .append($('<span class="sender-name"></span>').text(item.senderName)) // 显示发送者姓名
                    .append($('<span class="message-content"></span>').text(item.content)) // 显示内容
                    .append($('<span class="message-time"></span>').text(new Date(item.timestamp).toLocaleString())) // 显示时间
                    .append($('<button class="reply-message" data-receiver-name="' + item.senderName + '" data-receiver-id="' + item.receiverId + '"></button>').text('回复')); // 回复按钮

            // 将生成的私信项追加到列表中
            $messagesList.append($messageItem);
            console.log($messageItem);
          });
        } else {
          $('#messages').html('<p>' + response.msg + '</p>');
        }
      },
      error: function() {
        $('#messages').html('<p>加载数据时出错。</p>');
      }
    });

    $(document).on('click', '.reply-message', function() {
      var receiverId = $(this).data('receiver-id'); // 获取接收者ID
      var receiverName = $(this).data('receiver-name'); // 获取接收者姓名
      // 跳转并填充接收者姓名和ID
      window.location.href = 'sendmessage.jsp?receiverName=' + encodeURIComponent(receiverName) + '&receiverId=' + receiverId;
    });
  });
</script>

</body>
</html>