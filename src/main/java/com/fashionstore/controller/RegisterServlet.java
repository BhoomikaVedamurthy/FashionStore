package com.fashionstore.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import org.mindrot.jbcrypt.BCrypt;

import com.fashionstore.util.DBConnection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        request.getRequestDispatcher("/WEB-INF/views/register.jsp")
               .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String fullName = trim(request.getParameter("full_name"));
        String email = trim(request.getParameter("email"));
        String phone = trim(request.getParameter("phone"));
        String password = request.getParameter("password");

        String address1 = trim(request.getParameter("address_line1"));
        String address2 = trim(request.getParameter("address_line2"));
        String city = trim(request.getParameter("city"));
        String state = trim(request.getParameter("state"));
        String pincode = trim(request.getParameter("pincode"));
        String country = trim(request.getParameter("country"));

        if (fullName == null || email == null || phone == null
                || password == null || address1 == null
                || city == null || state == null
                || pincode == null || country == null
                || fullName.isEmpty() || email.isEmpty()
                || phone.isEmpty() || password.isEmpty()
                || address1.isEmpty() || city.isEmpty()
                || state.isEmpty() || pincode.isEmpty()
                || country.isEmpty()) {

            showError(request, response,
                    "Please fill in all required fields.");
            return;
        }

        if (fullName.length() > 100 || email.length() > 100
                || phone.length() > 15 || address1.length() > 150
                || (address2 != null && address2.length() > 150)
                || city.length() > 100 || state.length() > 100
                || pincode.length() > 10 || country.length() > 100) {

            showError(request, response,
                    "One or more fields exceed the allowed length.");
            return;
        }

        if (!email.matches("^[^\\s@]+@[^\\s@]+\\.[^\\s@]+$")) {
            showError(request, response,
                    "Please enter a valid email address.");
            return;
        }

        if (password.length() < 8 || password.length() > 72) {
            showError(request, response,
                    "Password must contain 8 to 72 characters.");
            return;
        }

        if (!phone.matches("^[0-9+() -]{7,15}$")) {
            showError(request, response,
                    "Please enter a valid phone number.");
            return;
        }

        if (!pincode.matches("^[A-Za-z0-9 -]{3,10}$")) {
            showError(request, response,
                    "Please enter a valid PIN code.");
            return;
        }

        String sql = "INSERT INTO users "
                + "(full_name, email, phone, password, "
                + "address_line1, address_line2, city, state, "
                + "pincode, country) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        String hashedPassword = BCrypt.hashpw(
                password, BCrypt.gensalt(12));

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, fullName);
            ps.setString(2, email);
            ps.setString(3, phone);
            ps.setString(4, hashedPassword);
            ps.setString(5, address1);
            ps.setString(6,
                    address2 == null || address2.isEmpty()
                            ? null : address2);
            ps.setString(7, city);
            ps.setString(8, state);
            ps.setString(9, pincode);
            ps.setString(10, country);

            ps.executeUpdate();

            response.sendRedirect(
                    request.getContextPath()
                    + "/login?registered=success");

        } catch (SQLException e) {

            if ("23000".equals(e.getSQLState())
                    && e.getErrorCode() == 1062) {

                showError(request, response,
                        "That email address or phone number is already registered.");

            } else {
                throw new ServletException(
                        "Unable to register the user.", e);
            }
        }
    }

    private String trim(String value) {
        return value == null ? null : value.trim();
    }

    private void showError(HttpServletRequest request,
                           HttpServletResponse response,
                           String message)
            throws ServletException, IOException {

        request.setAttribute("errorMessage", message);

        request.getRequestDispatcher("/WEB-INF/views/register.jsp")
               .forward(request, response);
    }
}