<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%
String username = (String) session.getAttribute("username");
if (username == null) {
    response.sendRedirect("login.jsp");
    return;
}
String total = request.getParameter("total");
if(total == null) total = "0";
%>
<!DOCTYPE html>
<html>
<head>
<title>Checkout - M.B Restaurant</title>
<style>
* { margin:0; padding:0; box-sizing:border-box; font-family:'Arial',sans-serif; }
body { background:#f8f8f8; }

.navbar {
    background:white; padding:15px 30px;
    display:flex; justify-content:space-between; align-items:center;
    box-shadow:0 2px 10px rgba(0,0,0,0.1);
}
.navbar h1 { color:#e74c3c; font-size:22px; }

.container {
    max-width:580px;
    margin:40px auto;
    padding:0 20px;
}

/* Progress Steps */
.steps {
    display:flex; justify-content:center;
    align-items:center; gap:8px;
    margin-bottom:30px;
}
.step {
    display:flex; align-items:center;
    gap:6px; font-size:13px;
    color:#bbb; font-weight:bold;
}
.step.active { color:#e74c3c; }
.step-num {
    width:28px; height:28px;
    border-radius:50%; background:#eee;
    display:flex; align-items:center;
    justify-content:center;
    font-size:13px; font-weight:bold;
}
.step.active .step-num { background:#e74c3c; color:white; }
.step-line { width:35px; height:2px; background:#eee; }

.card {
    background:white; border-radius:16px;
    padding:36px;
    box-shadow:0 4px 20px rgba(0,0,0,0.1);
}
.card h2 { font-size:22px; color:#333; margin-bottom:6px; }
.card p  { color:#999; font-size:14px; margin-bottom:28px; }

.form-group { margin-bottom:18px; }
.form-group label {
    display:block; font-size:13px;
    font-weight:bold; color:#555;
    margin-bottom:6px;
}
.form-group input,
.form-group textarea {
    width:100%; padding:12px 16px;
    border:2px solid #eee;
    border-radius:10px; font-size:15px;
    outline:none; transition:border 0.2s;
    font-family:'Arial',sans-serif;
}
.form-group input:focus,
.form-group textarea:focus { border-color:#e74c3c; }
.form-group textarea { resize:none; height:85px; }

.form-row {
    display:grid;
    grid-template-columns:1fr 1fr;
    gap:14px;
}

.total-box {
    background:#fff5f5;
    border:2px solid #e74c3c;
    border-radius:12px;
    padding:16px 20px;
    margin:24px 0;
    display:flex;
    justify-content:space-between;
    align-items:center;
}
.total-box span { font-size:16px; font-weight:bold; color:#333; }
.total-box strong { font-size:24px; color:#e74c3c; }

.place-btn {
    width:100%; background:#e74c3c;
    color:white; border:none;
    padding:16px; border-radius:12px;
    font-size:18px; font-weight:bold;
    cursor:pointer; transition:background 0.2s;
}
.place-btn:hover { background:#c0392b; }
</style>
</head>
<body>

<div class="navbar">
    <h1>🍕 M.B Restaurant</h1>
    <span style="color:#666;">👋 <%= username %></span>
</div>

<div class="container">

    <!-- Steps -->
    <div class="steps">
        <div class="step">
            <div class="step-num">1</div> Cart
        </div>
        <div class="step-line"></div>
        <div class="step active">
            <div class="step-num">2</div> Address
        </div>
        <div class="step-line"></div>
        <div class="step">
            <div class="step-num">3</div> Done
        </div>
    </div>

    <div class="card">
        <h2>🏠 Delivery Address</h2>
        <p>Where should we deliver your order?</p>

        <form action="PlaceOrderServlet" method="post">
            <input type="hidden" name="total" value="<%= total %>">

            <div class="form-group">
                <label>📱 Mobile Number *</label>
                <input type="tel" name="phone"
                       placeholder="10-digit mobile number"
                       maxlength="10" required>
            </div>

            <div class="form-group">
                <label>🏠 Full Address *</label>
                <textarea name="delivery_address"
                    placeholder="House No, Street, Area, Landmark..."
                    required></textarea>
            </div>

            <div class="form-row">
                <div class="form-group">
                    <label>🏙️ City *</label>
                    <input type="text" name="city"
                           placeholder="Your city" required>
                </div>
                <div class="form-group">
                    <label>📮 Pincode *</label>
                    <input type="text" name="pincode"
                           placeholder="6-digit pincode"
                           maxlength="6" required>
                </div>
            </div>

            <div class="total-box">
                <span>💰 Total Amount</span>
                <strong>₹<%= total %></strong>
            </div>

            <button type="submit" class="place-btn">
                🛵 Place Order
            </button>
        </form>
    </div>
</div>

</body>
</html>