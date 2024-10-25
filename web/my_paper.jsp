<%@ page import="xxxx.entity.value.MessageModel" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="zh-CN">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>图片插入示例</title>
  <link rel="stylesheet" href="main_style.css">
  <style>
    .message-list {
      list-style-type: none;
      padding: 0;
      margin: 0;
    }
    .message-list li {
      background-color: #f9f9f9;
      border: 1px solid #ddd;
      padding: 10px;
      margin-bottom: 5px;
      border-radius: 4px;
    }
    .message-list li:nth-child(even) {
      background-color: #e9e9e9;
    }
  </style>
</head>
<body>
<div class="header">
  <div class="logo">
    <!-- 在这里插入您的图片 -->
    <img src="img/bglogin.png" alt="网站Logo">
  </div>
  <div class="breadcrumb">当前位置: 首页 > 用户管理</div>
  <div class="user-info">
    <span class="username">用户名</span>
    <span class="role">身份</span>
  </div>
  <a href="#" class="logout">退出登录</a>
</div>
<div class="container">
  <div class="sidebar">
    <a href="#">首页</a>
    <a href="#">我的信息</a>
    <a href="#">检索</a>
    <a href="#">我的项目</a>
    <a href="#">我的论文</a>
    <!-- 其他导航选项 -->
  </div>
  <div class="main-area">
    <div id="message">
      <ul class="message-list"></ul>
    </div>
  </div>
</div>
<script type="text/javascript" src="js/jquery-3.4.1.js"></script>
<script>
  $(document).ready(function() {
    // 使用AJAX请求获取数据
    $.ajax({
      url: '/getPaper', // 请确保这个URL与你的service方法匹配
      method: 'GET',
      success: function(response) {
        console.log('Received response:', response);
        // 假设response是JSON格式的数据
        var messageModel = response; // 这里需要根据实际情况解析返回的数据
        if (messageModel && messageModel.list && messageModel.list.length > 0) {
          var $messageList = $('#message .message-list');
          $messageList.empty(); // 清空现有的列表
          messageModel.list.forEach(function(item) {
            // 确保 item 是一个对象并且有 toString 方法
            if (item && typeof item.toString === 'function') {
              $messageList.append('<li>' + item.toString() + '</li>');
            } else {
              $messageList.append('<li>' + JSON.stringify(item) + '</li>'); // 使用 JSON.stringify 来展示 item 的内容
            }
          });
        } else {
          $('#message').html('<p>没有找到消息模型。</p>');
        }
      },
      error: function() {
        $('#message').html('<p>加载数据时出错。</p>');
      }
    });
  });
</script>
</body>
</html>