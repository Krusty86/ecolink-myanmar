<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


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
        <div class="card border-0 shadow-sm rounded-4 h-100 eco-card-hover">
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
                    <span>+12% <span class="text-muted fw-normal">since last month</span></span>
                </div>
            </div>
        </div>
    </div>

    <div class="col-12 col-md-4">
        <div class="card border-0 shadow-sm rounded-4 h-100 eco-card-hover">
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
        </div>
    </div>

    <div class="col-12 col-md-4">
        <div class="card border-0 shadow-sm rounded-4 h-100 eco-card-hover border-start border-success border-4">
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
        </div>
    </div>
</div>

    <div class="row g-4">
        <div class="col-lg-8">
            <div class="card border-0 shadow-sm rounded-4 p-4 h-100">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h5 class="fw-bold mb-0">Sales Analytics</h5>
                    <select class="form-select form-select-sm w-auto rounded-pill">
                        <option>Last 7 Days</option>
                        <option>Last 30 Days</option>
                    </select>
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
</div>

<script>
document.addEventListener("DOMContentLoaded", function() {
    // --- 1. SALES TREND LINE CHART ---
    const ctxSales = document.getElementById('salesChart').getContext('2d');
    new Chart(ctxSales, {
        type: 'line',
        data: {
            labels: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'],
            datasets: [{
                label: 'Orders',
                data: [12, 19, 15, 25, 22, 30, 28], // You can pass JSP data here later
                borderColor: '#198754',
                backgroundColor: 'rgba(25, 135, 84, 0.1)',
                fill: true,
                tension: 0.4,
                pointRadius: 5,
                pointBackgroundColor: '#198754'
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            plugins: { legend: { display: false } },
            scales: {
                y: { beginAtZero: true, grid: { display: false } },
                x: { grid: { display: false } }
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
</style>

<script>
    if (typeof lucide !== 'undefined') {
        lucide.createIcons();
    }
</script>