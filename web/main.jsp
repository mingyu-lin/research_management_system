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
      <%
        // 从 session 中获取 MessageModel 对象
        MessageModel messageModel = (MessageModel) session.getAttribute("messageModel");
        if (messageModel != null) {
          out.println("<p>" + messageModel.getMsg() + "</p>");
          if (messageModel.getObject() != null) {
            out.println("<p>Object: " + messageModel.getObject().toString() + "</p>");
          }
          if (messageModel.getList() != null && !messageModel.getList().isEmpty()) {
            out.println("<ul class='message-list'>");
            for (Object item : messageModel.getList()) {
              out.println("<li>" + item.toString() + "</li>");
            }
            out.println("</ul>");
          }
          if (messageModel.getCount() != null) {
            out.println("<p>Count: " + messageModel.getCount() + "</p>");
          }
        } else {
          out.println("<p>没有找到消息模型。</p>");
        }
      %>
    </div>
  </div>
</div>
<form id="newsForm" action="/getNews" method="GET">
  <button type="submit" style="display: none;">获取消息</button>
</form>
<script type="text/javascript" src="js/jquery-3.4.1.js"></script>
<script>
  $(document).ready(function() {
    // 页面加载完成后自动提交表单
    $('#newsForm').submit();
  });
</script>
</body>
</html>