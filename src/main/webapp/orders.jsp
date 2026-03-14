<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <div class="container mt-5">

    <h2 class="mb-4 text-center">Orders List</h2>

    <div class="card shadow">
        <div class="card-body">

            <table id="ordersTable" class="table table-striped table-bordered text-center align-middle">
                <thead class="table-dark">
                    <tr>
                        <th>No</th>
                        <th>Customer</th>
                        <th>Total</th>
                        <th>Order Date</th>
                        <th>Status</th>
                        <th>Points Spent</th>
                        <th>Shipping Address</th>
                        <th>Discount</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>

                    <c:forEach var="order" items="${orders}" varStatus="count">
                        <tr>
                        	<td class="text-center">${count.index +1}</td>
                            <td>${order.id}</td>
                            <td>${order.user.name}</td>
                            <td>$ ${order.total_amount}</td>
                            <td>${order.order_date}</td>

                            <!-- Status Badge -->
                            <td>
                                <c:choose>
                                    <c:when test="${order.status == 'PENDING'}">
                                        <span class="badge bg-warning text-dark">Pending</span>
                                    </c:when>
                                    <c:when test="${order.status == 'CONFIRMED'}">
                                        <span class="badge bg-info">Confirmed</span>
                                    </c:when>
                                    <c:when test="${order.status == 'SHIPPING'}">
                                        <span class="badge bg-primary">Shipping</span>
                                    </c:when>
                                    <c:when test="${order.status == 'DELIVERED'}">
                                        <span class="badge bg-success">Delivered</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge bg-secondary">${order.status}</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
							<td>${order.points_spent }</td>
							<td>${order.address.toString }</td>
							<td>${order.discount_amount_from_points }</td>
							
                            <td>
                                <!-- Edit Button -->
                                <button 
                                    class="btn btn-warning btn-sm editBtn"
                                    data-id="${order.id}"
                                    data-status="${order.status}"
                                    data-bs-toggle="modal"
                                    data-bs-target="#editStatusModal">
                                    <i class="bi bi-pencil-square"></i>
                                </button>

                                <!-- View Button -->
                                <button 
                                	class="btn btn-primary btn-sm viewBtn" 
                                	data-id="${order.id }" 
                                	data-user="${order.user.name }"
                                	data-userEmail="${order.user.email }"
                                	data-total="${order.total }"
                                	data-status="${order.status }"
                                	data-date="${order.order_date }"
                                	data-pionts="${order.points_spent }"
                                	data-discount = "${order.discount_amount_from_points }"
                                	data-bs-toggle="modal"
                                    data-bs-target="#viewOrderModal">
                                    <i class="bi bi-eye-fill"></i>
                                </button>
                            </td>
                        </tr>
                    </c:forEach>

                </tbody>
            </table>

        </div>
    </div>

</div>

<!-- ================= MODAL ================= -->

<div class="modal fade" id="editStatusModal" tabindex="-1">
  <div class="modal-dialog">
    <div class="modal-content">

      <div class="modal-header">
        <h5 class="modal-title">Edit Order Status</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
      </div>

      <form action="dashboard" method="post">

        <div class="modal-body">

          <!-- Hidden ID -->
          <input type="hidden" name="id" id="orderId">
          <input type="hidden" name="mode" value="EDITO">

          <div class="mb-3">
            <label class="form-label">Select Status</label>
            <select class="form-select" name="status" id="orderStatus" required>
              <option value="PENDING">Pending</option>
              <option value="CONFIRMED">Confirmed</option>
              <option value="SHIPPING">Shipping</option>
              <option value="SHIPPED">Shipped</option>
              <option value="DELIVERED">Delivered</option>
              <option value="CANCELLED">Cancelled</option>
            </select>
          </div>

        </div>

        <div class="modal-footer">
          <button type="submit" class="btn btn-success">Update</button>
          <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
        </div>

      </form>

    </div>
  </div>
</div>


<div class="modal fade" id="viewOrderModal" tabindex="-1">
  <div class="modal-dialog">
    <div class="modal-content">

      <div class="modal-header">
        <h5 class="modal-title">View Order Detail</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
      </div>

      <div class="modal-body">

          <div class="mb-3">
            <label class="form-label">Order ID</label>
            <input type="text" class="form-control" id="viewOrderId" readonly>
          </div>

          <div class="mb-3">
            <label class="form-label">User Name</label>
            <input type="text" class="form-control" id="viewUserName" readonly>
          </div>

          <div class="mb-3">
            <label class="form-label">User Email</label>
            <input type="text" class="form-control" id="viewUserEmail" readonly>
          </div>

          <div class="mb-3">
            <label class="form-label">Total</label>
            <input type="text" class="form-control" id="viewTotal" readonly>
          </div>

          <div class="mb-3">
            <label class="form-label">Status</label>
            <input type="text" class="form-control" id="viewStatus" readonly>
          </div>
		  <div class="mb-3">
            <label class="form-label">Date</label>
            <input type="text" class="form-control" id="viewDate" readonly>
          </div>

          <div class="mb-3">
            <label class="form-label">Points Spent</label>
            <input type="text" class="form-control" id="viewPoint" readonly>
          </div>
		  <div class="mb-3">
            <label class="form-label">Discount Amount From Points</label>
            <input type="text" class="form-control" id="viewDiscount" readonly>
          </div>
		  
      </div>

      <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
      </div>

    </div>
  </div>
</div>




<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

<!-- Auto Fill Modal Script -->
<script>
    const editButtons = document.querySelectorAll(".editBtn");

    editButtons.forEach(button => {
        button.addEventListener("click", function () {

            const id = this.getAttribute("data-id");
            const status = this.getAttribute("data-status");

            document.getElementById("orderId").value = id;
            document.getElementById("orderStatus").value = status;
        });
    });
</script>

<!--  for view  -->
<script>
    const viewButtons = document.querySelectorAll(".viewBtn");

    viewButtons.forEach(button => {
        button.addEventListener("click", function () {

            const id = this.getAttribute("data-id");
            const userName = this.getAttribute("data-user");
            const userEmail = this.getAttribute("data-userEmail");
            const total = this.getAttribute("data-total");
            const status = this.getAttribute("data-status");
            const date = this.getAttribute("data-date");
            const points = this.getAttribute("data-points");
            const discount = this.getAttribute("data-discount");

            document.getElementById("viewOrderId").value = id;
            document.getElementById("viewUserName").value = userName;
            document.getElementById("viewUserEmail").value = userEmail;
            document.getElementById("viewTotal").value = total;
            document.getElementById("viewStatus").value = status;
            document.getElementById("viewDate").value = date;
            document.getElementById("viewPoint").value = points;
            document.getElementById("viewDiscount").value = discount;
            
        });
    });
</script>