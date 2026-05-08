<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Orders | EcoShop</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
    <style>
        :root {
            --bg-body: #f9fafb;
            --border-color: #e5e7eb;
        }
        body { background-color: var(--bg-body); font-family: sans-serif; }
        
        .order-card {
            border: 1px solid var(--border-color);
            border-radius: 12px;
            transition: shadow 0.2s ease;
            overflow: hidden;
            background: white;
            margin-bottom: 1rem;
        }
        .order-card:hover { box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1); }
        
        .order-header {
            padding: 1.5rem;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: space-between;
            background: none;
            border: none;
            width: 100%;
        }
        .order-header:hover { background-color: #f3f4f6; }

        .status-badge { padding: 0.25rem 0.75rem; border-radius: 9999px; font-size: 0.875rem; font-weight: 500; }
        .status-delivered { background-color: #dcfce7; color: #166534; }
        .status-shipped { background-color: #dbeafe; color: #1e40af; }
        .status-processing { background-color: #fef9c3; color: #854d0e; }
        
        .details-pane { background-color: #f8fafc; border-top: 1px solid var(--border-color); padding: 1.5rem; }
        .item-img { width: 64px; height: 64px; object-fit: cover; border-radius: 6px; }
        .tracking-box { background: white; border: 1px solid var(--border-color); border-radius: 8px; padding: 1rem; }
    </style>
</head>
<body>

    <nav class="navbar navbar-light bg-white border-bottom py-3">
        <div class="container">
            <a class="navbar-brand fw-bold text-success" href="/"><i class="bi bi-leaf-fill me-2"></i>EcoShop</a>
        </div>
    </nav>

    <div class="container py-5">
        <div class="max-width-auto" style="max-width: 800px; margin: 0 auto;">
            <div class="mb-5">
                <h1 class="fw-bold display-6">My Orders</h1>
                <p class="text-muted">Track and manage all your orders in one place</p>
            </div>

            <div id="orders-container">
            	<div id="orders-container">

    <div class="card mb-3 border-light shadow-sm" style="border-radius: 12px; overflow: hidden;">
        <div class="card-header bg-white p-0 border-0">
            <button class="btn w-100 text-start p-4 d-flex align-items-center justify-content-between" 
                    type="button" 
                    data-bs-toggle="collapse" 
                    data-bs-target="#orderOneDetails">
                
                <div class="d-flex align-items-start gap-3">
                    <i class="bi bi-check-circle-fill text-success fs-5"></i>
                    <div>
                        <div class="d-flex align-items-center gap-2 mb-1">
                            <span class="fw-bold text-dark">ORD-2024-001</span>	<!-- Order ID -->
                            <span class="badge rounded-pill bg-success-subtle text-success border border-success-subtle">Delivered</span>
                        </div>
                        <small class="text-muted">Ordered on April 15, 2024</small>
                    </div>
                </div>

                <div class="d-flex align-items-center gap-4">
                    <div class="text-end d-none d-sm-block">
                        <div class="fw-bold text-dark fs-5">$87.97</div>
                        <small class="text-muted">2 items</small>
                    </div>
                    <i class="bi bi-chevron-down text-muted"></i>
                </div>
            </button>
        </div>

        <div id="orderOneDetails" class="collapse">
            <div class="card-body bg-light border-top p-4">
                <h6 class="fw-bold mb-3">Order Items</h6>
                
                <div class="d-flex gap-3 mb-3">
                    <img src="https://images.unsplash.com/photo-1610701596007-11502861dcfa?w=100&h=100&fit=crop" 
                         class="rounded" style="width: 64px; height: 64px; object-fit: cover;" alt="Product">
                    <div>
                        <div class="fw-medium text-dark">Bamboo Toothbrush Set</div>
                        <small class="text-muted">Qty: 2 × $12.99 = $25.98</small>
                    </div>
                </div>

                <div class="bg-white border rounded p-3 my-4">
                    <div class="row">
                        <div class="col-sm-6 mb-2 mb-sm-0">
                            <div class="text-muted small">Tracking Number</div>
                            <code class="text-dark fw-bold">TRK-123456789</code>
                        </div>
                        <div class="col-sm-6">
                            <div class="text-muted small">Estimated Delivery</div>
                            <div class="text-dark fw-medium">April 20, 2024</div>
                        </div>
                    </div>
                </div>

                <div class="d-flex gap-2">
                    <button class="btn btn-outline-dark flex-grow-1">View Details</button>
                </div>
            </div>
        </div>
    </div>
    
    </div>
                </div>

            <div id="empty-state" class="text-center py-5 d-none">
                <div class="card p-5 border-0 shadow-sm">
                    <i class="bi bi-box-seam display-1 text-muted mb-4"></i>
                    <h3>No orders yet</h3>
                    <p class="text-muted">You haven't placed any orders. Start shopping to see your orders here!</p>
                    <div class="mt-4">
                        <a href="/products" class="btn btn-success btn-lg">Continue Shopping</a>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="orders.js"></script>
</body>
</html>