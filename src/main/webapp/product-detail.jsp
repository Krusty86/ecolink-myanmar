<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div class="container py-5">
    <%-- Breadcrumb for easy navigation --%>
    <nav aria-label="breadcrumb" class="mb-4">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="home" class="text-success text-decoration-none">Home</a></li>
            <li class="breadcrumb-item"><a href="products?mode=LIST" class="text-success text-decoration-none">Products</a></li>
            <li class="breadcrumb-item active">${product.name}</li>
        </ol>
    </nav>

    <div class="row g-5">
        <%-- Left Column: Product Image --%>
        <div class="col-md-6">
            <div class="card border-0 shadow-sm rounded-4 overflow-hidden">
                <c:choose>
                    <c:when test="${not empty productImages[product.id]}">
                        <img src="${pageContext.request.contextPath}/${productImages[product.id]}" 
                             class="img-fluid w-100" alt="${product.name}" style="min-height: 400px; object-fit: cover;">
                    </c:when>
                    <c:otherwise>
                        <img src="${pageContext.request.contextPath}/images/products/default.png" 
                             class="img-fluid w-100" alt="No image">
                    </c:otherwise>
                </c:choose>
            </div>
            
            <%-- Sustainability Badge --%>
            <div class="mt-4 p-3 bg-success bg-opacity-10 border border-success border-opacity-25 rounded-3 d-flex align-items-center">
                <i class="bi bi-recycle fs-3 text-success me-3"></i>
                <div>
                    <h6 class="fw-bold text-success mb-1">Plastic Saved: ${product.plastic_saved_per_unit}g</h6>
                    <small class="text-muted">By choosing this product, you're directly reducing plastic waste in Myanmar.</small>
                </div>
            </div>
        </div>

        <%-- Right Column: Product Details --%>
        <div class="col-md-6">
            <span class="badge bg-light text-success border border-success mb-2 px-3 py-2 rounded-pill">
                ${product.category.name}
            </span>
            <h1 class="fw-bold mb-3">${product.name}</h1>
            
            <div class="d-flex align-items-center mb-4">
                <h2 class="text-success fw-bold me-3 mb-0">${product.price} MMK</h2>
                <c:if test="${product.qty > 0}">
                    <span class="badge bg-success-subtle text-success border border-success border-opacity-25">In Stock (${product.qty})</span>
                </c:if>
                <c:if test="${product.qty <= 0}">
                    <span class="badge bg-danger-subtle text-danger border border-danger border-opacity-25">Out of Stock</span>
                </c:if>
            </div>

            <p class="text-muted mb-4 fs-5">
                Experience sustainable living with our <strong>${product.material_type}</strong> ${product.name}. 
                Crafted for durability and environmental responsibility, this item is perfect for those 
                looking to transition to a zero-waste lifestyle.
            </p>

            <%-- Specifications --%>
            <div class="row g-3 mb-5">
                <div class="col-6">
                    <div class="border rounded-3 p-3 text-center">
                        <small class="text-muted d-block mb-1">Material</small>
                        <span class="fw-bold">${product.material_type}</span>
                    </div>
                </div>
                <div class="col-6">
                    <div class="border rounded-3 p-3 text-center">
                        <small class="text-muted d-block mb-1">Sustainability Score</small>
                        <span class="fw-bold text-success">Excellent</span>
                    </div>
                </div>
            </div>

            <%-- Purchase Actions --%>
            <form action="carts" method="POST" class="d-flex gap-3">
                <input type="hidden" name="mode" value="ADD">
                <input type="hidden" name="productId" value="${product.id}">
                
                <div class="input-group" style="max-width: 130px;">
                    <button class="btn btn-outline-secondary" type="button" onclick="changeQty(-1)">-</button>
                    <input type="number" name="quantity" id="qtyInput" class="form-control text-center" value="1" min="1" max="${product.qty}">
                    <button class="btn btn-outline-secondary" type="button" onclick="changeQty(1)">+</button>
                </div>

                <button type="submit" class="btn btn-success flex-grow-1 py-3 fw-bold rounded-3" ${product.qty <= 0 ? 'disabled' : ''}>
                    <i class="bi bi-cart-plus me-2"></i> ${product.qty <= 0 ? 'Out of Stock' : 'Add to Cart'}
                </button>
            </form>
            
            <hr class="my-5">
            

            <div class="row g-4 small text-muted">
                <div class="col-sm-4">
                    <i class="bi bi-truck text-success me-1"></i> Fast Delivery
                </div>
                <div class="col-sm-4">
                    <i class="bi bi-shield-check text-success me-1"></i> Quality Tested
                </div>
                <div class="col-sm-4">
                    <i class="bi bi-star text-success me-1"></i> Earn Points
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    function changeQty(amt) {
        const input = document.getElementById('qtyInput');
        let newVal = parseInt(input.value) + amt;
        const max = parseInt(input.getAttribute('max'));
        if (newVal >= 1 && newVal <= max) {
            input.value = newVal;
        }
    }
</script>