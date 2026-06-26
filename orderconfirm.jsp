<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%
String username = (String) session.getAttribute("username");
if (username == null) {
    response.sendRedirect("login.jsp");
    return;
}
%>
<!DOCTYPE html>
<html>
<head>
<title>Order Confirmed!</title>
<style>
* { margin:0; padding:0; box-sizing:border-box; font-family:'Arial',sans-serif; }
body {
    background:#f8f8f8;
    display:flex; align-items:center;
    justify-content:center; min-height:100vh;
}
.card {
    background:white; border-radius:20px;
    padding:50px 40px; text-align:center;
    box-shadow:0 10px 40px rgba(0,0,0,0.1);
    max-width:440px; width:90%;
}
.tick { font-size:80px; margin-bottom:16px; }
h2 { color:#27ae60; font-size:26px; margin-bottom:10px; }
.subtitle { color:#999; font-size:15px; margin-bottom:30px; line-height:1.6; }

/* Tracking Steps */
.track-box {
    background:#f8f8f8;
    border-radius:14px;
    padding:20px 24px;
    margin-bottom:28px;
    text-align:left;
}
.track-box h3 {
    font-size:14px; color:#999;
    margin-bottom:16px;
    text-transform:uppercase;
    letter-spacing:1px;
}
.track-step {
    display:flex; align-items:center;
    gap:14px; padding:10px 0;
    border-bottom:1px solid #eee;
    font-size:14px; color:#bbb;
}
.track-step:last-child { border-bottom:none; }
.track-step.done { color:#27ae60; font-weight:bold; }

.dot {
    width:14px; height:14px;
    border-radius:50%; background:#eee;
    flex-shrink:0; border:2px solid #ddd;
}
.dot.done { background:#27ae60; border-color:#27ae60; }

/* Estimated Time */
.eta-box {
    background:linear-gradient(135deg,#e74c3c,#c0392b);
    color:white; border-radius:12px;
    padding:16px 20px; margin-bottom:24px;
    display:flex; justify-content:space-between;
    align-items:center;
}
.eta-box span { font-size:14px; opacity:0.9; }
.eta-box strong { font-size:20px; }

/* Buttons */
.btn {
    display:inline-block; padding:13px 28px;
    border-radius:10px; text-decoration:none;
    font-weight:bold; font-size:15px; margin:5px;
    transition:opacity 0.2s;
}
.btn:hover { opacity:0.85; }
.btn-green  { background:#27ae60; color:white; }
.btn-grey   { background:#f0f0f0; color:#333; }
</style>
</head>
<body>
<div class="card">

    <div class="tick">✅</div>
    <h2>Order Placed!</h2>
    <p class="subtitle">
        Thank you <strong><%= username %></strong>!<br>
        Your food is being prepared 👨‍🍳
    </p>

    <!-- ETA -->
    <div class="eta-box">
        <span>⏱️ Estimated Delivery</span>
        <strong>30–40 mins</strong>
    </div>

    <!-- Order Tracking -->
    <div class="track-box">
        <h3>📦 Order Status</h3>
        <div class="track-step done">
            <div class="dot done"></div>
            ✅ Order Placed
        </div>
        <div class="track-step">
            <div class="dot"></div>
            🏪 Confirmed by Restaurant
        </div>
        <div class="track-step">
            <div class="dot"></div>
            👨‍🍳 Preparing Your Food
        </div>
        <div class="track-step">
            <div class="dot"></div>
            🛵 Out for Delivery
        </div>
        <div class="track-step">
            <div class="dot"></div>
            🎉 Delivered
        </div>
    </div>

    <a href="orderhistory.jsp" class="btn btn-green">📋 My Orders</a>
    <a href="menu.jsp" class="btn btn-grey">🍛 Order More</a>

</div>
</body>
</html>