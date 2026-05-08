<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div class="container py-5">
    <div class="row justify-content-center">
        <div class="col-lg-8">
            <div class="card border-0 shadow-sm rounded-4 p-4 p-md-5 bg-white">
                <div class="d-flex align-items-center mb-4">
                    <a href="profile?mode=VIEW" class="btn btn-light rounded-circle me-3">
                        <i class="bi bi-arrow-left"></i>
                    </a>
                    <h4 class="fw-bold mb-0">Edit Profile</h4>
                </div>

                <c:if test="${not empty param.error}">
                    <div class="alert alert-danger rounded-3 mb-4">
                        <i class="bi bi-exclamation-circle me-2"></i> ${param.error}
                    </div>
                </c:if>

                <form action="profile" method="POST">
                    <input type="hidden" name="mode" value="UPDATE_PROFILE">
                    
                    <div class="row g-4">
                        <div class="col-md-6">
                            <label class="form-label text-muted small fw-bold text-uppercase">Username</label>
                            <input type="text" name="username" class="form-control form-control-lg border-0 bg-light" 
                                   value="${loginUser.username}" required>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label text-muted small fw-bold text-uppercase">Email Address</label>
                            <input type="email" name="email" class="form-control form-control-lg border-0 bg-light" 
                                   value="${loginUser.email}" required>
                        </div>

                        <hr class="my-4 opacity-25">

                        <div class="col-12">
                            <h6 class="fw-bold mb-3">Change Password <span class="text-muted fw-normal small">(Leave blank to keep current)</span></h6>
                        </div>
                        
                        <div class="col-md-6">
                            <label class="form-label text-muted small fw-bold text-uppercase">New Password</label>
                            <input type="password" name="newPassword" class="form-control form-control-lg border-0 bg-light">
                        </div>
                        <div class="col-md-6">
                            <label class="form-label text-muted small fw-bold text-uppercase">Confirm Password</label>
                            <input type="password" name="confirmPassword" class="form-control form-control-lg border-0 bg-light">
                        </div>

                        <div class="col-12 mt-5 text-end">
                            <a href="profile?mode=VIEW" class="btn btn-light rounded-pill px-4 me-2">Cancel</a>
                            <button type="submit" class="btn btn-success rounded-pill px-5 shadow-sm">
                                Save Changes
                            </button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>