<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>发布成功</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f0f2f5;
            display: flex;
            align-items: center;
            justify-content: center;
            height: 100vh;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
    </style>
</head>
<body>

<div class="card text-center p-5 shadow border-0" style="border-radius: 15px; max-width: 500px;">
    <div class="mb-4">
        <div style="font-size: 5rem; color: #28a745;">🎉</div>
    </div>
    <h2 class="fw-bold mb-3 text-success">发布成功！</h2>
    <p class="text-muted mb-4">
        您的救助信息已成功提交。<br>
        管理员审核通过后，该宠物将展示在领养中心。
    </p>
    <div>
        <a href="index.jsp" class="btn btn-outline-secondary me-2">返回首页</a>
        <a href="petList" class="btn btn-primary"
           style="background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); border:none;">去看看其他宠物</a>
    </div>
</div>

</body>
</html>