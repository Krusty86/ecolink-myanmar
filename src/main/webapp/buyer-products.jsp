<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page import="java.util.*" %>
<%@ page import="dao.ProductImageDAO" %>
<%@ page import="entity.ProductImage" %>

<%
    // ============================
    // Prepare product images map (Same as Admin)
    // ============================
    ProductImageDAO imgDAO = new ProductImageDAO();
    Map<Long, String> productImages = new HashMap<>();

    if(request.getAttribute("products") != null){
        List productsList = (List) request.getAttribute("products");
        for(Object obj : productsList){
            entity.Product p = (entity.Product) obj;
            List<ProductImage> images = imgDAO.findByProductId(p.getId());
            if(images != null && !images.isEmpty()){
                productImages.put(p.getId(), images.get(0).getImage_path());
            }
        }
    }
    request.setAttribute("productImages", productImages);
%>

<c:set var="defaultImagePath" value="images/products/default.png"/>

<style>
    :root { --primary-green: #52a675; }
    body { background-color: #f8fcf9; }
    .product-card { border: none; border-radius: 12px; transition: transform 0.2s; overflow: hidden; }
    .product-card:hover { transform: translateY(-5px); }
    /* Ensure all images are the same size and look professional */
    .product-img-container {
        height: 200px;
        width: 100%;
        background-color: #f0f0f0;
        overflow: hidden;
    }
    .product-img {
        width: 100%;
        height: 100%;
        object-fit: cover;
    }
    /* Sidebar Sticky logic */
.sticky-sidebar {
    position: -webkit-sticky; /* for Safari */
    position: sticky;
    top: 2rem; /* Distance from the top of the screen when scrolling */
    z-index: 100;
    /* Optional: Max height to ensure it doesn't overflow the screen */
    max-height: calc(100vh - 4rem);
    overflow-y: auto;
}

/* Hide scrollbar for the sidebar if it overflows */
.sticky-sidebar::-webkit-scrollbar {
    width: 0px;
}
</style>

<div class="container py-5">
    <div class="mb-4">
        <h1 class="fw-bold">All Products</h1>
        <p class="text-muted">
            Browse our collection of ${fn:length(products)} eco-friendly products
        </p>
    </div>

    <div class="row g-4">
	<div class="col-lg-2">
    <div class="bg-white p-4 rounded-3 shadow-sm sticky-sidebar">
        <h5 class="fw-bold mb-3">Categories</h5>
        <form action="products" method="GET">
            
            <c:forEach var="cat" items="${category}">
                <div class="form-check mb-2">
                    <input class="form-check-input" 
                           type="checkbox" 
                           name="category" 
                           value="${cat.id}" 
                           id="cat_${cat.id}"
                           <c:if test="${fn:contains(paramValues.category, cat.id)}">checked</c:if>>
                    
                    <label class="form-check-label" for="cat_${cat.id}">
                        ${cat.name}
                    </label>
                </div>
            </c:forEach>

            <button type="submit" class="btn btn-sm btn-success mt-3 w-100">
                Apply Filters
            </button>
        </form>
    </div>
</div>

        <div class="col-lg-10">
            <div class="row g-4" id="products-grid">
                <c:choose>
                    <c:when test="${not empty products}">
                        <c:forEach var="product" items="${products}">
                            <div class="col-md-4">
                                <div class="card product-card shadow-sm h-100 border-0">
                                    
                                    <div class="product-img-container">
                                        <c:choose>
                                            <c:when test="${productImages[product.id] != null}">
                                                <img src="${pageContext.request.contextPath}/${productImages[product.id]}" 
                                                     class="product-img" alt="${product.name}">
                                            </c:when>
                                            <c:otherwise>
                                                <img src="${pageContext.request.contextPath}/${defaultImagePath}" 
                                                     class="product-img" alt="No image available">
                                            </c:otherwise>
                                        </c:choose>
                                    </div>

                                    <div class="card-body">
                                        <div class="d-flex justify-content-between align-items-start mb-2">
                                            <small class="text-success fw-bold text-uppercase" style="font-size: 0.7rem;">
                                                ${product.category.name}
                                            </small>
                                            <c:choose>
                                                <c:when test="${product.status == 'ACTIVE'}">
                                                    <span class="badge bg-success rounded-pill" style="font-size: 0.65rem;">ACTIVE</span>
                                                </c:when>
                                                <c:when test="${product.status == 'OUT_OF_STOCK'}">
                                                    <span class="badge bg-danger rounded-pill" style="font-size: 0.65rem;">OUT OF STOCK</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="badge bg-secondary rounded-pill" style="font-size: 0.65rem;">${product.status}</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>

                                        <h6 class="fw-bold mb-1">${product.name}</h6>

                                        <div class="bg-light p-2 rounded-2 mb-3">
                                            <div class="d-flex justify-content-between small">
                                                <span class="text-muted">Material:</span>
                                                <span class="fw-medium">${product.material_type}</span>
                                            </div>
                                            <div class="d-flex justify-content-between small">
                                                <span class="text-muted">Stock:</span>
                                                <span class="${product.qty < 5 ? 'text-danger fw-bold' : 'text-dark'}">${product.qty} units</span>
                                            </div>
                                        </div>

                                        <div class="d-flex justify-content-between align-items-center mt-auto">
                                            <div>
                                                <span class="fs-5 fw-bold text-dark">${product.price}</span>
                                                <small class="text-muted">MMK</small>
                                            </div>
                                            <form action="carts" method="POST" class="m-0">
                                                <input type="hidden" name="mode" value="ADD">
                                                <input type="hidden" name="productId" value="${product.id}">
                                                <button type="submit" class="btn btn-dark btn-sm rounded-pill px-3" ${product.qty <= 0 ? 'disabled' : ''}>
                                                    ${product.qty <= 0 ? 'Out of Stock' : 'Add to Cart'}
                                                </button>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <div class="col-12 text-center py-5">
                            <i class="bi bi-search fs-1 text-muted"></i>
                            <h4 class="mt-3">No products found</h4>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
</div>