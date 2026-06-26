<%@ page import="java.sql.*" %>
<%
String username = (String) session.getAttribute("username");
if (username == null) {
    response.sendRedirect("login.jsp");
    return;
}
Integer sessionUserId = (Integer) session.getAttribute("userId");
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>M.B Restaurant — Menu</title>
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700;800&display=swap" rel="stylesheet">
<style>
*, *::before, *::after { margin:0; padding:0; box-sizing:border-box; }
:root { --red:#e74c3c; --dark:#1a1a2e; --green:#27ae60; --bg:#f5f5f5; --white:#fff; }
body { font-family:'Poppins',sans-serif; background:var(--bg); color:#333; }

/* NAVBAR */
.navbar {
    background:white; padding:0 40px; height:65px;
    display:flex; align-items:center; justify-content:space-between;
    box-shadow:0 2px 15px rgba(0,0,0,0.08);
    position:sticky; top:0; z-index:200;
}
.logo { font-size:1.4rem; font-weight:800; color:var(--red); }
.logo span { color:#333; font-weight:400; font-size:1rem; }
.nav-right { display:flex; align-items:center; gap:10px; }
.avatar {
    width:34px; height:34px; border-radius:50%;
    background:linear-gradient(135deg,#e74c3c,#c0392b);
    color:white; display:flex; align-items:center;
    justify-content:center; font-weight:700; font-size:0.9rem;
}
.nav-user { display:flex; align-items:center; gap:8px; font-size:0.85rem; color:#666; font-weight:500; }
.nav-btn {
    text-decoration:none; padding:8px 16px; border-radius:8px;
    font-size:0.82rem; font-weight:600; transition:all 0.2s;
    display:flex; align-items:center; gap:5px; font-family:'Poppins',sans-serif;
}
.btn-cart { background:var(--red); color:white; }
.btn-cart:hover { background:#c0392b; }
.btn-orders { background:#f5f5f5; color:#555; border:1.5px solid #eee; }
.btn-orders:hover { background:#eee; }
.btn-logout { background:#333; color:white; }

/* HERO */
.hero {
    background:linear-gradient(135deg,#1a1a2e 0%,#e74c3c 100%);
    padding:48px 40px; color:white; position:relative; overflow:hidden;
}
.hero::before {
    content:''; position:absolute; inset:0;
    background:url('https://images.unsplash.com/photo-1596797038530-2c107229654b?w=1400&q=60') center/cover;
    opacity:0.1;
}
.hero-content { position:relative; z-index:1; max-width:600px; }
.hero-badge {
    display:inline-flex; align-items:center; gap:6px;
    background:rgba(255,255,255,0.15); border:1px solid rgba(255,255,255,0.3);
    padding:5px 14px; border-radius:20px; font-size:0.75rem;
    font-weight:600; margin-bottom:14px;
}
.hero h1 { font-size:2.2rem; font-weight:800; line-height:1.2; margin-bottom:10px; }
.hero h1 span { color:#ffd700; }
.hero-meta { display:flex; gap:20px; margin-bottom:18px; font-size:0.82rem; opacity:0.85; flex-wrap:wrap; }
.hero-tags { display:flex; gap:8px; flex-wrap:wrap; }
.hero-tag {
    background:rgba(255,255,255,0.15); border:1px solid rgba(255,255,255,0.25);
    padding:6px 14px; border-radius:20px; font-size:0.78rem;
    font-weight:500; text-decoration:none; color:white; transition:all 0.2s;
}
.hero-tag:hover { background:rgba(255,255,255,0.28); transform:translateY(-2px); }

/* SEARCH */
.search-wrap {
    background:white; padding:14px 40px;
    box-shadow:0 2px 10px rgba(0,0,0,0.06);
    position:sticky; top:65px; z-index:150;
}
.search-inner { max-width:700px; margin:0 auto; position:relative; }
.search-inner input {
    width:100%; padding:13px 20px 13px 46px;
    border:2px solid #eee; border-radius:12px;
    font-size:0.9rem; font-family:'Poppins',sans-serif;
    outline:none; background:#fafafa; transition:border 0.2s;
}
.search-inner input:focus { border-color:var(--red); background:white; }
.s-icon { position:absolute; left:16px; top:50%; transform:translateY(-50%); font-size:1rem; color:#bbb; }

/* CAT BAR */
.cat-bar {
    background:white; padding:0 40px; display:flex;
    overflow-x:auto; border-bottom:2px solid #f0f0f0;
    position:sticky; top:115px; z-index:140; scrollbar-width:none;
}
.cat-bar::-webkit-scrollbar { display:none; }
.cat-pill {
    padding:13px 20px; border-bottom:3px solid transparent;
    color:#888; font-weight:600; font-size:0.8rem;
    white-space:nowrap; text-decoration:none;
    transition:all 0.2s; display:flex; align-items:center; gap:4px;
}
.cat-pill:hover { color:var(--red); border-bottom-color:var(--red); }

/* MAIN */
.main { max-width:1000px; margin:0 auto; padding:24px 24px 60px; }

.sec-header {
    display:flex; align-items:center; gap:10px;
    margin:36px 0 16px; padding-bottom:12px;
    border-bottom:2px solid #f0f0f0;
}
.sec-emoji { font-size:1.5rem; }
.sec-title { font-size:1.2rem; font-weight:700; color:#1a1a2e; }
.sec-count { margin-left:auto; font-size:0.75rem; color:#bbb; font-weight:500; }

/* FOOD CARD */
.food-card {
    background:white; border-radius:14px; margin-bottom:12px;
    display:flex; align-items:stretch; overflow:hidden;
    box-shadow:0 2px 12px rgba(0,0,0,0.07);
    border:1.5px solid #f5f5f5; transition:all 0.25s;
}
.food-card:hover { box-shadow:0 6px 24px rgba(0,0,0,0.11); transform:translateY(-2px); border-color:#fde8e8; }

.food-left { flex:1; padding:18px 20px; }
.veg-b {
    width:17px; height:17px; border-radius:3px;
    display:inline-flex; align-items:center; justify-content:center;
    margin-bottom:7px;
}
.veg-b.veg { border:2px solid var(--green); }
.veg-b.nonveg { border:2px solid var(--red); }
.veg-dot { width:7px; height:7px; border-radius:50%; }
.veg .veg-dot { background:var(--green); }
.nonveg .veg-dot { background:var(--red); }

.food-name { font-size:0.98rem; font-weight:700; color:#1a1a2e; margin-bottom:3px; }
.food-price { font-size:0.98rem; font-weight:700; color:#333; margin-bottom:5px; }
.food-desc { font-size:0.75rem; color:#bbb; line-height:1.5; margin-bottom:10px; }

.stars-row { display:flex; align-items:center; gap:1px; margin-bottom:6px; }
.sf { color:#f5a623; font-size:12px; }
.se { color:#e0e0e0; font-size:12px; }
.r-info { font-size:10px; color:#bbb; margin-left:3px; }
.r-avg  { font-size:10px; font-weight:700; color:var(--red); margin-left:2px; }

.r-label { font-size:10px; color:#ccc; margin-bottom:3px; }
.star-inp { display:flex; gap:2px; margin-bottom:5px; }
.sbt {
    font-size:17px; color:#e0e0e0; cursor:pointer;
    background:none; border:none; padding:0; line-height:1;
    transition:color 0.1s, transform 0.1s;
}
.sbt.on { color:#f5a623; }
.sbt:hover { transform:scale(1.2); }
.r-sub {
    background:var(--red); color:white; border:none;
    padding:4px 12px; border-radius:16px; font-size:10px;
    font-weight:600; cursor:pointer; font-family:'Poppins',sans-serif;
}
.r-sub:hover { background:#c0392b; }

.food-right {
    width:145px; flex-shrink:0; display:flex;
    flex-direction:column; align-items:center;
    padding:14px 12px; background:#fafafa;
    border-left:1px solid #f5f5f5;
}
.food-img {
    width:115px; height:86px; object-fit:cover;
    border-radius:10px; margin-bottom:10px;
    box-shadow:0 3px 10px rgba(0,0,0,0.1);
}
.add-btn {
    width:115px; padding:8px 0; text-align:center;
    background:white; color:var(--red);
    border:2px solid var(--red); border-radius:8px;
    font-weight:700; font-size:0.82rem;
    text-decoration:none; transition:all 0.2s;
    font-family:'Poppins',sans-serif;
}
.add-btn:hover { background:var(--red); color:white; }

.footer {
    background:#1a1a2e; color:rgba(255,255,255,0.55);
    text-align:center; padding:24px; font-size:0.8rem;
}
.footer strong { color:var(--red); }
</style>
</head>
<body>

<nav class="navbar">
    <div class="logo">🍕 M.B <span>Restaurant</span></div>
    <div class="nav-right">
        <div class="nav-user">
            <div class="avatar"><%= username.substring(0,1).toUpperCase() %></div>
            <span>Hi, <%= username %>!</span>
        </div>
        <a href="cart.jsp" class="nav-btn btn-cart">🛒 Cart</a>
        <a href="orderhistory.jsp" class="nav-btn btn-orders">📋 Orders</a>
        <a href="logout.jsp" class="nav-btn btn-logout">🚪 Logout</a>
    </div>
</nav>

<div class="hero">
    <div class="hero-content">
        <div class="hero-badge">⭐ 4.5 Rated · Open Now</div>
        <h1>Authentic <span>South Indian</span><br>Cuisine 🍛</h1>
        <div class="hero-meta">
            <span>⏱️ 30–40 mins</span>
            <span>🚚 Free above ₹299</span>
            <span>📍 Delivering Now</span>
        </div>
        <div class="hero-tags">
            <a href="#Biryani" class="hero-tag">🍛 Biryani</a>
            <a href="#Dosa" class="hero-tag">🫓 Dosa</a>
            <a href="#Tiffin" class="hero-tag">🥣 Tiffin</a>
            <a href="#Drinks" class="hero-tag">☕ Drinks</a>
            <a href="#Sweets" class="hero-tag">🍮 Sweets</a>
        </div>
    </div>
</div>

<div class="search-wrap">
    <div class="search-inner">
        <span class="s-icon">🔍</span>
        <input type="text" id="searchInput"
               placeholder="Search biryani, dosa, sweets..."
               onkeyup="searchFood()">
    </div>
</div>

<div class="cat-bar">
<%
Connection con = com.foodapp.DBConnection.getConnection();
Statement stC = con.createStatement();
ResultSet rsC = stC.executeQuery("SELECT DISTINCT category FROM food_items ORDER BY category");
while(rsC.next()) {
    String c = rsC.getString("category");
    String e = "🍽️";
    if(c.equals("Biryani"))e="🍛"; else if(c.equals("Dosa"))e="🫓";
    else if(c.equals("Tiffin"))e="🥣"; else if(c.equals("Uttapam"))e="🥞";
    else if(c.equals("Rice"))e="🍚"; else if(c.equals("Drinks"))e="☕";
    else if(c.equals("Sweets"))e="🍮"; else if(c.equals("Fast Food"))e="🍔";
    else if(c.equals("Indian"))e="🍲"; else if(c.equals("Italian"))e="🍝";
    else if(c.equals("South Indian"))e="🥘";
%>
    <a href="#<%= c %>" class="cat-pill"><%= e %> <%= c %></a>
<% } rsC.close(); stC.close(); %>
</div>

<div class="main">
<%
Statement stC2 = con.createStatement();
ResultSet rsC2 = stC2.executeQuery("SELECT DISTINCT category FROM food_items ORDER BY category");
while(rsC2.next()) {
    String cat = rsC2.getString("category");
    String ce = "🍽️";
    if(cat.equals("Biryani"))ce="🍛"; else if(cat.equals("Dosa"))ce="🫓";
    else if(cat.equals("Tiffin"))ce="🥣"; else if(cat.equals("Uttapam"))ce="🥞";
    else if(cat.equals("Rice"))ce="🍚"; else if(cat.equals("Drinks"))ce="☕";
    else if(cat.equals("Sweets"))ce="🍮"; else if(cat.equals("Fast Food"))ce="🍔";
    else if(cat.equals("Indian"))ce="🍲"; else if(cat.equals("Italian"))ce="🍝";
    else if(cat.equals("South Indian"))ce="🥘";
    PreparedStatement psC = con.prepareStatement("SELECT COUNT(*) FROM food_items WHERE category=?");
    psC.setString(1,cat); ResultSet rsCC = psC.executeQuery();
    int cnt=0; if(rsCC.next()) cnt=rsCC.getInt(1); rsCC.close(); psC.close();
%>
<div id="<%= cat %>">
    <div class="sec-header">
        <span class="sec-emoji"><%= ce %></span>
        <span class="sec-title"><%= cat %></span>
        <span class="sec-count"><%= cnt %> items</span>
    </div>
<%
    PreparedStatement psF = con.prepareStatement("SELECT * FROM food_items WHERE category=?");
    psF.setString(1,cat); ResultSet rsF = psF.executeQuery();
    while(rsF.next()) {
        String name=rsF.getString("name"); String desc=rsF.getString("description");
        double price=rsF.getDouble("price"); int id=rsF.getInt("id");
        double avg=0; int tot=0; int ur=0;
        PreparedStatement pa=con.prepareStatement("SELECT AVG(rating) a,COUNT(*) t FROM ratings WHERE food_id=?");
        pa.setInt(1,id); ResultSet ra=pa.executeQuery();
        if(ra.next()){avg=ra.getDouble("a");tot=ra.getInt("t");} ra.close(); pa.close();
        if(sessionUserId!=null){
            PreparedStatement pu=con.prepareStatement("SELECT rating FROM ratings WHERE food_id=? AND user_id=?");
            pu.setInt(1,id); pu.setInt(2,sessionUserId);
            ResultSet ru=pu.executeQuery(); if(ru.next()) ur=ru.getInt("rating"); ru.close(); pu.close();
        }
        int rnd=(int)Math.round(avg);
        String img="https://images.unsplash.com/photo-1585937421612-70a008356fbe?w=300";
        if(name.contains("Chicken")&&name.contains("Biryani"))img="https://images.unsplash.com/photo-1563379091339-03b21ab4a4f8?w=300";
        else if(name.contains("Mutton"))img="https://images.unsplash.com/photo-1589302168068-964664d93dc0?w=300";
        else if(name.equals("Prawn Biryani"))img="https://images.unsplash.com/photo-1565557623262-b51c2513a641?w=300";
        else if(name.contains("Paneer")||name.contains("Veg Dum")||name.contains("Mushroom"))img="https://images.unsplash.com/photo-1596797038530-2c107229654b?w=300";
        else if(name.contains("Dosa"))img="https://images.unsplash.com/photo-1668236543090-82eba5ee5976?w=300";
        else if(name.contains("Idli"))img="https://images.unsplash.com/photo-1630383249896-424e482df921?w=300";
        else if(name.contains("Vada"))img="https://images.unsplash.com/photo-1601050690597-df0568f70950?w=300";
        else if(name.contains("Uttapam"))img="https://images.unsplash.com/photo-1668236543090-82eba5ee5976?w=300";
        else if(name.contains("Rice"))img="https://images.unsplash.com/photo-1516684732162-798a0062be99?w=300";
        else if(name.equals("Filter Coffee"))img="https://images.unsplash.com/photo-1509042239860-f550ce710b93?w=300";
        else if(name.equals("Masala Tea"))img="https://images.unsplash.com/photo-1556679343-c7306c1976bc?w=300";
        else if(name.equals("Mango Lassi"))img="https://images.unsplash.com/photo-1571091718767-18b5b1457add?w=300";
        else if(name.equals("Coconut Water"))img="https://images.unsplash.com/photo-1550989460-0adf9ea622e2?w=300";
        else if(name.equals("Gulab Jamun"))img="https://upload.wikimedia.org/wikipedia/commons/thumb/4/4e/Gulab_jamun_%28Mona%29_2.jpg/320px-Gulab_jamun_%28Mona%29_2.jpg";
        else if(name.equals("Jalebi"))img="https://upload.wikimedia.org/wikipedia/commons/thumb/2/2e/Jalebi_%28fried%29.jpg/320px-Jalebi_%28fried%29.jpg";
        else if(name.equals("Rasgulla"))img="https://upload.wikimedia.org/wikipedia/commons/thumb/e/e5/Rosgulla.jpg/320px-Rosgulla.jpg";
        else if(name.equals("Halwa"))img="https://upload.wikimedia.org/wikipedia/commons/thumb/c/c3/Gajar_Ka_Halwa.jpg/320px-Gajar_Ka_Halwa.jpg";
        else if(name.equals("Kheer"))img="https://upload.wikimedia.org/wikipedia/commons/thumb/1/1e/Kheer_%28rice_pudding%29.jpg/320px-Kheer_%28rice_pudding%29.jpg";
        else if(name.equals("Payasam"))img="https://upload.wikimedia.org/wikipedia/commons/thumb/3/37/Payasam.jpg/320px-Payasam.jpg";
        boolean isVeg=!name.contains("Chicken")&&!name.contains("Mutton")&&!name.contains("Prawn")&&!name.contains("Fish")&&!name.contains("Egg");
%>
<div class="food-card">
    <div class="food-left">
        <div class="veg-b <%= isVeg?"veg":"nonveg" %>"><div class="veg-dot"></div></div>
        <div class="food-name"><%= name %></div>
        <div class="food-price">₹<%= (int)price %></div>
        <div class="food-desc"><%= (desc!=null&&!desc.isEmpty()) ? desc : "Freshly prepared with authentic spices" %></div>
        <div class="stars-row">
            <% for(int s=1;s<=5;s++){%><span class="<%= s<=rnd?"sf":"se" %>">★</span><%}%>
            <span class="r-info">(<%= tot %>)</span>
            <% if(tot>0){%><span class="r-avg"><%= String.format("%.1f",avg) %></span><%}%>
        </div>
        <div class="r-label"><%= ur>0?"Your rating: "+ur+"★":"Rate this:" %></div>
        <form action="RatingServlet" method="post" style="display:inline">
            <input type="hidden" name="food_id" value="<%= id %>">
            <input type="hidden" name="rating" id="rv_<%= id %>" value="<%= ur %>">
            <div class="star-inp" id="si_<%= id %>">
                <%for(int s=1;s<=5;s++){%>
                <button type="button" class="sbt <%=s<=ur?"on":""%>" onclick="setR(<%=id%>,<%=s%>)">★</button>
                <%}%>
            </div>
            <button type="submit" class="r-sub"><%= ur>0?"Update":"Submit" %></button>
        </form>
    </div>
    <div class="food-right">
        <img class="food-img" src="<%= img %>" alt="<%= name %>"
             onerror="this.src='https://images.unsplash.com/photo-1585937421612-70a008356fbe?w=300'">
        <a class="add-btn" href="cart.jsp?id=<%=id%>&name=<%=name%>&price=<%=price%>">＋ ADD</a>
    </div>
</div>
<% } rsF.close(); psF.close(); %>
</div>
<% } rsC2.close(); stC2.close(); con.close(); %>
</div>

<div class="footer">
    <p>🍕 <strong>M.B Restaurant</strong> · Made with ❤️ and Spice · © 2026</p>
</div>

<script>
function setR(id,val){
    document.getElementById('rv_'+id).value=val;
    document.querySelectorAll('#si_'+id+' .sbt').forEach(function(b,i){ b.classList.toggle('on',i<val); });
}
document.querySelectorAll('.star-inp').forEach(function(g){
    var bs=g.querySelectorAll('.sbt');
    bs.forEach(function(b,i){
        b.onmouseover=function(){ bs.forEach(function(x,j){ x.style.color=j<=i?'#f5a623':'#e0e0e0'; }); };
        b.onmouseout=function(){ bs.forEach(function(x){ x.style.color=x.classList.contains('on')?'#f5a623':'#e0e0e0'; }); };
    });
});
function searchFood(){
    var q=document.getElementById('searchInput').value.toLowerCase();
    document.querySelectorAll('.food-card').forEach(function(c){
        var n=c.querySelector('.food-name').textContent.toLowerCase();
        c.style.display=(!q||n.includes(q))?'flex':'none';
    });
    document.querySelectorAll('.main>div[id]').forEach(function(s){
        var v=[...s.querySelectorAll('.food-card')].some(function(c){ return c.style.display!=='none'; });
        s.style.display=(!q||v)?'block':'none';
    });
}
</script>
</body>
</html>