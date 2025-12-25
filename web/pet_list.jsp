<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>领养中心 - 宠物救助系统</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        .pet-card {
            transition: transform 0.3s, box-shadow 0.3s;
            border: none;
            border-radius: 12px;
            overflow: hidden;
            height: 100%;
        }

        .pet-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1);
        }

        .pet-img-container {
            height: 200px;
            overflow: hidden;
            position: relative;
        }

        .pet-img-container img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: transform 0.5s;
        }

        .pet-card:hover .pet-img-container img {
            transform: scale(1.1);
        }

        .page-header {
            background: white;
            padding: 20px 0;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.05);
            margin-bottom: 30px;
        }
    </style>
</head>
<body>

<div class="page-header">
    <div class="container d-flex justify-content-between align-items-center">
        <h3 class="mb-0 fw-bold text-primary">🐾 领养中心</h3>
        <div>
            <a href="index.jsp" class="btn btn-outline-secondary btn-sm me-2">返回首页</a>
            <c:if test="${not empty sessionScope.currUser}">
                <a href="publish.jsp" class="btn btn-primary btn-sm">发布救助</a>
            </c:if>
        </div>
    </div>
</div>

<div class="container pb-5">

    <c:if test="${empty list}">
        <div class="text-center py-5 text-muted">
            <div style="font-size: 4rem;">🏝️</div>
            <h4 class="mt-3">暂时没有待领养的宠物</h4>
            <p>去<a href="publish.jsp">发布</a>一个试试？</p>
        </div>
    </c:if>

    <div class="row row-cols-1 row-cols-md-3 row-cols-lg-4 g-4">
        <c:forEach items="${list}" var="p">
            <div class="col">
                <div class="card pet-card shadow-sm">
                    <div class="pet-img-container">
                        <img src="static/images/${p.image}" alt="${p.petName}"
                             onerror="this.src='static/images/default.jpg'">
                        <div class="position-absolute top-0 end-0 m-2">
                            <span class="badge bg-light text-dark border">${p.type}</span>
                        </div>
                    </div>
                    <div class="card-body d-flex flex-column">
                        <h5 class="card-title fw-bold">${p.petName}</h5>
                        <p class="card-text text-muted small mb-2">
                            <span class="me-2">🏷️ ${p.sex}</span>
                        </p>
                        <p class="card-text text-secondary flex-grow-1"
                           style="font-size: 0.9rem; display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical; overflow: hidden;">
                                ${p.description}
                        </p>
                        <a href="apply.jsp?petId=${p.id}" class="btn btn-outline-primary w-100 mt-3">❤️ 申请领养</a>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
    <c:if test="${totalCount > 0}">
        <div class="row mt-4">
            <div class="col-12 d-flex justify-content-center">
                <nav aria-label="Page navigation">
                    <ul class="pagination">

                        <c:choose>
                            <c:when test="${currPage <= 1}">
                                <li class="page-item disabled"><span class="page-link">上一页</span></li>
                            </c:when>
                            <c:otherwise>
                                <li class="page-item">
                                    <a class="page-link" href="petList?page=${currPage - 1}">上一页</a>
                                </li>
                            </c:otherwise>
                        </c:choose>

                        <li class="page-item disabled">
                            <span class="page-link text-dark">
                                第 ${currPage} / ${totalPage == 0 ? 1 : totalPage} 页
                                (共 ${totalCount} 条)
                            </span>
                        </li>

                        <c:choose>
                            <c:when test="${currPage >= totalPage}">
                                <li class="page-item disabled"><span class="page-link">下一页</span></li>
                            </c:when>
                            <c:otherwise>
                                <li class="page-item">
                                    <a class="page-link" href="petList?page=${currPage + 1}">下一页</a>
                                </li>
                            </c:otherwise>
                        </c:choose>

                    </ul>
                </nav>
            </div>
        </div>
    </c:if>
</div>

</body>
</html>