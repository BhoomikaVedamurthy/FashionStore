<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Login - FashionStore</title>

    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f5f5f5;
            margin: 0;
            padding: 0;
        }

        .login-container {
            width: 350px;
            margin: 100px auto;
            padding: 30px;
            background: white;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        h2 {
            text-align: center;
            margin-bottom: 25px;
        }

        label {
            display: block;
            margin-top: 15px;
        }

        input {
            width: 100%;
            padding: 10px;
            margin-top: 5px;
            box-sizing: border-box;
        }

        button {
            width: 100%;
            padding: 12px;
            margin-top: 25px;
            background: #222;
            color: white;
            border: none;
            cursor: pointer;
        }

        button:hover {
            background: #444;
        }

        .error {
            color: red;
            text-align: center;
        }
    </style>
</head>

<body>

    <div class="login-container">

        <h2>Login to FashionStore</h2>

        <% if ("invalid".equals(request.getParameter("error"))) { %>
            <p class="error">Invalid email or password.</p>
        <% } %>
        
        <% if ("success".equals(request.getParameter("registered"))) { %>
    <p style="color: green; text-align: center;">
        Registration successful! Please log in.
    </p>
<% } %>

        <form action="${pageContext.request.contextPath}/login"
              method="post">

            <label for="email">Email</label>
            <input type="email"
                   id="email"
                   name="email"
                   required>

            <label for="password">Password</label>
            <input type="password"
                   id="password"
                   name="password"
                   required>

            <button type="submit">Login</button>

        </form>
        
        <p style="text-align: center; margin-top: 20px;">
    Don't have an account?
    <a href="${pageContext.request.contextPath}/register"
       style="color: #222; font-weight: bold;">
        Create Account
    </a>
</p>

    </div>

</body>
</html>