<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>新用户注册 - 宠物救助系统</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f0f2f5; /* */
            display: flex;
            align-items: center;
            justify-content: center;
            min-height: 100vh;
            padding: 20px 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        .reg-card {
            border: none;
            border-radius: 15px; /* */
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            width: 100%;
            max-width: 450px;
        }

        .reg-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); /* */
            padding: 25px;
            text-align: center;
            color: white;
        }

        .btn-success-gradient {
            background: linear-gradient(135deg, #42e695 0%, #3bb2b8 100%);
            border: none;
            color: white;
        }

        .btn-success-gradient:hover {
            background: linear-gradient(135deg, #3bce85 0%, #2ea0a6 100%);
            color: white;
        }
    </style>
</head>
<body>

<div class="reg-card card">
    <div class="reg-header">
        <h3 class="mb-0 fw-bold">✨ 注册新账号</h3>
        <p class="mb-0 opacity-75">加入我们，一起守护小生命</p>
    </div>
    <div class="card-body p-4">

        <div class="text-danger mb-3 text-center small">${msg}</div>

        <form action="registerServlet" method="post">
            <div class="mb-3">
                <label class="form-label text-secondary">用户名</label>
                <input type="text" name="username" class="form-control" placeholder="设置您的登录账号" required>
            </div>
            <div class="mb-3">
                <label class="form-label text-secondary">登录密码</label>
                <input type="password" name="password" class="form-control" placeholder="设置您的登录密码" required>
            </div>
            <div class="row">
                <div class="col-md-6 mb-3">
                    <label class="form-label text-secondary">真实姓名</label>
                    <input type="text" name="realName" class="form-control" placeholder="您的称呼" required>
                </div>
                <div class="col-md-6 mb-3">
                    <label class="form-label text-secondary">手机号码</label>
                    <input type="text" name="phone" class="form-control" placeholder="联系方式" required>
                </div>
            </div>

            <div class="d-grid mt-3">
                <button type="submit" class="btn btn-success-gradient btn-lg">立即注册</button>
            </div>
        </form>

        <div class="text-center mt-3">
            <a href="login.jsp" class="text-decoration-none text-secondary">已有账号？<span
                    style="color: #3bb2b8">直接登录</span></a>
        </div>
    </div>
</div>

</body>
</html>