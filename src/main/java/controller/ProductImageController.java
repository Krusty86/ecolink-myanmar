package controller;

import java.io.IOException;
import java.io.File;
import java.nio.file.Path;
import java.util.Optional;

import dao.ProductImageDAO;
import entity.Product;
import entity.ProductImage;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

@WebServlet("/product-image")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024,      // 1MB
    maxFileSize = 1024 * 1024 * 5,       // 5MB
    maxRequestSize = 1024 * 1024 * 10    // 10MB
)
public class ProductImageController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            // 1. Get Product ID and optional Image ID (for updates)
            String prodIdStr = req.getParameter("productId");
            String imgIdStr = req.getParameter("imageId"); // Optional: if we are replacing a specific image
            
            if (prodIdStr == null) {
                resp.sendRedirect("admin/dashboard?mode=PRODUCTS&error=no_product");
                return;
            }
            long productId = Long.parseLong(prodIdStr);

            // 2. Get uploaded file
            Part filePart = req.getPart("image");
            if (filePart == null || filePart.getSize() == 0) {
                resp.sendRedirect("admin/dashboard?mode=PRODUCTS&error=no_file");
                return;
            }

            // Clean filename to avoid path traversal issues
            String fileName = System.currentTimeMillis() + "_" + Path.of(filePart.getSubmittedFileName()).getFileName().toString();

            // 3. Setup File Path (EcoLink Myanmar path)
            String uploadDir = "D:\\HMI Batch 5\\Year II\\Java EE\\JavaEE_WS\\ecolink-myanmar\\src\\main\\webapp\\images\\products";
            File dir = new File(uploadDir);
            if (!dir.exists()) dir.mkdirs();

            String filePath = uploadDir + File.separator + fileName;
            filePart.write(filePath); // Save physical file

            // Path for DB (relative to webapp root)
            String relativePath = "images/products/" + fileName;

            // 4. Persistence Logic
            Product product = new Product();
            product.setId(productId);


            ProductImageDAO imgDAO = new ProductImageDAO();

            boolean isUpdate =
                    imgIdStr != null &&
                    !imgIdStr.trim().isEmpty();

            if (isUpdate) {

                long imageId = Long.parseLong(imgIdStr.trim());

                ProductImage pi = new ProductImage(
                        imageId,
                        product,
                        relativePath
                );

                imgDAO.update(pi);

            } else {

                ProductImage pi = new ProductImage(
                        product,
                        relativePath
                );

                imgDAO.save(pi);
            }

            // 5. Redirect
            resp.sendRedirect("admin/home?mode=PRODUCTS&msg=upload_success");

        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect("admin/home?mode=PRODUCTS&error=upload_failed");
        }
    }
}