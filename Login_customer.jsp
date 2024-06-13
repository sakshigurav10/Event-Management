<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login Page</title>
    <link rel="stylesheet" href="Signup_css.css" />
    <link rel="stylesheet" href="https://unicons.iconscout.com/release/v4.0.8/css/line.css">
</head>
<body>
    <section class="home">
    <div class="form_items">
    <div class="login_form">
        <form action="login" method="post">
            <h2>Login</h2>
            <div id="error-message">
                <c:if test="${not empty errorMessage}">
                    <span style="color: red;">${errorMessage}</span>
                </c:if>
            </div>
            <div class="inp"><input type="email" name = "email" placeholder="Enter your email" required />
            <i class="uil uil-envelope-alt email"></i></div>
            <div class="inp"><input type="password" name ="password" placeholder="Create password" required />
            <i class="uil uil-lock password"></i>
            <i class="uil uil-eye-slash pw_hide"></i></div>

            <div class="b1"><button class="button" > Login</button></div>
            <div class="login">Don't have an account? <a href="Signup_customer.html" id="signup">Sign Up</a></div>
        </form>
    </div>
    </div>
    </section>
    <script src="signup_js.js"></script>

    <script>

        document.getElementById("validateButton").addEventListener("click", function() {
        var createPassword = document.getElementById("createPassword").value;
        var confirmPassword = document.getElementById("confirmPassword").value;

        if (createPassword !== confirmPassword) {
            alert("Passwords do not match. Please try again.");
        } else {
            // Perform validation logic here, if needed
            // You can also set a flag to indicate the form is validated
            // For example: var isFormValid = true;
        }
        });
    </script>
</body>
</html>
