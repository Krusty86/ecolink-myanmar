<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${pageTitle }</title>
	<c:import url="template/admin-header.jsp"></c:import>
</head>

<body>
	
    <div class="container-fluid d-flex">
    	<div class="row">
    		<div class="col p-4">
    			<c:import url="template/admin-sideBar.jsp"></c:import>
					<main class="main-content flex-grow-1">
			            <div class="container-fluid p-4 p-lg-5">
			                
					<c:import url="template/admin-topBar.jsp"></c:import>
					<jsp:include page="${pageContent }"></jsp:include>
					</div></main>
    		</div>
    	</div>
		
    </div>
    <div>
    	
		
    </div>

    <c:import url="template/admin-footer.jsp"></c:import>
</body>
</html>