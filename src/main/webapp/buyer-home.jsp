<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>
:root {
    --eco-dark: #1b4332;
    --eco-green: #2d6a4f;
    --eco-light: #d8f3dc;
    --eco-accent: #95d5b2;
}

body {
    background-color: #fcfdfc;
    font-family: 'Inter', sans-serif;
}

/* Hero Section with Glassmorphism */
.hero-section {
    background: linear-gradient(135deg, rgba(27, 67, 50, 0.9), rgba(45, 106, 79, 0.8)), 
                url('https://images.unsplash.com/photo-1542601906990-b4d3fb773b09?auto=format&fit=crop&q=80');
    background-size: cover;
    background-position: center;
    padding: 120px 0;
    color: white;
    border-radius: 0 0 50px 50px;
}

.tracking-wider { letter-spacing: 0.1em; }

/* Feature Icons with Soft Circles */
.feature-icon {
    width: 70px;
    height: 70px;
    background: var(--eco-light);
    color: var(--eco-green);
    display: flex;
    align-items: center;
    justify-content: center;
    border-radius: 20px;
    margin: 0 auto 20px;
    transition: all 0.3s ease;
}

.feature-card:hover .feature-icon {
    background: var(--eco-green);
    color: white;
    transform: translateY(-5px) rotate(5deg);
}

.btn-eco-primary {
    background-color: var(--eco-green);
    color: white;
    border: none;
    border-radius: 50px;
    transition: all 0.3s;
}

.btn-eco-primary:hover {
    background-color: var(--eco-dark);
    transform: scale(1.05);
    color: white;
}
</style>

    <header class="hero-section shadow-lg">
    <div class="container">
        <div class="row align-items-center">
            <div class="col-lg-7">
                <div class="d-flex align-items-center mb-3 animate__animated animate__fadeInDown">
                    <i class="bi bi-patch-check-fill text-accent me-2"></i>
                    <span class="text-uppercase fw-bold small tracking-wider opacity-75">Eco-Friendly Marketplace</span>
                </div>
                <h1 class="display-3 fw-bold mb-4">Live Sustainably,<br><span class="text-accent">Shop Consciously.</span></h1>
                <p class="lead mb-5 opacity-90 fs-4">Join thousands making a difference. High-quality products designed for your lifestyle and the planet.</p>
                <div class="d-flex gap-3">
                    <a href="products" class="btn btn-light btn-lg px-5 py-3 text-success fw-bold rounded-pill shadow">Shop Collection</a>
                    <a href="#about" class="btn btn-outline-light btn-lg px-5 py-3 rounded-pill">Our Mission</a>
                </div>
            </div>
        </div>
    </div>
</header>

<section class="container py-5 my-5">
    <div class="d-flex justify-content-between align-items-end mb-5">
        <div>
            <h2 class="fw-bold display-6">Featured Arrivals</h2>
            <p class="text-muted fs-5">Handpicked sustainable products for your home.</p>
        </div>
        <a href="products" class="btn btn-link text-success fw-bold text-decoration-none">View All <i class="bi bi-chevron-right"></i></a>
    </div>
    
    <div class="row g-4" id="product-grid">
        </div>
</section>

<section class="bg-white py-5 position-relative overflow-hidden">
    <div class="container py-5">
        <div class="text-center mb-5">
            <h2 class="fw-bold display-6">Why Choose EcoLink?</h2>
            <div class="mx-auto bg-success" style="height: 4px; width: 60px; border-radius: 2px;"></div>
        </div>
        <div class="row g-4">
            <div class="col-md-4 text-center feature-card">
                <div class="feature-icon shadow-sm"><i class="bi bi-tree-fill fs-3"></i></div>
                <h4 class="fw-bold text-dark">Ethically Sourced</h4>
                <p class="text-muted px-lg-4">Responsibly manufactured with zero-waste principles at every step.</p>
            </div>
            <div class="col-md-4 text-center feature-card">
                <div class="feature-icon shadow-sm"><i class="bi bi-shield-lock-fill fs-3"></i></div>
                <h4 class="fw-bold text-dark">Carbon Neutral</h4>
                <p class="text-muted px-lg-4">We offset 100% of the carbon emissions from every delivery we make.</p>
            </div>
            <div class="col-md-4 text-center feature-card">
                <div class="feature-icon shadow-sm"><i class="bi bi-currency-exchange fs-3"></i></div>
                <h4 class="fw-bold text-dark">Transparent Pricing</h4>
                <p class="text-muted px-lg-4">Fair trade prices that support artisans while remaining accessible to you.</p>
            </div>
        </div>
    </div>
</section>



    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="script.js"></script>
