<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>流浪宠物救助系统 - 首页</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        .hero-section {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 4rem 2rem;
            border-radius: 0 0 20px 20px;
            margin-bottom: 30px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
        }

        .menu-card {
            border: none;
            border-radius: 15px;
            transition: all 0.3s ease;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.05);
            height: 100%;
            text-decoration: none; /* 去掉链接下划线 */
            color: inherit; /* 继承文字颜色 */
            display: block; /* 让整个卡片可点击 */
            background: white;
            overflow: hidden;
        }

        .menu-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.15);
            color: inherit;
        }

        .card-icon {
            font-size: 3rem;
            margin-bottom: 15px;
        }

        .welcome-text {
            font-weight: 300;
            font-size: 1.1rem;
            opacity: 0.9;
        }
    </style>
</head>
<body>

<nav class="navbar navbar-expand-lg navbar-light bg-white shadow-sm">
    <div class="container">
        <a class="navbar-brand fw-bold text-primary" href="index.jsp">
            🐾 宠物救助系统
        </a>
        <div class="d-flex">
            <c:if test="${not empty sessionScope.currUser}">
                    <span class="navbar-text me-3">
                        你好, <b>${currUser.realName}</b>
                        <span class="badge bg-secondary">${currUser.role == 1 ? '管理员' : '普通用户'}</span>
                    </span>
                <a href="password.jsp" class="btn btn-outline-warning btn-sm me-2">修改密码</a>
                <a href="logoutServlet" class="btn btn-outline-danger btn-sm">退出登录</a>
            </c:if>
            <c:if test="${empty sessionScope.currUser}">
                <a href="login.jsp" class="btn btn-outline-primary btn-sm me-2">登录</a>
                <a href="register.jsp" class="btn btn-primary btn-sm">注册</a>
            </c:if>
        </div>
    </div>
</nav>

<div class="hero-section text-center">
    <h1 class="display-4 fw-bold">让爱不再流浪</h1>
    <p class="lead welcome-text">每一个生命都值得被温柔以待，欢迎加入我们的救助大家庭。</p>
</div>

<div class="container pb-5">

<%--    <c:if test="${empty sessionScope.currUser}">--%>
<%--        <div class="text-center mt-5">--%>
<%--            <h3>您尚未登录</h3>--%>
<%--            <p class="text-muted">请登录后查看更多功能</p>--%>
<%--            <a href="login.jsp" class="btn btn-primary btn-lg px-5 mt-3">立即登录</a>--%>
<%--        </div>--%>
<%--    </c:if>--%>

    <div class="row g-4">

        <div class="col-md-4 col-sm-6">
            <a href="petList" class="menu-card text-center p-4">
                <div class="card-icon">🐶</div>
                <h4 class="fw-bold">领养中心</h4>
                <p class="text-muted">浏览待领养的萌宠，寻找你的缘分</p>
            </a>
        </div>

        <c:if test="${not empty sessionScope.currUser}">
            <div class="col-md-4 col-sm-6">
                <a href="myApplyServlet" class="menu-card text-center p-4">
                    <div class="card-icon">📋</div>
                    <h4 class="fw-bold">我的申请</h4>
                    <p class="text-muted">查看之前的领养申请进度与状态</p>
                </a>
            </div>

            <div class="col-md-4 col-sm-6">
                <a href="publish.jsp" class="menu-card text-center p-4">
                    <div class="card-icon">📢</div>
                    <h4 class="fw-bold">发布救助</h4>
                    <p class="text-muted">遇到流浪动物？点击这里发布信息</p>
                </a>
            </div>

            <c:if test="${currUser.role == 1}">
                <div class="col-md-4 col-sm-6">
                    <a href="auditServlet" class="menu-card text-center p-4 border border-warning">
                        <div class="card-icon">🛡️</div>
                        <h4 class="fw-bold text-warning">后台审核</h4>
                        <p class="text-muted">【管理员】审核发布信息与领养申请</p>
                    </a>
                </div>
            </c:if>
        </c:if>

    </div>

</div>

<footer class="text-center text-muted py-4 mt-auto" style="font-size: 0.9rem;">
    <p>
        &copy; 2025 流浪宠物救助系统 | 山河不入心 <br>
        <span class="badge bg-success bg-opacity-10 text-success border border-success mt-2">
                🟢 当前在线人数：${applicationScope.onlineCount == null ? 1 : applicationScope.onlineCount} 人
            </span>
    </p>
</footer>

</body>
</html>