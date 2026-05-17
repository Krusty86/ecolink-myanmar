<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<div class="container py-4">

	<div class="row g-3 mb-4">
		<div class="mb-4">
			<nav aria-label="breadcrumb">
				<ol class="breadcrumb mb-1">
					<li class="breadcrumb-item"><a href="home"
						class="text-success text-decoration-none">Admin</a></li>
					<li class="breadcrumb-item active">Orders</li>
				</ol>
			</nav>
			<h2 class="fw-bold text-dark d-flex align-items-center">
				<i class="bi bi-cart-check-fill text-success me-2"></i> Order
				Management
			</h2>
		</div>
		<div class="col-md-4">
			<div class="card border-0 shadow-sm rounded-4 bg-white p-3">
				<div class="d-flex align-items-center">
					<div
						class="bg-success bg-opacity-10 text-success p-3 rounded-circle me-3">
						<i class="bi bi-currency-dollar fs-4"></i>
					</div>
					<div>
						<small class="text-muted d-block text-uppercase fw-bold">Total
							Orders</small>
						<h4 class="fw-bold mb-0">${orders.size()}</h4>
					</div>
				</div>
			</div>
		</div>
		<div class="col-md-4">
			<div
				class="card border-0 shadow-sm rounded-4 bg-white p-3 border-start border-primary border-4">
				<div class="d-flex align-items-center">
					<div
						class="bg-primary bg-opacity-10 text-primary p-3 rounded-circle me-3">
						<i class="bi bi-truck fs-4"></i>
					</div>
					<div>
						<small class="text-muted d-block text-uppercase fw-bold">Active
							Deliveries</small>
						<h4 class="fw-bold mb-0">
							<c:set var="activeCount" value="0" />
							<c:forEach var="o" items="${orders}">
								<c:if test="${o.status == 'SHIPPING'}">
									<c:set var="activeCount" value="${activeCount + 1}" />
								</c:if>
							</c:forEach>
							${activeCount}
						</h4>
					</div>
				</div>
			</div>
		</div>
		<div class="col-md-4">
			<div
				class="card border-0 shadow-sm rounded-4 bg-white p-3 border-start border-warning border-4">
				<div class="d-flex align-items-center">
					<div
						class="bg-warning bg-opacity-10 text-warning p-3 rounded-circle me-3">
						<i class="bi bi-hourglass-split fs-4"></i>
					</div>
					<div>
						<small class="text-muted d-block text-uppercase fw-bold">Pending
							Approval</small>
						<h4 class="fw-bold mb-0">
							<c:set var="pendingCount" value="0" />
							<c:forEach var="o" items="${orders}">
								<c:if test="${o.status == 'PENDING'}">
									<c:set var="pendingCount" value="${pendingCount + 1}" />
								</c:if>
							</c:forEach>
							${pendingCount}
						</h4>
					</div>
				</div>
			</div>
		</div>
	</div>

	<div class="card border-0 shadow-sm rounded-4 overflow-hidden">
		<div class="card-header bg-white py-3 border-0">
			<div class="row align-items-center">
				<div class="col">
					<h5 class="fw-bold mb-0 text-success">Order Transactions</h5>
				</div>
				<div class="col-md-4">
					<div class="input-group bg-light rounded-pill px-3 py-1 border">
						<span class="input-group-text bg-transparent border-0"> <i
							class="bi bi-search text-success"></i>
						</span> <input type="text" id="orderSearch"
							class="form-control bg-transparent border-0 shadow-none small"
							placeholder="Search Order ID, name or status...">
					</div>
				</div>
			</div>
		</div>
		<div class="table-responsive">
			<table class="table table-hover align-middle mb-0">
				<thead class="bg-light">
					<tr class="text-muted small fw-bold">
						<th class="ps-4">ORDER INFO</th>
						<th>CUSTOMER</th>
						<th>TOTAL AMOUNT</th>
						<th>STATUS</th>
						<th class="pe-4 text-end">ACTIONS</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="order" items="${orders}" varStatus="count">
						<tr>
							<td class="ps-4 py-3">
								<div class="fw-bold text-dark">#ORD-${order.id}</div>
								<div class="small text-muted">${order.order_date}</div>
							</td>
							<td>
								<div class="d-flex align-items-center">
									<div
										class="bg-light rounded-circle d-flex align-items-center justify-content-center me-2"
										style="width: 32px; height: 32px;">
										<i class="bi bi-person small text-secondary"></i>
									</div>
									<div class="small fw-bold text-dark">${order.user.username}</div>
								</div>
							</td>
							<td>
								<div class="fw-bold text-success">${order.total_amount}
									MMK</div> <c:if test="${order.discount_amount_from_points > 0}">
									<small class="text-danger">(-${order.discount_amount_from_points}
										discount)</small>
								</c:if>
							</td>
							<td><c:choose>
									<c:when test="${order.status == 'PENDING'}">
										<span
											class="badge bg-warning-subtle text-warning px-3 rounded-pill border border-warning-subtle">Pending</span>
									</c:when>
									<c:when test="${order.status == 'CONFIRMED'}">
										<span
											class="badge bg-info-subtle text-info px-3 rounded-pill border border-info-subtle">Confirmed</span>
									</c:when>
									<c:when test="${order.status == 'SHIPPING'}">
										<span
											class="badge bg-primary-subtle text-primary px-3 rounded-pill border border-primary-subtle">Shipping</span>
									</c:when>
									<c:when test="${order.status == 'DELIVERED'}">
										<span
											class="badge bg-success-subtle text-success px-3 rounded-pill border border-success-subtle">Delivered</span>
									</c:when>
									<c:otherwise>
										<span
											class="badge bg-light text-muted px-3 rounded-pill border">${order.status}</span>
									</c:otherwise>
								</c:choose></td>
							<td class="pe-4 text-end">
								<div
									class="btn-group rounded-3 overflow-hidden shadow-sm border">
									<button class="btn btn-white btn-sm viewBtn"
										data-id="${order.id}" data-user="${order.user.username}"
										data-email="${order.user.email}"
										data-total="${order.total_amount}"
										data-status="${order.status}" data-date="${order.order_date}"
										data-points="${order.points_spent}"
										data-discount="${order.discount_amount_from_points}"
										data-address="${order.address}" data-bs-toggle="modal"
										data-bs-target="#viewOrderModal">
										<i class="bi bi-eye"></i>
									</button>
									<button class="btn btn-white btn-sm editBtn"
										data-id="${order.id}" data-status="${order.status}"
										data-bs-toggle="modal" data-bs-target="#editStatusModal">
										<i class="bi bi-pencil"></i>
									</button>
								</div>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</div>
</div>

<div class="modal fade" id="editStatusModal" tabindex="-1">
	<div class="modal-dialog modal-dialog-centered">
		<div class="modal-content border-0 shadow rounded-4">
			<div class="modal-header border-0 bg-success py-3">
				<h5 class="fw-bold mb-0 text-white">
					<i class="bi bi-arrow-repeat me-2"></i>Update Order Status
				</h5>
				<button type="button" class="btn-close btn-close-white"
					data-bs-dismiss="modal"></button>
			</div>
			<form action="home" method="post">
				<div class="modal-body p-4">
					<input type="hidden" name="id" id="orderId"> <input
						type="hidden" name="mode" value="EDITO">

					<div class="mb-0">
						<label class="form-label small fw-bold text-muted text-uppercase">New
							Status for Order</label> <select
							class="form-select rounded-3 p-3 shadow-sm" name="status"
							id="orderStatus" required>
							<option value="PENDING">Pending</option>
							<option value="CONFIRMED">Confirmed</option>
							<option value="SHIPPING">Shipping</option>
							<option value="DELIVERED">Delivered</option>
							<option value="CANCELLED">Cancelled</option>
						</select>
					</div>
				</div>
				<div class="modal-footer border-0 p-4 pt-0">
					<button type="button" class="btn btn-light rounded-pill px-4"
						data-bs-dismiss="modal">Cancel</button>
					<button type="submit"
						class="btn btn-success rounded-pill px-5 shadow-sm">Save
						Update</button>
				</div>
			</form>
		</div>
	</div>
</div>

<div class="modal fade" id="viewOrderModal" tabindex="-1">
	<div class="modal-dialog modal-dialog-centered modal-lg">
		<div class="modal-content border-0 shadow rounded-4 overflow-hidden">
			<div class="modal-header bg-success text-white border-0 py-3">
				<h5 class="fw-bold mb-0">Order Receipt Detail</h5>
				<button type="button" class="btn-close btn-close-white"
					data-bs-dismiss="modal"></button>
			</div>
			<div class="modal-body p-0">
				<div class="row g-0">
					<div class="col-md-5 bg-light p-4">
						<div class="text-center mb-4">
							<div
								class="bg-success text-white rounded-circle d-inline-flex align-items-center justify-content-center mb-2"
								style="width: 60px; height: 60px;">
								<i class="bi bi-box-seam fs-3"></i>
							</div>
							<h5 class="fw-bold mb-0" id="v_id"></h5>
							<span
								class="badge bg-success bg-opacity-10 text-success rounded-pill px-3 mt-2"
								id="v_status"></span>
						</div>
						<div class="mb-3">
							<label class="text-muted small d-block text-uppercase fw-bold">Customer
								Info</label>
							<div class="fw-bold text-dark" id="v_user"></div>
							<div class="small text-muted" id="v_email"></div>
						</div>
						<div class="mb-0">
							<label class="text-muted small d-block text-uppercase fw-bold">Shipping
								Address</label>
							<div class="small text-dark" id="v_address"></div>
						</div>
					</div>
					<div class="col-md-7 p-4">
						<label
							class="text-muted small d-block text-uppercase fw-bold mb-3">Order
							Summary</label>
						<div class="d-flex justify-content-between mb-2">
							<span class="text-secondary">Order Date:</span> <span
								class="fw-bold" id="v_date"></span>
						</div>
						<div class="d-flex justify-content-between mb-2">
							<span class="text-secondary">Points Used:</span> <span
								class="fw-bold text-primary" id="v_points"></span>
						</div>
						<div class="d-flex justify-content-between mb-2">
							<span class="text-secondary">Points Discount:</span> <span
								class="fw-bold text-danger" id="v_discount"></span>
						</div>
						<hr>
						<div class="d-flex justify-content-between align-items-center">
							<span class="h5 fw-bold mb-0">Total Paid</span> <span
								class="h4 fw-bold text-success mb-0" id="v_total"></span>
						</div>
					</div>
				</div>
			</div>
			<div class="modal-footer border-0 bg-light">
				<button type="button" class="btn btn-secondary rounded-pill px-4"
					data-bs-dismiss="modal">Close</button>
			</div>
		</div>
	</div>
</div>

<style>
.btn-white {
	background-color: #fff;
	color: #495057;
}

.btn-white:hover {
	background-color: #f8f9fa;
	color: #198754;
}

.bg-success-subtle {
	background-color: #d1e7dd;
}

.bg-warning-subtle {
	background-color: #fff3cd;
}

.bg-info-subtle {
	background-color: #cff4fc;
}

.bg-primary-subtle {
	background-color: #cfe2ff;
}
</style>

<script>
document.addEventListener("DOMContentLoaded", function() {
    // Edit Mapping
    document.querySelectorAll(".editBtn").forEach(btn => {
        btn.addEventListener("click", function() {
            document.getElementById("orderId").value = this.dataset.id;
            document.getElementById("orderStatus").value = this.dataset.status;
        });
    });

    // View Mapping
    document.querySelectorAll(".viewBtn").forEach(btn => {
        btn.addEventListener("click", function() {
            const d = this.dataset;
            document.getElementById("v_id").innerText = "Order #" + d.id;
            document.getElementById("v_user").innerText = d.user;
            document.getElementById("v_email").innerText = d.email;
            document.getElementById("v_total").innerText = d.total + " MMK";
            document.getElementById("v_status").innerText = d.status;
            document.getElementById("v_date").innerText = d.date;
            document.getElementById("v_points").innerText = d.points || "0";
            document.getElementById("v_discount").innerText = "-" + (d.discount || "0") + " MMK";
            document.getElementById("v_address").innerText = d.address || "No address provided";
        });
    });
 // Order Search Logic
    const orderSearch = document.getElementById('orderSearch');
    const orderTableBody = document.querySelector("table tbody");
    const orderRows = orderTableBody.getElementsByTagName('tr');

    orderSearch.addEventListener('keyup', function() {
        const query = orderSearch.value.toLowerCase();
        let anyMatch = false;

        for (let row of orderRows) {
            // Skips the "No Results" row if it exists
            if (row.id === 'noOrderResults') continue;

            const text = row.textContent.toLowerCase();
            if (text.includes(query)) {
                row.style.setProperty('display', '', 'important');
                anyMatch = true;
            } else {
                row.style.setProperty('display', 'none', 'important');
            }
        }

        // Handle "No Results" display
        let noResultsMsg = document.getElementById('noOrderResults');
        if (!anyMatch) {
            if (!noResultsMsg) {
                noResultsMsg = document.createElement('tr');
                noResultsMsg.id = 'noOrderResults';
                noResultsMsg.innerHTML = `<td colspan="5" class="text-center py-5 text-muted">
                    <i class="bi bi-search fs-2 d-block mb-2"></i>
                    No orders found matching "${orderSearch.value}"</td>`;
                orderTableBody.appendChild(noResultsMsg);
            }
        } else if (noResultsMsg) {
            noResultsMsg.remove();
        }
    });
});
</script>