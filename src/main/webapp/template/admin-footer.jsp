<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<!-- DataTables JS -->
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.7.1.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/dataTables.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/dataTables.bootstrap5.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/dataTables.buttons.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/buttons.bootstrap5.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jszip.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/pdfmake.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/vfs_fonts.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/buttons.html5.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/buttons.print.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/buttons.colVis.min.js"></script>


<script>
	$('#recentOrdersTable').DataTable({
	    layout: {
	        topStart: {
	            buttons: ['copy', 'excel', 'pdf', 'colvis']
	        }
	    }
	});
	
	$('#ordersTable').DataTable({
	    layout: {
	        topStart: {
	            buttons: ['copy', 'excel', 'pdf', 'colvis']
	        }
	    }
	});
	$('#productsTable').DataTable({
	    layout: {
	        topStart: {
	            buttons: ['copy', 'excel', 'pdf', 'colvis']
	        }
	    }
	});
	
	$('#productApproveTable').DataTable({
	    layout: {
	        topStart: {
	            buttons: ['copy', 'excel', 'pdf', 'colvis']
	        }
	    }});

</script>
    <script>
        // Initialize Icons
        lucide.createIcons();

        // Sales Chart (Line)
        const ctxSales = document.getElementById('salesChart').getContext('2d');
        new Chart(ctxSales, {
            type: 'line',
            data: {
                labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul'],
                datasets: [{
                    label: 'Sales',
                    data: [4000, 3000, 2000, 2780, 1890, 2390, 3490],
                    borderColor: '#10b981',
                    backgroundColor: 'rgba(16, 185, 129, 0.1)',
                    tension: 0.4,
                    fill: true,
                    borderWidth: 3,
                    pointRadius: 4,
                    pointBackgroundColor: '#10b981'
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: { legend: { display: false } },
                scales: {
                    y: { beginAtZero: true, grid: { color: '#f1f5f9' } },
                    x: { grid: { display: false } }
                }
            }
        });

        // Orders Chart (Bar)
        const ctxOrders = document.getElementById('ordersChart').getContext('2d');
        new Chart(ctxOrders, {
            type: 'bar',
            data: {
                labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May'],
                datasets: [{
                    label: 'Orders',
                    data: [240, 221, 229, 200, 229],
                    backgroundColor: '#3b82f6',
                    borderRadius: 8
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: { legend: { display: false } },
                scales: {
                    y: { beginAtZero: true, grid: { color: '#f1f5f9' } },
                    x: { grid: { display: false } }
                }
            }
        });
    </script>