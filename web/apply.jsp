<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:if test="${empty sessionScope.currUser}">
    <c:redirect url="login.jsp"></c:redirect>
</c:if>

<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>申请领养 - 宠物救助系统</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f0f2f5; /* */
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            padding-top: 50px;
        }

        .apply-card {
            border: none;
            border-radius: 15px;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
            overflow: hidden;
        }

        .apply-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); /* */
            color: white;
            padding: 20px;
            text-align: center;
        }
    </style>
</head>
<body>

<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-8 col-lg-6">

            <div class="card apply-card">
                <div class="apply-header">
                    <h3 class="mb-0">📝 领养申请表</h3>
                    <small style="opacity: 0.9;">请真诚填写您的领养条件</small>
                </div>
                <div class="card-body p-4">
                    <form action="applyServlet" method="post">
                        <input type="hidden" name="petId" value="${param.petId}">

                        <div class="mb-3">
                            <label class="form-label fw-bold text-secondary">申请人账号</label>
                            <input type="text" class="form-control bg-light" value="${sessionScope.currUser.username}"
                                   disabled>
                            <div class="form-text">系统自动获取您的登录账号</div>
                        </div>

                        <div class="mb-4">
                            <label class="form-label fw-bold text-secondary">申请理由 / 养宠条件</label>
                            <textarea name="reason" class="form-control" rows="5"
                                      placeholder="例如：我有稳定的住房和收入，家人支持养宠，之前有过养猫经验..."
                                      required></textarea>
                        </div>

                        <div class="d-grid gap-2">
                            <button type="submit" class="btn btn-success btn-lg"
                                    style="background-color: #28a745; border:none;">✅ 提交申请
                            </button>
                            <a href="petList" class="btn btn-light text-secondary mt-2">返回列表</a>
                        </div>
                    </form>
                </div>
            </div>

        </div>
    </div>
</div>

</body>
</html>