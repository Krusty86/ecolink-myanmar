<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<div class="container py-4">
<div class="mb-4">
    <nav aria-label="breadcrumb">
        <ol class="breadcrumb mb-1">
            <li class="breadcrumb-item"><a href="home" class="text-success text-decoration-none small fw-bold">Admin</a></li>
            <li class="breadcrumb-item active small">Overview</li>
        </ol>
    </nav>
    <h1 class="h3 fw-bold text-dark d-flex align-items-center">
        <i class="bi bi-grid-1x2-fill text-success me-2" style="font-size: 1.5rem;"></i> Dashboard
    </h1>
    <p class="text-secondary">Welcome back! Here's your business overview for EcoLink Myanmar.</p>
</div>

<div class="row g-4 mb-4">
    <div class="col-12 col-md-4">
        <div class="card border-0 shadow-sm rounded-4 h-100 eco-card-hover position-relative">
            <div class="card-body p-4">
                <div class="d-flex justify-content-between align-items-start mb-3">
                    <div>
                        <span class="text-muted fw-bold small text-uppercase ls-wide">Total Orders</span>
                        <h2 class="fw-bold mb-0 mt-1">${orderCount}</h2>
                    </div>
                    <div class="p-3 bg-success bg-opacity-10 text-success rounded-3">
                        <i data-lucide="shopping-cart"></i>
                    </div>
                </div>
                <div class="d-flex align-items-center text-success small fw-bold">
                    <i data-lucide="trending-up" class="me-1" style="width: 16px;"></i>
                </div>
            </div>
            <a href="home?mode=ORDERS" class="stretched-link"></a>
        </div>
    </div>

    <div class="col-12 col-md-4">
        <div class="card border-0 shadow-sm rounded-4 h-100 eco-card-hover position-relative">
            <div class="card-body p-4">
                <div class="d-flex justify-content-between align-items-start mb-3">
                    <div>
                        <span class="text-muted fw-bold small text-uppercase ls-wide">Active Inventory</span>
                        <h2 class="fw-bold mb-0 mt-1">${productCount}</h2>
                    </div>
                    <div class="p-3 bg-success bg-opacity-10 text-success rounded-3">
                        <i data-lucide="package"></i>
                    </div>
                </div>
                <div class="d-flex align-items-center text-success small fw-bold">
                    <i data-lucide="plus-circle" class="me-1" style="width: 16px;"></i>
                    <span>Recently Updated</span>
                </div>
            </div>
            <a href="home?mode=PRODUCTS" class="stretched-link"></a>
        </div>
    </div>

    <div class="col-12 col-md-4">
        <div class="card border-0 shadow-sm rounded-4 h-100 eco-card-hover border-start border-success border-4 position-relative">
            <div class="card-body p-4">
                <div class="d-flex justify-content-between align-items-start mb-3">
                    <div>
                        <span class="text-muted fw-bold small text-uppercase ls-wide">Eco Community</span>
                        <h2 class="fw-bold mb-0 mt-1">${userCount}</h2>
                    </div>
                    <div class="p-3 bg-success text-white rounded-3 shadow-sm">
                        <i data-lucide="users"></i>
                    </div>
                </div>
                <div class="d-flex align-items-center text-muted small">
                    <i data-lucide="check-circle" class="me-1 text-success" style="width: 16px;"></i>
                    <span>Verified Active Users</span>
                </div>
            </div>
            <a href="home?mode=USERS" class="stretched-link"></a>
        </div>
    </div>
</div>
    <div class="row g-4">
        <div class="col-lg-8">
            <div class="card border-0 shadow-sm rounded-4 p-4 h-100">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h5 class="fw-bold mb-0">Sales Analytics</h5>
                    <input type="month" 
           class="form-control form-control-sm w-auto rounded-pill" 
           value="${selectedMonth}" 
           onchange="location.href='home?mode=DASHBOARD&month=' + this.value">
                </div>
                <div style="height: 300px;">
                    <canvas id="salesChart"></canvas>
                </div>
            </div>
        </div>

        <div class="col-lg-4">
            <div class="card border-0 shadow-sm rounded-4 p-4 h-100">
                <h5 class="fw-bold mb-4">Category Split</h5>
                <div style="height: 250px;">
                    <canvas id="categoryChart"></canvas>
                </div>
                <div class="mt-4 small text-muted text-center">
                    <i class="bi bi-info-circle me-1"></i> Based on total inventory units
                </div>
            </div>
        </div>
    </div>
    <%-- RECENT ORDERS SECTION --%>
<div class="row mt-4">
    <div class="col-12">
        <div class="card border-0 shadow-sm rounded-4 overflow-hidden">
            <div class="card-header bg-white border-0 p-4 d-flex justify-content-between align-items-center">
                <h5 class="fw-bold mb-0">Recent Orders</h5>
                <a href="home?mode=ORDERS" class="btn btn-sm btn-outline-success rounded-pill px-3">View All</a>
            </div>
            <div class="table-responsive">
                <table class="table table-hover align-middle mb-0">
                    <thead class="bg-light">
                        <tr>
                            <th class="ps-4 border-0 text-muted small text-uppercase fw-bold">Order ID</th>
                            <th class="border-0 text-muted small text-uppercase fw-bold">Customer</th>
                            <th class="border-0 text-muted small text-uppercase fw-bold">Date</th>
                            <th class="border-0 text-muted small text-uppercase fw-bold">Total</th>
                            <th class="border-0 text-muted small text-uppercase fw-bold text-center">Status</th>
                            <th class="pe-4 border-0 text-muted small text-uppercase fw-bold text-end">Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:choose>
                            <c:when test="${not empty recentOrders}">
                                <c:forEach var="order" items="${recentOrders}">
                                    <tr>
                                        <td class="ps-4 fw-bold text-dark">#${order.id}</td>
                                        <td>
                                            <div class="d-flex align-items-center">
                                                <div class="avatar-sm-text me-2 bg-success bg-opacity-10 text-success rounded-circle d-flex align-items-center justify-content-center fw-bold" style="width: 32px; height: 32px; font-size: 0.8rem;">
                                                    ${fn:substring(order.user.username, 0, 1).toUpperCase()}
                                                </div>
                                                <span>${order.user.username}</span>
                                            </div>
                                        </td>
                                        <td class="text-secondary small">${order.order_date}</td>
                                        <td class="fw-bold">${order.total_amount} <small>MMK</small></td>
                                        <td class="text-center">
                                            <c:set var="statusClass" value="bg-secondary" />
                                            <c:choose>
                                                <c:when test="${order.status == 'DELIVERED'}"><c:set var="statusClass" value="bg-success" /></c:when>
                                                <c:when test="${order.status == 'PENDING'}"><c:set var="statusClass" value="bg-warning text-dark" /></c:when>
                                                <c:when test="${order.status == 'SHIPPING'}"><c:set var="statusClass" value="bg-primary" /></c:when>
                                                <c:when test="${order.status == 'CONFIRMED'}"><c:set var="statusClass" value="bg-info" /></c:when>
                                                <c:otherwise><c:set var="statusClass" value="bg-danger" /></c:otherwise>
                                            </c:choose>
                                            <span class="badge ${statusClass} rounded-pill fw-normal px-3 py-2" style="font-size: 0.7rem;">
                                                ${order.status}
                                            </span>
                                        </td>
                                        <td class="pe-4 text-end">
                                            <div class="btn-group rounded-3 overflow-hidden shadow-sm border">
                                    <button class="btn btn-white btn-sm viewBtn" 
                                            data-id="${order.id}" data-user="${order.user.username}"
                                            data-email="${order.user.email}" data-total="${order.total_amount}"
                                            data-status="${order.status}" data-date="${order.order_date}"
                                            data-points="${order.points_spent}" data-discount="${order.discount_amount_from_points}"
                                            data-address="${order.address}"
                                            data-bs-toggle="modal" data-bs-target="#viewOrderModal">
                                        <i class="bi bi-eye"></i>
                                    </button></div>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <tr>
                                    <td colspan="6" class="text-center py-5 text-muted">
                                        <i class="bi bi-inbox fs-2 d-block mb-2"></i>
                                        No recent orders found.
                                    </td>
                                </tr>
                            </c:otherwise>
                        </c:choose>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
</div>
<div class="modal fade" id="viewOrderModal" tabindex="-1">
    <div class="modal-dialog modal-dialog-centered modal-lg">
        <div class="modal-content border-0 shadow rounded-4 overflow-hidden">
            <div class="modal-header bg-success text-white border-0 py-3">
                <h5 class="fw-bold mb-0">Order Receipt Detail</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body p-0">
                <div class="row g-0">
                    <div class="col-md-5 bg-light p-4">
                        <div class="text-center mb-4">
                            <div class="bg-success text-white rounded-circle d-inline-flex align-items-center justify-content-center mb-2" style="width: 60px; height: 60px;">
                                <i class="bi bi-box-seam fs-3"></i>
                            </div>
                            <h5 class="fw-bold mb-0" id="v_id"></h5>
                            <span class="badge bg-success bg-opacity-10 text-success rounded-pill px-3 mt-2" id="v_status"></span>
                        </div>
                        <div class="mb-3">
                            <label class="text-muted small d-block text-uppercase fw-bold">Customer Info</label>
                            <div class="fw-bold text-dark" id="v_user"></div>
                            <div class="small text-muted" id="v_email"></div>
                        </div>
                        <div class="mb-0">
                            <label class="text-muted small d-block text-uppercase fw-bold">Shipping Address</label>
                            <div class="small text-dark" id="v_address"></div>
                        </div>
                    </div>
                    <div class="col-md-7 p-4">
                        <label class="text-muted small d-block text-uppercase fw-bold mb-3">Order Summary</label>
                        <div class="d-flex justify-content-between mb-2">
                            <span class="text-secondary">Order Date:</span>
                            <span class="fw-bold" id="v_date"></span>
                        </div>
                        <div class="d-flex justify-content-between mb-2">
                            <span class="text-secondary">Points Used:</span>
                            <span class="fw-bold text-primary" id="v_points"></span>
                        </div>
                        <div class="d-flex justify-content-between mb-2">
                            <span class="text-secondary">Points Discount:</span>
                            <span class="fw-bold text-danger" id="v_discount"></span>
                        </div>
                        <hr>
                        <div class="d-flex justify-content-between align-items-center">
                            <span class="h5 fw-bold mb-0">Total Paid</span>
                            <span class="h4 fw-bold text-success mb-0" id="v_total"></span>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal-footer border-0 bg-light">
                <button type="button" class="btn btn-secondary rounded-pill px-4" data-bs-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>

<script>
document.addEventListener("DOMContentLoaded", function() {
    // --- 1. SALES TREND LINE CHART ---
const ctxSales = document.getElementById('salesChart').getContext('2d');
    
    // Extract just the Day number from the full date "YYYY-MM-DD"
    const rawLabels = [
        <c:forEach var="label" items="${salesLabels}" varStatus="loop">
            '${label}'${!loop.last ? ',' : ''}
        </c:forEach>
    ];
    
    const displayLabels = rawLabels.map(date => date.split('-')[2]); // Shows "01", "02", etc.
    
    const dataValues = [
        <c:forEach var="val" items="${salesValues}" varStatus="loop">
            ${val}${!loop.last ? ',' : ''}
        </c:forEach>
    ];

    new Chart(ctxSales, {
        type: 'line',
        data: {
            labels: displayLabels,
            datasets: [{
                label: 'Orders',
                data: dataValues,
                borderColor: '#198754',
                backgroundColor: 'rgba(25, 135, 84, 0.1)',
                fill: true,
                tension: 0.3,
                pointRadius: displayLabels.length > 15 ? 2 : 4 // Smaller dots for full month
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            scales: {
                x: {
                    title: { display: true, text: 'Day of Month', font: { size: 10 } },
                    grid: { display: false }
                },
                y: { beginAtZero: true, ticks: { stepSize: 1 } }
            }
        }
    });

    // --- 2. CATEGORY DOUGHNUT CHART ---
    const ctxCat = document.getElementById('categoryChart').getContext('2d');
    new Chart(ctxCat, {
        type: 'doughnut',
        data: {
            labels: ['Bamboo', 'Recycled', 'Organic', 'Other'],
            datasets: [{
                data: [40, 25, 20, 15],
                backgroundColor: ['#198754', '#20c997', '#a3cfbb', '#e9ecef'],
                borderWidth: 0,
                hoverOffset: 10
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            plugins: {
                legend: {
                    position: 'bottom',
                    labels: { usePointStyle: true, padding: 20 }
                }
            },
            cutout: '70%'
        }
    });
});
</script>
<style>
    .eco-card-hover {
        transition: transform 0.2s ease, box-shadow 0.2s ease;
    }
    .eco-card-hover:hover {
        transform: translateY(-5px);
        box-shadow: 0 10px 25px rgba(25, 135, 84, 0.1) !important;
    }
    .ls-wide {
        letter-spacing: 0.5px;
    }
    /* Lucide sizing fix */
    [data-lucide] {
        width: 24px;
        height: 24px;
    }
    .eco-card-hover {
    cursor: pointer; /* Changes the mouse to a hand icon */
}

/* Ensure the stretched link doesn't show a default focus outline that looks ugly */
.stretched-link:focus {
    outline: none;
}
</style>

<script>
    if (typeof lucide !== 'undefined') {
        lucide.createIcons();
    }
</script>