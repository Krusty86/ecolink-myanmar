<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<header class="navbar navbar-light bg-white border-bottom d-lg-none fixed-top px-3">
    <div class="container-fluid p-0">
        <button class="navbar-toggler border-0 p-0 me-3" type="button" 
                data-bs-toggle="offcanvas" data-bs-target="#sidebarMenu">
            <i data-lucide="menu" class="text-success" style="width: 28px; height: 28px;"></i>
        </button>
        <span class="navbar-brand fw-bold text-success m-0">EcoLink</span>
    </div>
</header>

<div class="offcanvas-lg offcanvas-start sidebar border-end shadow-sm" tabindex="-1" id="sidebarMenu">
    
    <div class="offcanvas-header d-lg-none border-bottom">
        <h5 class="offcanvas-title fw-bold text-success">EcoLink Menu</h5>
        <button type="button" class="btn-close" data-bs-dismiss="offcanvas" data-bs-target="#sidebarMenu"></button>
    </div>

    <div class="offcanvas-body p-4 d-flex flex-column h-100">
        <div class="d-none d-lg-block mb-4">
            <h4 class="fw-bold text-success m-0">EcoLink</h4>
            <small class="text-primary fw-medium">Admin Portal</small>
        </div>

        <ul class="nav flex-column gap-1 w-100">
            <li class="nav-item">
                <a href="home" class="nav-link rounded ${empty param.mode ? 'active bg-success text-white' : 'text-secondary'}">
                    <i data-lucide="layout-dashboard" class="me-2"></i> Dashboard
                </a>
            </li>
            <li class="nav-item">
        <a href="home?mode=ORDERS" class="nav-link rounded ${param.mode == 'ORDERS' ? 'active bg-success text-white' : 'text-secondary'}">
            <i data-lucide="shopping-cart" class="me-2"></i> Orders
        </a>
    </li>
            <li class="nav-item">
                <a href="home?mode=PRODUCTS" class="nav-link rounded ${param.mode == 'PRODUCTS' ? 'active bg-success text-white' : 'text-secondary'}">
                    <i data-lucide="package" class="me-2"></i> Products
                </a>
            </li>
            
            <li class="nav-item">
                <a href="#userCollapse" class="nav-link text-secondary d-flex justify-content-between align-items-center" 
                   data-bs-toggle="collapse" role="button" aria-expanded="${param.mode == 'BUYERS' || param.mode == 'SELLERS'}">
                    <span><i data-lucide="users" class="me-2"></i> Users</span>
                    <i data-lucide="chevron-down" style="width:14px"></i>
                </a>
                <div class="collapse ${param.mode == 'BUYERS' || param.mode == 'SELLERS' ? 'show' : ''}" id="userCollapse">
                    <ul class="list-unstyled ps-4 ms-2 mt-1 border-start">
                        <li><a href="home?mode=BUYERS" class="nav-link py-1 small ${param.mode == 'BUYERS' ? 'text-success fw-bold' : 'text-muted'}">Buyers</a></li>
                        <li><a href="home?mode=SELLERS" class="nav-link py-1 small ${param.mode == 'SELLERS' ? 'text-success fw-bold' : 'text-muted'}">Sellers</a></li>
                    </ul>
                </div>
            </li>
        </ul>

        <div class="mt-auto pt-4">
            <hr class="opacity-10">
            <a href="logout" class="nav-link text-danger">
                <i data-lucide="log-out" class="me-2"></i> Logout
            </a>
        </div>
    </div>
</div>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin-style.css">
