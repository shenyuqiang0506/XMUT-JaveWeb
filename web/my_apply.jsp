<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>我的申请 - 宠物救助系统</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            padding-top: 30px;
        }

        .content-card {
            border: none;
            border-radius: 12px;
            box-shadow: 0 2px 15px rgba(0, 0, 0, 0.05);
            background: white;
            padding: 20px;
        }

        .table th {
            background-color: #f1f3f5;
            font-weight: 600;
        }

        .table img {
            border-radius: 6px;
        }
    </style>
</head>
<body>

<div class="container">

    <div class="d-flex justify-content-between align-items-center mb-4">
        <h3 class="text-dark fw-bold mb-0">📋 我的领养申请记录</h3>
        <a href="petList" class="btn btn-outline-primary">返回领养中心</a>
    </div>

    <div class="content-card">
        <div class="table-responsive">
            <table class="table table-hover align-middle mb-0">
                <thead>
                <tr>
                    <th>宠物信息</th>
                    <th style="width: 40%;">我的理由</th>
                    <th>申请时间</th>
                    <th>当前状态</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${applyList}" var="a">
                    <tr>
                        <td>
                            <div class="d-flex align-items-center">
                                <img src="static/images/${a.pet.image}" width="60" height="60"
                                     class="me-3 object-fit-cover" onerror="this.src='static/images/default.jpg'">
                                <div>
                                    <div class="fw-bold">${a.pet.petName}</div>
                                    <small class="text-muted">ID: ${a.pet.id}</small>
                                </div>
                            </div>
                        </td>
                        <td>
                            <div class="text-secondary" style="font-size: 0.95rem;">${a.reason}</div>
                        </td>
                        <td class="text-muted small">${a.applyTime}</td>
                        <td>
                            <c:choose>
                                <c:when test="${a.applyStatus == 0}"><span
                                        class="badge bg-warning text-dark">⏳ 审核中</span></c:when>
                                <c:when test="${a.applyStatus == 1}"><span
                                        class="badge bg-success">✅ 已通过</span></c:when>
                                <c:when test="${a.applyStatus == 2}"><span
                                        class="badge bg-danger">❌ 已驳回</span></c:when>
                            </c:choose>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>

        <c:if test="${empty applyList}">
            <div class="text-center py-5 text-muted">
                <p class="mb-0">您还没有提交过任何申请哦</p>
            </div>
        </c:if>
    </div>
</div>

</body>
</html>