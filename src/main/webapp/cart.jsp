<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div class="container py-5">
    <div class="row">
        <div class="col-lg-8">
            <div class="card border-0 shadow-sm rounded-3">
                <div class="card-header bg-white border-bottom py-3">
                    <h4 class="fw-bold m-0"><i class="bi bi-cart3 text-success me-2"></i>Your Shopping Cart</h4>
                </div>
                <div class="card-body p-0">
                    <c:choose>
                        <c:when test="${not empty sessionScope.cart.items}">
                            <div class="table-responsive">
                                <table class="table table-hover align-middle mb-0">
                                    <thead class="table-light">
                                        <tr>
                                            <th class="ps-4">Product</th>
                                            <th>Price</th>
                                            <th>Quantity</th>
                                            <th>Subtotal</th>
                                            <th class="text-end pe-4">Action</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="item" items="${sessionScope.cart.items}">
                                            <tr>
                                                <td class="ps-4">
                                                    <div class="fw-bold text-dark">${item.product.name}</div>
                                                    <small class="text-muted">${item.product.category.name}</small>
                                                </td>
                                                <td>${item.product.price} MMK</td>
                                                <td>
                                                    <span class="badge bg-light text-dark border px-3 py-2">
                                                        ${item.quantity}
                                                    </span>
                                                </td>
                                                <td class="fw-bold text-success">
                                                    ${item.product.price * item.quantity} MMK
                                                </td>
                                                <td class="text-end pe-4">
                                                    <a href="carts?mode=REMOVE&productId=${item.product.id}" 
                                                       class="btn btn-outline-danger btn-sm rounded-pill">
                                                        <i class="bi bi-trash"></i>
                                                    </a>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="text-center py-5">
                                <i class="bi bi-cart-x text-muted" style="font-size: 4rem;"></i>
                                <h5 class="mt-3">Your cart is feeling light!</h5>
                                <p class="text-muted">You haven't added any eco-friendly products yet.</p>
                                <a href="products" class="btn btn-success rounded-pill px-4">Start Shopping</a>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>

        <%-- Summary Sidebar --%>
<c:if test="${not empty sessionScope.cart.items}">
    <div class="col-lg-4">
        <form action="orders?mode=CHECKOUT" method="POST"> <div class="card border-0 shadow-sm rounded-3">
                <div class="card-body p-4">
                    <h5 class="fw-bold mb-4">Order Summary</h5>
                    <%-- ADDRESS SELECTION SECTION --%>
<div class="bg-light p-3 rounded-3 mb-3">
    <div class="d-flex align-items-center mb-2">
        <i class="bi bi-geo-alt-fill text-danger me-2"></i>
        <span class="small fw-bold">Shipping Address</span>
    </div>
    
    <c:choose>
        <c:when test="${not empty userAddresses}">
            <select name="addressId" class="form-select form-select-sm border-0 shadow-sm mb-2" required>
                <c:forEach var="addr" items="${userAddresses}">
                    <option value="${addr.id}" ${addr.is_default ? 'selected' : ''}>
                        ${addr.label}: ${addr.street}, ${addr.city}
                    </option>
                </c:forEach>
            </select>
            <div class="text-end">
                <a href="profile?mode=ADDRESS" class="text-success x-small" style="font-size: 0.7rem; text-decoration: none;">
                    + Add New Address
                </a>
            </div>
        </c:when>
        <c:otherwise>
            <div class="alert alert-warning p-2 mb-0" style="font-size: 0.75rem;">
                <i class="bi bi-exclamation-circle me-1"></i> No addresses found.
                <a href="profile?mode=ADDRESS" class="fw-bold text-dark">Add one now</a>
            </div>
        </c:otherwise>
    </c:choose>
</div>
                    <%-- LOYALTY POINTS SECTION --%>
                    <div class="bg-light p-3 rounded-3 mb-3">
                        <div class="d-flex align-items-center mb-2">
                            <i class="bi bi-star-fill text-warning me-2"></i>
                            <span class="small fw-bold">Loyalty Points</span>
                        </div>
                        <div class="d-flex justify-content-between small mb-2">
                            <span class="text-muted">Available:</span>
                            <span class="fw-bold">${sessionScope.loginUser.loyaltyPoints} pts</span>
                        </div>
                        
                        <c:if test="${sessionScope.loginUser.loyaltyPoints >= 100}">
                            <div class="form-check form-switch">
                                <input class="form-check-input" type="checkbox" name="usePoints" id="usePoints" value="true">
                                <label class="form-check-label small" for="usePoints">
                                    Use points for discount 
                                    <br><span class="text-success">(-1,000 MMK per 100 pts)</span>
                                </label>
                            </div>
                        </c:if>
                        <c:if test="${sessionScope.loginUser.loyaltyPoints < 100}">
                            <small class="text-muted italic">Need 100 pts to redeem</small>
                        </c:if>
                    </div>

                    <div class="d-flex justify-content-between mb-2">
                        <span class="text-muted">Total Items</span>
                        <span>${sessionScope.cart.items.size()}</span>
                    </div>
                    <hr class="my-3 opacity-10">
                    <div class="d-flex justify-content-between mb-4">
                        <span class="fs-5 fw-bold">Total Amount</span>
                        <span class="fs-5 fw-bold text-success">${sessionScope.cart.total} MMK</span>
                    </div>
                    
                    <button type="submit" class="btn btn-success w-100 py-2 fw-bold rounded-pill mb-2">
                        Proceed to Checkout
                    </button>
                    <a href="products?mode=LIST" class="btn btn-outline-secondary w-100 py-2 rounded-pill small">
                        Continue Shopping
                    </a>
                </div>
            </div>
        </form>
        
        <%-- Eco Tip --%>
        <div class="card bg-success text-white border-0 rounded-3 mt-3 shadow-sm">
            <div class="card-body">
                <small><i class="bi bi-leaf me-2"></i>Did you know?</small>
                <p class="small m-0 mt-1">Buying eco-friendly reduces your plastic footprint by up to 40% per year!</p>
            </div>
        </div>
    </div>
</c:if>
    </div>
</div>