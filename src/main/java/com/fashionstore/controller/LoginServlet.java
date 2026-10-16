package com.fashionstore.controller;

import org.mindrot.jbcrypt.BCrypt;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.fashionstore.util.DBConnection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        request.getRequestDispatcher("/WEB-INF/views/login.jsp")
               .forward(request, response);
    }

 
    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        if (email == null || password == null
                || email.trim().isEmpty() || password.isEmpty()) {

            response.sendRedirect(
                    request.getContextPath() + "/login?error=invalid");
            return;
        }

        String sql = "SELECT user_id, full_name, password "
                   + "FROM users WHERE email = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, email.trim());

            try (ResultSet rs = ps.executeQuery()) {

                if (rs.next()) {

                    String storedPassword = rs.getString("password");
                    boolean passwordMatches = false;

                    // Only BCrypt-hashed passwords are accepted.
                    if (storedPassword != null
                            && (storedPassword.startsWith("$2a$")
                            || storedPassword.startsWith("$2b$")
                            || storedPassword.startsWith("$2y$"))) {

                        try {
                            passwordMatches = BCrypt.checkpw(
                                    password, storedPassword);
                        } catch (IllegalArgumentException e) {
                            passwordMatches = false;
                        }
                    }

                    if (passwordMatches) {

                        HttpSession session = request.getSession();

                        // Prevent session fixation: issue a new session ID.
                        request.changeSessionId();

                        session.setAttribute(
                                "userId", rs.getInt("user_id"));

                        session.setAttribute(
                                "fullName", rs.getString("full_name"));

                        response.sendRedirect(
                                request.getContextPath() + "/home");

                    } else {
                        response.sendRedirect(
                                request.getContextPath()
                                + "/login?error=invalid");
                    }

                } else {
                    response.sendRedirect(
                            request.getContextPath()
                            + "/login?error=invalid");
                }
            }

        } catch (SQLException e) {
            throw new ServletException(
                    "Unable to process login.", e);
        }
    }
}