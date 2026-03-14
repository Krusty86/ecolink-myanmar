<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

                
                <div class="mb-4">
                    <h1 class="h3 fw-bold text-dark">Dashboard</h1>
                    <p class="text-secondary">Welcome back! Here's your business overview.</p>
                </div>

                <div class="row g-4 mb-4">
                    <div class="col-12 col-md-4 col-xl-4">
                        <div class="card stat-card h-100">
                            <div class="card-body">
                                <div class="d-flex justify-content-between align-items-start mb-3">
                                    <span class="text-secondary fw-medium small">Total Orders</span>
                                    <div class="icon-box bg-blue-light text-primary">
                                        <i data-lucide="shopping-cart" size="20"></i>
                                    </div>
                                </div>
                                <h2 class="fw-bold mb-1"> ${orderCount }</h2>
                                <p class="text-success small mb-0">+12% from last month</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-12 col-md-4 col-xl-4">
                        <div class="card stat-card h-100">
                            <div class="card-body">
                                <div class="d-flex justify-content-between align-items-start mb-3">
                                    <span class="text-secondary fw-medium small">Products</span>
                                    <div class="icon-box bg-green-light text-success">
                                        <i data-lucide="package" size="20"></i>
                                    </div>
                                </div>
                                <h2 class="fw-bold mb-1">${productCount }</h2>
                                <p class="text-success small mb-0">+12% from last month</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-12 col-md-4 col-xl-4">
                        <div class="card stat-card h-100">
                            <div class="card-body">
                                <div class="d-flex justify-content-between align-items-start mb-3">
                                    <span class="text-secondary fw-medium small">Active Users</span>
                                    <div class="icon-box bg-purple-light text-purple">
                                        <i data-lucide="users" size="20"></i>
                                    </div>
                                </div>
                                <h2 class="fw-bold mb-1">${userCount }</h2>
                                <p class="text-success small mb-0">+12% from last month</p>
                            </div>
                        </div>
                    </div>

                </div>

