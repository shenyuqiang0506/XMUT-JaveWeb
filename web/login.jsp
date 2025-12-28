<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    if (session.getAttribute("is_human") == null) {
        session.setAttribute("is_human", "yes");
    }
%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>系统登录 - 宠物救助系统</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f0f2f5;
            display: flex;
            align-items: center;
            justify-content: center;
            height: 100vh;
            font-family: 'Segoe UI', sans-serif;
        }

        .login-card {
            border: none;
            border-radius: 15px;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            width: 100%;
            max-width: 400px;
        }

        .login-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            padding: 30px 20px;
            text-align: center;
            color: white;
        }

        .btn-primary-gradient {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border: none;
            color: white;
        }

        .btn-primary-gradient:hover {
            background: linear-gradient(135deg, #5a6fd6 0%, #6a4292 100%);
            color: white;
        }
    </style>
</head>
<body>

<div class="login-card card">
    <div class="login-header">
        <h3 class="mb-0 fw-bold">🐾 欢迎回来</h3>
        <p class="mb-0 opacity-75" style="font-size: 0.9rem;">流浪宠物救助管理系统</p>
    </div>
    <div class="card-body p-4">

        <c:if test="${not empty msg}">
            <div class="alert alert-danger py-2 text-center" role="alert">${msg}</div>
        </c:if>

        <form action="loginServlet" method="post">
            <div class="mb-3">
                <label class="form-label fw-bold text-secondary">账号</label>
                <input type="text" name="username" class="form-control" placeholder="请输入用户名" required>
            </div>
            <div class="mb-3">
                <label class="form-label fw-bold text-secondary">密码</label>
                <input type="password" name="password" class="form-control" placeholder="请输入密码" required>
            </div>

            <div class="mb-4">
                <label class="form-label fw-bold text-secondary">验证码</label>
                <div class="d-flex">
                    <input type="text" name="captcha" class="form-control me-2" placeholder="不区分大小写" required
                           style="width: 140px;">
                    <img src="captchaServlet" id="captchaImg"
                         onclick="this.src='captchaServlet?t=' + new Date().getTime()"
                         style="cursor: pointer; border-radius: 5px; border: 1px solid #ddd;"
                         title="看不清？点击刷新" alt="验证码">
                </div>
            </div>

            <div class="d-grid">
                <button type="submit" class="btn btn-primary-gradient btn-lg">立即登录</button>
            </div>
        </form>

        <div class="text-center mt-3">
            <a href="register.jsp" class="text-decoration-none text-secondary">没有账号？<span style="color: #667eea">点此注册</span></a>
            <br>
            <a href="index.jsp" class="text-decoration-none text-muted small mt-2 d-inline-block">返回首页</a>
        </div>
    </div>
</div>
</body>
</html>