<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:if test="${sessionScope.currUser.role != 1}">
    <% response.sendRedirect("../login.jsp"); %>
</c:if>

<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>后台管理 - 综合审核</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f0f2f5;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            padding-top: 30px;
        }

        .admin-card {
            border: none;
            border-radius: 12px;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.08);
            overflow: hidden;
            margin-bottom: 30px;
        }

        .admin-header {
            background: linear-gradient(135deg, #2c3e50 0%, #4ca1af 100%);
            color: white;
            padding: 15px 25px;
        }

        .table th {
            background-color: #f8f9fa;
            font-weight: 600;
            color: #555;
        }

        .table img {
            border-radius: 6px;
            object-fit: cover;
        }
    </style>
</head>
<body>

<div class="container">

    <div class="d-flex justify-content-between align-items-center mb-4">
        <h3 class="fw-bold text-secondary">🛡️ 管理员控制台</h3>
        <a href="../index.jsp" class="btn btn-outline-secondary">返回前台</a>
    </div>

    <div class="card admin-card">
        <div class="admin-header bg-primary d-flex justify-content-between align-items-center">
            <h5 class="mb-0">📢 新发布救助信息审核</h5>

            <div>
                <button type="button" class="btn btn-light btn-sm fw-bold text-success" onclick="submitBatch(1)">⚡
                    批量通过
                </button>
                <button type="button" class="btn btn-light btn-sm fw-bold text-danger ms-2" onclick="submitBatch(0)">🗑️
                    批量驳回
                </button>
            </div>
        </div>

        <div class="card-body p-0">
            <form action="${pageContext.request.contextPath}/auditServlet" method="post" id="batchForm">
                <%--隐藏域--%>
                <input type="hidden" name="action" value="batchAuditPet">
                <input type="hidden" name="result" id="batchResult">
                <table class="table table-hover align-middle mb-0">
                    <thead class="table-light">
                    <tr>
                        <th class="ps-4" width="50"><input type="checkbox" class="form-check-input"
                                                           onclick="toggleAll(this)"></th>
                        <th>图片</th>
                        <th>宠物昵称</th>
                        <th>类别</th>
                        <th>描述</th>
                        <th>发布时间</th>
                        <th>操作</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${pendingPets}" var="p">
                        <tr>
                            <td class="ps-4">
                                <input type="checkbox" name="ids" value="${p.id}" class="form-check-input">
                            </td>
                            <td>
                                <img src="../static/images/${p.image}" width="50" height="50"
                                     onerror="this.src='../static/images/default.jpg'">
                            </td>
                            <td class="fw-bold">${p.petName}</td>
                            <td>${p.type} <span class="text-muted">|</span> ${p.sex}</td>
                            <td>
                                <div class="text-truncate" style="max-width: 150px;" title="${p.description}">
                                        ${p.description}
                                </div>
                            </td>
                            <td class="small text-muted">${p.createTime}</td>
                            <td>
                                <a href="${pageContext.request.contextPath}/auditServlet?action=auditPet&petId=${p.id}&result=1"
                                   class="btn btn-sm btn-outline-success border-0">通过</a>
                                <a href="${pageContext.request.contextPath}/auditServlet?action=auditPet&petId=${p.id}&result=0"
                                   class="btn btn-sm btn-outline-danger border-0">驳回</a>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty pendingPets}">
                        <tr>
                            <td colspan="7" class="text-center py-4 text-muted">🎉 暂无待审核信息</td>
                        </tr>
                    </c:if>
                    </tbody>
                </table>
            </form>
        </div>
    </div>

    <div class="card admin-card">
        <div class="admin-header">
            <h5 class="mb-0">📋 领养申请审核</h5>
        </div>
        <div class="card-body p-0">
            <table class="table table-hover align-middle mb-0">
                <thead>
                <tr>
                    <th class="ps-4">申请人</th>
                    <th>目标宠物</th>
                    <th style="width: 30%;">申请理由</th>
                    <th>状态</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${applyList}" var="a">
                    <tr>
                        <td class="ps-4">
                            <div class="fw-bold">${a.user.username}</div>
                            <small class="text-muted">${a.user.realName}</small>
                        </td>
                        <td>🐶 ${a.pet.petName}</td>
                        <td>
                            <div class="text-truncate" style="max-width: 200px;" title="${a.reason}">
                                    ${a.reason}
                            </div>
                        </td>
                        <td>
                            <c:choose>
                                <c:when test="${a.applyStatus == 0}"><span
                                        class="badge bg-warning text-dark">⏳ 待审核</span></c:when>
                                <c:when test="${a.applyStatus == 1}"><span
                                        class="badge bg-success">✅ 已通过</span></c:when>
                                <c:when test="${a.applyStatus == 2}"><span
                                        class="badge bg-danger">❌ 已驳回</span></c:when>
                            </c:choose>
                        </td>
                        <td>
                            <c:if test="${a.applyStatus == 0}">
                                <a href="${pageContext.request.contextPath}/auditServlet?action=audit&applyId=${a.id}&petId=${a.petId}&status=1"
                                   class="btn btn-sm btn-primary" onclick="return confirm('同意领养？')">同意</a>
                                <a href="${pageContext.request.contextPath}/auditServlet?action=audit&applyId=${a.id}&petId=${a.petId}&status=2"
                                   class="btn btn-sm btn-outline-danger" onclick="return confirm('驳回申请？')">驳回</a>
                            </c:if>
                            <c:if test="${a.applyStatus != 0}"><span class="text-muted small">已归档</span></c:if>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty applyList}">
                    <tr>
                        <td colspan="5" class="text-center py-3 text-muted">暂无领养申请记录</td>
                    </tr>
                </c:if>
                </tbody>
            </table>
        </div>
    </div>

</div>

<script>
    function toggleAll(source) {
        var checkboxes = document.getElementsByName('ids');
        for (var i = 0; i < checkboxes.length; i++) {
            checkboxes[i].checked = source.checked;
        }
    }

    function submitBatch(res) {
        // 检查是否有选中
        var checkboxes = document.getElementsByName('ids');
        var isChecked = false;
        for (var i = 0; i < checkboxes.length; i++) {
            if (checkboxes[i].checked) isChecked = true;
        }
        if (!isChecked) {
            alert("请至少选择一条数据！");
            return;
        }

        var tips = res === 1 ? "确定要批量【通过】这些信息吗？" : "确定要批量【驳回并删除】这些信息吗？";
        if (confirm(tips)) {
            document.getElementById("batchResult").value = res;
            document.getElementById("batchForm").submit();
        }
    }
</script>

</body>
</html>