<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div class="container py-5">
    <div class="row mb-4 align-items-center">
        <div class="col">
            <h2 class="fw-bold text-dark mb-1">My Addresses</h2>
            <p class="text-muted mb-0">Manage your shipping and billing destinations for EcoLink.</p>
        </div>
        <div class="col-auto">
            <button class="btn btn-success rounded-pill px-4 shadow-sm" data-bs-toggle="modal" data-bs-target="#addAddressModal">
                <i class="bi bi-plus-lg me-2"></i> Add New Address
            </button>
        </div>
    </div>

    <c:if test="${not empty param.error}">
        <div class="alert alert-danger alert-dismissible fade show rounded-4" role="alert">
            <i class="bi bi-exclamation-triangle me-2"></i> ${param.error}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>
    <c:if test="${param.msg == 'saved'}">
        <div class="alert alert-success alert-dismissible fade show rounded-4" role="alert">
            <i class="bi bi-check-circle me-2"></i> Address successfully added to your profile!
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>

    <div class="row g-4">
        <c:choose>
            <c:when test="${not empty addresses}">
                <c:forEach var="addr" items="${addresses}">
                    <div class="col-md-6 col-lg-4">
                        <div class="card h-100 border-0 shadow-sm rounded-4 position-relative ${addr.is_default ? 'border border-success bg-light-success' : 'bg-white'}">
                            
                            <c:if test="${addr.is_default}">
                                <span class="position-absolute top-0 end-0 m-3 badge rounded-pill bg-success">
                                    Default
                                </span>
                            </c:if>

                            <div class="card-body p-4">
                                <div class="d-flex align-items-center mb-3">
                                    <div class="rounded-circle bg-light p-2 me-3">
                                        <c:choose>
                                            <c:when test="${addr.address_type == 'SHIPPING'}">
                                                <i class="bi bi-truck text-success fs-5"></i>
                                            </c:when>
                                            <c:when test="${addr.address_type == 'BILLING'}">
                                                <i class="bi bi-receipt text-primary fs-5"></i>
                                            </c:when>
                                            <c:when test="${addr.address_type == 'PICKUP'}">
                                                <i class="bi bi-shop text-info fs-5"></i>
                                            </c:when>
                                            <c:when test="${addr.address_type == 'HOME'}">
                                                <i class="bi bi-house-door text-warning fs-5"></i>
                                            </c:when>
                                            <c:otherwise>
                                                <i class="bi bi-geo-alt text-secondary fs-5"></i>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                    <div>
                                        <h5 class="card-title fw-bold mb-0">${addr.label}</h5>
                                        <small class="text-muted text-uppercase fw-bold" style="font-size: 0.7rem;">${addr.address_type}</small>
                                    </div>
                                </div>
                                
                                <p class="card-text text-muted mb-4" style="min-height: 60px;">
                                    ${addr.street}, ${addr.township}<br>
                                    <strong>${addr.city}</strong>
                                </p>

                                <div class="d-flex gap-2 mt-auto">
                                    <c:if test="${!addr.is_default}">
                                        <form action="profile" method="POST" class="flex-grow-1">
                                            <input type="hidden" name="mode" value="ADDDEFAULT">
                                            <input type="hidden" name="aid" value="${addr.id}">
                                            <button type="submit" class="btn btn-outline-success btn-sm w-100 rounded-pill">Set Default</button>
                                        </form>
                                    </c:if>
                                    <a href="profile?mode=DELETEADDRESS&aid=${addr.id}" 
                                       class="btn btn-outline-danger btn-sm rounded-circle"
                                       onclick="return confirm('Delete this address permanently?')">
                                        <i class="bi bi-trash"></i>
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <div class="col-12 text-center py-5">
                    <div class="bg-light rounded-circle d-inline-flex p-4 mb-3">
                        <i class="bi bi-geo-alt text-muted display-4"></i>
                    </div>
                    <h5 class="text-muted">No addresses found.</h5>
                    <p class="small text-muted">Add an address to speed up your checkout process.</p>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</div>

<div class="modal fade" id="addAddressModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content border-0 rounded-4 shadow">
            <div class="modal-header border-0">
                <h5 class="modal-title fw-bold">Add New Address</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <form action="profile" method="POST">
                <input type="hidden" name="mode" value="SAVEADDRESS">
                
                <div class="modal-body p-4">
                    <div class="mb-3">
                        <label class="form-label small fw-bold text-uppercase opacity-75">Label</label>
                        <input type="text" name="label" class="form-control rounded-3" placeholder="e.g. My Warehouse, Office" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label small fw-bold text-uppercase opacity-75">Street Address</label>
                        <input type="text" name="street" class="form-control rounded-3" placeholder="No. 12, Strand Road" required>
                    </div>
                    <div class="row mb-3">
                        <div class="col">
                            <label class="form-label small fw-bold text-uppercase opacity-75">Township</label>
                            <input type="text" name="township" class="form-control rounded-3" required>
                        </div>
                        <div class="col">
                            <label class="form-label small fw-bold text-uppercase opacity-75">City</label>
                            <input type="text" name="city" class="form-control rounded-3" required>
                        </div>
                    </div>
                    <div class="mb-3">
                        <label class="form-label small fw-bold text-uppercase opacity-75">Address Type</label>
                        <select name="type" class="form-select rounded-3">
                            <option value="SHIPPING">Shipping Address</option>
                            <option value="BILLING">Billing Address</option>
                            <option value="PICKUP">Pickup Point</option>
                            <option value="HOME">Home</option>
                        </select>
                    </div>
                    <div class="form-check form-switch mt-4">
                        <input class="form-check-input" type="checkbox" name="isDefault" id="isDefault" value="true">
                        <label class="form-check-label small" for="isDefault">Make this my default address</label>
                    </div>
                </div>
                <div class="modal-footer border-0">
                    <button type="button" class="btn btn-light rounded-pill px-4" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-success rounded-pill px-4">Save Address</button>
                </div>
            </form>
        </div>
    </div>
</div>

<style>
    .bg-light-success { background-color: #f1fcf4; }
    .card { transition: transform 0.2s ease-in-out, box-shadow 0.2s; }
    .card:hover { transform: translateY(-5px); box-shadow: 0 .5rem 1rem rgba(0,0,0,.1) !important; }
    .form-switch .form-check-input:checked { background-color: #198754; border-color: #198754; }
</style>