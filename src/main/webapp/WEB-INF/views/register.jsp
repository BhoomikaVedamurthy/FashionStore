<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Create Account | FashionStore</title>

    <style>
        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background: #f5f3f0;
            color: #222;
        }

        .container {
            width: 90%;
            max-width: 650px;
            margin: 40px auto;
            padding: 30px;
            background: white;
            border-radius: 10px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.08);
        }

        h1 {
            text-align: center;
            margin-bottom: 10px;
        }

        .subtitle {
            text-align: center;
            color: #666;
            margin-bottom: 25px;
        }

        .form-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 16px;
        }

        .form-group {
            display: flex;
            flex-direction: column;
        }

        .full-width {
            grid-column: 1 / -1;
        }

        label {
            margin-bottom: 6px;
            font-size: 14px;
            font-weight: bold;
        }

        input {
            width: 100%;
            padding: 11px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 14px;
        }

        input:focus {
            outline: none;
            border-color: #222;
        }

        .submit-btn {
            width: 100%;
            padding: 13px;
            margin-top: 22px;
            background: #222;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
        }

        .submit-btn:hover {
            background: #444;
        }

        .login-link {
            text-align: center;
            margin-top: 18px;
        }

        .login-link a {
            color: #222;
            font-weight: bold;
        }

        .message {
            color: #b00020;
            text-align: center;
            margin-bottom: 15px;
        }

        @media (max-width: 550px) {
            .form-grid {
                grid-template-columns: 1fr;
            }

            .full-width {
                grid-column: auto;
            }

            .container {
                padding: 20px;
                margin: 20px auto;
            }
        }
    </style>
</head>

<body>

    <div class="container">

        <h1>Create Account</h1>

        <p class="subtitle">
            Join FashionStore and discover your style.
        </p>

        <% if (request.getAttribute("errorMessage") != null) { %>
            <p class="message">
                <%= org.apache.taglibs.standard.functions
                        .Functions.escapeXml(
                            String.valueOf(request.getAttribute("errorMessage"))
                        ) %>
            </p>
        <% } %>

        <form action="${pageContext.request.contextPath}/register"
              method="post">

            <div class="form-grid">

                <div class="form-group">
                    <label for="fullName">Full Name *</label>
                    <input type="text" id="fullName" name="full_name"
                           maxlength="100" autocomplete="name"
                           required>
                </div>

                <div class="form-group">
                    <label for="phone">Phone Number *</label>
                    <input type="tel" id="phone" name="phone"
                           maxlength="15" autocomplete="tel"
                           required>
                </div>

                <div class="form-group full-width">
                    <label for="email">Email Address *</label>
                    <input type="email" id="email" name="email"
                           maxlength="100" autocomplete="email"
                           required>
                </div>

                <div class="form-group full-width">
                    <label for="password">Password *</label>
                    <input type="password" id="password" name="password"
                           minlength="8" autocomplete="new-password"
                           required>
                </div>

                <div class="form-group full-width">
                    <label for="address1">Address Line 1 *</label>
                    <input type="text" id="address1" name="address_line1"
                           maxlength="150" autocomplete="address-line1"
                           required>
                </div>

                <div class="form-group full-width">
                    <label for="address2">Address Line 2</label>
                    <input type="text" id="address2" name="address_line2"
                           maxlength="150" autocomplete="address-line2">
                </div>

                <div class="form-group">
                    <label for="city">City *</label>
                    <input type="text" id="city" name="city"
                           maxlength="100" autocomplete="address-level2"
                           required>
                </div>

                <div class="form-group">
                    <label for="state">State *</label>
                    <input type="text" id="state" name="state"
                           maxlength="100" autocomplete="address-level1"
                           required>
                </div>

                <div class="form-group">
                    <label for="pincode">PIN Code *</label>
                    <input type="text" id="pincode" name="pincode"
                           maxlength="10" autocomplete="postal-code"
                           required>
                </div>

                <div class="form-group">
                    <label for="country">Country *</label>
                    <input type="text" id="country" name="country"
                           value="India" maxlength="100"
                           autocomplete="country-name" required>
                </div>

            </div>

            <button type="submit" class="submit-btn">
                Create Account
            </button>

        </form>

        <p class="login-link">
            Already have an account?
            <a href="${pageContext.request.contextPath}/login">
                Log in
            </a>
        </p>

    </div>

</body>
</html>