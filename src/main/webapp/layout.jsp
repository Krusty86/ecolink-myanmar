<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:import url="template/header.jsp"></c:import>
<body>
<!-- <jsp:include page="template/menuBar.jsp"></jsp:include>
 -->
  <jsp:include page="sidebar.jsp" />
  <jsp:include page="${pageContent }"></jsp:include>
  
    
<c:import url="template/footer.jsp"></c:import>
</body>
</html>