<%@ page import="xxxx.entity.Paper" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>论文详细信息</title>
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="onepaper_style.css"> <!-- 引入CSS文件 -->
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
                <a href="index.jsp" class="back-home">返回首页</a>
            </div>
            <div class="user-info">
                <span class="username"><c:out value="${sessionScope.username}" /></span>
                (<span class="role"><c:out value="${sessionScope.role}" /></span>) <!-- 修改为显示用户名和身份 -->

                <a href="logout.jsp" onclick="window.history.forward(); window.location.href='login.jsp'; return false;" class="logout">退出登录</a>
            </div>
        </div>

        <div class="main-area">
            <h1>论文详细信息</h1>
            <div class="paper-details" id="paper-details">
                <!-- 论文详情将在这里动态加载 -->
            </div>
            <div class="action-buttons">
                <button id="edit-button" class="action-btn">编辑</button>
                <button id="delete-button" class="action-btn">删除</button>
                <button id="approve-button" class="action-btn">通过</button>
                <button id="reject-button" class="action-btn">拒绝</button>
            </div>

        </div>
    </div>
</div>

<script type="text/javascript" src="js/jquery-3.4.1.js"></script>
<script type="text/javascript">
    $(document).ready(function() {
        var paperId = new URLSearchParams(window.location.search).get('paperId'); // 获取URL中的paperId
        var adminId = '<%= session.getAttribute("userid") %>'; // 从Session中获取adminId
        var username = '<%= session.getAttribute("username") %>'; // 从Session中获取username
        var role = '<%= session.getAttribute("role") %>'; // 从Session中获取role
        var paper;
        $.ajax({
            url: '/getOnePaper?paperId=' + paperId, // 假设你有这个servlet
            method: 'GET',
            success: function(response) {
                if (response.code === 1 && response.object) {
                    paper = response.object;
                    var $paperDetails = $('#paper-details');
                    $paperDetails.empty(); // 清空现有内容
                    console.log(paper);
                    // 使用 jQuery 动态创建论文详情
                    $paperDetails.append('<h2>' + paper.paperTitle + '</h2>');
                    $paperDetails.append('<p><strong>作者：</strong>' + paper.paperAuthor + '</p>');
                    $paperDetails.append('<p><strong>刊物/会议：</strong>' + paper.paperPublicationVenue + '</p>');
                    $paperDetails.append('<p><strong>等级：</strong>' + paper.paperLevel + '</p>');
                    $paperDetails.append('<p><strong>关键词：</strong>' + paper.keywords + '</p>');
                    $paperDetails.append('<p><strong>摘要：</strong>' + paper.paperAbstract + '</p>');
                    $paperDetails.append('<p><strong>发布时间：</strong>' + paper.paperPublicationTime + '</p>');

                    // 控制按钮的显示
                    if (role === 'admin') {
                        $('#edit-button').hide();
                        $('#delete-button').hide();
                        $('#approve-button').show();
                        $('#reject-button').show();
                    } else if (paper.paperAuthor === username) {
                        $('#edit-button').show();
                        $('#delete-button').show();
                        $('#approve-button').hide();
                        $('#reject-button').hide();
                    } else {
                        $('#edit-button').hide();
                        $('#delete-button').hide();
                        $('#approve-button').hide();
                        $('#reject-button').hide();
                    }
                } else {
                    $('#paper-details').html('<p>' + response.msg + '</p>');
                }
            },
            error: function() {
                $('#paper-details').html('<p>加载论文时出错。</p>');
            }
        });

        // 编辑按钮的点击事件
        $('#edit-button').on('click', function() {
            var url = 'add_paper.jsp?action=' + "edit" +
                '&paperTitle=' + encodeURIComponent(paper.paperTitle) +
                '&paperAuthor=' + encodeURIComponent(paper.paperAuthor) +
                '&paperPublicationVenue=' + encodeURIComponent(paper.paperPublicationVenue) +
                '&Keywords=' + encodeURIComponent(paper.keywords) +
                '&paperAbstract=' + encodeURIComponent(paper.paperAbstract) +
                '&paperPublicationTime=' + encodeURIComponent(paper.paperPublicationTime) +
                '&paperLevel=' + encodeURIComponent(paper.paperLevel);
            window.location.href = url;
        });

        // 删除按钮的点击事件
        $('#delete-button').on('click', function() {
            if (confirm("确定要删除这篇论文吗？")) {
                $.ajax({
                    url: '/deletePaper?paperId=' + paperId, // 假设你有这个servlet处理删除请求
                    method: 'DELETE',
                    success: function(response) {
                        if (response.code === 1) {
                            alert("论文删除成功！");
                            var username = '<%= session.getAttribute("username") %>';
                            var paperTitle = 'admin';

                            // 构建 URL
                            console.log("username:" + username);
                            var url = 'my_paper.jsp?paperAuthor=' + encodeURIComponent(username) + '&paperTitle=' + encodeURIComponent(paperTitle);

                            // 跳转到目标页面
                            window.location.href = url;
                        } else {
                            alert("删除失败: " + response.msg);
                        }
                    },
                    error: function() {
                        alert("删除请求失败，请稍后重试。");
                    }
                });
            }
        });

        // 通过按钮的点击事件
        $('#approve-button').on('click', function() {
            $.ajax({
                url: '/paperReview?paperId=' + paperId + '&action=approve&adminId=' + adminId, // 添加adminId
                method: 'POST',
                success: function(response) {
                    if (response.code === 1) {
                        alert("论文审核通过成功！");
                        var url='my_paper.jsp?paperFlag=1';
                        window.location.href = url;
                    } else {
                        alert("审核失败: " + response.msg);
                    }
                },
                error: function() {
                    alert("请求失败，请稍后重试。");
                }
            });
        });

        // 拒绝按钮的点击事件
        $('#reject-button').on('click', function() {
            $.ajax({
                url: '/paperReview?paperId=' + paperId + '&action=reject&adminId='+adminId, // adminId为0
                method: 'POST',
                success: function(response) {
                    if (response.code === 1) {
                        alert("论文审核拒绝成功！");
                        var url='my_paper.jsp?paperFlag=1';
                        window.location.href = url;

                    } else {
                        alert("拒绝失败: " + response.msg);
                    }
                },
                error: function() {
                    alert("请求失败，请稍后重试。");
                }
            });
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
