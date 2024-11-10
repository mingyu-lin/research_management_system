<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>添加论文</title>
  <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

  <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap" rel="stylesheet">
  <link rel="stylesheet" type="text/css" href="mydata.css"> <!-- 引入CSS文件 -->
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
      <h2>数据可视化</h2>

      <div class="chart-container">
        <h3>全部论文分布情况</h3>
        <canvas id="allPapersChart"></canvas>
        <p>描述全部论文的等级分布情况。</p>
      </div>

      <div class="chart-container">
        <h3>当前用户论文分布情况</h3>
        <canvas id="userPapersChart"></canvas>
        <p>描述当前用户论文的等级分布情况。</p>
      </div>

      <div class="chart-container">
        <h3>全部项目分布情况</h3>
        <canvas id="allProjectsChart"></canvas>
        <p>描述全部项目的等级分布情况。</p>
      </div>

      <div class="chart-container">
        <h3>当前用户项目分布情况</h3>
        <canvas id="userProjectsChart"></canvas>
        <p>描述当前用户项目的等级分布情况。</p>
      </div>
    </div>


  </div>
</div>

<script type="text/javascript" src="js/jquery-3.4.1.js"></script>


<script type="text/javascript">

  document.addEventListener("DOMContentLoaded", function() {
    // 测试数据
    const allPapersData = { counts: [5, 10, 15, 20, 25], avgRatings: [1.2, 2.3, 3.1, 4.0, 4.8] };
    const userPapersData = { counts: [3, 5, 8, 6, 10], avgRatings: [1.0, 2.5, 3.0, 4.2, 4.5] };
    const allProjectsData = { counts: [6, 12, 18, 15, 10], avgRatings: [1.5, 2.6, 3.3, 4.1, 4.9] };
    const userProjectsData = { counts: [2, 7, 6, 5, 8], avgRatings: [1.3, 2.4, 3.2, 4.0, 4.4] };

    // 初始化图表
    function createChart(ctx, data, label, backgroundColor, avgRatings) {
      new Chart(ctx, {
        type: 'bar',
        data: {
          labels: ['等级 1', '等级 2', '等级 3', '等级 4', '等级 5'],
          datasets: [{
            label: label,
            data: data.counts,
            backgroundColor: backgroundColor
          }]
        },
        options: {
          scales: { y: { beginAtZero: true } },
          plugins: {
            tooltip: {
              callbacks: {
                label: function(context) {
                  const avgRating = avgRatings[context.dataIndex];
                  return `数量: ${context.raw}, 平均等级: ${avgRating}`;
                }
              }
            }
          }
        }
      });
    }

    createChart(document.getElementById('allPapersChart').getContext('2d'), allPapersData, '所有论文', 'rgba(92, 126, 250, 0.7)', allPapersData.avgRatings);
    createChart(document.getElementById('userPapersChart').getContext('2d'), userPapersData, '用户论文', 'rgba(255, 99, 132, 0.7)', userPapersData.avgRatings);
    createChart(document.getElementById('allProjectsChart').getContext('2d'), allProjectsData, '所有项目', 'rgba(54, 162, 235, 0.7)', allProjectsData.avgRatings);
    createChart(document.getElementById('userProjectsChart').getContext('2d'), userProjectsData, '用户项目', 'rgba(255, 206, 86, 0.7)', userProjectsData.avgRatings);

    // 总体评价
    const summaryDiv = document.createElement("div");
    summaryDiv.classList.add("summary");
    summaryDiv.innerHTML = `
        <p>您的论文表现高于平均水平，项目表现接近平均水平。</p>
        <p>建议您在后续工作中继续提升！</p>
    `;
    document.querySelector(".content-container").appendChild(summaryDiv);
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