<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<div class="container py-4">
    <div class="mb-4">
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb mb-1">
                <li class="breadcrumb-item"><a href="home" class="text-success text-decoration-none small fw-bold">Admin</a></li>
                <li class="breadcrumb-item active small">Community</li>
            </ol>
        </nav>
        <div class="d-flex justify-content-between align-items-center">
            <div>
                <h2 class="fw-bold text-dark d-flex align-items-center">
                    <i class="bi bi-people-fill text-success me-2"></i> User Management
                </h2>
                <p class="text-muted mb-0">Monitor and manage your eco-conscious community members.</p>
            </div>
            <div class="text-end">
                <div class="card border-0 shadow-sm rounded-pill px-4 py-2 bg-white">
                    <span class="text-muted small fw-bold">TOTAL USERS:</span>
                    <span class="text-success fw-bold ms-2">${users.size()}</span>
                </div>
            </div>
        </div>
    </div>

    <div class="card border-0 shadow-sm rounded-4 overflow-hidden">
    <div class="card-header bg-white py-3 border-0">
        <div class="row align-items-center">
            <div class="col">
                <h5 class="fw-bold mb-0 text-success">Member Directory</h5>
            </div>
            <div class="col-md-4">
                <div class="input-group bg-light rounded-pill px-3 py-1 border">
                    <span class="input-group-text bg-transparent border-0">
                        <i class="bi bi-search text-success"></i>
                    </span>
                    <input type="text" id="userSearch" class="form-control bg-transparent border-0 shadow-none small" placeholder="Search username, email or role...">
                </div>
            </div>
        </div>
    </div>
        <div class="table-responsive">
            <table class="table  table-hover align-middle mb-0">
                <thead class="bg-light">
                    <tr class="text-muted small fw-bold">
                        <th class="ps-4">USER PROFILE</th>
                        <th>ROLE</th>
                        <th>LOYALTY POINTS</th>
                        <th>JOINED DATE</th>
                        <th>STATUS</th>
                        <th class="pe-4 text-end">ACTIONS</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="user" items="${users}">
                        <tr>
                            <td class="ps-4 py-3">
                                <div class="d-flex align-items-center">
                                    <div class="bg-success bg-opacity-10 text-success rounded-circle d-flex align-items-center justify-content-center me-3" style="width: 45px; height: 45px;">
                                        <span class="fw-bold">${user.username.substring(0,1).toUpperCase()}</span>
                                    </div>
                                    <div>
                                        <div class="fw-bold text-dark">${user.username}</div>
                                        <div class="small text-muted">${user.email}</div>
                                    </div>
                                </div>
                            </td>
                            
                            <td>
                                <span class="badge ${user.role == 'ADMIN' ? 'bg-primary' : 'bg-light text-dark border'} rounded-pill px-3">
                                    ${user.role}
                                </span>
                            </td>

                            <td>
                                <div class="d-flex align-items-center">
                                    <i class="bi bi-star-fill text-warning me-2"></i>
                                    <span class="fw-bold">${user.loyaltyPoints}</span>
                                    <small class="text-muted ms-1">pts</small>
                                </div>
                            </td>

                            <td class="small text-muted">
                                ${user.joinedDate.toString().replace('T', ' ')}
                            </td>

                            <td>
                                <c:choose>
                                    <c:when test="${user.status}">
                                        <span class="badge bg-success-subtle text-success border border-success-subtle rounded-pill px-3">
                                            <i class="bi bi-check-circle-fill me-1"></i> Active
                                        </span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge bg-danger-subtle text-danger border border-danger-subtle rounded-pill px-3">
                                            <i class="bi bi-x-circle-fill me-1"></i> Suspended
                                        </span>
                                    </c:otherwise>
                                </c:choose>
                            </td>

                            <td class="pe-4 text-end">
                                <div class="btn-group rounded-3 shadow-sm border overflow-hidden">
                                    <button class="btn btn-white btn-sm editUserBtn" 
                                            data-id="${user.id}" 
                                            data-username="${user.username}" 
                                            data-status="${user.status}"
                                            data-role="${user.role}"
                                            data-bs-toggle="modal" data-bs-target="#editUserModal">
                                        <i class="bi bi-shield-lock"></i>
                                    </button>
                                    <button class="btn btn-white btn-sm viewUserBtn" 
                                            data-id="${user.id}"
                                            data-points="${user.loyaltyPoints}"
                                            data-bs-toggle="modal" data-bs-target="#viewUserModal">
                                        <i class="bi bi-eye"></i>
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

<div class="modal fade" id="editUserModal" tabindex="-1">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content border-0 shadow rounded-4">
            <div class="modal-header border-0 bg-success py-3">
                <h5 class="fw-bold mb-0 text-white"><i class="bi bi-person-gear me-2"></i>Account Permissions</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
            </div>
            <form action="home" method="post">
                <div class="modal-body p-4">
                    <input type="hidden" name="id" id="editUserId">
                    <input type="hidden" name="mode" value="EDITU">
                    
                    <div class="mb-3">
                        <label class="form-label small fw-bold text-muted">Username</label>
                        <input type="text" id="editUsername" class="form-control bg-light rounded-3 border-0" readonly>
                    </div>

                    <div class="row g-3">
         
                        <div class="col-6">
                            <label class="form-label small fw-bold text-muted">Account Status</label>
                            <select class="form-select rounded-3" name="status" id="editStatus">
                                <option value="true">Active</option>
                                <option value="false">Suspended</option>
                            </select>
                        </div>
                    </div>
                </div>
                <div class="modal-footer border-0 p-4 pt-0">
                    <button type="button" class="btn btn-light rounded-pill px-4" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-success rounded-pill px-5 shadow-sm">Save Changes</button>
                </div>
            </form>
        </div>
    </div>
</div>

<style>
    .btn-white { background-color: #fff; color: #495057; }
    .btn-white:hover { background-color: #f8f9fa; color: #198754; }
    .bg-success-subtle { background-color: #d1e7dd; }
    .bg-danger-subtle { background-color: #f8d7da; }
    .table-hover tbody tr:hover { background-color: #fcfdfc; }
</style>
<div class="modal fade" id="viewUserModal" tabindex="-1">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content border-0 shadow rounded-4 overflow-hidden">
            <div class="modal-header bg-success text-white border-0 py-4 d-flex flex-column align-items-center">
                <button type="button" class="btn-close btn-close-white position-absolute end-0 top-0 m-3" data-bs-dismiss="modal"></button>
                
                <div class="bg-white text-success rounded-circle d-flex align-items-center justify-content-center mb-3 shadow" style="width: 80px; height: 80px;">
                    <i class="bi bi-person-fill" style="font-size: 2.5rem;"></i>
                </div>
                <h4 class="fw-bold mb-0" id="v_username">User Profile</h4>
                <span class="badge bg-white text-success rounded-pill px-3 mt-2" id="v_role"></span>
            </div>

            <div class="modal-body p-4">
                <div class="card bg-light border-0 rounded-4 p-3 mb-4 text-center">
                    <small class="text-muted text-uppercase fw-bold ls-wide d-block mb-1">Loyalty Points Earned</small>
                    <div class="d-flex align-items-center justify-content-center">
                        <i class="bi bi-star-fill text-warning me-2 fs-4"></i>
                        <span class="h2 fw-bold mb-0 text-dark" id="v_points">0</span>
                        <span class="ms-2 text-secondary">pts</span>
                    </div>
                </div>

                <div class="row g-3">
                    <div class="col-6">
                        <label class="text-muted small d-block text-uppercase fw-bold">User ID</label>
                        <span class="fw-bold text-dark" id="v_userId"></span>
                    </div>
                    <div class="col-6">
                        <label class="text-muted small d-block text-uppercase fw-bold">Status</label>
                        <span id="v_status_badge"></span>
                    </div>
                    <div class="col-12">
                        <hr class="my-1 opacity-5">
                    </div>
                    <div class="col-12">
                        <label class="text-muted small d-block text-uppercase fw-bold">Email Address</label>
                        <span class="text-dark fw-medium" id="v_email"></span>
                    </div>
                    <div class="col-12">
                        <label class="text-muted small d-block text-uppercase fw-bold">Member Since</label>
                        <span class="text-dark" id="v_joined"></span>
                    </div>
                </div>
            </div>

            <div class="modal-footer border-0 bg-light p-3">
                <button type="button" class="btn btn-secondary rounded-pill px-4 w-100" data-bs-dismiss="modal">Close Profile</button>
            </div>
        </div>
    </div>
</div>

<script>
document.addEventListener("DOMContentLoaded", function() {
    // User Edit Logic
    document.querySelectorAll(".editUserBtn").forEach(btn => {
        btn.addEventListener("click", function() {
            const d = this.dataset;
            document.getElementById("editUserId").value = d.id;
            document.getElementById("editUsername").value = d.username;
            document.getElementById("editStatus").value = d.status;
        });
    });

    // View User Logic
    document.querySelectorAll(".viewUserBtn").forEach(btn => {
        btn.addEventListener("click", function() {
            const d = this.closest('tr').querySelector('.editUserBtn').dataset; 
             
            const points = this.dataset.points;
            const id = this.dataset.id;
            const row = this.closest('tr');
            const email = row.querySelector('.small.text-muted').innerText;
            const joined = row.cells[3].innerText;
            const role = d.role;
            const status = d.status === "true";

            // Update Modal Content
            document.getElementById("v_username").innerText = d.username;
            document.getElementById("v_role").innerText = role;
            document.getElementById("v_userId").innerText = "#USR-" + id;
            document.getElementById("v_points").innerText = points;
            document.getElementById("v_email").innerText = email;
            document.getElementById("v_joined").innerText = joined;

            // Update Status Badge
            const statusBox = document.getElementById("v_status_badge");
            if (status) {
                statusBox.innerHTML = '<span class="text-success small fw-bold"><i class="bi bi-circle-fill me-1" style="font-size: 8px;"></i> Active Account</span>';
            } else {
                statusBox.innerHTML = '<span class="text-danger small fw-bold"><i class="bi bi-circle-fill me-1" style="font-size: 8px;"></i> Suspended</span>';
            }
        });
    });
        // --- User Search Logic ---
        const userSearch = document.getElementById('userSearch');
        const tableBody = document.querySelector("table tbody");
        const rows = tableBody.getElementsByTagName('tr');

        userSearch.addEventListener('keyup', function() {
            const query = userSearch.value.toLowerCase();
            let found = false;

            for (let row of rows) {
                // Ignore the "No Results" row if it exists
                if (row.id === 'noUserResults') continue;

                const text = row.textContent.toLowerCase();
                if (text.includes(query)) {
                    row.style.setProperty('display', '', 'important');
                    found = true;
                } else {
                    row.style.setProperty('display', 'none', 'important');
                }
            }

            // Show a "No users found" message if the search is empty
            let emptyMsg = document.getElementById('noUserResults');
            if (!found) {
                if (!emptyMsg) {
                    emptyMsg = document.createElement('tr');
                    emptyMsg.id = 'noUserResults';
                    emptyMsg.innerHTML = `
                        <td colspan="6" class="text-center py-5 text-muted">
                            <i class="bi bi-person-x fs-2 d-block mb-2"></i>
                            No community members match "${userSearch.value}"
                        </td>`;
                    tableBody.appendChild(emptyMsg);
                }
            } else if (emptyMsg) {
                emptyMsg.remove();
            }
        });
});
</script>