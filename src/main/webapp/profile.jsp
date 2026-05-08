<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<div class="container py-5">
    <div class="row g-4">
        <div class="col-lg-4">
            <div class="card border-0 shadow-sm rounded-4 text-center p-4 mb-4 bg-white">
                <div class="position-relative d-inline-block mx-auto mb-3">
                    <div class="rounded-circle bg-success d-flex align-items-center justify-content-center text-white fw-bold shadow-sm" 
                         style="width: 80px; height: 80px; font-size: 2rem;">
                        ${loginUser.username.substring(0,1).toUpperCase()}
                    </div>
                </div>
                <h4 class="fw-bold mb-1">${loginUser.username}</h4>
                <p class="text-muted small mb-3">${loginUser.email}</p>
                <span class="badge rounded-pill bg-light text-success px-3 py-2 border border-success border-opacity-10">
                    <i class="bi bi-shield-check me-1"></i> ${loginUser.role}
                </span>
                
                <hr class="my-4 opacity-50">
                
                <div class="list-group list-group-flush text-start rounded-3 overflow-hidden">
                    <a href="orders?mode=VIEWALL" class="list-group-item list-group-item-action border-0 py-3">
                        <i class="bi bi-bag-check me-3"></i> My Orders
                    </a>
                    <a href="profile?mode=ADDRESS" class="list-group-item list-group-item-action border-0 py-3">
                        <i class="bi bi-geo-alt me-3"></i> Shipping Addresses
                    </a>
                    <a href="login?mode=LOGOUT" class="list-group-item list-group-item-action border-0 py-3 text-danger">
                        <i class="bi bi-box-arrow-right me-3"></i> Logout
                    </a>
                </div>
            </div>

            <div class="card border-0 shadow-sm rounded-4 p-4 bg-success text-white">
                <div class="d-flex align-items-center justify-content-between mb-3">
                    <h6 class="mb-0 text-uppercase small fw-bold opacity-75">Loyalty Points</h6>
                    <i class="bi bi-star-fill text-warning"></i>
                </div>
                <h2 class="fw-bold mb-0">${loginUser.loyaltyPoints} <span class="fs-6 fw-normal">Points</span></h2>
                <p class="small mt-2 mb-0 opacity-75">Use points to get discounts on your future EcoLink orders!</p>
            </div>
        </div>

        <div class="col-lg-8">
            <div class="card border-0 shadow-sm rounded-4 p-4 p-md-5 bg-white">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h5 class="fw-bold mb-0">Account Settings</h5>
                    <a href="profile?mode=EDIT" class="btn btn-sm btn-outline-success rounded-pill px-3">
    <i class="bi bi-pencil-square me-1"></i> Edit Profile
</a>
                </div>

                <form class="row g-4">
                    <div class="col-md-6">
                        <label class="form-label text-muted small fw-bold text-uppercase">Username</label>
                        <input type="text" class="form-control form-control-lg bg-light border-0" value="${loginUser.username}" readonly>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label text-muted small fw-bold text-uppercase">Email Address</label>
                        <input type="email" class="form-control form-control-lg bg-light border-0" value="${loginUser.email}" readonly>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label text-muted small fw-bold text-uppercase">Member Since</label>
                        <div class="form-control form-control-lg bg-light border-0 text-muted">
                            <i class="bi bi-calendar3 me-2"></i>
                            <%-- Note: Using standard date formatting for LocalDateTime --%>
                            ${loginUser.joinedDate.toLocalDate()}
                        </div>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label text-muted small fw-bold text-uppercase">Account Status</label>
                        <div class="form-control form-control-lg bg-light border-0">
                            <c:choose>
                                <c:when test="${loginUser.status}">
                                    <span class="text-success"><i class="bi bi-check-circle-fill me-2"></i> Active</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="text-danger"><i class="bi bi-x-circle-fill me-2"></i> Inactive</span>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </form>

                <div class="mt-5 p-4 rounded-4 border border-warning border-opacity-25 bg-warning bg-opacity-10">
                    <div class="d-flex">
                        <i class="bi bi-shield-lock text-warning fs-4 me-3"></i>
                        <div>
                            <h6 class="fw-bold text-dark">Security Notice</h6>
                            <p class="small text-muted mb-0">Keep your password secure and never share your credentials. Last login data is stored for your security.</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<style>
    .list-group-item-action:hover {
        background-color: #f8f9fa;
        color: #198754;
    }
    .form-control:focus {
        box-shadow: none;
    }
</style>