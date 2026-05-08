<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register | EcoLink</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
    
    <style>
        body {
            background-color: #f8fcf9;
            height: 100vh;
            display: flex;
            align-items: center;
        }
        .register-card {
            border: none;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.05);
        }
        .btn-success {
            background-color: #52a675;
            border: none;
            padding: 12px;
            font-weight: 600;
        }
        .btn-success:hover {
            background-color: #438a61;
        }
        .form-control {
            padding: 12px;
            border-radius: 8px;
        }
        .logo-text {
            color: #52a675;
            font-weight: 800;
            letter-spacing: -1px;
        }
        .input-group-text {
            border-radius: 8px 0 0 8px;
        }
    </style>
</head>
<body>

    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-5">
                
                <%-- Error Handling from Servlet --%>
                <c:if test="${not empty error}">
                    <div class="alert alert-danger border-0 shadow-sm animate__animated animate__shakeX">
                        <i class="bi bi-x-circle-fill me-2"></i> ${error}
                    </div>
                </c:if>

                <div class="card register-card p-4">
                    <div class="text-center mb-4">
                        <h2 class="logo-text m-0">EcoLink</h2>
                        <p class="text-muted">Create your account to start shopping.</p>
                    </div>

                    <%-- Action points to your UserServlet --%>
                    <form action="login" method="post">
                        <input type="hidden" name="mode" value="SAVE">
                        
                        <%-- Username Field --%>
                        <div class="mb-3">
                            <label class="form-label small fw-bold">Username</label>
                            <div class="input-group">
                                <span class="input-group-text bg-light border-end-0"><i class="bi bi-person text-muted"></i></span>
                                <input type="text" class="form-control bg-light border-start-0" 
                                       name="username" placeholder="johndoe" required>
                            </div>
                        </div>

                        <%-- Email Field --%>
                        <div class="mb-3">
                            <label class="form-label small fw-bold">Email address</label>
                            <div class="input-group">
                                <span class="input-group-text bg-light border-end-0"><i class="bi bi-envelope text-muted"></i></span>
                                <input type="email" class="form-control bg-light border-start-0" 
                                       name="email" placeholder="name@example.com" required>
                            </div>
                        </div>

                        <%-- Password Field --%>
                        <div class="mb-4">
                            <label class="form-label small fw-bold">Password</label>
                            <div class="input-group">
                                <span class="input-group-text bg-light border-end-0"><i class="bi bi-lock text-muted"></i></span>
                                <input type="password" class="form-control bg-light border-start-0" 
                                       name="password" id="password" placeholder="••••••••" required>
                            </div>
                            <div id="passwordHelp" class="form-text small" style="font-size: 0.75rem;">
                                Must be at least 6 characters long.
                            </div>
                        </div>

                        <button type="submit" class="btn btn-success w-100 rounded-pill mb-3">
                            Create Account
                        </button>

                        <div class="text-center">
                            <span class="text-muted small">Already have an account? </span>
                            <a href="login" class="text-success small fw-bold text-decoration-none">Login here</a>
                        </div>
                    </form>
                </div>
                
                <div class="text-center mt-4">
                    <a href="home" class="text-muted small text-decoration-none">
                        <i class="bi bi-arrow-left me-1"></i> Back to Homepage
                    </a>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    
    <%-- Simple Client-side validation --%>
    <script>
        const form = document.querySelector('form');
        const password = document.getElementById('password');

        form.addEventListener('submit', function(e) {
            if (password.value.length < 6) {
                e.preventDefault();
                alert('Password must be at least 6 characters!');
            }
        });
    </script>
</body>
</html>