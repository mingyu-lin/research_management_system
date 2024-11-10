<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>添加项目</title>
  <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap" rel="stylesheet">
  <link rel="stylesheet" type="text/css" href="add_project_style.css"> <!-- 引入CSS文件 -->
</head>
<body>
<div class="container">
  <div class="sidebar">
    <div class="logo">
      <img src="img/logo.png" alt="网站Logo">
    </div>
    <div class="system-name">科研管理系统</div>
    <a href="main.jsp">首页</a>
    <a href="my_project.jsp">项目检索</a>
    <a href="my_message.jsp">我的私信</a>
    <a href="sendmessage.jsp">发送私信</a>
    <c:choose>
      <c:when test="${sessionScope.role == 'admin'}">
        <a href="add_news.jsp">发布新闻</a>
        <a href="my_project.jsp?projectFlag=1">项目审核</a>
        <a href="#">项目管理</a>
        <a href="user_management.jsp">用户管理</a>
      </c:when>

      <c:when test="${sessionScope.role == 'user'}">
        <a href="userinfo.jsp?author=${sessionScope.username}">个人信息</a>
        <a href="#">我的项目</a>
        <a href="add_project.jsp?projectManager=${sessionScope.username}">提交项目</a>
        <a href="#">提交论文</a>
        <a href="#">我的数据</a>
      </c:when>
    </c:choose>
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
      <h2>添加项目</h2>
      <form id="projectForm" action="/add_project" method="POST">
        <label for="projectTitle">项目标题:</label>
        <input type="text" id="projectTitle" name="projectTitle" required>

        <label for="projectManager">项目负责人:</label>
        <input type="text" id="projectManager" name="projectManager" readonly required>

        <label for="projectSource">项目来源:</label>
        <input type="text" id="projectSource" name="projectSource">

        <label for="projectFunding">项目资金:</label>
        <input type="text" id="projectFunding" name="projectFunding">

        <label for="projectLevel">项目等级:</label>
        <input type="text" id="projectLevel" name="projectLevel" required>

        <label for="projectBeginTime">项目开始时间:</label>
        <input type="date" id="projectBeginTime" name="projectBeginTime">

        <label for="projectEndTime">项目结束时间:</label>
        <input type="date" id="projectEndTime" name="projectEndTime">

        <div class="button-container">
          <button type="submit" id="addBtn">提交</button>
        </div>
      </form>
    </div>
  </div>
</div>

<script type="text/javascript" src="js/jquery-3.4.1.js"></script>
<script type="text/javascript">
  $(document).ready(function() {
    // 获取URL中的参数
    var urlParams = new URLSearchParams(window.location.search);

    // 填充表单输入框
    function fillFormFromParams(params) {
      if (params.has('projectTitle')) {
        $('#projectTitle').val(params.get('projectTitle'));
      }
      if (params.has('projectManager')) {
        $('#projectManager').val(params.get('projectManager'));
      }
      if (params.has('projectSource')) {
        $('#projectSource').val(params.get('projectSource'));
      }
      if (params.has('projectFunding')) {
        $('#projectFunding').val(params.get('projectFunding'));
      }
      if (params.has('projectBeginTime')) {
        $('#projectBeginTime').val(params.get('projectBeginTime'));
      }
      if (params.has('projectEndTime')) {
        $('#projectEndTime').val(params.get('projectEndTime'));
      }
      if (params.has('projectLevel')) {
        $('#projectLevel').val(params.get('projectLevel'));
      }
    }

    // 调用函数填充表单
    fillFormFromParams(urlParams);

    // 处理表单提交
    $('#projectForm').on('submit', function(event) {
      event.preventDefault(); // 阻止表单默认提交

      var projectTitle = $('#projectTitle').val();
      var projectManager = $('#projectManager').val();
      var projectSource = $('#projectSource').val();
      var projectFunding = $('#projectFunding').val();
      var projectLevel = $('#projectLevel').val();
      var projectBeginTime = $('#projectBeginTime').val();
      var projectEndTime = $('#projectEndTime').val();

      $.ajax({
        url: '/addProject', // 发送消息的后端接口
        method: 'POST',
        data: {
          projectTitle: projectTitle,
          projectManager: projectManager,
          projectSource: projectSource,
          projectFunding: projectFunding,
          projectLevel: projectLevel,
          projectBeginTime: projectBeginTime,
          projectEndTime: projectEndTime
        },
        success: function(response) {
          if (response.code === 1) {
            alert('项目添加成功!');
            // 可选择重定向或清空表单
            $('#projectForm')[0].reset();
          } else {
            alert('项目添加失败: ' + response.msg);
          }
        },
        error: function() {
          alert('发送请求时出错，请稍后重试。');
        }
      });
    });
  });
</script>
</body>
</html>
