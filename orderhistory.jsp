<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
String username = (String) session.getAttribute("username");
Object userIdObj = session.getAttribute("userId");
if (username == null || userIdObj == null) {
    response.sendRedirect("login.jsp");
    return;
}
int userId = (Integer) userIdObj;
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>My Orders - M.B Restaurant</title>
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700;800&display=swap" rel="stylesheet">
<style>
*,*::before,*::after{margin:0;padding:0;box-sizing:border-box;}
body{font-family:'Poppins',sans-serif;background:#f5f5f5;}

/* NAVBAR */
.navbar{
    background:#fff;padding:0 40px;height:65px;
    display:flex;align-items:center;justify-content:space-between;
    box-shadow:0 2px 15px rgba(0,0,0,0.08);
    position:sticky;top:0;z-index:100;
}
.logo{font-size:1.3rem;font-weight:800;color:#e74c3c;}
.logo span{color:#333;font-weight:400;font-size:1rem;}
.nav-right{display:flex;gap:10px;align-items:center;}
.nav-btn{
    text-decoration:none;padding:8px 16px;border-radius:8px;
    font-size:0.82rem;font-weight:600;transition:all 0.2s;
    font-family:'Poppins',sans-serif;
}
.btn-red{background:#e74c3c;color:#fff;}
.btn-red:hover{background:#c0392b;}
.btn-dark{background:#333;color:#fff;}
.btn-grey{background:#f5f5f5;color:#555;border:1.5px solid #eee;}
.btn-grey:hover{background:#eee;}

/* HERO STRIP */
.hero-strip{
    background:linear-gradient(135deg,#e74c3c,#c0392b);
    padding:32px 40px;color:#fff;
}
.hero-strip h2{font-size:1.6rem;font-weight:800;margin-bottom:4px;}
.hero-strip p{opacity:0.85;font-size:0.88rem;}

/* CONTAINER */
.container{max-width:860px;margin:32px auto;padding:0 20px 60px;}

/* STATS ROW */
.stats-row{
    display:grid;grid-template-columns:repeat(3,1fr);
    gap:14px;margin-bottom:28px;
}
.stat-box{
    background:#fff;border-radius:14px;padding:18px 20px;
    box-shadow:0 2px 10px rgba(0,0,0,0.06);text-align:center;
}
.stat-box .num{font-size:1.6rem;font-weight:800;color:#e74c3c;}
.stat-box .lbl{font-size:0.75rem;color:#aaa;font-weight:600;margin-top:2px;}

/* ORDER CARD */
.order-card{
    background:#fff;border-radius:18px;margin-bottom:20px;
    box-shadow:0 3px 16px rgba(0,0,0,0.07);
    overflow:hidden;border:1.5px solid #f5f5f5;
    transition:box-shadow 0.2s;
}
.order-card:hover{box-shadow:0 6px 24px rgba(0,0,0,0.11);}

/* ORDER HEADER */
.order-header{
    background:linear-gradient(135deg,#1a1a2e,#2d2d44);
    padding:16px 24px;
    display:flex;justify-content:space-between;align-items:center;
}
.order-id{font-size:1rem;font-weight:800;color:#fff;}
.order-date{font-size:0.75rem;color:rgba(255,255,255,0.6);margin-top:2px;}
.order-total{font-size:1.2rem;font-weight:800;color:#fff;}

/* STATUS BADGE */
.status-badge{
    padding:5px 14px;border-radius:20px;
    font-size:0.75rem;font-weight:700;margin-top:4px;
    display:inline-block;
}
.status-Pending{background:rgba(255,193,7,0.2);color:#ffc107;border:1px solid rgba(255,193,7,0.4);}
.status-Confirmed{background:rgba(33,150,243,0.2);color:#2196f3;border:1px solid rgba(33,150,243,0.4);}
.status-Preparing{background:rgba(255,152,0,0.2);color:#ff9800;border:1px solid rgba(255,152,0,0.4);}
.status-Out{background:rgba(156,39,176,0.2);color:#9c27b0;border:1px solid rgba(156,39,176,0.4);}
.status-Delivered{background:rgba(76,175,80,0.2);color:#4caf50;border:1px solid rgba(76,175,80,0.4);}

/* TRACKING BAR */
.tracking{
    padding:16px 24px;
    background:#fafafa;
    border-bottom:1px solid #f0f0f0;
}
.tracking-label{font-size:0.72rem;color:#aaa;font-weight:700;text-transform:uppercase;letter-spacing:1px;margin-bottom:12px;}
.track-steps{display:flex;align-items:center;gap:0;}
.track-step{
    display:flex;flex-direction:column;align-items:center;
    flex:1;position:relative;
}
.track-step::after{
    content:'';position:absolute;top:14px;left:50%;
    width:100%;height:2px;background:#eee;z-index:0;
}
.track-step:last-child::after{display:none;}
.step-dot{
    width:28px;height:28px;border-radius:50%;
    background:#eee;border:2px solid #ddd;
    display:flex;align-items:center;justify-content:center;
    font-size:0.7rem;z-index:1;position:relative;
    transition:all 0.3s;
}
.step-dot.done{background:#e74c3c;border-color:#e74c3c;color:#fff;}
.step-dot.active{background:#fff;border-color:#e74c3c;color:#e74c3c;box-shadow:0 0 0 3px rgba(231,76,60,0.2);}
.step-name{font-size:0.65rem;color:#aaa;margin-top:6px;text-align:center;font-weight:600;}
.step-name.done{color:#e74c3c;}
.step-name.active{color:#e74c3c;font-weight:700;}

/* ORDER BODY */
.order-body{padding:16px 24px;}
.delivery-info{
    background:#f8f8f8;border-radius:10px;
    padding:12px 16px;margin-bottom:14px;
    font-size:0.8rem;color:#666;
    display:flex;gap:16px;flex-wrap:wrap;
}
.delivery-info span{display:flex;align-items:center;gap:5px;}

.order-summary{
    display:flex;justify-content:space-between;
    align-items:center;
    padding-top:12px;border-top:1px dashed #eee;
    margin-top:12px;
}
.order-summary .total-text{font-size:0.85rem;color:#aaa;font-weight:600;}
.order-summary .total-amt{font-size:1.1rem;font-weight:800;color:#e74c3c;}

/* EMPTY STATE */
.empty{
    text-align:center;padding:80px 20px;
    background:#fff;border-radius:18px;
    box-shadow:0 3px 16px rgba(0,0,0,0.07);
}
.empty-icon{font-size:4.5rem;margin-bottom:16px;}
.empty h3{font-size:1.3rem;font-weight:700;color:#333;margin-bottom:8px;}
.empty p{color:#aaa;font-size:0.88rem;margin-bottom:24px;}
.empty-btn{
    display:inline-block;background:#e74c3c;color:#fff;
    text-decoration:none;padding:12px 28px;border-radius:10px;
    font-weight:700;font-size:0.9rem;
}

@media(max-width:600px){
    .navbar{padding:0 16px;}
    .hero-strip{padding:24px 16px;}
    .stats-row{grid-template-columns:repeat(3,1fr);gap:8px;}
    .stat-box .num{font-size:1.2rem;}
    .track-step::after{display:none;}
}
</style>
</head>
<body>

<!-- NAVBAR -->
<nav class="navbar">
    <div class="logo">M.B <span>Restaurant</span></div>
    <div class="nav-right">
        <a href="menu.jsp" class="nav-btn btn-grey">Menu</a>
        <a href="cart.jsp" class="nav-btn btn-red">Cart</a>
        <a href="logout.jsp" class="nav-btn btn-dark">Logout</a>
    </div>
</nav>

<!-- HERO -->
<div class="hero-strip">
    <h2>My Orders</h2>
    <p>Hello <%= username %>! Track all your orders here.</p>
</div>

<%
Connection con = com.foodapp.DBConnection.getConnection();

// Count stats
PreparedStatement psCount = con.prepareStatement(
    "SELECT COUNT(*) as total, SUM(total) as spent FROM orders WHERE user_id=?");
psCount.setInt(1, userId);
ResultSet rsCount = psCount.executeQuery();
int totalOrders = 0; double totalSpent = 0;
if(rsCount.next()){ totalOrders=rsCount.getInt("total"); totalSpent=rsCount.getDouble("spent"); }
rsCount.close(); psCount.close();

PreparedStatement psDel = con.prepareStatement(
    "SELECT COUNT(*) as cnt FROM orders WHERE user_id=? AND status='Delivered'");
psDel.setInt(1, userId);
ResultSet rsDel = psDel.executeQuery();
int delivered = 0; if(rsDel.next()) delivered=rsDel.getInt("cnt");
rsDel.close(); psDel.close();
%>

<div class="container">

    <!-- STATS -->
    <div class="stats-row">
        <div class="stat-box">
            <div class="num"><%= totalOrders %></div>
            <div class="lbl">Total Orders</div>
        </div>
        <div class="stat-box">
            <div class="num"><%= delivered %></div>
            <div class="lbl">Delivered</div>
        </div>
        <div class="stat-box">
            <div class="num">&#8377;<%= (int)totalSpent %></div>
            <div class="lbl">Total Spent</div>
        </div>
    </div>

<%
PreparedStatement ps = con.prepareStatement(
    "SELECT * FROM orders WHERE user_id=? ORDER BY id DESC");
ps.setInt(1, userId);
ResultSet rsOrders = ps.executeQuery();
boolean hasOrders = false;

while(rsOrders.next()) {
    hasOrders = true;
    int orderId   = rsOrders.getInt("id");
    double total  = rsOrders.getDouble("total");
    String date   = rsOrders.getString("order_date");
    String status = rsOrders.getString("status");
    String addr   = rsOrders.getString("delivery_address");
    String city   = rsOrders.getString("city");
    String phone  = rsOrders.getString("phone");
    if(status == null) status = "Pending";
    if(addr == null) addr = "";
    if(city == null) city = "";
    if(phone == null) phone = "";

    // Determine step progress
    int step = 0;
    if(status.equals("Pending"))           step = 1;
    else if(status.equals("Confirmed"))    step = 2;
    else if(status.equals("Preparing"))    step = 3;
    else if(status.equals("Out for Delivery")) step = 4;
    else if(status.equals("Delivered"))    step = 5;

    String statusClass = status.replace(" ","").replace("forDelivery","");
%>

    <div class="order-card">

        <!-- HEADER -->
        <div class="order-header">
            <div>
                <div class="order-id">Order #<%= orderId %></div>
                <div class="order-date"><%= date != null ? date.toString().substring(0,16) : "" %></div>
            </div>
            <div style="text-align:right;">
                <div class="order-total">&#8377;<%= (int)total %></div>
                <div class="status-badge status-<%= statusClass %>"><%= status %></div>
            </div>
        </div>

        <!-- TRACKING -->
        <div class="tracking">
            <div class="tracking-label">Order Tracking</div>
            <div class="track-steps">
                <div class="track-step">
                    <div class="step-dot <%= step>=1?"done":"" %>"><%= step>=1?"鉁�":"1" %></div>
                    <div class="step-name <%= step>=1?"done":"" %>">Placed</div>
                </div>
                <div class="track-step">
                    <div class="step-dot <%= step>=2?"done":step==1?"active":"" %>"><%= step>=2?"鉁�":"2" %></div>
                    <div class="step-name <%= step>=2?"done":step==1?"active":"" %>">Confirmed</div>
                </div>
                <div class="track-step">
                    <div class="step-dot <%= step>=3?"done":step==2?"active":"" %>"><%= step>=3?"鉁�":"3" %></div>
                    <div class="step-name <%= step>=3?"done":step==2?"active":"" %>">Preparing</div>
                </div>
                <div class="track-step">
                    <div class="step-dot <%= step>=4?"done":step==3?"active":"" %>"><%= step>=4?"鉁�":"4" %></div>
                    <div class="step-name <%= step>=4?"done":step==3?"active":"" %>">On Way</div>
                </div>
                <div class="track-step">
                    <div class="step-dot <%= step>=5?"done":step==4?"active":"" %>"><%= step>=5?"鉁�":"5" %></div>
                    <div class="step-name <%= step>=5?"done":step==4?"active":"" %>">Delivered</div>
                </div>
            </div>
        </div>

        <!-- BODY -->
        <div class="order-body">
            <% if(!addr.isEmpty()) { %>
            <div class="delivery-info">
                <span>Delivered to: <%= addr %><%= !city.isEmpty()?", "+city:"" %></span>
                <% if(!phone.isEmpty()) { %><span>Phone: <%= phone %></span><% } %>
            </div>
            <% } %>
            <div class="order-summary">
                <span class="total-text">Order Total</span>
                <span class="total-amt">&#8377;<%= (int)total %></span>
            </div>
        </div>

    </div>
<% } %>

<% if(!hasOrders) { %>
    <div class="empty">
        <div class="empty-icon">馃洅</div>
        <h3>No Orders Yet!</h3>
        <p>You haven't placed any orders yet.<br>Explore our menu and order something delicious!</p>
        <a href="menu.jsp" class="empty-btn">Browse Menu</a>
    </div>
<% } %>

<% con.close(); %>
</div>

</body>
</html>