<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="zh-CN">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>首页</title>
  <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap" rel="stylesheet">

  <link rel="stylesheet" type="text/css" href="main_style.css"> <!-- 引入CSS文件 -->
</head>
<body>
<div class="container">
  <div class="sidebar">
    <div class="logo">
      <img src="img/logo.png" alt="网站Logo">
    </div>
    <div class="system-name">科研管理系统</div>
    <a href="main.jsp">首页</a>
    <a href="#">检索</a>
    <a href="my_message.jsp">我的私信</a>
    <a href="sendmessage.jsp">发送私信</a>
    <c:choose>
      <c:when test="${sessionScope.role == 'admin'}">
        <a href="add_news.jsp">发布新闻</a>
        <a href="my_paper.jsp?paperFlag=1">论文审核</a>
        <a href="#">项目审核</a>
        <a href="user_management.jsp">用户管理</a>
      </c:when>


      <c:when test="${sessionScope.role == 'user'}">
        <a href="userinfo.jsp?author=${sessionScope.username}">个人信息</a>
        <a href="#" id="myPapersLink">我的论文</a>
        <a href="#">我的项目</a>
        <a href="#">我的数据</a>
      </c:when>
    </c:choose>
  </div>
  <div class="content-container">
    <div class="header">
      <div class="breadcrumb">
        <a href="#" class="back-home">返回首页</a> <!-- 修改为返回首页 -->
      </div>
      <div class="user-info">
        <span class="username"><c:out value="${sessionScope.username}" /></span>
        (<span class="role"><c:out value="${sessionScope.role}" /></span>) <!-- 修改为显示用户名和身份 -->
        <button id="changePwdBtn" class="change-password">修改密码</button>
        <a href="logout.jsp" onclick="window.history.forward(); window.location.href='login.jsp'; return false;" class="logout">退出登录</a>
      </div>

    </div>

    <div class="main-area">
      <div id="message">
        <ul class="message-list">

        </ul>
      </div>
    </div>
  </div>
</div>
<div id="changePwdModal" class="modal">
  <div class="modal-content">
    <span class="close">&times;</span>
    <h2>修改密码</h2>
    <form id="changePwdForm">
      <label for="oldPassword">旧密码:</label>
      <input type="password" id="oldPassword" name="oldPassword" required>
      <label for="newPassword">新密码:</label>
      <input type="password" id="newPassword" name="newPassword" required>
      <label for="confirmNewPassword">确认新密码:</label>
      <input type="password" id="confirmNewPassword" name="confirmNewPassword" required>
      <div class="buttons-container">
        <button type="submit" class="confirm-btn">确认</button>
        <button type="button" class="cancel-btn">取消</button>
      </div>
    </form>
  </div>
</div>
</body>

</html>
<script type="text/javascript" src="js/jquery-3.4.1.js"></script>
<script>
  $(document).ready(function() {
    $('#changePwdBtn').click(function() {
      $('#changePwdModal').css('display', 'block');
    });

    // Close modal
    $('.close, .cancel-btn').click(function() {
      $('#changePwdModal').css('display', 'none');
    });

    // Handle form submission
    $('#changePwdForm').submit(function(event) {
      event.preventDefault();

      const oldPassword = $('#oldPassword').val();
      const newPassword = $('#newPassword').val();
      const confirmNewPassword = $('#confirmNewPassword').val();

      if (newPassword !== confirmNewPassword) {
        alert('新密码和确认密码不匹配，请重新输入。');
        return;
      }

      // Send AJAX request to server
      $.ajax({
        url: '/editPwd',
        method: 'POST',
        data: {
          oldPassword: oldPassword,
          newPassword: newPassword
        },
        success: function(response) {
          alert(response.msg || '操作成功');
          $('#changePwdModal').css('display', 'none');
        },
        error: function(xhr, status, error) {
          alert('修改密码时出现错误，请重试。');
        }
      });
    });

    // Load news
    $.ajax({
      url: '/getNews',
      method: 'GET',
      success: function(response) {
        console.log('Received response:', response);
        if (response.code === 1 && response.list && response.list.length > 0) {
          var $messageList = $('#message .message-list');
          $messageList.empty(); // 清空现有列表项

          response.list.forEach(function(item) {
            var $newsItem = $('<li class="news-item"></li>')
                    .append($('<div class="news-header"></div>')
                            .append($('<h3 class="news-title"></h3>').text(item.newsTitle))
                            .append($('<div class="news-meta"></div>')
                                    .append($('<span class="news-author"></span>').text(item.newsWriter))
                                    .append($('<span class="news-time"></span>').text(item.publishTime))
                            )
                    )
                    .append($('<div class="news-content"></div>')
                            .append($('<p></p>').text(item.newsContent))
                    )
                    .append($('<div class="news-buttons"></div>')
                            .append($('<button class="view-news" data-news-id="' + item.newsId + '">查看</button>'))
                    );

            $messageList.append($newsItem);
          });
        } else {
          $('#message').html('<p>' + response.msg + '</p>');
        }
      },
      error: function() {
        $('#message').html('<p>加载数据时出错。</p>');
      }
    });

    // Handle my papers link click
    $('#myPapersLink').click(function(event) {
      event.preventDefault(); // 阻止默认行为

      // 从 session 中获取当前用户姓名
      var username = '<%= session.getAttribute("username") %>';
      var paperTitle = 'admin';

      // 构建 URL
      console.log("username:" + username);
      var url = 'my_paper.jsp?paperAuthor=' + encodeURIComponent(username) + '&paperTitle=' + encodeURIComponent(paperTitle);

      // 跳转到目标页面
      window.location.href = url;
    });

    // Handle view news button click
    $(document).on('click', '.view-news', function() {
      var newsId = $(this).data('news-id'); // 获取新闻 ID

      // 直接跳转到展示页面
      window.location.href = 'onenews_display.jsp?newsId=' + newsId;
    });
  });
</script>
</body>
</html>