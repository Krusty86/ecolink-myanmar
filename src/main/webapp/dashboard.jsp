<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
        

                <div class="row g-4 mb-4">
                    <div class="col-12 col-xl-8">
                        <div class="card shadow-sm border-0">
                            <div class="card-header bg-white border-0 pt-4 px-4">
                                <h5 class="fw-bold">Sales Overview</h5>
                            </div>
                            <div class="card-body">
                                <canvas id="salesChart" height="300"></canvas>
                            </div>
                        </div>
                    </div>
                    <div class="col-12 col-xl-4">
                        <div class="card shadow-sm border-0">
                            <div class="card-header bg-white border-0 pt-4 px-4">
                                <h5 class="fw-bold">Orders Distribution</h5>
                            </div>
                            <div class="card-body">
                                <canvas id="ordersChart" height="300"></canvas>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="card shadow-sm border-0 mb-4">
                    <div class="card-header bg-white border-0 pt-4 px-4">
                        <h5 class="fw-bold">Recent Orders</h5>
                    </div>
                    <div class="card-body px-0 px-lg-4">
                        <div class="table-responsive">
                            <table class="table table-hover align-middle">
                                <thead class="table-light">
                                    <tr>
                                        <th class="border-0">Order ID</th>
                                        <th class="border-0">Customer</th>
                                        <th class="border-0">Amount</th>
                                        <th class="border-0">Status</th>
                                        <th class="border-0">Date</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td class="fw-medium">#ORD001</td>
                                        <td>John Doe</td>
                                        <td class="fw-bold text-dark">$1,234</td>
                                        <td><span class="badge status-completed">Completed</span></td>
                                        <td class="text-secondary">2024-03-05</td>
                                    </tr>
                                    <tr>
                                        <td class="fw-medium">#ORD002</td>
                                        <td>Jane Smith</td>
                                        <td class="fw-bold text-dark">$890</td>
                                        <td><span class="badge status-pending">Pending</span></td>
                                        <td class="text-secondary">2024-03-04</td>
                                    </tr>
                                    <tr>
                                        <td class="fw-medium">#ORD003</td>
                                        <td>Bob Johnson</td>
                                        <td class="fw-bold text-dark">$2,456</td>
                                        <td><span class="badge status-shipped">Shipped</span></td>
                                        <td class="text-secondary">2024-03-03</td>
                                    </tr>
                                    <tr>
                                        <td class="fw-medium">#ORD004</td>
                                        <td>Alice Williams</td>
                                        <td class="fw-bold text-dark">$567</td>
                                        <td><span class="badge status-completed">Completed</span></td>
                                        <td class="text-secondary">2024-03-02</td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>

    