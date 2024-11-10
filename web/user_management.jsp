<%@ page import="xxxx.entity.User" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>用户管理</title>
  <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap" rel="stylesheet">
  <link rel="stylesheet" type="text/css" href="user_management_style.css"> <!-- 引入CSS文件 -->
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
      <div id="user-list">
        <table class="user-table">
          <thead>
          <tr>
            <th>用户名</th>
            <th>邮箱</th>
            <th>电话</th>
            <th>注册时间</th>
            <th>操作</th>
          </tr>
          </thead>
          <tbody>
          <!-- 用户数据将在这里填充 -->
          </tbody>
        </table>
      </div>
    </div>
  </div>
</div>

<script type="text/javascript" src="js/jquery-3.4.1.js"></script>
<script type="text/javascript">
  $(document).ready(function() {
    // 获取用户列表
    $.ajax({
      url: '/getUserList',
      method: 'GET',
      success: function(response) {
        if (response.code === 1 && response.list && response.list.length > 0) {
          var $userTableBody = $('#user-list .user-table tbody');
          $userTableBody.empty(); // 清空现有表格行

          response.list.forEach(function(item) {
            // 动态生成表格行
            var $userRow = $('<tr></tr>')
                    .append($('<td></td>').text(item.userName))
                    .append($('<td></td>').text(item.userEmail))
                    .append($('<td></td>').text(item.userPhone))
                    .append($('<td></td>').text(item.userCreateTime))
                    .append($('<td></td>')
                            .append($('<button class="view-user" data-user-id="' + item.userId + '">查看</button>'))
                            .append(' ')
                            .append($('<button class="delete-user" data-user-id="' + item.userId + '">删除</button>'))
                    );

            $userTableBody.append($userRow);
          });
        } else {
          $('#user-list').html('<p>' + response.msg + '</p>');
        }
      },
      error: function() {
        $('#user-list').html('<p>加载数据时出错。</p>');
      }
    });

    // 删除用户
    $(document).on('click', '.delete-user', function() {
      var userId = $(this).data('user-id');
      if (confirm("确定删除该用户吗？")) {
        $.ajax({
          url: '/deleteUser',
          method: 'POST',
          data: { userId: userId },
          success: function(response) {
            if (response.code === 1) {
              alert('用户删除成功！');
              location.reload(); // 刷新页面以更新用户列表
            } else {
              alert('删除失败：' + response.msg);
            }
          },
          error: function() {
            alert('删除时出错，请稍后再试。');
          }
        });
      }
    });
    $(document).on('click', '.view-user', function() {
      var userId = $(this).data('user-id');
      var userName = $(this).closest('tr').find('td:eq(0)').text(); // 获取同一行的第一个单元格的文本（用户名）
      window.location.href = 'userinfo.jsp?author=' + encodeURIComponent(userName);
    });

  });
</script>
</body>
</html>
