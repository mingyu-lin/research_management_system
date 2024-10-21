<%--
  Created by IntelliJ IDEA.
  User: 30281
  Date: 2024/10/21
  Time: 19:25
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>发布论文</title>
    <link rel="stylesheet" href="add_paper_style.css">
</head>
<body>

<div class="header">
    <div class="logo">
        <img src="bgimg.jpg" alt="网站Logo">
    </div>
    <div class="breadcrumb">当前位置: 首页 > 用户管理</div>
    <div class="user-info">
        <span class="username">用户名</span>
        <span class="role">身份</span>
    </div>
    <a href="#" class="logout">退出登录</a>
</div>
<div class="container">
    <div class="sidebar">
        <a href="#">首页</a>
        <a href="#">用户管理</a>
        <a href="#">系统设置</a>
        <a href="#">订单管理</a>
        <a href="#">会员管理</a>
    </div>
    <div class="main-area">
        <h2>添加论文</h2>
        <form id="paperForm" action="/add_paper" method="POST">
            <label for="paperTitle">标题:</label>
            <input type="text" id="paperTitle" name="paperTitle" required><br>

            <label for="paperAuthor">作者:</label>
            <input type="text" id="paperAuthor" name="paperAuthor" required><br>

            <label for="paperPublicationVenue">发表地点:</label>
            <input type="text" id="paperPublicationVenue" name="paperPublicationVenue"><br>

            <label for="Keywords">关键词:</label>
            <input type="text" id="Keywords" name="Keywords"><br>

            <label for="paperAbstract">摘要:</label>
            <textarea id="paperAbstract" name="paperAbstract" rows="4" cols="50"></textarea><br>

            <label for="paperPublicationTime">发表时间:</label>
            <input type="date" id="paperPublicationTime" name="paperPublicationTime"><br>

            <button type="submit",id="addBtn">提交</button>
        </form>
    </div>
</div>
</body>
<script type="text/javascript" src="js/jquery-3.4.1.js"></script>
<!-- 注意：以下JavaScript部分在图片中未直接显示，但基于常规操作可能会包含 -->
<script type="text/javascript">
    // 这里可以添加JavaScript代码来处理登录、注册等事件
    // 例如，给登录按钮添加点击事件
    $('#addBtn').click(function() {

        $("#paperForm").submit();
    });


</script>
</html>