<%@ page import="xxxx.entity.Paper" %>
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
                <a href="index.jsp" class="back-home">返回首页</a>
            </div>
            <div class="user-info">
                <span class="username">用户名</span>(<span class="role">身份</span>)
                <a href="#" class="logout">退出登录</a>
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
            </div>
        </div>
    </div>
</div>

<script type="text/javascript" src="js/jquery-3.4.1.js"></script>
<script type="text/javascript">
    $(document).ready(function() {
        var paperId = new URLSearchParams(window.location.search).get('paperId'); // 获取URL中的paperId

        $.ajax({
            url: '/getOnePaper?paperId=' + paperId, // 假设你有这个servlet
            method: 'GET',
            success: function(response) {
                if (response.code === 1 && response.object) {
                    var paper = response.object;
                    var $paperDetails = $('#paper-details');
                    $paperDetails.empty(); // 清空现有内容

                    // 使用 jQuery 动态创建论文详情
                    $paperDetails.append('<h2>' + paper.paperTitle + '</h2>');
                    $paperDetails.append('<p><strong>作者：</strong>' + paper.paperAuthor + '</p>');
                    $paperDetails.append('<p><strong>发表场所：</strong>' + paper.paperPublicationVenue + '</p>');
                    $paperDetails.append('<p><strong>关键词：</strong>' + paper.keywords + '</p>');
                    $paperDetails.append('<p><strong>来源：</strong>' + paper.paperUpdateFrom + '</p>');
                    $paperDetails.append('<p><strong>摘要：</strong>' + paper.paperAbstract + '</p>');
                    $paperDetails.append('<p><strong>发布时间：</strong>' + paper.paperPublicationTime + '</p>');
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
            window.location.href = 'add_paper.jsp?paperId=' + paperId; // 跳转到编辑页面
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
                            window.location.href = 'index.jsp'; // 删除后跳转到首页
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
    });
</script>
</body>
</html>
