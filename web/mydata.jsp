<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>添加论文</title>
  <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/chartjs-plugin-datalabels"></script> <!-- 引入显示百分比的插件 -->

  <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap" rel="stylesheet">
  <link rel="stylesheet" type="text/css" href="mydata.css">
  <style>
    .chart-container {
      width: 45%;
      margin: 2%;
      display: inline-block;
      vertical-align: top;
    }
    .chart-group {
      display: flex;
      justify-content: space-between;
      margin-bottom: 20px;
    }
  </style>
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

      <!-- 论文等级分布 -->
      <div class="chart-group">
        <div class="chart-container">
          <h3>用户论文等级分布</h3>
          <canvas id="userPapersPieChart"></canvas>
          <p id="userPapersComment"></p>
        </div>
        <div class="chart-container">
          <h3>全体论文等级分布</h3>
          <canvas id="allPapersPieChart"></canvas>
          <p id="allPapersComment"></p>
        </div>
      </div>

      <!-- 项目等级分布 -->
      <div class="chart-group">
        <div class="chart-container">
          <h3>用户项目等级分布</h3>
          <canvas id="userProjectsPieChart"></canvas>
          <p id="userProjectsComment"></p>
        </div>
        <div class="chart-container">
          <h3>全体项目等级分布</h3>
          <canvas id="allProjectsPieChart"></canvas>
          <p id="allProjectsComment"></p>
        </div>
      </div>

      <!-- 论文发表时间分布 -->
      <div class="chart-container">
        <h3>论文发表时间分布</h3>
        <canvas id="papersTimeBarChart"></canvas>
        <p id="papersTimeComment"></p>
      </div>

      <!-- 项目资金分布 -->
      <div class="chart-container">
        <h3>项目资金分布</h3>
        <canvas id="projectsFundsBarChart"></canvas>
        <p id="projectsFundsComment"></p>
      </div>
    </div>
  </div>
</div>

<script type="text/javascript" src="js/jquery-3.4.1.js"></script>
<script type="text/javascript">
  document.addEventListener("DOMContentLoaded", function() {
    // 测试数据
    const userPapersPieData = {
      labels: ['等级 1', '等级 2', '等级 3', '等级 4', '等级 5'],
      datasets: [{
        data: [3, 5, 8, 6, 10],
        backgroundColor: ['#FF6384', '#36A2EB', '#FFCE56', '#4BC0C0', '#9966FF']
      }]
    };
    const allPapersPieData = {
      labels: ['等级 1', '等级 2', '等级 3', '等级 4', '等级 5'],
      datasets: [{
        data: [5, 10, 15, 20, 25],
        backgroundColor: ['#FF6384', '#36A2EB', '#FFCE56', '#4BC0C0', '#9966FF']
      }]
    };
    const userProjectsPieData = {
      labels: ['等级 1', '等级 2', '等级 3', '等级 4', '等级 5'],
      datasets: [{
        data: [2, 7, 6, 5, 8],
        backgroundColor: ['#FF6384', '#36A2EB', '#FFCE56', '#4BC0C0', '#9966FF']
      }]
    };
    const allProjectsPieData = {
      labels: ['等级 1', '等级 2', '等级 3', '等级 4', '等级 5'],
      datasets: [{
        data: [6, 12, 18, 15, 10],
        backgroundColor: ['#FF6384', '#36A2EB', '#FFCE56', '#4BC0C0', '#9966FF']
      }]
    };
    const papersTimeBarData = {
      labels: ['2020', '2021', '2022', '2023'],
      datasets: [{
        label: '论文数量',
        data: [10, 15, 20, 25],
        backgroundColor: 'rgba(92, 126, 250, 0.7)'
      }]
    };
    const projectsFundsBarData = {
      labels: ['<10万', '10-50万', '50-100万', '>100万'],
      datasets: [{
        label: '项目数量',
        data: [5, 10, 15, 5],
        backgroundColor: 'rgba(54, 162, 235, 0.7)'
      }]
    };

    // 初始化图表
    function createPieChart(ctx, data) {
      new Chart(ctx, {
        type: 'pie',
        data: data,
        options: {
          plugins: {
            datalabels: {
              formatter: (value, context) => {
                let sum = context.chart.data.datasets[0].data.reduce((a, b) => a + b, 0);
                let percentage = (value / sum * 100).toFixed(1) + '%';
                return percentage;
              },
              color: '#fff',
              font: {
                weight: 'bold'
              }
            },
            tooltip: {
              callbacks: {
                label: (context) => `等级 ${context.label}: ${context.raw}`
              }
            }
          }
        }
      });
    }

    function createBarChart(ctx, data) {
      new Chart(ctx, {
        type: 'bar',
        data: data,
        options: {
          scales: { y: { beginAtZero: true } }
        }
      });
    }

    createPieChart(document.getElementById('userPapersPieChart').getContext('2d'), userPapersPieData);
    createPieChart(document.getElementById('allPapersPieChart').getContext('2d'), allPapersPieData);
    createPieChart(document.getElementById('userProjectsPieChart').getContext('2d'), userProjectsPieData);
    createPieChart(document.getElementById('allProjectsPieChart').getContext('2d'), allProjectsPieData);
    createBarChart(document.getElementById('papersTimeBarChart').getContext('2d'), papersTimeBarData);
    createBarChart(document.getElementById('projectsFundsBarChart').getContext('2d'), projectsFundsBarData);

    // 设置评价内容
    document.getElementById('userPapersComment').innerText = "用户论文等级与整体论文数据对比显示：用户主要集中在中间等级，低等级较少。";
    document.getElementById('allPapersComment').innerText = "整体论文等级分布显示：论文数量随着等级提高而逐步减少，说明高等级论文较为稀少。";
    document.getElementById('userProjectsComment').innerText = "用户项目分布较为均衡，高等级项目数量相对较少。";
    document.getElementById('allProjectsComment').innerText = "整体项目数据分布相似，显示高等级项目数量有限。";
    document.getElementById('papersTimeComment').innerText = "论文发表时间分布显示：2020年至2023年间，发表数量逐年增加，研究趋势稳步提升。";
    document.getElementById('projectsFundsComment').innerText = "项目资金分布显示：50-100万预算的项目最多，资金投入较为集中。";
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
</script>
</body>
</html>
