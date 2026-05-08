<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<div class="container py-5">
    <div class="row mb-4 align-items-center">
        <div class="col">
            <h2 class="fw-bold text-dark mb-1">Order History</h2>
            <p class="text-muted mb-0">Track and manage your recent purchases</p>
        </div>
        <div class="col-auto">
            <a href="products?mode=LIST" class="btn btn-outline-success btn-sm rounded-pill px-3">
                <i class="bi bi-plus-lg me-1"></i> New Order
            </a>
        </div>
    </div>

    <div class="row g-3 mb-5">
        <div class="col-md-4">
            <div class="card border-0 shadow-sm rounded-4 p-3 bg-white">
                <div class="d-flex align-items-center">
                    <div class="flex-shrink-0 bg-light-success text-success p-3 rounded-circle me-3">
                        <i class="bi bi-bag-check fs-4"></i>
                    </div>
                    <div>
                        <h6 class="text-muted small mb-1">Total Orders</h6>
                        <h4 class="fw-bold mb-0">${orders.size()}</h4>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <c:choose>
        <c:when test="${not empty orders}">
            <div class="card border-0 shadow-sm rounded-4 overflow-hidden">
                <div class="table-responsive">
                    <table class="table table-hover align-middle mb-0">
                        <thead class="bg-light">
                            <tr class="text-muted small text-uppercase">
                                <th class="ps-4 py-3">Order ID</th>
                                <th class="py-3">Date</th>
                                <th class="py-3">Address</th>
                                <th class="py-3">Total Amount</th>
                                <th class="py-3">Status</th>
                                <th class="pe-4 text-end py-3">Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="order" items="${orders}">
                                <tr>
                                    <td class="ps-4">
                                        <span class="fw-bold text-dark">#${order.id}</span>
                                    </td>
                                    <td>
                                        <div class="small">
                                            <fmt:formatDate value="${order.order_date}" pattern="dd MMM yyyy"/>
                                        </div>
                                    </td>
                                    <td>
                                        <div class="text-truncate" style="max-width: 200px;">
                                            <span class="small text-muted">${order.address.label}</span><br>
                                            <span class="small">${order.address.city}</span>
                                        </div>
                                    </td>
                                    <td>
                                        <span class="fw-bold text-success">
                                            <fmt:formatNumber value="${order.total_amount}" type="number"/> MMK
                                        </span>
                                    </td>
                                    <td>
                                        <%-- FIXED: Added .name() to Enum comparison to avoid Coercion Exception --%>
                                        <c:set var="statusClass" value="bg-secondary"/>
                                        <c:choose>
                                            <c:when test="${order.status.name() == 'PENDING'}">
                                                <c:set var="statusClass" value="bg-warning text-dark"/>
                                            </c:when>
                                            <c:when test="${order.status.name() == 'SHIPPED'}">
                                                <c:set var="statusClass" value="bg-info text-white"/>
                                            </c:when>
                                            <c:when test="${order.status.name() == 'COMPLETED'}">
                                                <c:set var="statusClass" value="bg-success text-white"/>
                                            </c:when>
                                            <c:when test="${order.status.name() == 'CANCELLED'}">
                                                <c:set var="statusClass" value="bg-danger text-white"/>
                                            </c:when>
                                        </c:choose>
                                        
                                        <span class="badge ${statusClass} rounded-pill px-3 py-2 small">
                                            ${order.status.name()}
                                        </span>
                                    </td>
                                    <td class="pe-4 text-end">
                                        <a href="orders?mode=VIEW&oid=${order.id}" class="btn btn-light btn-sm rounded-circle shadow-sm">
                                            <i class="bi bi-eye text-dark"></i>
                                        </a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </c:when>
        <c:otherwise>
            <div class="text-center py-5 bg-white rounded-4 shadow-sm">
                <i class="bi bi-clipboard-x display-1 text-light mb-3"></i>
                <h4 class="fw-bold">No orders yet</h4>
                <p class="text-muted">You haven't placed any orders with us yet.</p>
                <a href="products?mode=LIST" class="btn btn-success rounded-pill px-4 mt-2">Start Shopping</a>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<style>
    .bg-light-success { background-color: #e8f5e9; }
    .table thead th { border-top: none; }
    .card { transition: transform 0.2s; }
    .card:hover { transform: translateY(-3px); }
</style>