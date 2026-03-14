<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


<div class="container mt-5">
    <nav class="nav nav-tabs" id="nav-tab" role="tablist">
        <a class="nav-link active" id="nav-home-tab" data-bs-toggle="tab" href="#pLst" role="tab" aria-controls="pLst" aria-selected="true">Product List</a>
        <a class="nav-link" id="nav-profile-tab" data-bs-toggle="tab" href="#pApp" role="tab" aria-controls="pApp" aria-selected="false">Product Approval</a>
    </nav>
    <div class="tab-content w-100" id="nav-tabContent">
        <div class="tab-pane fade show active" id="pLst" role="tabpanel" aria-labelledby="nav-pLst-tab">
            <div class="card shadow ">
                <div class="card-body table-responsive">
                    <table id="productsTable" class="table table-striped table-bordered text-center align-middle w-100 fs-sm-6">
                        <thead class="table-dark">
                            <tr>
                                <th>ID</th>
                                <th>Name</th>
                                <th>Price</th>
                                <th>Supplier Name</th>
                                <th>Category</th>                        
                                <th>Material Type</th>
                                <th>Plastic Saved Per Unit</th>
                                <th>QTY</th>
                                <th>Status</th> <!--DRAFT, ACTIVE, OUT_OF_STOCK, ARCHIVED-->
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>

                            <c:forEach var="product" items="${products}">
                                <tr>
                                    <td>${product.id}</td>
                                    <td>${product.name}</td>
                                    <td>${product.price}MMK</td>
                                    <td>${product.user.username}</td>
                                    <td>${product.category.name}</td>
                                    <td>${product.material_type}</td>
                                    <td>${product.plastic_saved_per_unit}</td>
                                    <!-- Stock Badge -->
                                    <td>
                                        <c:choose>
                                            <c:when test="${product.qty > 10}">
                                                <span class="badge bg-success">${product.qty}</span>
                                            </c:when>
                                            <c:when test="${product.qty > 0}">
                                                <span class="badge bg-warning text-dark">${product.qty}</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge bg-danger">Out of Stock</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>${product.status}</td>


                                    <td>
                                        <!-- Edit Button -->
                                        <button 
                                            class="btn btn-warning btn-sm editProductBtn"
                                            data-id="${product.id}"
                                            data-name="${product.name}"
                                            data-price="${product.price}"
                                            data-qty="${product.qty}"
                                            data-material="${product.material_type}"
                                            data-plastic="${product.plastic_saved_per_unit}"
                                            data-supplier="${product.user.business_name}" 
                                            data-category="${product.category.name}"
                                            data-bs-toggle="modal"
                                            data-bs-target="#editProductModal">
                                            <i class="bi bi-pencil-square"></i>
                                        </button>

                                        <!-- View Button -->
                                        <button 
                                            class="btn btn-primary btn-sm viewProductBtn"
                                            data-id="${product.id}"
                                            data-name="${product.name}"
                                            data-price="${product.price}"
                                            data-qty="${product.qty}"
                                            data-material="${product.material_type}"
                                            data-plastic="${product.plastic_saved_per_unit}"
                                            data-status="${product.status}"
                                            data-supplier="${product.user.username}" 
                                            data-category="${product.category.name}"
                                            data-bs-toggle="modal"
                                            data-bs-target="#viewProductModal">
                                            <i class="bi bi-eye-fill"></i>
                                        </button>
                                        
                                        <!-- Category Edit -->
                                        <button 
                                            class="btn btn-info btn-sm editCategoryBtn"
                                            data-id="${product.id}"
                                            data-name="${product.name}"
                                            data-current-cat-id="${product.category.id}"
                                            data-current-cat-name="${product.category.name}"
                                            data-bs-toggle="modal"
                                            data-bs-target="#editCategoryModal">
                                            <i class="bi bi-tag-fill text-white"></i>
                                        </button>
                                    </td>

                                </tr>
                            </c:forEach>

                        </tbody>
                    </table>

                </div>
            </div>    
        </div>
        <div class="tab-pane fade" id="pApp" role="tabpanel" aria-labelledby="nav-pApp-tab">
            <div class="card shadow">
                <div class="card-body  table-responsive">
                    <table id="productApproveTable" class="table table-striped table-bordered text-center align-middle">
                        <thead class="table-dark">
                            <tr>
                                <th>No</th>
                                <th>Name</th>
                                <th>Price</th>
                                <th>Supplier Name</th>
                                <th>Category</th>                        
                                <th>Material Type</th>
                                <th>Plastic Saved Per Unit</th>
                                <th>QTY</th>
                                <th>Status</th> <!--DRAFT, ACTIVE, OUT_OF_STOCK, ARCHIVED-->
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="product" items="${uproducts}" varStatus="count">
                                <tr>
                                    <td class="text-center">${count.index +1}</td>
                                    <td>${product.name}</td>
                                    <td>$ ${product.price}</td>
                                    <td>${product.user.username}</td>
                                    <td>${product.category.name}</td>
                                    <td>${product.material_type}</td>
                                    <td>${product.plastic_saved_per_unit}</td>
                                    <!-- Stock Badge -->
                                    <td>
                                        <c:choose>
                                            <c:when test="${product.qty > 10}">
                                                <span class="badge bg-success">${product.qty}</span>
                                            </c:when>
                                            <c:when test="${product.qty > 0}">
                                                <span class="badge bg-warning text-dark">${product.qty}</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge bg-danger">Out of Stock</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>${product.status}</td>


                                    <td>
                                    <!-- Approve Button -->
                                    <form action="home" method="post" style="display:inline;">
									    <input type="hidden" name="mode" value="UPDATE_STATUS">
									    <input type="hidden" name="id" value="${product.id}">
									    <input type="hidden" name="status" value="ACTIVE">
									    <button type="submit" class="btn btn-success btn-sm" title="Approve Product">
									        <i class="bi bi-check-circle-fill"></i>
									    </button>
									</form>
									<!-- Cancel Button -->
									<button 
									    class="btn btn-danger btn-sm cancelProductBtn"
									    data-id="${product.id}"
									    data-name="${product.name}"
									    data-bs-toggle="modal"
									    data-bs-target="#cancelProductModal"
									    title="Cancel Product">
									    <i class="bi bi-x-circle-fill"></i>
									</button>
									<!-- View Button -->
									<button 
									    class="btn btn-primary btn-sm viewProductBtn"
									    data-id="${product.id}"
									    data-name="${product.name}"
									    data-price="${product.price}"
									    data-qty="${product.qty}"
									    data-material="${product.material_type}"
									    data-plastic="${product.plastic_saved_per_unit}"
									    data-status="${product.status}"
									    data-supplier="${product.user.username}" 
									    data-category="${product.category.name}"
									    data-bs-toggle="modal"
									    data-bs-target="#viewProductModal">
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

<!-- ================= EDIT MODAL ================= -->

<div class="modal fade" id="editProductModal" tabindex="-1">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header bg-warning">
        <h5 class="modal-title text-dark">Edit Product Details</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
      </div>
      <form action="home" method="post">
        <div class="modal-body">
          <input type="hidden" name="mode" value="EDITP">
          <input type="hidden" name="id" id="editProductId">

          <div class="row mb-3">
              <div class="col-6">
                <label class="form-label text-muted small">Supplier</label>
                <input type="text" class="form-control bg-light" id="editProductSupplier" readonly>
              </div>
              <div class="col-6">
                <label class="form-label text-muted small">Category</label>
                <input type="text" class="form-control bg-light" id="editProductCategory" readonly>
              </div>
          </div>

          <div class="mb-3">
            <label class="form-label fw-bold">Product Name</label>
            <input type="text" class="form-control" name="name" id="editProductName" required>
          </div>

          <div class="row">
              <div class="col-md-6 mb-3">
                <label class="form-label fw-bold">Price (MMK)</label>
                <input type="number" step="0.01" class="form-control" name="price" id="editProductPrice" required>
              </div>
              <div class="col-md-6 mb-3">
                <label class="form-label fw-bold">Stock Quantity</label>
                <input type="number" class="form-control" name="qty" id="editProductQty" required>
              </div>
          </div>

          <div class="mb-3">
            <label class="form-label fw-bold">Material Type</label>
            <input type="text" class="form-control" name="material_type" id="editProductMaterial">
          </div>
            
          <div class="mb-3">
            <label class="form-label fw-bold">Plastic Saved (kg)</label>
            <input type="number" step="0.01" class="form-control" name="plastic_saved" id="editProductPlastic">
          </div>
        </div>
        <div class="modal-footer">
          <button type="submit" class="btn btn-success">Save Changes</button>
          <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
        </div>
      </form>
    </div>
  </div>
</div>
<!-- ================= VIEW MODAL ================= -->

<div class="modal fade" id="viewProductModal" tabindex="-1">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header bg-primary text-white">
        <h5 class="modal-title" id="viewProductNameTitle">Product Detail</h5>
        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
      </div>

      <div class="modal-body">
        <div class="row">
          <div class="col-6 mb-3">
            <label class="text-muted small d-block">ID</label>
            <span class="fw-bold" id="viewProductId"></span>
          </div>
          <div class="col-6 mb-3">
            <label class="text-muted small d-block">Status</label>
            <span class="badge bg-info" id="viewProductStatus"></span>
          </div>
        </div>

		<div class="row">
			<div class="col-6 mb-3">
	          <label class="text-muted small d-block">Name</label>
	          <span class="fw-bold" id="viewProductName"></span>
	        </div>
	        <div class="col-6 mb-3">
	          <label class="text-muted small d-block">Category</label>
	          <span class="fw-bold" id="viewProductCategory"></span>
	        </div>
		</div>
		
        <div class="row">
          <div class="col-6 mb-3">
            <label class="text-muted small d-block">Price</label>
            <span class="text-success fw-bold" id="viewProductPrice"></span>
          </div>
          <div class="col-6 mb-3">
            <label class="text-muted small d-block">Stock Qty</label>
            <span id="viewProductQty"></span>
          </div>
        </div>

        <hr>

        <div class="mb-3">
          <label class="text-muted small d-block">Material Type</label>
          <span id="viewProductMaterial"></span>
        </div>

        <div class="mb-3">
          <label class="text-muted small d-block">Plastic Saved (kg)</label>
          <span id="viewProductPlastic"></span>
        </div>

        <div class="mb-3">
          <label class="text-muted small d-block">Supplier</label>
          <span id="viewProductSupplier"></span>
        </div>
      </div>

      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>

<!-- Category Edit -->
<div class="modal fade" id="editCategoryModal" tabindex="-1">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header bg-info text-white">
        <h5 class="modal-title">Change Product Category</h5>
        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
      </div>
      <form action="home" method="post">
        <div class="modal-body">
          <input type="hidden" name="mode" value="EDIT_CAT">
          <input type="hidden" name="id" id="catProductId">

          <div class="mb-3">
            <label class="form-label">Product</label>
            <input type="text" class="form-control bg-light" id="catProductName" readonly>
          </div>

          <div class="mb-3">
            <label class="form-label">Select New Category</label>
            <select class="form-select" name="categoryId" id="categorySelect" required>
                <c:forEach var="cat" items="${categories}">
                    <option value="${cat.id}">${cat.name}</option>
                </c:forEach>
            </select>
            <div class="form-text">Current: <strong id="currentCatNameDisplay"></strong></div>
          </div>
        </div>
        <div class="modal-footer">
          <button type="submit" class="btn btn-info text-white">Update Category</button>
          <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
        </div>
      </form>
    </div>
  </div>
</div>

<!-- Product Cancel Modal -->
<div class="modal fade" id="cancelProductModal" tabindex="-1">
  <div class="modal-dialog">
    <div class="modal-content border-danger">
      <div class="modal-header bg-danger text-white">
        <h5 class="modal-title">Confirm Cancellation</h5>
        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
      </div>
      <form action="home" method="post">
        <div class="modal-body">
          <p>Are you sure you want to cancel the following product?</p>
          <h5 id="cancelProdName" class="text-center fw-bold"></h5>
          
          <input type="hidden" name="mode" value="UPDATE_STATUS">
          <input type="hidden" name="id" id="cancelProductId">
          <input type="hidden" name="status" value="ARCHIVED"> <div class="alert alert-warning small mt-3">
              <i class="bi bi-exclamation-triangle"></i> This will hide the product from the shop.
          </div>
        </div>
        <div class="modal-footer">
          <button type="submit" class="btn btn-danger">Yes, Cancel Product</button>
          <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
        </div>
      </form>
    </div>
  </div>
</div>
<!-- ================= SCRIPT ================= -->

<script>
// Category Update
// Edit Category Logic
document.querySelectorAll(".editCategoryBtn").forEach(button => {
    button.addEventListener("click", function () {
        const prodId = this.dataset.id;
        const prodName = this.dataset.name;
        const currentCatId = this.dataset.currentCatId;
        const currentCatName = this.dataset.currentCatName;

        document.getElementById("catProductId").value = prodId;
        document.getElementById("catProductName").value = prodName;
        document.getElementById("currentCatNameDisplay").innerText = currentCatName;

        // Auto-select the current category in the dropdown
        const selectElement = document.getElementById("categorySelect");
        selectElement.value = currentCatId;
    });
});
    // Edit Product Logic
    document.querySelectorAll(".editProductBtn").forEach(button => {
        button.addEventListener("click", function () {
            document.getElementById("editProductId").value = this.dataset.id;
            document.getElementById("editProductSupplier").value = this.dataset.supplier;
            document.getElementById("editProductCategory").value = this.dataset.category;
            
            // Fill Editable Fields
            document.getElementById("editProductName").value = this.dataset.name;
            document.getElementById("editProductPrice").value = this.dataset.price;
            document.getElementById("editProductQty").value = this.dataset.qty;
            document.getElementById("editProductMaterial").value = this.dataset.material;
            document.getElementById("editProductPlastic").value = this.dataset.plastic;
        });
    });

    // Cancel Product Logic
    document.querySelectorAll(".cancelProductBtn").forEach(button => {
        button.addEventListener("click", function () {
            document.getElementById("cancelProductId").value = this.dataset.id;
            document.getElementById("cancelProdName").innerText = this.dataset.name;
        });
    });

    // View Product Logic
    document.querySelectorAll(".viewProductBtn").forEach(button => {
        button.addEventListener("click", function () {
            const d = this.dataset;

            const set = (id, val) => {
                const el = document.getElementById(id);
                if (el) el.innerText = val || "N/A";
            };

            set("viewProductId", d.id);
            set("viewProductName", d.name);
            set("viewProductPrice", d.price + " MMK");
            set("viewProductQty", d.qty);
            set("viewProductMaterial", d.material);
            set("viewProductPlastic", d.plastic + " kg");
            set("viewProductStatus", d.status);
            set("viewProductSupplier", d.supplier);
            set("viewProductCategory", d.category);
        });
    });
</script>