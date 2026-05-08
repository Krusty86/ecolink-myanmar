<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div id="backdrop"></div>

<aside class="sidebar d-flex flex-column border-end" id="sidebar">
    <div class="p-3 border-bottom d-flex justify-content-between align-items-center">
        <div>
            <h1 class="h5 fw-bold text-primary mb-0">EcoLink Myanmar</h1>
            <small class="text-secondary">Admin Portal</small>
        </div>
        <button class="btn d-md-none text-secondary" id="closeSidebar"><i class="bi bi-x-lg"></i></button>
    </div>

    <nav class="flex-grow-1 p-2 ">
        <ul class="nav nav-pills flex-column gap-1">
            <li class="nav-item">
                <a href="home" class="nav-link ${empty param.mode ? 'active bg-success text-white' : 'text-secondary'} d-flex align-items-center gap-3">
                    <i data-lucide="layout-dashboard" class="me-2"></i> <span>Dashboard</span>
                </a>
            </li>
            <li class="nav-item">
                <a href="home?mode=ORDERS" class="nav-link d-flex align-items-center gap-3 text-body ${param.mode == 'ORDERS' ? 'active bg-success text-white' : 'text-secondary'}">
                    <i data-lucide="shopping-cart" class="me-2"></i> <span>Orders</span>
                </a>
            </li>
            <li class="nav-item">
                <a href="home?mode=PRODUCTS" class="nav-link d-flex align-items-center gap-3 text-body ${param.mode == 'PRODUCTS' ? 'active bg-success text-white' : 'text-secondary'}">
                    <i data-lucide="package" class="me-2"></i>
                    <span>Products</span>
                </a>
            </li>

            <li class="nav-item">
                <a href="home?mode=USERS" class="nav-link d-flex align-items-center gap-3 text-body ${param.mode == 'USERS' ? 'active bg-success text-white' : 'text-secondary'}">
                    <i data-lucide="package" class="me-2">
                    <span>Users</span>
                </a>
            </li>

            <!-- Divider -->
            <li class="mt-2 border-top"></li>

            
        </ul>
    </nav>

    <div class="p-3 border-top">
        
        <button class="btn btn-primary w-100">
        <a href="logout" class="nav-link text-danger">
                <i data-lucide="log-out" class="me-2"></i> Logout
            </a></button>
    </div>
</aside>

<link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin-style.css">

