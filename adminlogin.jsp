<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<html>
<head>
<title>Admin Login</title>
<style>
* { margin:0; padding:0; box-sizing:border-box; font-family:Arial,sans-serif; }
body {
    min-height: 100vh;
    background: linear-gradient(135deg, #1a1a2e, #16213e, #0f3460);
    display: flex;
    align-items: center;
    justify-content: center;
}
.container {
    width: 400px;
    background: white;
    padding: 40px;
    border-radius: 20px;
    box-shadow: 0 25px 70px rgba(0,0,0,0.5);
    text-align: center;
}
.logo { font-size: 55px; margin-bottom: 10px; }
h2 { color: #1a1a2e; margin-bottom: 5px; }
h3 { color: #666; margin-bottom: 25px; font-size: 16px; }
.input-group { margin-bottom: 20px; text-align: left; }
.input-group label { display:block; color:#444; font-weight:bold; margin-bottom:7px; }
input[type="text"], input[type="password"] {
    width: 100%;
    padding: 13px 15px;
    border: 2px solid #eee;
    border-radius: 10px;
    font-size: 15px;
}
input:focus { border-color:#0f3460; outline:none; }
.btn-submit {
    width: 100%;
    padding: 15px;
    background: linear-gradient(135deg, #0f3460, #16213e);
    color: white;
    border: none;
    border-radius: 10px;
    font-size: 17px;
    font-weight: bold;
    cursor: pointer;
}
.error { color:red; margin-bottom:15px; }
.back-link { margin-top:20px; display:block; color:#0f3460; text-decoration:none; }
</style>
</head>
<body>
<div class="container">
    <div class="logo">👨‍💼</div>
    <h2>Admin Panel</h2>
    <h3>Sai's Kitchen Management</h3>

    <p class="error">
        <%= request.getParameter("error") != null ? "❌ Invalid credentials!" : "" %>
    </p>

    <form action="AdminLoginServlet" method="post">
        <div class="input-group">
            <label>👤 Admin Username</label>
            <input type="text" name="username" placeholder="Enter username">
        </div>
        <div class="input-group">
            <label>🔒 Password</label>
            <input type="password" name="password" placeholder="Enter password">
        </div>
        <input type="submit" value="🔐 Login as Admin" class="btn-submit">
    </form>

    <a href="login.jsp" class="back-link">← Back to User Login</a>
</div>
</body>
</html>