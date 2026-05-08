<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<div class="container py-5">
    <div class="row justify-content-center">
        <div class="col-lg-10">
            <div class="card border-0 shadow-sm rounded-4 overflow-hidden">
                <div class="card-header bg-success text-white p-4 border-0">
                    <div class="d-flex justify-content-between align-items-center">
                        <div>
                            <h3 class="fw-bold mb-0">Invoice</h3>
                            <p class="mb-0 opacity-75">Order #${order.id}</p>
                        </div>
                        <div class="text-end">
                            <span class="badge bg-white text-success rounded-pill px-3 py-2">
                                <i class="bi bi-clock-history me-1"></i> ${order.status}
                            </span>
                        </div>
                    </div>
                </div>

                <div class="card-body p-4 p-md-5">
                    <div class="row mb-5">
                        <div class="col-sm-6">
                            <h6 class="text-muted text-uppercase small fw-bold mb-3">Customer Details</h6>
                            <p class="mb-1 fw-bold text-dark">${order.user.username}</p>
                            <p class="text-muted small">${order.user.email}</p>
                        </div>
                        <div class="col-sm-6 text-sm-end">
                            <h6 class="text-muted text-uppercase small fw-bold mb-3">Shipping Address</h6>
                            <p class="mb-1 fw-bold text-dark">${order.address.label}</p>
                            <p class="text-muted small mb-0">
                                ${order.address.street}, ${order.address.township}<br>
                                ${order.address.city}
                            </p>
                        </div>
                    </div>

                    <div class="table-responsive mb-4">
                        <table class="table table-borderless align-middle">
                            <thead class="border-bottom">
                                <tr class="text-muted small text-uppercase">
                                    <th>Item Description</th>
                                    <th class="text-center">Quantity</th>
                                    <th class="text-end">Price</th>
                                    <th class="text-end">Subtotal</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="item" items="${items}">
                                    <tr class="border-bottom-0">
                                        <td class="py-3">
                                            <div class="fw-bold text-dark">${item.product.name}</div>
                                            <small class="text-muted">${item.product.material_type}</small>
                                        </td>
                                        <td class="text-center">${item.quantity}</td>
                                        <td class="text-end">${item.product.price} MMK</td>
                                        <td class="text-end fw-bold">${item.product.price * item.quantity} MMK</td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>

                    <div class="row justify-content-end">
                        <div class="col-md-5">
                            <div class="bg-light rounded-3 p-4">
                                <div class="d-flex justify-content-between mb-2">
                                    <span class="text-muted">Order Date:</span>
                                    <span class="small"><fmt:formatDate value="${order.order_date}" pattern="dd MMM yyyy, HH:mm"/></span>
                                </div>
                                <hr>
                                <div class="d-flex justify-content-between">
                                    <span class="fs-5 fw-bold">Grand Total:</span>
                                    <span class="fs-5 fw-bold text-success">${order.total_amount} MMK</span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="card-footer bg-white border-0 p-4 text-center">
                    <button onclick="window.print()" class="btn btn-outline-secondary btn-sm rounded-pill px-4 me-2">
                        <i class="bi bi-printer me-2"></i>Print Invoice
                    </button>
                    <a href="products?mode=LIST" class="btn btn-success btn-sm rounded-pill px-4">
                        Continue Shopping
                    </a>
                </div>
            </div>
        </div>
    </div>
</div>