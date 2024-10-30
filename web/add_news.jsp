<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="zh-CN">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>添加新闻</title>
  <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap" rel="stylesheet">
  <link rel="stylesheet" type="text/css" href="add_news_style.css"> <!-- 引入CSS文件 -->
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
      <div id="message">
        <h2>添加新闻</h2>
        <form id="addNewsForm">
          <div>
            <label for="newsTitle">标题：</label>
            <input type="text" id="newsTitle" name="newsTitle" required>
          </div>
          <div>
            <label for="newsContent">内容：</label>
            <textarea id="newsContent" name="newsContent" required></textarea>
          </div>
          <div>
            <label for="newsWriter">作者：</label>
            <input type="text" id="newsWriter" name="newsWriter" required>
          </div>
          <button type="submit">提交</button>
        </form>
      </div>
    </div>
  </div>
</div>

<script type="text/javascript" src="js/jquery-3.4.1.js"></script>
<script>
  $(document).ready(function() {
    const userInfo = {
      username: "张三",
      role: "管理员"
    };

    $('.username').text(userInfo.username);
    $('.role').text(userInfo.role);

    $('#addNewsForm').on('submit', function(e) {
      e.preventDefault(); // 防止默认提交行为

      // 使用 .serialize() 获取表单数据
      const formData = $(this).serialize();

      // 发送 AJAX 请求保存新闻
      $.ajax({
        url: 'AddNewsServlet', // 确保这个路径正确
        method: 'POST',
        data: formData, // 使用表单数据
        success: function(response) {
          if (response.code === 1) {
            $('#message').html('<p>新闻添加成功！</p>');
          } else {
            $('#message').html('<p>添加新闻失败：' + response.msg + '</p>');
          }
        },
        error: function() {
          $('#message').html('<p>提交新闻时出错，请稍后再试。</p>');
        }
      });
    });
  });
</script>

</body>
</html>
