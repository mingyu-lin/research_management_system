<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
        <a href="main.jsp" class="back-home">返回首页</a>
      </div>
      <div class="user-info">
        <span class="username"><c:out value="${sessionScope.username}" /></span>
        (<span class="role"><c:out value="${sessionScope.role}" /></span>) <!-- 修改为显示用户名和身份 -->

        <a href="logout.jsp" onclick="window.history.forward(); window.location.href='login.jsp'; return false;" class="logout">退出登录</a>
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
            <input type="text" id="newsWriter" name="newsWriter" readonly>
          </div>
          <div class="submit-container">
            <button type="submit">提交</button>
          </div>
        </form>
      </div>
    </div>
  </div>
</div>

<script type="text/javascript" src="js/jquery-3.4.1.js"></script>
<script>
  $(document).ready(function() {

    $('#newsWriter').val("${sessionScope.username}").prop('readonly', true);
    $('#addNewsForm').on('submit', function(e) {
      e.preventDefault(); // 防止默认提交行为

      // 弹出确认对话框
      if (confirm("确定要提交这条新闻吗？")) {
        // 使用 .serialize() 获取表单数据
        const formData = $(this).serialize();

        // 发送 AJAX 请求保存新闻
        $.ajax({
          url: 'AddNewsServlet', // 确保这个路径正确
          method: 'POST',
          data: formData, // 使用表单数据
          success: function(response) {
            if (response.code === 1) {
              alert("新闻添加成功！");
              // 可以在这里重定向到其他页面或刷新当前页面
              // window.location.href = 'index.jsp';
            } else {
              alert("添加新闻失败：" + response.msg);
            }
          },
          error: function() {
            alert("提交新闻时出错，请稍后再试。");
          }
        });
      } else {
        // 用户取消提交
        alert("已取消提交新闻。");
      }
    });
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