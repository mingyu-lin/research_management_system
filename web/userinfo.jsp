<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
            <div class="user-profile">
                <h2 class="profile-name">用户姓名</h2>
                <div class="profile-field">
                    <label for="profile-email">邮箱：</label>
                    <input type="email" id="profile-email" class="profile-email">
                </div>
                <div class="profile-field">
                    <label for="profile-phone">电话：</label>
                    <input type="tel" id="profile-phone" class="profile-phone">
                </div>
                <div class="profile-field">
                    <label for="profile-postscript">备注：</label>
                    <input type="text" id="profile-postscript" class="profile-postscript">
                </div>
                <div class="profile-field">
                    <label for="profile-create-time">注册时间：</label>
                    <input type="text" id="profile-create-time" class="profile-create-time">
                </div>

                <!-- 新增保存和返回按钮 -->
                <div class="button-group">
                    <button id="save-button" class="button save-button">保存</button>
                    <button id="back-button" class="button back-button">返回</button>
                </div>
            </div>

        </div>
    </div>
</div>

<script type="text/javascript" src="js/jquery-3.4.1.js"></script>
<script type="text/javascript">
    $(document).ready(function() {
        var userId = new URLSearchParams(window.location.search).get('author'); // 获取URL中的userId
        if (userId) {
            $.ajax({
                url: 'getUserInfo?userName=' + userId, // 假设你有这个servlet
                method: 'GET',
                success: function(response) {
                    if (response.code === 1 && response.object) {
                        var user = response.object;
                        $('.profile-name').text(user.userName);
                        $('#profile-email').val(user.userEmail);
                        $('#profile-phone').val(user.userPhone);
                        $('#profile-postscript').val(user.userPostscript);
                        $('#profile-create-time').val(user.userCreateTime ? user.userCreateTime : '未知');
                        $('.profile-avatar').attr('src', 'img/default_avatar.png'); // 可以根据实际情况替换为实际头像URL
                    } else {
                        $('.user-profile').html('<p>' + response.msg + '</p>');
                    }
                },
                error: function() {
                    $('.user-profile').html('<p>加载数据时出错。</p>');
                }
            });
            $('#save-button').on('click', function() {
                var userData = {
                    userId: userId,
                    userName: $('.profile-name').text(),
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
        }
    });
</script>
</body>
</html>