<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="sidebar" id="sidebar">
    <div class="sidebar-header">
        <div class="brand-info">
            <h1>EcoLink</h1>
            <p style="font-size: 9px; color: #95C22B; margin: 0;">SUPPLY FOR FUTURE</p>
        </div>
        <button class="toggle-btn" onclick="toggleSidebar()">
            <i class="fas fa-bars"></i>
        </button>
    </div>

    <nav class="nav-menu">
        <a href="layout.jsp?contentPage=dashboard.jsp" class="nav-item">
            <i class="fas fa-chart-line"></i>
            <span class="nav-text">Dashboard</span>
        </a>
        <a href="layout.jsp?contentPage=products.jsp" class="nav-item">
            <i class="fas fa-leaf"></i>
            <span class="nav-text">Eco Products</span>
        </a>
        <a href="layout.jsp?contentPage=orders.jsp" class="nav-item">
            <i class="fas fa-shopping-cart"></i>
            <span class="nav-text">Orders</span>
        </a>
        <a href="layout.jsp?contentPage=impact.jsp" class="nav-item">
            <i class="fas fa-seedling"></i>
            <span class="nav-text">My Impact</span>
        </a>
    </nav>
</div>

<script>
    function toggleSidebar() {
        const sidebar = document.getElementById('sidebar');
        const content = document.getElementById('contentArea');
        
        sidebar.classList.toggle('collapsed');
        content.classList.toggle('expanded');
        
        // Optional: Save state to localStorage so it stays collapsed on refresh
        localStorage.setItem('sidebarCollapsed', sidebar.classList.contains('collapsed'));
    }

    // Check saved state on load
    window.onload = function() {
        if(localStorage.getItem('sidebarCollapsed') === 'true') {
            toggleSidebar();
        }
    }
</script>