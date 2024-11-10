<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>用户信息 - 科研管理系统</title>
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="userinfo_style.css"> <!-- 引入CSS文件 -->
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
                <button id="changePwdBtn" class="change-password">修改密码</button>
                <a href="logout.jsp" onclick="window.history.forward(); window.location.href='login.jsp'; return false;" class="logout">退出登录</a>
            </div>
        </div>

        <div class="main-area">
            <div class="user-profile">
                <h2 class="profile-name">个人信息</h2>
                <div class="profile-field">
                    <label for="profile-name">姓名：</label>
                    <input type="text" id="profile-name" class="profile-name" readonly>
                </div>
                <div class="profile-field">
                    <label for="profile-email">邮箱：</label>
                    <input type="email" id="profile-email" class="profile-email" readonly>
                </div>
                <div class="profile-field">
                    <label for="profile-phone">电话：</label>
                    <input type="tel" id="profile-phone" class="profile-phone" readonly>
                </div>
                <div class="profile-field">
                    <label for="profile-postscript">备注：</label>
                    <input type="text" id="profile-postscript" class="profile-postscript" readonly>
                </div>
                <div class="profile-field">
                    <label for="profile-create-time">注册时间：</label>
                    <input type="text" id="profile-create-time" class="profile-create-time" readonly>
                </div>

                <!-- 新增保存和返回按钮 -->
                <div class="button-group">
                    <button id="save-button" class="button save-button" style="display: none;">保存</button>
                    <button id="back-button" class="button back-button">返回</button>
                    <button id="message-button" class="button message-button" style="display: none;">私信</button>
                </div>
            </div>

        </div>
    </div>
</div>
<div id="changePwdModal" class="modal">
    <div class="modal-content">
        <span class="close">&times;</span>
        <h2>修改密码</h2>
        <form id="changePwdForm">
            <label for="oldPassword">旧密码:</label>
            <input type="password" id="oldPassword" name="oldPassword" required>
            <label for="newPassword">新密码:</label>
            <input type="password" id="newPassword" name="newPassword" required>
            <label for="confirmNewPassword">确认新密码:</label>
            <input type="password" id="confirmNewPassword" name="confirmNewPassword" required>
            <div class="buttons-container">
                <button type="submit" class="confirm-btn">确认</button>
                <button type="button" class="cancel-btn">取消</button>
            </div>
        </form>
    </div>
</div>
<script type="text/javascript" src="js/jquery-3.4.1.js"></script>
<script type="text/javascript">
    $(document).ready(function() {
        $('#changePwdBtn').click(function() {
            $('#changePwdModal').css('display', 'block');
        });

        // Close modal
        $('.close, .cancel-btn').click(function() {
            $('#changePwdModal').css('display', 'none');
        });

        // Handle form submission
        $('#changePwdForm').submit(function(event) {
            event.preventDefault();

            const oldPassword = $('#oldPassword').val();
            const newPassword = $('#newPassword').val();
            const confirmNewPassword = $('#confirmNewPassword').val();

            if (newPassword !== confirmNewPassword) {
                alert('新密码和确认密码不匹配，请重新输入。');
                return;
            }

            // Send AJAX request to server
            $.ajax({
                url: '/editPwd',
                method: 'POST',
                data: {
                    oldPassword: oldPassword,
                    newPassword: newPassword
                },
                success: function(response) {
                    alert(response.msg || '操作成功');
                    $('#changePwdModal').css('display', 'none');
                },
                error: function(xhr, status, error) {
                    alert('修改密码时出现错误，请重试。');
                }
            });
        });

        const sessionRole = '<%= session.getAttribute("role") %>';
        const sessionUsername = '<%= session.getAttribute("username") %>';
        var user;
        var userId = new URLSearchParams(window.location.search).get('author'); // 获取URL中的userId
        if (userId) {
            $.ajax({
                url: 'getUserInfo?userName=' + userId, // 假设你有这个servlet
                method: 'GET',
                success: function(response) {
                    if (response.code === 1 && response.object) {
                       user = response.object;
                        $('#profile-name').val(user.userName);
                        $('#profile-email').val(user.userEmail);
                        $('#profile-phone').val(user.userPhone);
                        $('#profile-postscript').val(user.userPostscript);
                        $('#profile-create-time').val(user.userCreateTime ? user.userCreateTime : '未知');
                        $('.profile-avatar').attr('src', 'img/default_avatar.png'); // 可以根据实际情况替换为实际头像URL
                    } else {
                        $('.user-profile').html('<p>' + response.msg + '</p>');
                    }
                    // Check role and username conditions
                    console.log("sessionUsername:"+sessionUsername);
                    console.log(user.userName);
                    const isCurrentUser = sessionUsername === user.userName;
                    if (sessionRole === 'admin') {
                        $('#save-button, #message-button').show();
                        $('.profile-field input').prop('readonly', false);
                    } else if (sessionRole === 'user' && isCurrentUser) {
                        $('#save-button').show();
                        $('.profile-field input').prop('readonly', false);
                    } else if (sessionRole === 'user' && !isCurrentUser) {
                        $('#message-button').show();
                    }
                },
                error: function() {
                    $('.user-profile').html('<p>加载数据时出错。</p>');
                }
            });
            $('#save-button').on('click', function() {
                var userData = {
                    userId: userId,
                    userName: $('#profile-name').val(),
                    userEmail: $('#profile-email').val(),
                    userPhone: $('#profile-phone').val(),
                    userPostscript: $('#profile-postscript').val(),
                    userCreateTime: $('#profile-create-time').val()
                };
                console.log(userData);
                $.ajax({
                    url: '/editPwd',
                    method: 'POST',
                    //contentType: 'application/json',
                    data: userData,
                    success: function(response) {
                        alert(response.message || '保存成功！');
                    },
                    error: function() {
                        alert('保存时出错，请稍后再试。');
                    }
                });
            });

            // 返回按钮事件
            $('#back-button').on('click', function() {
                window.history.back();
            });
            $('#message-button').on('click', function() {
                var receiver = $('#profile-name').val(); // 获取当前显示的用户名
                window.location.href = 'sendmessage.jsp?receiver=' + encodeURIComponent(receiver);
            });
        }
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