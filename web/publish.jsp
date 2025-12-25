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
    <title>发布救助信息 - 宠物救助系统</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f0f2f5;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            padding-top: 50px;
            padding-bottom: 50px;
        }

        .publish-card {
            border: none;
            border-radius: 15px;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
            overflow: hidden;
        }

        .card-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 20px;
            text-align: center;
        }

        .form-label {
            font-weight: 600;
            color: #495057;
        }

        .btn-submit {
            background-color: #667eea;
            border: none;
            padding: 10px 30px;
            transition: all 0.3s;
        }

        .btn-submit:hover {
            background-color: #5a6fd6;
            transform: translateY(-2px);
        }
    </style>
</head>
<body>

<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-8 col-lg-6">

            <div class="card publish-card">
                <div class="card-header">
                    <h3 class="mb-0">📢 发布救助信息</h3>
                    <small style="opacity: 0.8;">请填写详细信息，管理员审核后即可展示</small>
                </div>

                <div class="card-body p-4">
                    <form action="publishServlet" method="post" enctype="multipart/form-data">

                        <div class="mb-3">
                            <label class="form-label">宠物昵称</label>
                            <input type="text" name="petName" class="form-control" placeholder="给它起个名字吧"
                                   required>
                        </div>

                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label">种类</label>
                                <select name="type" class="form-select">
                                    <option value="猫">🐱 猫</option>
                                    <option value="狗">🐶 狗</option>
                                    <option value="其他">🐰 其他</option>
                                </select>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label">性别</label>
                                <select name="sex" class="form-select">
                                    <option value="公">♂ 公</option>
                                    <option value="母">♀ 母</option>
                                    <option value="未知">❓ 未知</option>
                                </select>
                            </div>
                        </div>

                        <div class="mb-3">
                            <label class="form-label">年龄状况</label>
                            <input type="text" name="age" class="form-control" placeholder="例如：3个月 / 2岁 / 成年"
                                   required>
                        </div>

                        <div class="mb-3">
                            <label class="form-label">上传照片</label>
                            <input type="file" name="petImage" class="form-control" accept="image/*" required>
                            <div class="form-text">支持 jpg, png 等格式，建议上传清晰的近照。</div>
                        </div>

                        <div class="mb-4">
                            <label class="form-label">详细描述</label>
                            <textarea name="description" class="form-control" rows="4"
                                      placeholder="请描述宠物的健康状况、性格特点、捡到地点、联系方式等..."
                                      required></textarea>
                        </div>

                        <div class="d-grid gap-2">
                            <button type="submit" class="btn btn-primary btn-lg btn-submit">✨ 确认发布</button>
                            <a href="index.jsp" class="btn btn-light text-secondary mt-2">返回首页</a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>