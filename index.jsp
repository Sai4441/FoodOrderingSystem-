<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>M.B Restaurant - Taste the Tradition</title>
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700;800;900&display=swap" rel="stylesheet">
<style>
*,*::before,*::after{margin:0;padding:0;box-sizing:border-box;}
:root{--red:#e74c3c;--dark:#1a0a00;--gold:#f5a623;--white:#fff;}
body{font-family:'Poppins',sans-serif;overflow-x:hidden;}

/* NAVBAR */
.nav{
    position:fixed;top:0;left:0;right:0;z-index:100;
    display:flex;align-items:center;justify-content:space-between;
    padding:16px 48px;
    background:rgba(26,10,0,0.88);
    backdrop-filter:blur(14px);
}
.nav-logo{font-size:1.5rem;font-weight:900;color:#fff;letter-spacing:-0.5px;}
.nav-logo span{color:var(--red);}
.nav-links{display:flex;gap:10px;}
.nav-links a{
    text-decoration:none;font-size:0.85rem;font-weight:600;
    padding:9px 22px;border-radius:50px;transition:all 0.25s;
}
.btn-login{color:#fff;border:1.5px solid rgba(255,255,255,0.35);}
.btn-login:hover{border-color:var(--red);color:var(--red);}
.btn-reg{background:var(--red);color:#fff;}
.btn-reg:hover{background:#c0392b;transform:translateY(-1px);}

/* HERO */
.hero{
    min-height:100vh;
    background:
        linear-gradient(to bottom,rgba(26,10,0,0.75) 0%,rgba(26,10,0,0.4) 50%,rgba(26,10,0,0.82) 100%),
        url('https://images.unsplash.com/photo-1585937421612-70a008356fbe?w=1600&q=80') center/cover no-repeat;
    display:flex;flex-direction:column;align-items:center;
    justify-content:center;text-align:center;
    padding:120px 24px 100px;position:relative;
}
.hero-badge{
    display:inline-flex;align-items:center;gap:8px;
    background:rgba(232,97,44,0.2);border:1px solid rgba(232,97,44,0.5);
    border-radius:50px;padding:7px 20px;
    font-size:0.75rem;font-weight:700;color:var(--gold);
    letter-spacing:1.5px;text-transform:uppercase;margin-bottom:24px;
}
.hero h1{
    font-size:clamp(2.8rem,7vw,5.5rem);font-weight:900;
    color:#fff;line-height:1.05;max-width:800px;margin-bottom:18px;
}
.hero h1 em{font-style:normal;color:var(--red);}
.hero p{
    font-size:1.05rem;color:rgba(255,255,255,0.72);
    max-width:500px;line-height:1.75;margin-bottom:40px;
}
.hero-btns{display:flex;gap:14px;flex-wrap:wrap;justify-content:center;margin-bottom:60px;}
.cta-main{
    text-decoration:none;background:var(--red);color:#fff;
    font-weight:700;font-size:1rem;padding:15px 38px;
    border-radius:50px;transition:all 0.25s;
    box-shadow:0 8px 30px rgba(231,76,60,0.45);
}
.cta-main:hover{background:#c0392b;transform:translateY(-2px);}
.cta-sec{
    text-decoration:none;color:#fff;font-weight:600;
    font-size:1rem;padding:15px 38px;border-radius:50px;
    border:1.5px solid rgba(255,255,255,0.4);transition:all 0.25s;
}
.cta-sec:hover{border-color:#fff;background:rgba(255,255,255,0.08);}

/* STATS FLOATING BAR */
.stats{
    display:flex;gap:0;
    background:#fff;border-radius:18px;
    box-shadow:0 20px 60px rgba(0,0,0,0.18);
    overflow:hidden;
}
.stat{
    padding:20px 36px;text-align:center;
    border-right:1px solid #f0f0f0;
}
.stat:last-child{border-right:none;}
.stat-num{font-size:1.7rem;font-weight:800;color:var(--red);}
.stat-label{font-size:0.72rem;color:#999;font-weight:600;margin-top:2px;text-transform:uppercase;letter-spacing:0.5px;}

/* FOOD PHOTOS STRIP */
.photos-strip{
    background:#1a0a00;padding:60px 0;overflow:hidden;
}
.strip-title{
    text-align:center;font-size:1.8rem;font-weight:800;
    color:#fff;margin-bottom:32px;
}
.strip-title span{color:var(--red);}
.photos-row{
    display:flex;gap:16px;padding:0 40px;
    overflow-x:auto;scrollbar-width:none;
    scroll-behavior:smooth;
}
.photos-row::-webkit-scrollbar{display:none;}
.photo-card{
    flex-shrink:0;width:200px;height:200px;
    border-radius:16px;overflow:hidden;
    position:relative;cursor:pointer;
    transition:transform 0.3s;
}
.photo-card:hover{transform:scale(1.05);}
.photo-card img{width:100%;height:100%;object-fit:cover;}
.photo-label{
    position:absolute;bottom:0;left:0;right:0;
    background:linear-gradient(transparent,rgba(0,0,0,0.75));
    color:#fff;font-size:0.8rem;font-weight:700;
    padding:24px 12px 10px;text-align:center;
}

/* CATEGORIES */
.categories-sec{
    background:#f8f8f8;padding:80px 48px;
}
.sec-head{text-align:center;margin-bottom:48px;}
.eyebrow{font-size:0.72rem;font-weight:700;letter-spacing:2px;text-transform:uppercase;color:var(--red);margin-bottom:10px;}
.sec-head h2{font-size:clamp(1.8rem,4vw,2.6rem);font-weight:800;color:#1a0a00;}
.cats-grid{
    display:grid;grid-template-columns:repeat(auto-fit,minmax(150px,1fr));
    gap:18px;max-width:1000px;margin:0 auto;
}
.cat-card{
    background:#fff;border-radius:18px;padding:28px 14px 22px;
    text-align:center;border:2px solid transparent;
    transition:all 0.28s;box-shadow:0 3px 14px rgba(0,0,0,0.06);
    text-decoration:none;color:inherit;display:block;
}
.cat-card:hover{border-color:var(--red);transform:translateY(-6px);box-shadow:0 14px 36px rgba(231,76,60,0.14);}
.cat-icon{font-size:2.4rem;margin-bottom:10px;display:block;}
.cat-name{font-weight:700;font-size:0.9rem;color:#1a0a00;}
.cat-sub{font-size:0.72rem;color:#bbb;margin-top:3px;}

/* WHY US */
.why-sec{
    background:linear-gradient(135deg,#1a0a00 0%,#3d1a08 100%);
    padding:80px 48px;
}
.why-grid{
    display:grid;grid-template-columns:repeat(auto-fit,minmax(220px,1fr));
    gap:24px;max-width:1000px;margin:48px auto 0;
}
.why-card{
    background:rgba(255,255,255,0.06);
    border:1px solid rgba(255,255,255,0.08);
    border-radius:18px;padding:32px 24px;
    transition:all 0.25s;
}
.why-card:hover{background:rgba(231,76,60,0.12);border-color:rgba(231,76,60,0.3);}
.why-icon{
    width:48px;height:48px;background:rgba(231,76,60,0.18);
    border-radius:12px;display:flex;align-items:center;
    justify-content:center;font-size:1.4rem;margin-bottom:16px;
}
.why-card h3{color:#fff;font-size:1rem;font-weight:700;margin-bottom:8px;}
.why-card p{color:rgba(255,255,255,0.5);font-size:0.82rem;line-height:1.65;}
.why-sec .sec-head .eyebrow{color:var(--gold);}
.why-sec .sec-head h2{color:#fff;}

/* FOOTER */
footer{
    background:#0f0600;color:rgba(255,255,255,0.45);
    text-align:center;padding:28px 20px;font-size:0.8rem;
}
footer strong{color:var(--red);}

@media(max-width:768px){
    .nav{padding:14px 20px;}
    .hero{padding:100px 20px 80px;}
    .stats{flex-wrap:wrap;}
    .stat{border-right:none;border-bottom:1px solid #f0f0f0;flex:1 0 40%;}
    .categories-sec,.why-sec{padding:60px 20px;}
}
</style>
</head>
<body>

<!-- NAVBAR -->
<nav class="nav">
    <div class="nav-logo">M<span>.</span>B <span style="color:#fff;font-weight:400;font-size:1rem;">Restaurant</span></div>
    <div class="nav-links">
        <a href="login.jsp" class="btn-login">Login</a>
        <a href="register.jsp" class="btn-reg">Register Free</a>
    </div>
</nav>

<!-- HERO -->
<section class="hero">
    <div class="hero-badge">Now Open &nbsp;路&nbsp; Fresh Every Day</div>
    <h1>Every Bite Tells a <em>Story</em></h1>
    <p>Authentic Indian flavours crafted with love 鈥� from fiery biryanis to melt-in-your-mouth sweets, delivered hot.</p>
    <div class="hero-btns">
        <a href="login.jsp" class="cta-main">Order Now</a>
        <a href="register.jsp" class="cta-sec">Create Account</a>
    </div>
    <div class="stats">
        <div class="stat"><div class="stat-num">50+</div><div class="stat-label">Menu Items</div></div>
        <div class="stat"><div class="stat-num">4.8</div><div class="stat-label">Avg Rating</div></div>
        <div class="stat"><div class="stat-num">30min</div><div class="stat-label">Avg Delivery</div></div>
        <div class="stat"><div class="stat-num">1200+</div><div class="stat-label">Happy Customers</div></div>
    </div>
</section>

<!-- FOOD PHOTO STRIP -->
<div class="photos-strip">
    <div class="strip-title">Our <span>Signature</span> Dishes</div>
    <div class="photos-row">
        <div class="photo-card">
            <img src="https://images.unsplash.com/photo-1563379091339-03b21ab4a4f8?w=400&q=80" alt="Biryani">
            <div class="photo-label">Chicken Biryani</div>
        </div>
        <div class="photo-card">
            <img src="https://images.unsplash.com/photo-1668236543090-82eba5ee5976?w=400&q=80" alt="Dosa">
            <div class="photo-label">Masala Dosa</div>
        </div>
        <div class="photo-card">
            <img src="https://images.unsplash.com/photo-1630383249896-424e482df921?w=400&q=80" alt="Idli">
            <div class="photo-label">Idli Sambar</div>
        </div>
        <div class="photo-card">
            <img src="https://images.unsplash.com/photo-1571091718767-18b5b1457add?w=400&q=80" alt="Lassi">
            <div class="photo-label">Mango Lassi</div>
        </div>
        <div class="photo-card">
            <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/4/4e/Gulab_jamun_%28Mona%29_2.jpg/320px-Gulab_jamun_%28Mona%29_2.jpg" alt="Gulab Jamun">
            <div class="photo-label">Gulab Jamun</div>
        </div>
        <div class="photo-card">
            <img src="https://images.unsplash.com/photo-1509042239860-f550ce710b93?w=400&q=80" alt="Coffee">
            <div class="photo-label">Filter Coffee</div>
        </div>
        <div class="photo-card">
            <img src="https://images.unsplash.com/photo-1589302168068-964664d93dc0?w=400&q=80" alt="Mutton">
            <div class="photo-label">Mutton Biryani</div>
        </div>
        <div class="photo-card">
            <img src="https://images.unsplash.com/photo-1601050690597-df0568f70950?w=400&q=80" alt="Vada">
            <div class="photo-label">Medu Vada</div>
        </div>
    </div>
</div>

<!-- CATEGORIES -->
<section class="categories-sec">
    <div class="sec-head">
        <div class="eyebrow">What are you craving?</div>
        <h2>Explore Our Menu</h2>
    </div>
    <div class="cats-grid">
        <a href="login.jsp" class="cat-card"><span class="cat-icon">馃崨</span><div class="cat-name">Biryani</div><div class="cat-sub">Rich &amp; Aromatic</div></a>
        <a href="login.jsp" class="cat-card"><span class="cat-icon">馃珦</span><div class="cat-name">Dosa</div><div class="cat-sub">Crispy &amp; Fresh</div></a>
        <a href="login.jsp" class="cat-card"><span class="cat-icon">馃ィ</span><div class="cat-name">Tiffin</div><div class="cat-sub">Morning Specials</div></a>
        <a href="login.jsp" class="cat-card"><span class="cat-icon">馃崥</span><div class="cat-name">Rice</div><div class="cat-sub">Pulao &amp; More</div></a>
        <a href="login.jsp" class="cat-card"><span class="cat-icon">鈽�</span><div class="cat-name">Drinks</div><div class="cat-sub">Lassi &amp; Coffee</div></a>
        <a href="login.jsp" class="cat-card"><span class="cat-icon">馃嵁</span><div class="cat-name">Sweets</div><div class="cat-sub">Gulab Jamun &amp; More</div></a>
    </div>
</section>

<!-- WHY US -->
<section class="why-sec">
    <div class="sec-head">
        <div class="eyebrow">Why M.B Restaurant</div>
        <h2>Made with Passion, Served with Pride</h2>
    </div>
    <div class="why-grid">
        <div class="why-card"><div class="why-icon">馃敟</div><h3>Fresh Ingredients</h3><p>Sourced locally every day. No frozen shortcuts 鈥� cooked fresh to order.</p></div>
        <div class="why-card"><div class="why-icon">鈿�</div><h3>Fast Ordering</h3><p>Browse, add to cart, checkout in under 2 minutes. Simple and seamless.</p></div>
        <div class="why-card"><div class="why-icon">馃嵔锔�</div><h3>Authentic Recipes</h3><p>Traditional South Indian recipes with generations of flavour.</p></div>
        <div class="why-card"><div class="why-icon">猸�</div><h3>Rate &amp; Review</h3><p>Rate every dish and help others discover the best items on our menu.</p></div>
    </div>
</section>

<footer>
    <p>2026 <strong>M.B Restaurant</strong> &nbsp;路&nbsp; All rights reserved &nbsp;路&nbsp; Made with love and spice</p>
</footer>

</body>
</html>