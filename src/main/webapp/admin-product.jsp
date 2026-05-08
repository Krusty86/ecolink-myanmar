<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>


<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.List" %>
<%@ page import="dao.ProductImageDAO" %>
<%@ page import="entity.ProductImage" %>


<%
    // ============================
    // Prepare product images map
    // ============================
    ProductImageDAO imgDAO = new ProductImageDAO();
    Map<Long,String> productImages = new HashMap<>();

    if(request.getAttribute("products") != null){

        List productsList = (List) request.getAttribute("products");

        for(Object obj : productsList){

            entity.Product p = (entity.Product) obj;

            List<ProductImage> images = imgDAO.findByProductId(p.getId());

            if(images != null && !images.isEmpty()){

                ProductImage pi = images.get(0);

                productImages.put(
                    p.getId(),
                    pi.getImage_path()
                );
            }
        }
    }

    request.setAttribute("productImages", productImages);
%>

<c:set var="defaultImagePath" value="images/products/default.png"/>
<div class="container py-4">
    <div class="row g-3 mb-4">
    <div class="mb-4">
    <nav aria-label="breadcrumb">
        <ol class="breadcrumb mb-1">
            <li class="breadcrumb-item"><a href="home" class="text-success text-decoration-none">Admin</a></li>
            <li class="breadcrumb-item active">Products</li>
        </ol>
    </nav>
    <h2 class="fw-bold text-dark d-flex align-items-center">
        <i class="bi bi-leaf-fill text-success me-2"></i> Product Inventory
    </h2>
</div>
        <div class="col-md-4">
            <div class="card border-0 shadow-sm rounded-4 bg-white p-3">
                <div class="d-flex align-items-center">
                    <div class="bg-success bg-opacity-10 text-success p-3 rounded-circle me-3">
                        <i class="bi bi-box-seam fs-4"></i>
                    </div>
                    <div>
                        <small class="text-muted d-block text-uppercase fw-bold">Active Catalog</small>
                        <h4 class="fw-bold mb-0">${products.size()}</h4>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card border-0 shadow-sm rounded-4 bg-white p-3 border-start border-warning border-4">
                <div class="d-flex align-items-center">
                    <div class="bg-warning bg-opacity-10 text-warning p-3 rounded-circle me-3">
                        <i class="bi bi-clock-history fs-4"></i>
                    </div>
                    <div>
                        <small class="text-muted d-block text-uppercase fw-bold">Pending Approval</small>
                        <h4 class="fw-bold mb-0">${uproducts.size()}</h4>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-4 text-end d-flex align-items-center justify-content-end">
             <button data-bs-toggle="modal" data-bs-target="#addProductModal" class="btn btn-success rounded-pill px-4 shadow-sm py-2 fw-bold">
                <i class="bi bi-plus-lg me-2"></i>New Product
            </button>
        </div>
    </div>

    <ul class="nav nav-pills mb-4 bg-white p-2 rounded-pill shadow-sm d-inline-flex" id="adminTab" role="tablist">
        <li class="nav-item" role="presentation">
            <button class="nav-link active rounded-pill px-4" id="list-tab" data-bs-toggle="tab" data-bs-target="#pLst" type="button">
                <i class="bi bi-list-ul me-2"></i>Inventory
            </button>
        </li>
        <li class="nav-item" role="presentation">
            <button class="nav-link rounded-pill px-4 position-relative" id="approval-tab" data-bs-toggle="tab" data-bs-target="#pApp" type="button">
                <i class="bi bi-shield-check me-2"></i>Approvals
                <c:if test="${uproducts.size() > 0}">
                    <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger">
                        ${uproducts.size()}
                    </span>
                </c:if>
            </button>
        </li>
    </ul>

    <div class="tab-content" id="adminTabContent">
        <div class="tab-pane fade show active" id="pLst" role="tabpanel">
            <div class="card border-0 shadow-sm rounded-4 overflow-hidden">
                <div class="table-responsive">
                    <table class="table table-hover align-middle mb-0">
                        <thead class="bg-light">
                            <tr class="text-muted small fw-bold">
                                <th class="ps-4">PRODUCT INFO</th>
                                <th>CATEGORY</th>
                                <th>STOCK</th>
                                <th>STATUS</th>
                                <th class="pe-4 text-end">ACTIONS</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="product" items="${products}">
                                <tr>
                                    <td class="ps-4 py-3">
                                        <div class="d-flex align-items-center">
                                            <div class="me-3">
											    <c:choose>
											        <c:when test="${productImages[product.id] != null}">
											            <img 
											                src="${pageContext.request.contextPath}/${productImages[product.id]}"
											                alt="${product.name}"
											                class="rounded-3 border object-fit-cover"
											                style="width: 55px; height: 55px;"
											            >
											        </c:when>
											
											        <c:otherwise>
											            <img 
											                src="${pageContext.request.contextPath}/${defaultImagePath}"
											                alt="default"
											                class="rounded-3 border object-fit-cover"
											                style="width: 55px; height: 55px;"
											            >
											        </c:otherwise>
											    </c:choose>
											</div>
                                            <div>
                                                <div class="fw-bold text-dark">${product.name}</div>
                                                <div class="small text-muted">ID: #${product.id} • ${product.material_type}</div>
                                            </div>
                                        </div>
                                    </td>
                                    <td><span class="badge bg-light text-dark border fw-normal p-2">${product.category.name}</span></td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${product.qty > 10}"><span class="text-success fw-bold">${product.qty}</span></c:when>
                                            <c:when test="${product.qty > 0}"><span class="text-warning fw-bold">${product.qty}</span></c:when>
                                            <c:otherwise><span class="badge bg-danger-subtle text-danger">Sold Out</span></c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
									    <c:choose>
									        <c:when test="${product.status == 'ACTIVE'}">
									            <span class="badge bg-success-subtle text-success rounded-pill border border-success-subtle">
									                <i class="bi bi-check-circle-fill me-1"></i> Active
									            </span>
									        </c:when>
									        <c:when test="${product.status == 'OUT_OF_STOCK'}">
									            <span class="badge bg-warning-subtle text-warning rounded-pill border border-warning-subtle">
									                <i class="bi bi-exclamation-triangle-fill me-1"></i> Sold Out
									            </span>
									        </c:when>
									        <c:when test="${product.status == 'DRAFT'}">
									            <span class="badge bg-info-subtle text-info rounded-pill border border-info-subtle">
									                <i class="bi bi-pencil-fill me-1"></i> Draft
									            </span>
									        </c:when>
									        <c:otherwise> <span class="badge bg-light text-muted rounded-pill border">
									                <i class="bi bi-archive-fill me-1"></i> Archived
									            </span>
									        </c:otherwise>
									    </c:choose>
									</td>
                                    <td class="pe-4 text-end">
                                        <div class="btn-group rounded-3 overflow-hidden shadow-sm border">
										    <!-- Edit -->
										    <button 
											    class="btn btn-white btn-sm editProductBtn"
											    data-id="${product.id}"
											    data-name="${product.name}"
											    data-price="${product.price}"
											    data-qty="${product.qty}"
											    data-material="${product.material_type}"
											    data-plastic="${product.plastic_saved_per_unit}"
											    data-category-id="${product.category.id}" 
											    data-bs-toggle="modal"
											    data-bs-target="#editProductModal">
											    <i class="bi bi-pencil"></i>
											</button>
										
										    <!-- View -->
										    <button 
										        class="btn btn-white btn-sm viewProductBtn"
										        data-id="${product.id}"
										        data-name="${product.name}"
										        data-price="${product.price}"
										        data-qty="${product.qty}"
										        data-material="${product.material_type}"
										        data-plastic="${product.plastic_saved_per_unit}"
										        data-status="${product.status}"
										        data-category="${product.category.name}"
										        data-bs-toggle="modal"
										        data-bs-target="#viewProductModal">
										
										        <i class="bi bi-eye"></i>
										    </button>
										
										    <!-- Category -->
										    <button 
										        class="btn btn-white btn-sm editCategoryBtn"
										        data-id="${product.id}"
										        data-name="${product.name}"
										        data-current-cat-id="${product.category.id}"
										        data-current-cat-name="${product.category.name}"
										        data-bs-toggle="modal"
										        data-bs-target="#editCategoryModal">
										
										        <i class="bi bi-tag"></i>
										    </button>
										
										    <!-- Upload Image -->
										    <button 
										        class="btn btn-white btn-sm uploadImageBtn"
										        data-id="${product.id}"
										        data-name="${product.name}"
										        data-bs-toggle="modal"
										        data-bs-target="#uploadImageModal">
										
										        <i class="bi bi-image"></i>
										    </button>
											
											<!-- Update Product Status -->
											<button 
											    class="btn btn-white btn-sm updateStatusBtn"
											    data-id="${product.id}"
											    data-name="${product.name}"
											    data-current-status="${product.status}"
											    data-bs-toggle="modal"
											    data-bs-target="#updateStatusModal">
											    <i class="bi bi-check-circle"></i>
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

        <div class="tab-pane fade" id="pApp" role="tabpanel">
            <div class="row g-3">
                <c:forEach var="product" items="${uproducts}">
                    <div class="col-md-6 col-lg-4">
                        <div class="card border-0 shadow-sm rounded-4 h-100">
                            <div class="card-body p-4">
                                <div class="d-flex justify-content-between mb-3">
                                    <span class="badge bg-warning bg-opacity-10 text-warning px-3 py-2 rounded-pill">Pending Approval</span>
                                    <span class="text-muted small">#${product.id}</span>
                                </div>
                                <h5 class="fw-bold mb-1">${product.name}</h5>
                                <p class="text-muted small mb-3">${product.category.name} • ${product.material_type}</p>
                                
                                <div class="row mb-4 bg-light rounded-3 p-2 g-0 text-center">
                                    <div class="col-6 border-end">
                                        <small class="text-muted d-block">Price</small>
                                        <span class="fw-bold text-success">${product.price} MMK</span>
                                    </div>
                                    <div class="col-6">
                                        <small class="text-muted d-block">Stock</small>
                                        <span class="fw-bold">${product.qty}</span>
                                    </div>
                                </div>

                                <div class="d-flex gap-2">
                                    <form action="home" method="post" class="flex-grow-1">
                                        <input type="hidden" name="mode" value="UPDATE_STATUS">
                                        <input type="hidden" name="id" value="${product.id}">
                                        <input type="hidden" name="status" value="ACTIVE">
                                        <button type="submit" class="btn btn-success w-100 rounded-pill">Approve</button>
                                    </form>
                                    <button class="btn btn-outline-danger rounded-pill cancelProductBtn" data-id="${product.id}" data-name="${product.name}" data-bs-toggle="modal" data-bs-target="#cancelProductModal">Reject</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="editProductModal" tabindex="-1">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content border-0 shadow rounded-4">
            <div class="modal-header border-0 bg-success py-3">
                <h5 class="fw-bold mb-0 text-white"><i class="bi bi-pencil-square me-2 text-warning "></i>Edit Product</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
            </div>
            <form action="home" method="post">
                <div class="modal-body p-4">
                    <input type="hidden" name="mode" value="EDITP">
                    <input type="hidden" name="id" id="editProductId">

                    <div class="mb-3">
                        <label class="form-label small fw-bold text-muted">Product Name</label>
                        <input type="text" class="form-control rounded-3" name="name" id="editProductName" required>
                    </div>

                    <div class="mb-3">
                        <label class="form-label small fw-bold text-muted">Category</label>
                        <select class="form-select rounded-3" name="categoryId" id="editProductCategoryId" required>
                            <c:forEach var="cat" items="${categories}">
                                <option value="${cat.id}">${cat.name}</option>
                            </c:forEach>
                        </select>
                    </div>

                    <div class="row g-3 mb-3">
                        <div class="col-6">
                            <label class="form-label small fw-bold text-muted">Price (MMK)</label>
                            <input type="number" step="0.01" class="form-control rounded-3" name="price" id="editProductPrice" required>
                        </div>
                        <div class="col-6">
                            <label class="form-label small fw-bold text-muted">Stock Qty</label>
                            <input type="number" class="form-control rounded-3" name="qty" id="editProductQty" required>
                        </div>
                    </div>

                    <div class="mb-3">
                        <label class="form-label small fw-bold text-muted">Material Type</label>
                        <input type="text" class="form-control rounded-3" name="material_type" id="editProductMaterial">
                    </div>
                    
                    <div class="mb-0">
                        <label class="form-label small fw-bold text-muted">Plastic Saved (kg)</label>
                        <input type="number" step="0.01" class="form-control rounded-3" name="plastic_saved" id="editProductPlastic">
                    </div>
                </div>
                <div class="modal-footer border-0 p-4 pt-0">
                    <button type="button" class="btn btn-light rounded-pill px-4" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-success rounded-pill px-4 fw-bold shadow-sm">Save Changes</button>
                </div>
            </form>
        </div>
    </div>
</div>


<!-- View Product -->
<div class="modal fade" id="viewProductModal" tabindex="-1">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content border-0 shadow rounded-4 overflow-hidden">
            <div class="modal-header bg-success text-white border-0 py-3">
                <h5 class="fw-bold mb-0" id="viewProductNameTitle">Product Detail</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body p-4">
                <div class="row g-4">
                    <div class="col-6">
                        <label class="text-muted small d-block text-uppercase fw-bold">Status</label>
                        <span class="badge bg-success bg-opacity-10 text-success rounded-pill px-3" id="viewProductStatus"></span>
                    </div>
                    <div class="col-6">
                        <label class="text-muted small d-block text-uppercase fw-bold">Product ID</label>
                        <span class="fw-bold text-dark" id="viewProductId"></span>
                    </div>
                    <div class="col-6">
                        <label class="text-muted small d-block text-uppercase fw-bold">Price</label>
                        <span class="text-success fw-bold h5 mb-0" id="viewProductPrice"></span>
                    </div>
                    <div class="col-6">
                        <label class="text-muted small d-block text-uppercase fw-bold">Stock</label>
                        <span class="fw-bold text-success " id="viewProductQty"></span>
                    </div>
                    <div class="col-12">
                        <hr class="my-0 opacity-5">
                    </div>
                    <div class="col-6">
                        <label class="text-muted small d-block text-uppercase fw-bold">Category</label>
                        <span class="text-dark" id="viewProductCategory"></span>
                    </div>
                    <div class="col-6">
                        <label class="text-muted small d-block text-uppercase fw-bold">Material</label>
                        <span class="text-dark" id="viewProductMaterial"></span>
                    </div>
                </div>
            </div>
            <div class="modal-footer border-0 bg-light">
                <button type="button" class="btn btn-secondary rounded-pill px-4" data-bs-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>


<!-- Edit Category -->
<div class="modal fade" id="editCategoryModal" tabindex="-1">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content border-0 shadow rounded-4">
            <div class="modal-header border-0 py-3 bg-success">
                <h5 class="fw-bold mb-0">Change Category</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <form action="home" method="post">
                <div class="modal-body p-4">
                    <input type="hidden" name="mode" value="EDIT_CAT">
                    <input type="hidden" name="id" id="catProductId">
                    <div class="mb-3">
                        <label class="form-label small fw-bold text-muted">Product</label>
                        <input type="text" class="form-control bg-light rounded-3 border-0" id="catProductName" readonly>
                    </div>
                    <div class="mb-0">
                        <label class="form-label small fw-bold text-muted">Select New Category</label>
                        <select class="form-select rounded-3" name="categoryId" id="categorySelect" required>
                            <c:forEach var="cat" items="${categories}">
                                <option value="${cat.id}">${cat.name}</option>
                            </c:forEach>
                        </select>
                        <div class="form-text mt-2">Current: <span id="currentCatNameDisplay" class="fw-bold text-success"></span></div>
                    </div>
                </div>
                <div class="modal-footer border-0 p-4 pt-0">
                    <button type="submit" class="btn btn-success rounded-pill px-4 w-100">Update Category</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- New Product -->
<div class="modal fade" id="addProductModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content border-0 shadow rounded-4">
            <div class="modal-header border-0 bg-success py-3">
                <h5 class="fw-bold mb-0"><i class="bi bi-plus-circle me-2 text-success"></i>Add New Product</h5>
                <button type="button" class="btn-close"  data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form action="home" method="post">
                <div class="modal-body p-4">
                    <input type="hidden" name="mode" value="ADDP">

                    <div class="mb-3">
                        <label class="form-label small fw-bold text-muted">Product Name</label>
                        <input type="text" class="form-control rounded-3" name="name" placeholder="e.g. Bamboo Toothbrush" required>
                    </div>

                    <div class="mb-3">
                        <label class="form-label small fw-bold text-muted">Select Category</label>
                        <select class="form-select rounded-3" name="categoryId" required>
                            <option value="" disabled selected>Choose a category...</option>
                            <c:forEach var="cat" items="${categories}">
                                <option value="${cat.id}">${cat.name}</option>
                            </c:forEach>
                        </select>
                    </div>

                    <div class="row g-3 mb-3">
                        <div class="col-6">
                            <label class="form-label small fw-bold text-muted">Price (MMK)</label>
                            <input type="number" step="0.01" class="form-control rounded-3" name="price" placeholder="0.00" required>
                        </div>
                        <div class="col-6">
                            <label class="form-label small fw-bold text-muted">Initial Stock</label>
                            <input type="number" class="form-control rounded-3" name="qty" placeholder="0" required>
                        </div>
                    </div>

                    <div class="mb-3">
                        <label class="form-label small fw-bold text-muted">Material Type</label>
                        <input type="text" class="form-control rounded-3" name="material_type" placeholder="e.g. Organic Cotton / Bamboo">
                    </div>
                    
                    <div class="mb-0">
                        <label class="form-label small fw-bold text-muted">Plastic Saved Per Unit (kg)</label>
                        <input type="number" step="0.01" class="form-control rounded-3" name="plastic_saved" placeholder="0.05">
                        <div class="form-text mt-2 small">This data helps track the environmental impact of EcoLink.</div>
                    </div>
                </div>
                <div class="modal-footer border-0 p-4 pt-0">
                    <button type="button" class="btn btn-light rounded-pill px-4 fw-bold" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-success rounded-pill px-5 fw-bold shadow-sm">Save Product</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Upload Product Image -->
<div class="modal fade" id="uploadImageModal" tabindex="-1">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content border-0 shadow rounded-4 overflow-hidden">

            <div class="modal-header bg-success border-0 py-3">
                <h5 class="fw-bold mb-0 text-white">
                    <i class="bi bi-image me-2"></i>
                    Upload Product Image
                </h5>

                <button 
                    type="button" 
                    class="btn-close btn-close-white"
                    data-bs-dismiss="modal">
                </button>
            </div>

            <form 
                action="${pageContext.request.contextPath}/product-image"
                method="post"
                enctype="multipart/form-data">

                <div class="modal-body p-4">

                    <input 
                        type="hidden"
                        name="productId"
                        id="uploadProductId">

                    <div class="mb-3">
                        <label class="form-label small fw-bold text-muted">
                            Product
                        </label>

                        <input 
                            type="text"
                            class="form-control  rounded-3"
                            id="uploadProductName"
                            readonly>
                    </div>

                    <div class="mb-3">
                        <label class="form-label small fw-bold text-muted">
                            Choose Image
                        </label>

                        <input 
                            type="file"
                            name="image"
                            class="form-control rounded-3"
                            accept="image/*"
                            required>
                    </div>

                </div>

                <div class="modal-footer border-0 bg-light px-4 py-3">
                    <button 
                        type="button"
                        class="btn btn-light rounded-pill px-4"
                        data-bs-dismiss="modal">

                        Cancel
                    </button>

                    <button 
                        type="submit"
                        class="btn btn-success rounded-pill px-4">

                        Upload Image
                    </button>
                </div>

            </form>
        </div>
    </div>
</div>

<!-- Update Product Status -->
<div class="modal fade" id="updateStatusModal" tabindex="-1">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content border-0 shadow rounded-4">
            <div class="modal-header border-0 py-3 bg-success">
                <h5 class="fw-bold mb-0 text-white"><i class="bi bi-gear-wide-connected me-2"></i>Change Status</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
            </div>
            <form action="home" method="post">
                <div class="modal-body p-4">
                    <input type="hidden" name="mode" value="UPDATE_STATUS">
                    <input type="hidden" name="id" id="statusProductId">
                    
                    <div class="mb-3">
                        <label class="form-label small fw-bold text-muted">Product</label>
                        <input type="text" class="form-control bg-light rounded-3 border-0" id="statusProductName" readonly>
                    </div>

                    <div class="mb-0">
                        <label class="form-label small fw-bold text-muted">Select New Status</label>
                        <select class="form-select rounded-3" name="status" id="statusSelect" required>
                            <option value="ACTIVE">Active</option>
                            <option value="DRAFT">Draft</option>
                            <option value="OUT_OF_STOCK">Out of Stock</option>
                            <option value="ARCHIVED">Archived</option>
                        </select>
                        <div class="form-text mt-2">
                            Current Status: <span id="currentStatusDisplay" class="fw-bold text-success"></span>
                        </div>
                    </div>
                </div>
                <div class="modal-footer border-0 p-4 pt-0">
                    <button type="submit" class="btn btn-success rounded-pill px-4 w-100 fw-bold">Update Status</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!--  Product Reject -->
<div class="modal fade" id="cancelProductModal" tabindex="-1">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content border-0 shadow rounded-4">
            <div class="modal-header border-0 bg-danger py-3">
                <h5 class="fw-bold mb-0 text-white"><i class="bi bi-archive me-2"></i>Reject & Archive</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
            </div>
            <form action="home" method="post">
                <div class="modal-body p-4 text-center">
                    <input type="hidden" name="mode" value="UPDATE_STATUS">
                    <input type="hidden" name="id" id="cancelProductId">
                    <input type="hidden" name="status" value="ARCHIVED">
                    
                    <div class="bg-danger bg-opacity-10 text-danger rounded-circle d-inline-flex align-items-center justify-content-center mb-3" style="width: 60px; height: 60px;">
                        <i class="bi bi-trash3 fs-3"></i>
                    </div>
                    <h5 class="fw-bold">Reject this submission?</h5>
                    <p class="text-muted">
                        Rejecting <span id="cancelProdName" class="fw-bold text-dark"></span> will move it to <strong>Archived</strong> status. It will no longer appear in the shop or approval list.
                    </p>
                </div>
                <div class="modal-footer border-0 p-4 pt-0">
                    <button type="button" class="btn btn-light rounded-pill px-4" data-bs-dismiss="modal">Go Back</button>
                    <button type="submit" class="btn btn-danger rounded-pill px-4 shadow-sm">Confirm Archive</button>
                </div>
            </form>
        </div>
    </div>
</div>

<style>
    .nav-pills .nav-link { color: #6c757d; font-weight: 600; transition: 0.3s; }
    .nav-pills .nav-link.active { background-color: #198754; color: white; }
    .btn-white { background-color: #fff; color: #495057; }
    .btn-white:hover { background-color: #f8f9fa; color: #198754; }
    .bg-danger-subtle { background-color: #f8d7da; }
    .table-hover tbody tr:hover { background-color: #fcfdfc; }
</style>

<script>
document.addEventListener("DOMContentLoaded", function() {
    
	// --- EDIT PRODUCT LOGIC ---
	document.querySelectorAll(".editProductBtn").forEach(button => {
	    button.addEventListener("click", function () {
	        const d = this.dataset;

	        // Safety Helper: Checks if element exists before setting value
	        const setVal = (id, value) => {
	            const el = document.getElementById(id);
	            if (el) el.value = value || "";
	        };

	        setVal("editProductId", d.id);
	        setVal("editProductName", d.name);
	        setVal("editProductPrice", d.price);
	        setVal("editProductQty", d.qty);
	        setVal("editProductMaterial", d.material);
	        setVal("editProductPlastic", d.plastic);
	        
	        // Handle the Dropdown
	        setVal("editProductCategoryId", d.categoryId);
	    });
	});

    // --- VIEW PRODUCT LOGIC ---
    document.querySelectorAll(".viewProductBtn").forEach(button => {
        button.addEventListener("click", function () {
            const d = this.dataset;
            const set = (id, val) => {
                const el = document.getElementById(id);
                if (el) el.innerText = val || "N/A";
            };

            set("viewProductId", "#" + d.id);
            set("viewProductName", d.name);
            set("viewProductPrice", d.price + " MMK");
            set("viewProductQty", d.qty);
            set("viewProductMaterial", d.material);
            set("viewProductPlastic", d.plastic + " kg");
            set("viewProductStatus", d.status);
            set("viewProductCategory", d.category);
            
            // Update Title
            document.getElementById("viewProductNameTitle").innerText = d.name;
        });
    });

 // --- UPDATE STATUS LOGIC ---
    document.querySelectorAll(".updateStatusBtn").forEach(button => {
        button.addEventListener("click", function () {
            const d = this.dataset;
            
            // Populate Hidden ID and Display Name
            document.getElementById("statusProductId").value = d.id;
            document.getElementById("statusProductName").value = d.name;
            
            // Show current status text
            document.getElementById("currentStatusDisplay").innerText = d.currentStatus;

            // Auto-select the current status in the dropdown
            const statusSelect = document.getElementById("statusSelect");
            if(statusSelect) {
                statusSelect.value = d.currentStatus;
            }
        });
    });
    // --- CATEGORY EDIT LOGIC ---
    document.querySelectorAll(".editCategoryBtn").forEach(button => {
        button.addEventListener("click", function () {
            const d = this.dataset;
            document.getElementById("catProductId").value = d.id;
            document.getElementById("catProductName").value = d.name;
            document.getElementById("currentCatNameDisplay").innerText = d.currentCatName;

            // Auto-select the current category in the dropdown
            const selectElement = document.getElementById("categorySelect");
            if(selectElement) selectElement.value = d.currentCatId;
        });
    });

    // --- REJECT / CANCEL LOGIC ---
    document.querySelectorAll(".cancelProductBtn").forEach(button => {
        button.addEventListener("click", function () {
            document.getElementById("cancelProductId").value = this.dataset.id;
            document.getElementById("cancelProdName").innerText = this.dataset.name;
        });
    });
 // --- UPLOAD IMAGE LOGIC ---
    document.querySelectorAll(".uploadImageBtn").forEach(button => {

        button.addEventListener("click", function () {

            const d = this.dataset;

            document.getElementById("uploadProductId").value = d.id;

            document.getElementById("uploadProductName").value = d.name;

            console.log("Uploading for Product ID:", d.id);

        });

    });
});

</script>