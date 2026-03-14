<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <div class="container mt-5">
	<nav class="nav nav-tabs" id="nav-tab" role="tablist">
        <a class="nav-link active" id="nav-home-tab" data-bs-toggle="tab" href="#sLst" role="tab" aria-controls="pLst" aria-selected="true">Supplier List</a>
        <a class="nav-link" id="nav-profile-tab" data-bs-toggle="tab" href="#sAdd" role="tab" aria-controls="pApp" aria-selected="false">Supplier Submission</a>
    </nav>
	<div class="tab-content w-100" id="nav-tabContent">
	    <div class="tab-pane fade show active" id="sLst" role="tabpanel" aria-labelledby="nav-sLst-tab">
	        <div class="card shadow ">
			    <h2 class="mb-4 text-center">Supplier List</h2>
			    <div class="card shadow">
			        <div class="card-body">
			
			            <table id="sellersTable" class="table table-striped table-bordered text-center align-middle">
			                <thead class="table-dark">
			                    <tr>
			                        <th>No</th>
			                        <th>Username</th>
			                        <th>Email</th>
			                        <th>Role</th>
			                        <th>Business Name</th>
			                        <th>Status</th>
			                        <th>Loyalty Points</th>
			                        <th>Joined Date</th>
			                        <th>Action</th>
			                    </tr>
			                </thead>
			                <tbody>
			
			                    <c:forEach var="user" items="${users}" varStatus="count">
			                        <tr>
			                        	<td class="text-center">${count.index +1}</td>
			                            <td>${user.username}</td>
			                            <td>${user.email}</td>
			                            <td>${user.role}</td>
			                            <td>${user.business_name}</td>
			
			                            <!-- Status Badge -->
			                            <td>
			                                <c:choose>
			                                    <c:when test="${user.status == 'true'}">
			                                        <span class="badge bg-warning text-dark">Active</span>
			                                    </c:when>
			                                    <c:otherwise>
			                                        <span class="badge bg-secondary">Inactive</span>
			                                    </c:otherwise>
			                                </c:choose>
			                            </td>
			                            <td>${user.loyalty_points }</td>
			                            <td>${user.joined_date }</td>
			                            <td>
			                                <!-- Edit Button -->
			                                <button 
			                                    class="btn btn-warning btn-sm editBtn"
			                                    data-id="${user.id}"
			                                    data-status="${user.status}"
			                                    data-bs-toggle="modal"
			                                    data-bs-target="#editStatusModal">
			                                    <i class="bi bi-pencil-square"></i>
			                                </button>
			
			                                <!-- View Button -->
			                                <button 
			                                	class="btn btn-primary btn-sm viewBtn" 
			                                	data-id="${user.id }" 
			                                	data-username="${user.username }"
			                                	data-Email="${user.email }"
			                                	data-role="${user.role }"
			                                	data-business-name="${user.business_name }"
			                                	data-status="${user.status }"
			                                	data-pionts="${user.loyalty_points }"
			                                	data-joined-date = "${user.joined_date }"
			                                	data-bs-toggle="modal"
			                                    data-bs-target="#viewUserModal">
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
		</div>
	 </div>
	<div class="tab-content w-100" id="nav-tabContent">
	    <div class="tab-pane fade" id="sAdd" role="tabpanel" aria-labelledby="nav-sLst-tab">
	        <div class="card shadow ">
			    <h2 class="mb-4 text-center">Supplier Submissions</h2>
			    <div class="card shadow">
			        <div class="card-body">
			
			            <table id="sellersTable" class="table table-striped table-bordered text-center align-middle">
			                <thead class="table-dark">
			                    <tr>
			                        <th>No</th>
			                        <th>Username</th>
			                        <th>Email</th>
			                        <th>Role</th>
			                        <th>Business Name</th>
			                        <th>Status</th>
			                        <th>Loyalty Points</th>
			                        <th>Joined Date</th>
			                        <th>Action</th>
			                    </tr>
			                </thead>
			                <tbody>
			
			                    <c:forEach var="user" items="${users}" varStatus="count">
			                        <tr>
			                        	<td class="text-center">${count.index +1}</td>
			                            <td>${user.username}</td>
			                            <td>${user.email}</td>
			                            <td>${user.role}</td>
			                            <td>${user.business_name}</td>
			
			                            <!-- Status Badge -->
			                            <td>
			                                <c:choose>
			                                    <c:when test="${user.status == 'true'}">
			                                        <span class="badge bg-warning text-dark">Active</span>
			                                    </c:when>
			                                    <c:otherwise>
			                                        <span class="badge bg-secondary">Inactive</span>
			                                    </c:otherwise>
			                                </c:choose>
			                            </td>
			                            <td>${user.loyalty_points }</td>
			                            <td>${user.joined_date }</td>
			                            <td>
			                                <!-- Edit Button -->
			                                <button 
			                                    class="btn btn-warning btn-sm editBtn"
			                                    data-id="${user.id}"
			                                    data-status="${user.status}"
			                                    data-bs-toggle="modal"
			                                    data-bs-target="#editStatusModal">
			                                    <i class="bi bi-pencil-square"></i>
			                                </button>
			
			                                <!-- View Button -->
			                                <button 
			                                	class="btn btn-primary btn-sm viewBtn" 
			                                	data-id="${user.id }" 
			                                	data-username="${user.username }"
			                                	data-Email="${user.email }"
			                                	data-role="${user.role }"
			                                	data-business-name="${user.business_name }"
			                                	data-status="${user.status }"
			                                	data-pionts="${user.loyalty_points }"
			                                	data-joined-date = "${user.joined_date }"
			                                	data-bs-toggle="modal"
			                                    data-bs-target="#viewUserModal">
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
		</div>
	 </div>
	  
	</div>

<!-- ================= MODAL ================= -->

<div class="modal fade" id="editStatusModal" tabindex="-1">
  <div class="modal-dialog">
    <div class="modal-content">

      <div class="modal-header">
        <h5 class="modal-title">Edit User Status</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
      </div>

      <form action="home" method="post">

        <div class="modal-body">

          <!-- Hidden ID -->
          <input type="hidden" name="id" id="userId">
          <input type="hidden" name="mode" value="EDITU">

          <div class="mb-3">
            <label class="form-label">Select Status</label>
            <select class="form-select" name="status" id="userStatus" required>
              <option value="true">Active</option>
              <option value="false">Inactive</option>
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


<div class="modal fade" id="viewUserModal" tabindex="-1">
  <div class="modal-dialog">
    <div class="modal-content">

      <div class="modal-header">
        <h5 class="modal-title">View User Detail</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
      </div>
      <div class="modal-body">
        <div class="row">
          <div class="col-6 mb-3">
            <label class="text-muted small d-block">User ID</label>
            <span class="fw-bold" id="viewUserId"></span>
          </div>
          <div class="col-6 mb-3">
            <label class="text-muted small d-block">Username</label>
            <span class="fw-bold" id="viewUserName"></span>
          </div>
        </div>

        <div class="row">
          <div class="col-6 mb-3">
                <label class="text-muted small d-block">Email</label>
                <span class="fw-bold" id="viewUserEmail"></span>
              </div>
              <div class="col-6 mb-3">
                <label class="text-muted small d-block">Role</label>
                <span class="fw-bold" id="viewRole"></span>
              </div>
        </div>
		
        <div class="row">
          <div class="col-6 mb-3">
            <label class="text-muted small d-block">Business Name</label>
            <span class="text-success fw-bold" id="viewBusinessName"></span>
          </div>
          <div class="col-6 mb-3">
            <label class="text-muted small d-block">Status</label>
            <span id="viewStatus"></span>
          </div>
        </div>
        <div class="row">
          <div class="col-6 mb-3">
            <label class="text-muted small d-block">Loyalty Points</label>
            <span class="text-success fw-bold" id="viewPoint"></span>
          </div>
          <div class="col-6 mb-3">
            <label class="text-muted small d-block">Joined Date</label>
            <span id="viewDate"></span>
          </div>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
        </div>

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

            document.getElementById("userId").value = id;
            document.getElementById("userStatus").value = status;
        });
    });
</script>

<!--  for view  -->
<script>
    const viewButtons = document.querySelectorAll(".viewBtn");

    viewButtons.forEach(button => {
        button.addEventListener("click", function () {

            const id = this.getAttribute("data-id");
            const userName = this.getAttribute("data-username");
            const userEmail = this.getAttribute("data-Email");
            const role = this.getAttribute("data-role");
            const businessName = this.getAttribute("data-business-name");
            const status = this.getAttribute("data-status");
            const points = this.getAttribute("data-points");
            const joinedDate = this.getAttribute("data-joined-date");

            document.getElementById("viewUserId").innerHTML = id;
            document.getElementById("viewUserName").innerHTML = userName;
            document.getElementById("viewUserEmail").innerHTML = userEmail;
            document.getElementById("viewRole").innerHTML = role;
            document.getElementById("viewBusinessName").innerHTML = businessName;
            if(status == 'true')
            	document.getElementById("viewStatus").innerHTML = `<span class="badge bg-info text-dark">Active</span>`
            else
            	document.getElementById("viewStatus").innerHTML = `<span class="badge bg-secondary text-white">Inactive</span>`
            document.getElementById("viewPoint").innerHTML = points;
            document.getElementById("viewDate").innerHTML = joinedDate;
            
        });
    });
</script>