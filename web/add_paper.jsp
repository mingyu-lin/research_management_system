<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>添加论文</title>
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="add_paper_style.css"> <!-- 引入CSS文件 -->
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
            <h2>添加论文</h2>
            <form id="paperForm" action="/add_paper" method="POST">
                <label for="paperTitle">标题:</label>
                <input type="text" id="paperTitle" name="paperTitle" required>

                <label for="paperAuthor">作者:</label>
                <input type="text" id="paperAuthor" name="paperAuthor" required>

                <label for="paperPublicationVenue">发表地点:</label>
                <input type="text" id="paperPublicationVenue" name="paperPublicationVenue">

                <label for="Keywords">关键词:</label>
                <input type="text" id="Keywords" name="Keywords">

                <label for="paperAbstract">摘要:</label>
                <textarea id="paperAbstract" name="paperAbstract" rows="4"></textarea>

                <label for="paperPublicationTime">发表时间:</label>
                <input type="date" id="paperPublicationTime" name="paperPublicationTime">

                <button type="submit" id="addBtn">提交</button>
            </form>
        </div>
    </div>
</div>

<script type="text/javascript" src="js/jquery-3.4.1.js"></script>
<script type="text/javascript">
    $(document).ready(function() {
        var paperId = new URLSearchParams(window.location.search).get('paperId');

        if (paperId) {
            $.ajax({
                url: '/getOnePaper?paperId=' + paperId,
                method: 'GET',
                success: function(response) {
                    if (response.code === 1 && response.object) {
                        var paper = response.object;
                        $('#paperTitle').val(paper.paperTitle);
                        $('#paperAuthor').val(paper.paperAuthor);
                        $('#paperPublicationVenue').val(paper.paperPublicationVenue);
                        $('#Keywords').val(paper.keywords);
                        $('#paperAbstract').val(paper.paperAbstract);
                        $('#paperPublicationTime').val(paper.paperPublicationTime);
                    } else {
                        alert('加载论文数据失败: ' + response.msg);
                    }
                },
                error: function() {
                    alert('获取论文数据时出错。');
                }
            });
        }
    });
</script>
</body>
</html>

