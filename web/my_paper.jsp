<%@ page import="xxxx.entity.value.MessageModel" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>论文</title>
  <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap" rel="stylesheet">

  <link rel="stylesheet" type="text/css" href="my_paper_style.css"> <!-- 引入CSS文件 -->
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
      <div class="search-box">
        <form id="searchForm" class="search-form">
          <label for="searchType" class="search-label"></label>
          <select id="searchType" name="searchType" class="search-select">
            <option value="论文">论文</option>
            <option value="项目">项目</option>
          </select>

          <label for="searchTitle" class="search-label"></label>
          <input type="text" id="searchTitle" name="searchTitle" class="search-input" placeholder="请输入标题关键字" />

          <label for="searchAuthor" class="search-label"></label>
          <input type="text" id="searchAuthor" name="searchAuthor" class="search-input" placeholder="请输入作者/项目关键字" />

          <button type="submit" class="search-button">搜索</button>
        </form>
      </div>
      <div id="papers">
        <table class="papers-table">
          <thead>
          <tr>
            <th>标题</th>
            <th>作者</th>
            <th>等级</th>
            <th>发布时间</th>
            <th>状态</th>
            <th>操作</th>
          </tr>
          </thead>
          <tbody>

          </tbody>
        </table>
      </div>
    </div>
  </div>
</div>
</body>
<script type="text/javascript" src="js/jquery-3.4.1.js"></script>
<script type="text/javascript">
  $(document).ready(function() {
    // 使用 URLSearchParams 获取查询参数
    const urlParams = new URLSearchParams(window.location.search);
    const paperFlag = urlParams.get('paperFlag');
    const paperAuthor = urlParams.get('paperAuthor'); // 注意拼写
    const paperTitle = urlParams.get('paperTitle');
    $.ajax({
      url: '/getPaper',
      method: 'GET',
      data: {
        paperFlag: paperFlag || '', // 如果为 null，发送空字符串
        paperAuthor: paperAuthor || '%', // 如果为 null，发送空字符串
        paperTitle: paperTitle || '%' // 如果为 null，发送空字符串
      },
      success: function(response) {
        console.log('Received response:', response);
        if (response.code === 1 && response.list && response.list.length > 0) {
          var $papersTableBody = $('#papers .papers-table tbody');
          $papersTableBody.empty(); // 清空现有表格行

          response.list.forEach(function(item) {
            console.log(item);

            // 使用 jQuery 动态创建表格行
            let statusText = '';
            switch (item.paperFlag) {
              case -1:
                statusText = '待审核';
                break;
              case 0:
                statusText = '拒绝';
                break;
              case 1:
                statusText = '通过';
                break;
              default:
                statusText = '未知状态';
                break;
            }

            // 使用 jQuery 动态创建表格行
            var $paperRow = $('<tr></tr>')
                    .append($('<td></td>').text(item.paperTitle))
                    .append($('<td></td>')
                            .append($('<a class="author-link"></a>') // 添加 class
                                    .text(item.paperAuthor)
                                    .attr('href', 'userinfo.jsp?author=' + item.paperAuthor)
                            )
                    )
                    .append($('<td></td>').text(item.paperLevel))
                    .append($('<td></td>').text(item.paperPublicationTime))
                    .append($('<td></td>').text(statusText)) // 添加状态列
                    .append($('<td></td>')
                            .append($('<button class="view-paper" data-paper-id="' + item.paperId + '"></button>').text('查看'))
                    );


            // 将生成的表格行追加到表格容器中
            $papersTableBody.append($paperRow);
            console.log($paperRow);
          });
        } else {
          $('#papers').html('<p>' + response.msg + '</p>');
        }
      },
      error: function() {
        $('#papers').html('<p>加载数据时出错。</p>');
      }
    });
    $(document).on('click', '.view-paper', function() {
      var paperId = $(this).data('paper-id'); // 获取Paper ID
      window.location.href = 'onepaper_display.jsp?paperId=' + paperId; // 跳转到Paper展示页面
    });
    $('.search-button').click(function(event) {
      event.preventDefault(); // 阻止表单的默认提交

      // 获取输入框的值
      var searchTitle = $('#searchTitle').val();
      var searchAuthor = $('#searchAuthor').val();

      // 构造跳转URL，附带查询参数
      var url = 'my_paper.jsp?paperTitle=' + encodeURIComponent(searchTitle) + '&paperAuthor=' + encodeURIComponent(searchAuthor);

      // 跳转到my_paper.jsp，并附上参数
      window.location.href = url;
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
</html>