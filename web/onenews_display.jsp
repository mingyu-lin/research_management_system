<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html lang="zh-CN">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>新闻展示界面</title>
  <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap" rel="stylesheet">
  <link rel="stylesheet" type="text/css" href="onenews_style.css"> <!-- 引入CSS文件 -->
</head>
<body>
<div class="container">
  <div class="sidebar">
    <div class="logo">
      <img src="img/logo.png" alt="网站Logo">
    </div>
    <div class="system-name">科研管理系统</div>
    <a href="main.jsp">首页</a>
    <a href="my_paper.jsp">检索</a>
    <a href="my_message.jsp">我的私信</a>
    <a href="sendmessage.jsp">发送私信</a>
    <c:choose>
      <c:when test="${sessionScope.role == 'admin'}">
        <a href="add_news.jsp">发布新闻</a>
        <a href="my_paper.jsp?paperFlag=1">论文审核</a>
        <a href="my_project.jsp?projectFlag=1">项目审核</a>
        <a href="user_management.jsp">用户管理</a>
      </c:when>


      <c:when test="${sessionScope.role == 'user'}">
        <a href="userinfo.jsp?author=${sessionScope.username}">个人信息</a>
        <a href="#" id="myPapersLink">我的论文</a>
        <a href="#" id="myProjectLink">我的项目</a>
        <a href="add_paper.jsp?paperAuthor=${sessionScope.username}">提交论文</a>
        <a href="add_project.jsp?projectManager=${sessionScope.username}">提交项目</a>
        <a href="mydata.jsp">我的数据</a>
      </c:when>
    </c:choose>
  </div>
  <div class="content-container">
    <div class="header">
      <div class="breadcrumb">
        <a href="#" class="back-home">返回首页</a>
      </div>
      <div class="user-info">
        <span class="username"><c:out value="${sessionScope.username}" /></span>
        (<span class="role"><c:out value="${sessionScope.role}" /></span>) <!-- 修改为显示用户名和身份 -->

        <a href="logout.jsp" onclick="window.history.forward(); window.location.href='login.jsp'; return false;" class="logout">退出登录</a>
      </div>
    </div>

    <div class="main-area">
      <div id="message">
        <!-- 新闻内容将通过 JavaScript 动态填充 -->

        </div>
      <div class="news-buttons">
        <button id="delete-button" class="view-news" style="display: none;">删除</button>
      </div>

    </div>
    </div>
  </div>
</div>

<script type="text/javascript" src="js/jquery-3.4.1.js"></script>
<script>
  const userInfo = {
    username: "<%= session.getAttribute("username") %>",
    role: "<%= session.getAttribute("role") %>"
  };

  document.addEventListener("DOMContentLoaded", () => {
    const usernameElement = document.querySelector('.username');
    const roleElement = document.querySelector('.role');
    usernameElement.textContent = userInfo.username;
    roleElement.textContent = userInfo.role;

    // 显示删除按钮（仅限 admin）
    if (userInfo.role === "admin") {
      document.getElementById('delete-button').style.display = 'block';
    }
    // 获取新闻 ID
    const urlParams = new URLSearchParams(window.location.search);
    const newsId = urlParams.get('newsId');

    // 发送 AJAX 请求获取新闻详情
    if (newsId) {
      $.ajax({
        url: 'OneNewsGetServlet',
        method: 'GET',
        data: { newsId: newsId },
        success: function(response) {
          console.log("test");
          console.log('Message Model:', response);
          if (response.code === 1 && response.object) {
            const news = response.object;
            console.log('Received news:', news);

            const formattedTime = new Date(news.publishTime).toLocaleString();
            const $newsItem = $('<div class="news-item"></div>')
                    .append($('<h3 class="news-title"></h3>').text(news.newsTitle))
                    .append($('<div class="news-meta"></div>')
                            .append($('<span class="news-time"></span>').text(news.publishTime))
                            .append($('<span class="news-author"></span>').text(news.newsWriter))
                    )
                    .append($('<div class="news-content"></div>')
                            .append($('<p></p>').text(news.newsContent))
                    );

            // 将生成的 HTML 结构添加到页面中
            $('#message').html($newsItem);
            //console.log(newsItem); // 打印生成的 HTML 代码

          } else {
            $('#message').html('<p>未找到该新闻。</p>');
          }
        },


        error: function() {
          $('#message').html('<p>加载新闻时出错，请稍后再试。</p>');
        }
      });
    }
  });
  document.getElementById('delete-button').addEventListener('click', () => {
    const newsId = new URLSearchParams(window.location.search).get('newsId');

    if (confirm("确定要删除这条新闻吗？")) {
      $.ajax({
        url: 'DeleteNewsServlet', // 删除新闻的 servlet
        method: 'POST',
        data: { newsId: newsId },
        success: function(response) {
          if (response.code === 1) {
            alert("新闻删除成功！");
            window.location.href = 'newsList.jsp'; // 重定向到新闻列表页
          } else {
            alert("删除失败，请重试。");
          }
        },
        error: function() {
          alert("删除时出错，请稍后再试。");
        }
      });
    }
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
    $('#myProjectLink').click(function(event) {
      event.preventDefault(); // 阻止默认行为

      // 从 session 中获取当前用户姓名
      var username = '<%= session.getAttribute("username") %>';
      var paperTitle = 'admin';

      // 构建 URL
      console.log("username:" + username);
      var url = 'my_project.jsp?projectManager=' + encodeURIComponent(username) + '&projectTitle=' + encodeURIComponent(paperTitle);

      // 跳转到目标页面
      window.location.href = url;
    });
  });

</script>
</body>
</html>
