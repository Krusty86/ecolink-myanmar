<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${pageTitle}</title>
    <c:import url="template/admin-header.jsp"></c:import>
</head>

<body>

	<c:import url="template/admin-sideBar.jsp"></c:import>
    <main class="content-offset">
    <nav class="navbar navbar-expand-lg border-bottom bg-body d-md-none p-2">
        <div class="container-fluid">
            <button class="btn btn-outline-primary" id="mobileToggle">
                <i class="bi bi-list"></i>
            </button>
            <span class="fw-bold">EcoLink Myanmar</span>
        </div>
    </nav>

<div class="container-fluid p-4">
    <jsp:include page="${pageContent}"></jsp:include>
    
</div>

</main>
    <c:import url="template/admin-footer.jsp"></c:import>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://unpkg.com/lucide@latest"></script>
    <script>
        lucide.createIcons();
    </script>
</body>
</html>