<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String msg = request.getParameter("msg");
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Login - M.B Restaurant</title>
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700;800&display=swap" rel="stylesheet">
<style>
*,*::before,*::after{margin:0;padding:0;box-sizing:border-box;}
body{
    font-family:'Poppins',sans-serif;
    min-height:100vh;
    display:flex;
    background:#0f0f0f;
}

/* LEFT PANEL */
.left{
    flex:1;
    background:
        linear-gradient(135deg,rgba(26,10,0,0.88) 0%,rgba(180,40,30,0.75) 100%),
        url('https://images.unsplash.com/photo-1563379091339-03b21ab4a4f8?w=800&q=80') center/cover;
    display:flex;flex-direction:column;
    align-items:center;justify-content:center;
    padding:60px 48px;color:#fff;
    position:relative;overflow:hidden;
}
.left::before{
    content:'';position:absolute;
    width:400px;height:400px;
    background:rgba(231,76,60,0.15);
    border-radius:50%;top:-100px;left:-100px;
}
.left::after{
    content:'';position:absolute;
    width:300px;height:300px;
    background:rgba(231,76,60,0.1);
    border-radius:50%;bottom:-80px;right:-80px;
}
.left-content{position:relative;z-index:1;text-align:center;}
.left-logo{
    font-size:1.4rem;font-weight:800;color:#fff;
    margin-bottom:40px;letter-spacing:-0.5px;
}
.left-logo span{color:#e74c3c;}
.left h2{font-size:2.4rem;font-weight:800;line-height:1.2;margin-bottom:16px;}
.left h2 em{font-style:normal;color:#f5a623;}
.left p{font-size:0.9rem;color:rgba(255,255,255,0.7);line-height:1.7;margin-bottom:40px;}

/* DISH CARDS */
.dish-cards{display:flex;flex-direction:column;gap:12px;width:100%;}
.dish-card{
    background:rgba(255,255,255,0.08);
    border:1px solid rgba(255,255,255,0.12);
    border-radius:14px;padding:14px 18px;
    display:flex;align-items:center;gap:14px;
    backdrop-filter:blur(10px);
}
.dish-img{
    width:52px;height:52px;border-radius:10px;
    object-fit:cover;flex-shrink:0;
}
.dish-info h4{font-size:0.88rem;font-weight:700;color:#fff;margin-bottom:2px;}
.dish-info p{font-size:0.72rem;color:rgba(255,255,255,0.55);}
.dish-price{margin-left:auto;font-size:0.9rem;font-weight:800;color:#f5a623;}

/* RIGHT PANEL */
.right{
    width:460px;flex-shrink:0;
    background:#fff;
    display:flex;flex-direction:column;
    align-items:center;justify-content:center;
    padding:60px 48px;
}
.form-logo{
    font-size:1.6rem;font-weight:900;color:#e74c3c;
    margin-bottom:8px;text-align:center;
}
.form-logo span{color:#333;font-weight:400;font-size:1rem;}
.form-tagline{font-size:0.8rem;color:#aaa;text-align:center;margin-bottom:36px;}

.form-title{font-size:1.5rem;font-weight:800;color:#1a1a2e;margin-bottom:6px;}
.form-sub{font-size:0.82rem;color:#aaa;margin-bottom:28px;}

/* ERROR MSG */
.error-msg{
    background:#fee2e2;color:#dc2626;
    border:1px solid #fca5a5;border-radius:10px;
    padding:10px 16px;font-size:0.82rem;
    font-weight:600;margin-bottom:20px;
    display:flex;align-items:center;gap:8px;
}

/* FORM */
.form-group{margin-bottom:18px;}
.form-group label{
    display:block;font-size:0.78rem;font-weight:700;
    color:#555;margin-bottom:6px;letter-spacing:0.3px;
}
.form-group input{
    width:100%;padding:13px 16px;
    border:2px solid #f0f0f0;border-radius:12px;
    font-size:0.9rem;font-family:'Poppins',sans-serif;
    outline:none;background:#fafafa;
    transition:all 0.2s;color:#333;
}
.form-group input:focus{
    border-color:#e74c3c;background:#fff;
    box-shadow:0 0 0 4px rgba(231,76,60,0.08);
}

.submit-btn{
    width:100%;padding:14px;
    background:linear-gradient(135deg,#e74c3c,#c0392b);
    color:#fff;border:none;border-radius:12px;
    font-size:1rem;font-weight:700;
    cursor:pointer;font-family:'Poppins',sans-serif;
    transition:all 0.25s;margin-top:6px;
    box-shadow:0 6px 20px rgba(231,76,60,0.35);
}
.submit-btn:hover{transform:translateY(-2px);box-shadow:0 10px 28px rgba(231,76,60,0.45);}

.divider{
    display:flex;align-items:center;gap:12px;
    margin:20px 0;color:#ddd;font-size:0.78rem;
}
.divider::before,.divider::after{content:'';flex:1;height:1px;background:#f0f0f0;}

.switch-text{
    text-align:center;font-size:0.82rem;color:#aaa;margin-top:20px;
}
.switch-text a{color:#e74c3c;font-weight:700;text-decoration:none;}
.switch-text a:hover{text-decoration:underline;}

/* FEATURES */
.features{display:flex;gap:16px;margin-bottom:32px;flex-wrap:wrap;}
.feature{
    flex:1;min-width:100px;
    background:#fff8f8;border:1px solid #fde8e8;
    border-radius:12px;padding:12px 10px;text-align:center;
}
.feature-icon{font-size:1.3rem;margin-bottom:4px;}
.feature-text{font-size:0.7rem;color:#888;font-weight:600;}

@media(max-width:860px){
    .left{display:none;}
    .right{width:100%;padding:40px 28px;}
}
</style>
</head>
<body>

<!-- LEFT PANEL -->
<div class="left">
    <div class="left-content">
        <div class="left-logo">M<span>.</span>B Restaurant</div>
        <h2>Taste the <em>Tradition</em></h2>
        <p>Authentic South Indian cuisine delivered fresh to your table. Order from our wide variety of biryanis, dosas, tiffins and more!</p>

        <div class="dish-cards">
            <div class="dish-card">
                <img class="dish-img" src="https://images.unsplash.com/photo-1563379091339-03b21ab4a4f8?w=200&q=80" alt="Biryani">
                <div class="dish-info">
                    <h4>Chicken Dum Biryani</h4>
                    <p>Aromatic basmati with tender chicken</p>
                </div>
                <div class="dish-price">&#8377;220</div>
            </div>
            <div class="dish-card">
                <img class="dish-img" src="https://images.unsplash.com/photo-1668236543090-82eba5ee5976?w=200&q=80" alt="Dosa">
                <div class="dish-info">
                    <h4>Masala Dosa</h4>
                    <p>Crispy crepe with spiced potato filling</p>
                </div>
                <div class="dish-price">&#8377;80</div>
            </div>
            <div class="dish-card">
                <img class="dish-img" src="https://images.unsplash.com/photo-1630383249896-424e482df921?w=200&q=80" alt="Idli">
                <div class="dish-info">
                    <h4>Idli Sambar</h4>
                    <p>Soft steamed cakes with sambar</p>
                </div>
                <div class="dish-price">&#8377;60</div>
            </div>
        </div>
    </div>
</div>

<!-- RIGHT PANEL -->
<div class="right">
    <div class="form-logo">M<span>.</span>B <span>Restaurant</span></div>
    <div class="form-tagline">Your favourite food, just a click away</div>

    <div class="features">
        <div class="feature">
            <div class="feature-icon">&#9733;</div>
            <div class="feature-text">4.8 Rated</div>
        </div>
        <div class="feature">
            <div class="feature-icon">&#9200;</div>
            <div class="feature-text">30 Min Delivery</div>
        </div>
        <div class="feature">
            <div class="feature-icon">&#127829;</div>
            <div class="feature-text">50+ Items</div>
        </div>
    </div>

    <div class="form-title">Welcome Back!</div>
    <div class="form-sub">Login to your account to order food</div>

    <% if(msg != null && !msg.isEmpty()) { %>
    <div class="error-msg">&#10060; <%= msg %></div>
    <% } %>

    <form action="LoginServlet" method="post" style="width:100%;">
        <div class="form-group">
            <label>Email Address</label>
            <input type="email" name="email" placeholder="Enter your email" required>
        </div>
        <div class="form-group">
            <label>Password</label>
            <input type="password" name="password" placeholder="Enter your password" required>
        </div>
        <button type="submit" class="submit-btn">Login to M.B Restaurant</button>
    </form>

    <div class="divider">or</div>

    <div class="switch-text">
        Don't have an account? <a href="register.jsp">Register Free</a>
    </div>
    <div class="switch-text" style="margin-top:8px;">
        <a href="adminlogin.jsp" style="color:#888;font-size:0.75rem;">Admin Login</a>
    </div>
</div>

</body>
</html>