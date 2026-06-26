<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String msg = request.getParameter("msg");
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Register - M.B Restaurant</title>
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700;800&display=swap" rel="stylesheet">
<style>
*,*::before,*::after{margin:0;padding:0;box-sizing:border-box;}
body{
    font-family:'Poppins',sans-serif;
    min-height:100vh;display:flex;
    background:#0f0f0f;
}

/* LEFT */
.left{
    flex:1;
    background:
        linear-gradient(135deg,rgba(26,10,0,0.85) 0%,rgba(20,60,30,0.8) 100%),
        url('https://images.unsplash.com/photo-1555396273-367ea4eb4db5?w=800&q=80') center/cover;
    display:flex;flex-direction:column;
    align-items:center;justify-content:center;
    padding:60px 48px;color:#fff;
    position:relative;overflow:hidden;
}
.left::before{
    content:'';position:absolute;
    width:350px;height:350px;
    background:rgba(39,174,96,0.12);
    border-radius:50%;top:-80px;right:-80px;
}
.left-content{position:relative;z-index:1;text-align:center;}
.left-logo{font-size:1.4rem;font-weight:800;color:#fff;margin-bottom:40px;}
.left-logo span{color:#e74c3c;}
.left h2{font-size:2.2rem;font-weight:800;line-height:1.2;margin-bottom:14px;}
.left h2 em{font-style:normal;color:#27ae60;}
.left p{font-size:0.88rem;color:rgba(255,255,255,0.7);line-height:1.7;margin-bottom:40px;}

/* PERKS */
.perks{display:flex;flex-direction:column;gap:14px;width:100%;}
.perk{
    display:flex;align-items:center;gap:14px;
    background:rgba(255,255,255,0.07);
    border:1px solid rgba(255,255,255,0.1);
    border-radius:14px;padding:14px 18px;
}
.perk-icon{
    width:42px;height:42px;border-radius:10px;
    background:rgba(39,174,96,0.2);
    display:flex;align-items:center;justify-content:center;
    font-size:1.2rem;flex-shrink:0;
}
.perk-text h4{font-size:0.88rem;font-weight:700;color:#fff;margin-bottom:2px;}
.perk-text p{font-size:0.72rem;color:rgba(255,255,255,0.55);}

/* RIGHT */
.right{
    width:480px;flex-shrink:0;background:#fff;
    display:flex;flex-direction:column;
    align-items:center;justify-content:center;
    padding:50px 48px;
}
.form-logo{font-size:1.5rem;font-weight:900;color:#e74c3c;margin-bottom:6px;text-align:center;}
.form-logo span{color:#333;font-weight:400;font-size:1rem;}
.form-tagline{font-size:0.8rem;color:#aaa;text-align:center;margin-bottom:28px;}
.form-title{font-size:1.4rem;font-weight:800;color:#1a1a2e;margin-bottom:4px;}
.form-sub{font-size:0.82rem;color:#aaa;margin-bottom:24px;}

.error-msg{
    background:#fee2e2;color:#dc2626;
    border:1px solid #fca5a5;border-radius:10px;
    padding:10px 16px;font-size:0.82rem;font-weight:600;
    margin-bottom:18px;display:flex;align-items:center;gap:8px;
}
.success-msg{
    background:#dcfce7;color:#16a34a;
    border:1px solid #86efac;border-radius:10px;
    padding:10px 16px;font-size:0.82rem;font-weight:600;
    margin-bottom:18px;
}

.form-group{margin-bottom:16px;}
.form-group label{
    display:block;font-size:0.78rem;font-weight:700;
    color:#555;margin-bottom:5px;
}
.form-group input{
    width:100%;padding:12px 16px;
    border:2px solid #f0f0f0;border-radius:12px;
    font-size:0.88rem;font-family:'Poppins',sans-serif;
    outline:none;background:#fafafa;transition:all 0.2s;color:#333;
}
.form-group input:focus{
    border-color:#27ae60;background:#fff;
    box-shadow:0 0 0 4px rgba(39,174,96,0.08);
}

/* PASSWORD STRENGTH */
.strength-bar{height:4px;border-radius:2px;background:#f0f0f0;margin-top:6px;overflow:hidden;}
.strength-fill{height:100%;border-radius:2px;transition:all 0.3s;width:0;}
.strength-text{font-size:0.7rem;margin-top:4px;font-weight:600;}

.submit-btn{
    width:100%;padding:14px;
    background:linear-gradient(135deg,#27ae60,#1e8449);
    color:#fff;border:none;border-radius:12px;
    font-size:1rem;font-weight:700;
    cursor:pointer;font-family:'Poppins',sans-serif;
    transition:all 0.25s;margin-top:6px;
    box-shadow:0 6px 20px rgba(39,174,96,0.35);
}
.submit-btn:hover{transform:translateY(-2px);box-shadow:0 10px 28px rgba(39,174,96,0.45);}

.terms{
    font-size:0.72rem;color:#aaa;text-align:center;
    margin-top:14px;line-height:1.6;
}
.divider{
    display:flex;align-items:center;gap:12px;
    margin:18px 0;color:#ddd;font-size:0.78rem;
}
.divider::before,.divider::after{content:'';flex:1;height:1px;background:#f0f0f0;}
.switch-text{text-align:center;font-size:0.82rem;color:#aaa;margin-top:16px;}
.switch-text a{color:#e74c3c;font-weight:700;text-decoration:none;}
.switch-text a:hover{text-decoration:underline;}

@media(max-width:860px){
    .left{display:none;}
    .right{width:100%;padding:40px 24px;}
}
</style>
</head>
<body>

<!-- LEFT -->
<div class="left">
    <div class="left-content">
        <div class="left-logo">M<span>.</span>B Restaurant</div>
        <h2>Join Us &amp; <em>Enjoy</em><br>Delicious Food</h2>
        <p>Create your free account and start ordering authentic South Indian food delivered fresh to your doorstep!</p>

        <div class="perks">
            <div class="perk">
                <div class="perk-icon">&#127381;</div>
                <div class="perk-text">
                    <h4>Free Registration</h4>
                    <p>No hidden charges 鈥� join in seconds</p>
                </div>
            </div>
            <div class="perk">
                <div class="perk-icon">&#128666;</div>
                <div class="perk-text">
                    <h4>Free Delivery above Rs.299</h4>
                    <p>Order more and save on delivery</p>
                </div>
            </div>
            <div class="perk">
                <div class="perk-icon">&#11088;</div>
                <div class="perk-text">
                    <h4>Rate &amp; Review</h4>
                    <p>Share your experience with every dish</p>
                </div>
            </div>
            <div class="perk">
                <div class="perk-icon">&#128203;</div>
                <div class="perk-text">
                    <h4>Order Tracking</h4>
                    <p>Track your order from kitchen to door</p>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- RIGHT -->
<div class="right">
    <div class="form-logo">M<span>.</span>B <span>Restaurant</span></div>
    <div class="form-tagline">Authentic South Indian Cuisine</div>

    <div class="form-title">Create Account</div>
    <div class="form-sub">Join thousands of happy food lovers!</div>

    <% if(msg != null && !msg.isEmpty()) { %>
        <% if(msg.contains("success") || msg.contains("Success")) { %>
        <div class="success-msg">&#10003; <%= msg %></div>
        <% } else { %>
        <div class="error-msg">&#10060; <%= msg %></div>
        <% } %>
    <% } %>

    <form action="RegisterServlet" method="post" style="width:100%;">
        <div class="form-group">
            <label>Full Name</label>
            <input type="text" name="name" placeholder="Enter your full name" required>
        </div>
        <div class="form-group">
            <label>Email Address</label>
            <input type="email" name="email" placeholder="Enter your email" required>
        </div>
        <div class="form-group">
            <label>Password</label>
            <input type="password" name="password" id="passInput"
                   placeholder="Create a strong password"
                   oninput="checkStrength(this.value)" required>
            <div class="strength-bar">
                <div class="strength-fill" id="strengthFill"></div>
            </div>
            <div class="strength-text" id="strengthText"></div>
        </div>
        <button type="submit" class="submit-btn">Create My Account</button>
    </form>

    <div class="terms">
        By registering you agree to our Terms of Service and Privacy Policy
    </div>

    <div class="divider">or</div>

    <div class="switch-text">
        Already have an account? <a href="login.jsp">Login Here</a>
    </div>
</div>

<script>
function checkStrength(val) {
    var fill = document.getElementById('strengthFill');
    var text = document.getElementById('strengthText');
    var score = 0;
    if(val.length >= 6) score++;
    if(val.length >= 10) score++;
    if(/[A-Z]/.test(val)) score++;
    if(/[0-9]/.test(val)) score++;
    if(/[^A-Za-z0-9]/.test(val)) score++;

    var colors = ['#ef4444','#f97316','#eab308','#22c55e','#16a34a'];
    var labels = ['Very Weak','Weak','Fair','Strong','Very Strong'];
    var widths = ['20%','40%','60%','80%','100%'];

    if(val.length === 0) { fill.style.width='0'; text.textContent=''; return; }
    var idx = Math.min(score-1, 4);
    fill.style.width = widths[idx];
    fill.style.background = colors[idx];
    text.textContent = labels[idx];
    text.style.color = colors[idx];
}
</script>

</body>
</html>