<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
            <h2>添加论文</h2>
            <form id="paperForm" action="/add_paper" method="POST">
                <label for="paperTitle">标题:</label>
                <input type="text" id="paperTitle" name="paperTitle" required>

                <label for="paperAuthor">作者:</label>
                <input type="text" id="paperAuthor" name="paperAuthor" readonly required>

                <label for="paperPublicationVenue">发表地点:</label>
                <input type="text" id="paperPublicationVenue" name="paperPublicationVenue">

                <label for="Keywords">关键词:</label>
                <input type="text" id="Keywords" name="Keywords">

                <label for="paperAbstract">摘要:</label>
                <textarea id="paperAbstract" name="paperAbstract" rows="4"></textarea>

                <label for="paperLevel">等级:</label>
                <input type="text" id="paperLevel" name="paperLevel" required>

                <label for="paperPublicationTime">发表时间:</label>
                <input type="date" id="paperPublicationTime" name="paperPublicationTime">

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
            if (params.has('paperTitle')) {
                $('#paperTitle').val(params.get('paperTitle'));
            }
            if (params.has('paperAuthor')) {
                $('#paperAuthor').val(params.get('paperAuthor'));
            }
            if (params.has('paperPublicationVenue')) {
                $('#paperPublicationVenue').val(params.get('paperPublicationVenue'));
            }
            if (params.has('Keywords')) {
                $('#Keywords').val(params.get('Keywords'));
            }
            if (params.has('paperAbstract')) {
                $('#paperAbstract').val(params.get('paperAbstract'));
            }
            if (params.has('paperPublicationTime')) {
                $('#paperPublicationTime').val(params.get('paperPublicationTime'));
            }
            if (params.has('paperLevel')) {
                $('#paperLevel').val(params.get('paperLevel'));
            }
        }

        // 调用函数填充表单
        fillFormFromParams(urlParams);

        // 处理表单提交
        $('#paperForm').on('submit', function(event) {
            event.preventDefault(); // 阻止表单默认提交

            var paperTitle = $('#paperTitle').val();
            var paperAuthor = $('#paperAuthor').val();
            var paperPublicationVenue = $('#paperPublicationVenue').val();
            var keywords = $('#Keywords').val();
            var paperAbstract = $('#paperAbstract').val();
            var paperPublicationTime = $('#paperPublicationTime').val();
            var paperLevel = $('#paperLevel').val(); // 新增的等级输入框

            $.ajax({
                url: '/addPaper', // 发送消息的后端接口
                method: 'POST',
                data: {
                    paperTitle: paperTitle,
                    paperAuthor: paperAuthor,
                    paperPublicationVenue: paperPublicationVenue,
                    keywords: keywords,
                    paperAbstract: paperAbstract,
                    paperPublicationTime: paperPublicationTime,
                    paperLevel: paperLevel // 新增的等级字段
                },
                success: function(response) {
                    if (response.code === 1) {
                        alert('论文添加成功!');
                        // 可选择重定向或清空表单
                        $('#paperForm')[0].reset();
                    } else {
                        alert('论文添加失败: ' + response.msg);
                    }
                },
                error: function() {
                    alert('发送请求时出错，请稍后重试。');
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