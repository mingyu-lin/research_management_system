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
        <a href="main.jsp">首页</a>
        <a href="my_paper.jsp">检索</a>
        <a href="my_message.jsp">我的私信</a>
        <a href="sendmessage.jsp">发送私信</a>
        <c:choose>
            <c:when test="${sessionScope.role == 'admin'}">
                <a href="add_news.jsp">发布新闻</a>
                <a href="my_paper.jsp?paperFlag=1">论文审核</a>
                <a href="#">项目审核</a>
                <a href="user_management.jsp">用户管理</a>
            </c:when>


            <c:when test="${sessionScope.role == 'user'}">
                <a href="userinfo.jsp?author=${sessionScope.username}">个人信息</a>
                <a href="#" id="myPapersLink">我的论文</a>
                <a href="#">我的项目</a>
                <a href="add_paper.jsp?paperAuthor=${sessionScope.username}">提交论文</a>
                <a href="#">提交项目</a>
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
                    <input type="text" id="searchAuthor" name="searchAuthor" class="search-input" placeholder="请输入作者关键字" />

                    <button type="submit" class="search-button">搜索</button>
                </form>
            </div>

        </div>
    </div>
</div>
</body>
<script type="text/javascript" src="js/jquery-3.4.1.js"></script>
<script type="text/javascript">
    $(document).ready(function() {
        // 使用 URLSearchParams 获取查询参数

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