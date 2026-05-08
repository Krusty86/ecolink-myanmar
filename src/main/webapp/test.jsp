<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div id="backdrop"></div>

<aside class="sidebar d-flex flex-column" id="sidebar">
    <div class="p-3 border-bottom d-flex justify-content-between align-items-center">
        <div>
            <h1 class="h5 fw-bold text-success mb-0">EcoLink Myanmar</h1>
            <small class="text-muted">Admin Portal</small>
        </div>
        <button class="btn d-md-none text-secondary" id="closeSidebar"><i class="bi bi-x-lg"></i></button>
    </div>

    <nav class="flex-grow-1 p-2">
        <ul class="nav nav-pills flex-column gap-1">
            <li class="nav-item">
                <a href="home" class="nav-link ${empty param.mode ? 'active' : ''}">
                    <i data-lucide="layout-dashboard"></i> <span>Dashboard</span>
                </a>
            </li>
            <li class="nav-item">
                <a href="home?mode=ORDERS" class="nav-link ${param.mode == 'ORDERS' ? 'active' : ''}">
                    <i data-lucide="shopping-cart"></i> <span>Orders</span>
                </a>
            </li>
            <li class="nav-item">
                <a href="home?mode=PRODUCTS" class="nav-link ${param.mode == 'PRODUCTS' ? 'active' : ''}">
                    <i data-lucide="package"></i> <span>Products</span>
                </a>
            </li>
            <li class="nav-item">
                <a href="home?mode=USERS" class="nav-link ${param.mode == 'USERS' ? 'active' : ''}">
                    <i data-lucide="users"></i> <span>Users</span>
                </a>
            </li>
            <li class="mt-2 border-top"></li>
        </ul>
    </nav>

    <div class="p-3 border-top login-section">
        <a href="logout" class="btn btn-success w-100 d-flex align-items-center justify-content-center gap-2 rounded-pill">
             <i data-lucide="log-out" style="width: 18px;"></i> Logout
        </a>
    </div>
</aside>

<link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin-style.css">