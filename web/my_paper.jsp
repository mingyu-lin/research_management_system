<%@ page import="xxxx.entity.value.MessageModel" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>注册界面</title>
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
  });
</script>
</html>