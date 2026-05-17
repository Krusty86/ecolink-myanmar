<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Login | Secure Portal</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://unpkg.com/lucide@latest"></script>

    <style>
        body {
            background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
        }
        .login-card {
            border: none;
            border-radius: 1rem;
            box-shadow: 0 0.5rem 1.5rem rgba(0, 0, 0, 0.1);
        }
        .icon-wrapper {
            width: 60px;
            height: 60px;
            background-color: rgba(25, 135, 84, 0.1); /* Bootstrap success light */
            color: #198754;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 12px;
            margin: 0 auto 1.5rem;
        }
        .form-floating > .form-control {
            padding-left: 3rem;
        }
        .form-floating > label {
            padding-left: 3rem;
        }
        .input-icon {
            position: absolute;
            left: 1rem;
            top: 1.2rem;
            z-index: 10;
            color: #6c757d;
        }
    </style>
</head>
<body>

<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-6 col-lg-4">
            
            <div class="card login-card p-4 p-md-5">
                <div class="text-center">
                    <div class="icon-wrapper">
                        <i data-lucide="lock" style="width: 30px; height: 30px;"></i>
                    </div>
                    <h2 class="fw-bold mb-1">Admin Portal</h2>
                    <p class="text-muted mb-4">Secure access to your dashboard</p>
                </div>

                <form id="loginForm" action="login" method="post">
                    <div class="form-floating mb-3 position-relative">
                        <i data-lucide="mail" class="input-icon" style="width: 20px;"></i>
                        <input type="email" class="form-control" id="email" name="email" placeholder="name@example.com" required>
                        <label for="email">Email Address</label>
                    </div>

                    <div class="form-floating mb-4 position-relative">
                        <i data-lucide="shield-check" class="input-icon" style="width: 20px;"></i>
                        <input type="password" class="form-control" id="password" name="password" placeholder="Password" required>
                        <label for="password">Password</label>
                        <button type="button" class="btn position-absolute end-0 top-0 mt-2 me-2 border-0 text-muted" id="togglePassword">
                            <i data-lucide="eye" id="eyeIcon" style="width: 20px;"></i>
                        </button>
                    </div>

                    <button type="submit" class="btn btn-success btn-lg w-100 fw-bold shadow-sm py-3" id="submitBtn">
                        Sign In
                    </button>
                </form>

                <div class="mt-4 text-center">
                    <p class="small text-muted mb-0">Protected by enterprise-grade security</p>
                </div>
            </div>

        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

<script>
    // Initialize Lucide Icons
    lucide.createIcons();

    // Password Toggle Logic
    const toggleBtn = document.getElementById('togglePassword');
    const passwordInput = document.getElementById('password');
    const eyeIcon = document.getElementById('eyeIcon');

    toggleBtn.addEventListener('click', () => {
        const isPassword = passwordInput.type === 'password';
        passwordInput.type = isPassword ? 'text' : 'password';
        eyeIcon.setAttribute('data-lucide', isPassword ? 'eye-off' : 'eye');
        lucide.createIcons(); // Refresh icons
    });
</script>

</body>
</html>