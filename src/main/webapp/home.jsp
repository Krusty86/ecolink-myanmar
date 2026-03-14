<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>EcoLink Myanmar | Home</title>
<link rel="stylesheet" href="css/bootstrap.min.css">
</head>
<body>
    <div class="container mt-5">
        <div class="row">
            <c:forEach items="${products }" var="product">
                <div class="col col-md-3 card m-2">
                    <div class="card-img-top">
                        
                    </div>
                    <div class="card-body">
                        <h3 class="card-title">${product.name}</h3>
                        <p class="warning card-text">${product.price} mmk</p>
                    </div>
                    <div class="card-footer">
                        <a href="products?mode=DETAIL&id=${product.id }" class="btn btn-outline-primary card-link">View Detail</a>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
    <script src="js/bootstrap.bundle.min.js"></script>
</body>
</html>