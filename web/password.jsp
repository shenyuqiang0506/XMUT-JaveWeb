<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:if test="${empty sessionScope.currUser}">
    <c:redirect url="login.jsp"></c:redirect>
</c:if>

<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>修改密码</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background: #f8f9fa; padding-top: 50px; font-family: 'Segoe UI', sans-serif; }
        .pwd-card { border: none; border-radius: 15px; box-shadow: 0 4px 15px rgba(0,0,0,0.05); max-width: 500px; margin: 0 auto; overflow: hidden; }
        .card-header { background: #ffc107; color: #333; padding: 15px 20px; font-weight: bold; }
    </style>
</head>
<body>

<div class="container">
    <div class="card pwd-card">
        <div class="card-header">
            🔒 修改账户密码
        </div>
        <div class="card-body p-4">

            <c:if test="${not empty msg}">
                <div class="alert alert-danger">${msg}</div>
            </c:if>
            <c:if test="${not empty successMsg}">
                <div class="alert alert-success">${successMsg}</div>
            </c:if>

            <form action="passwordServlet" method="post">
                <div class="mb-3">
                    <label class="form-label">当前账号</label>
                    <input type="text" class="form-control bg-light" value="${sessionScope.currUser.username}" disabled>
                </div>
                <div class="mb-3">
                    <label class="form-label">旧密码</label>
                    <input type="password" name="oldPassword" class="form-control" required>
                </div>
                <div class="mb-3">
                    <label class="form-label">新密码</label>
                    <input type="password" name="newPassword" class="form-control" required>
                </div>
                <div class="mb-4">
                    <label class="form-label">确认新密码</label>
                    <input type="password" name="confirmPassword" class="form-control" required>
                </div>

                <div class="d-grid gap-2">
                    <button type="submit" class="btn btn-warning text-dark fw-bold">确认修改</button>
                    <a href="index.jsp" class="btn btn-light text-secondary">返回首页</a>
                </div>
            </form>
        </div>
    </div>
</div>

</body>
</html>