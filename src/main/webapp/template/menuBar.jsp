<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<style>
:root {
      --bs-primary: #52a868; /* Converted from oklch(0.5 0.15 142.5) */
      --bs-primary-rgb: 82, 168, 104;
    }

    .navbar {
      box-shadow: 0 4px 6px -1px rgb(0 0 0 / 0.1);
    }

    /* Cart Badge styling */
    .cart-badge {
      font-size: 0.7rem;
      width: 20px;
      height: 20px;
      display: flex;
      align-items: center;
      justify-content: center;
    }
</style>

    <nav class="navbar navbar-expand-lg navbar-dark bg-primary sticky-top">
  <div class="container-fluid">
    <a class="navbar-brand d-flex align-items-center gap-2 fw-bold" href="home">
      <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M11 20A7 7 0 0 1 9.8 6.1C15.5 5 17 4.48 19 2c1 2 2 4.18 2 8 0 5.5-4.78 10-10 10Z"/><path d="M2 21c0-3 1.85-5.36 5.08-6C6 1クリスマス 6 12 8 12"/></svg>
      EcoLink Myanmar
    </a>

    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarContent" aria-controls="navbarContent" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="navbarContent">
      <ul class="navbar-nav me-auto mb-2 mb-lg-0">
        <li class="nav-item"><a class="nav-link" href="home">Home</a></li>
        <li class="nav-item"><a class="nav-link" href="products?mode=LIST">Products</a></li>
        <li class="nav-item"><a class="nav-link" href="orders?mode=VIEWALL">Orders</a></li>
        <li class="nav-item"><a class="nav-link" href="profile?mode=VIEW">Profile Settings</a></li>
      </ul>

      <div class="d-flex align-items-center gap-3">
    <a href="carts?mode=VIEW" class="nav-link position-relative text-white">
      <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><circle cx="8" cy="21" r="1"/><circle cx="19" cy="21" r="1"/><path d="M2.05 2.05h2l2.4 11.3a2 2 0 0 0 2 1.6h9.7a2 2 0 0 0 1.95-1.5l1.6-7.4H5.4"/></svg>
      <c:if test="${not empty sessionScope.cart and sessionScope.cart.items.size() > 0}">
          <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger cart-badge">
              ${sessionScope.cart.items.size()}
          </span>
      </c:if>
    </a>
    
    <c:choose>
        <c:when test="${not empty sessionScope.loginUser}">
            <a href="login?mode=LOGOUT" class="btn btn-outline-light">Logout</a>
        </c:when>
        <c:otherwise>
            <a href="login" class="btn btn-outline-light">Login</a>
        </c:otherwise>
    </c:choose>
</div>
    </div>
  </div>
</nav>
    </nav>
