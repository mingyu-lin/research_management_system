<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
        <a href="#" class="back-home">返回首页</a> <!-- 修改为返回首页 -->
      </div>
      <div class="user-info">
        <span class="username">用户名</span>(<span class="role">身份</span>) <!-- 修改为用户名（身份） -->
        <a href="#" class="logout">退出登录</a>
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
</body>

</html>
<script type="text/javascript" src="js/jquery-3.4.1.js"></script>
<script>
  $(document).ready(function() {
    $.ajax({
      url: '/getNews',
      method: 'GET',
      success: function(response) {
        console.log('Received response:', response);
        if (response.code === 1 && response.list && response.list.length > 0) {
          var $messageList = $('#message .message-list');
          $messageList.empty(); // 清空现有列表项

          response.list.forEach(function(item) {
            console.log(item);

            // 使用 jQuery 动态创建元素
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
                            .append($('<button class="view-news" data-news-id="' + item.newsId + '"></button>').text('查看'))
                    );

            // 将生成的 HTML 字符串追加到新闻列表容器中
            $messageList.append($newsItem);
            console.log($newsItem);
          });
        } else {
          $('#message').html('<p>' + response.msg + '</p>');
        }
      },
      error: function() {
        $('#message').html('<p>加载数据时出错。</p>');
      }
    });
  });
  $(document).ready(function() {
    $(document).on('click', '.view-news', function() {
      var newsId = $(this).data('news-id'); // 获取新闻 ID

      // 直接跳转到展示页面
      window.location.href = 'onenews_display.jsp?newsId=' + newsId;
    });
  });


</script>
</body>
</html>