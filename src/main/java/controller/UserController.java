package controller;

import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import dao.AddressDAO;
import dao.UserDAO;
import entity.Address;
import entity.User;
import enums.AddressType;

@WebServlet("/profile")
public class UserController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String mode = req.getParameter("mode");
        if (mode == null) mode = "VIEW";

        switch (mode) {
            case "VIEW":
                showProfile(req, resp);
                break;
            case "EDIT":
                showEditForm(req, resp);
                break;
            case "SAVEPROFILE":
                saveProfile(req, resp);
                break;
            case "ADDRESS":
                showAddresses(req, resp);
                break;
            case "SAVEADDRESS":
            	saveAddress(req, resp);
            	break;
            default:
                showProfile(req, resp);
                break;
        }
    }

 // --- Mode: EDIT (Show the update form) ---
    private void showEditForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User user = getAuthenticatedUser(req, resp);
        if (user == null) return;

        req.setAttribute("pageTitle", "Edit Account | EcoLink");
        req.setAttribute("pageContent", "edit-profile.jsp");
        req.getRequestDispatcher("layout.jsp").forward(req, resp);
    }

    // --- Mode: SAVEPROFILE (Process the update) ---
    private void saveProfile(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User user = getAuthenticatedUser(req, resp);
        if (user == null) return;

        try {
            String username = req.getParameter("username");
            String email = req.getParameter("email");
            String newPass = req.getParameter("newPassword");
            String confirmPass = req.getParameter("confirmPassword");

            // 1. Password Match Validation
            if (newPass != null && !newPass.isEmpty()) {
                if (!newPass.equals(confirmPass)) {
                    resp.sendRedirect("profile?mode=EDIT&error=pass_mismatch");
                    return;
                }
                user.setPassword(newPass);
            }

            // 2. Update object
            user.setUsername(username);
            user.setEmail(email);

            // 3. Persist to Database
            boolean success = UserDAO.update(user);

            if (success) {
                // Refresh session data
                req.getSession().setAttribute("loginUser", user);
                resp.sendRedirect("profile?mode=VIEW&msg=updated");
            } else {
                resp.sendRedirect("profile?mode=EDIT&error=update_failed");
            }
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect("profile?mode=EDIT&error=server_error");
        }
    }
    // --- Mode: VIEW (Profile Dashboard) ---
    private void showProfile(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User user = getAuthenticatedUser(req, resp);
        if (user == null) return;

        // Refresh user data (loyalty points, etc.)
        User updatedUser = UserDAO.findById(user.getId());
        if (updatedUser != null) {
            req.getSession().setAttribute("loginUser", updatedUser);
        }

        req.setAttribute("pageTitle", "My Profile | EcoLink");
        req.setAttribute("pageContent", "profile.jsp");
        req.getRequestDispatcher("layout.jsp").forward(req, resp);
    }

    // --- Mode: ADDRESS (Address Management) ---
    private void showAddresses(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User user = getAuthenticatedUser(req, resp);
        if (user == null) return;

        // Fetch all addresses for this user
        List<Address> addressList = AddressDAO.findAllByUser(user.getId());
        
        req.setAttribute("addresses", addressList);
        req.setAttribute("pageTitle", "My Addresses | EcoLink");
        req.setAttribute("pageContent", "address.jsp");
        
        req.getRequestDispatcher("layout.jsp").forward(req, resp);
    }

    // Helper to check session and return user
    private User getAuthenticatedUser(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        HttpSession session = req.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("loginUser") : null;
        if (user == null) {
            resp.sendRedirect("login.jsp");
            return null;
        }
        return user;
    }

private void saveAddress(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    User user = getAuthenticatedUser(req, resp);
    if (user == null) return;

    try {
        // 1. Extract raw data from form
        String label = req.getParameter("label");
        String street = req.getParameter("street");
        String township = req.getParameter("township");
        String city = req.getParameter("city");
        String typeStr = req.getParameter("type"); // Comes as "HOME", "WORK", or "OTHER"
        boolean isDefault = "true".equals(req.getParameter("isDefault"));

        // 2. Map to Entity
        Address addr = new Address();
        addr.setUser(user);
        addr.setLabel(label);
        addr.setStreet(street);
        addr.setTownship(township);
        addr.setCity(city);
        addr.setIs_default(isDefault);

        // --- ENUM CONVERSION ---
        // Converts the String "HOME" into AddressType.HOME
        if (typeStr != null) {
            addr.setAddress_type(AddressType.valueOf(typeStr.toUpperCase()));
        }

        // 3. Database Persistence
        // Note: If isDefault is true, your DAO should handle unsetting 
        // other defaults before saving this one.
        boolean success = AddressDAO.save(addr);

        if (success) {
            resp.sendRedirect("profile?mode=ADDRESS&msg=saved");
        } else {
            resp.sendRedirect("profile?mode=ADDRESS&error=db_failed");
        }
        
    } catch (IllegalArgumentException e) {
        // This catches if the Enum value doesn't match
        resp.sendRedirect("profile?mode=ADDRESS&error=invalid_type");
    } catch (Exception e) {
        e.printStackTrace();
        resp.sendRedirect("profile?mode=ADDRESS&error=process_failed");
    }
}
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Handle address actions like SAVE or SET_DEFAULT
        
        
        doGet(req, resp);
    }
}