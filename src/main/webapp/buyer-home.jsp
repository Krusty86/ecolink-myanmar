<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


    <header class="hero-section">
        <div class="container">
            <div class="row">
                <div class="col-lg-8">
                    <div class="d-flex align-items-center mb-3">
                        <i class="bi bi-leaf me-2"></i>
                        <span class="text-uppercase fw-semibold small tracking-wider">Sustainable Living</span>
                    </div>
                    <h1 class="display-4 fw-bold mb-4">Shop Eco-Friendly Products for a Better Tomorrow</h1>
                    <p class="lead mb-5 opacity-90">Discover our curated collection of sustainable, high-quality products that don't compromise on style or functionality.</p>
                    <div class="d-flex gap-3">
                        <a href="#" class="btn btn-light btn-lg px-4 py-2 text-success fw-bold">Shop Now <i class="bi bi-arrow-right ms-2"></i></a>
                        <a href="#" class="btn btn-outline-light btn-lg px-4 py-2">Learn More</a>
                    </div>
                </div>
            </div>
        </div>
    </header>

    <section class="container py-5 my-5">
        <div class="mb-5">
            <h2 class="fw-bold">Featured Products</h2>
            <p class="text-muted">Handpicked sustainable products you'll love</p>
        </div>
        
        <div class="row g-4" id="product-grid"></div>

        <div class="text-center mt-5">
            <button class="btn btn-primary btn-lg px-5">View All Products <i class="bi bi-arrow-right ms-2"></i></button>
        </div>
    </section>

    <section class="bg-light py-5 border-top border-bottom">
        <div class="container py-4">
            <h2 class="text-center fw-bold mb-5">Why Choose EcoShop?</h2>
            <div class="row text-center g-4">
                <div class="col-md-4">
                    <div class="feature-icon"><i class="bi bi-leaf-fill fs-3"></i></div>
                    <h3 class="h5 fw-bold">Sustainable</h3>
                    <p class="text-muted">All products are sourced responsibly from eco-conscious manufacturers</p>
                </div>
                <div class="col-md-4">
                    <div class="feature-icon"><i class="bi bi-star-fill fs-3"></i></div>
                    <h3 class="h5 fw-bold">High Quality</h3>
                    <p class="text-muted">We only stock premium products that last and perform exceptionally</p>
                </div>
                <div class="col-md-4">
                    <div class="feature-icon"><i class="bi bi-tag-fill fs-3"></i></div>
                    <h3 class="h5 fw-bold">Fair Prices</h3>
                    <p class="text-muted">Affordable sustainable living without the premium price tag</p>
                </div>
            </div>
        </div>
    </section>



    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="script.js"></script>
</body>
</html>