<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%
String username = (String) session.getAttribute("username");
if (username == null) {
    response.sendRedirect("login.jsp");
    return;
}
List<Map<String, String>> cart = (List<Map<String, String>>) session.getAttribute("cart");
if (cart == null) {
    cart = new ArrayList<>();
    session.setAttribute("cart", cart);
}
String id = request.getParameter("id");
String name = request.getParameter("name");
String price = request.getParameter("price");
if (id != null && name != null) {
    Map<String, String> item = new HashMap<>();
    item.put("id", id);
    item.put("name", name);
    item.put("price", price);
    cart.add(item);
}
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>My Cart - M.B Restaurant</title>
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700;800&display=swap" rel="stylesheet">
<style>
*,*::before,*::after{margin:0;padding:0;box-sizing:border-box;}
body{
    font-family:'Poppins',sans-serif;
    min-height:100vh;
    background:
        linear-gradient(135deg,rgba(26,10,0,0.92) 0%,rgba(180,40,30,0.85) 100%),
        url('https://images.unsplash.com/photo-1555396273-367ea4eb4db5?w=1400&q=70') center/cover fixed;
    display:flex;flex-direction:column;align-items:center;
    padding:0 16px 40px;
}

/* NAVBAR */
.navbar{
    width:100%;max-width:750px;
    display:flex;align-items:center;justify-content:space-between;
    padding:18px 0;margin-bottom:30px;
}
.logo{font-size:1.3rem;font-weight:800;color:#fff;}
.logo span{color:#e74c3c;}
.back-btn{
    text-decoration:none;color:rgba(255,255,255,0.8);
    font-size:0.82rem;font-weight:600;
    display:flex;align-items:center;gap:6px;
    background:rgba(255,255,255,0.1);
    border:1px solid rgba(255,255,255,0.2);
    padding:8px 16px;border-radius:20px;
    transition:all 0.2s;
}
.back-btn:hover{background:rgba(255,255,255,0.18);}

/* CARD */
.cart-card{
    width:100%;max-width:750px;
    background:rgba(255,255,255,0.97);
    border-radius:24px;
    overflow:hidden;
    box-shadow:0 30px 80px rgba(0,0,0,0.35);
}

/* CARD HEADER */
.cart-header{
    background:linear-gradient(135deg,#e74c3c,#c0392b);
    padding:28px 32px;color:#fff;
    display:flex;align-items:center;justify-content:space-between;
}
.cart-header h2{font-size:1.4rem;font-weight:800;}
.cart-header p{font-size:0.82rem;opacity:0.85;margin-top:3px;}
.cart-count{
    background:rgba(255,255,255,0.2);
    border:1px solid rgba(255,255,255,0.35);
    border-radius:50px;padding:6px 16px;
    font-size:0.82rem;font-weight:700;
}

/* ITEMS */
.cart-body{padding:24px 32px;}

.empty-cart{
    text-align:center;padding:48px 20px;
}
.empty-icon{font-size:4rem;margin-bottom:16px;}
.empty-cart h3{font-size:1.2rem;font-weight:700;color:#333;margin-bottom:8px;}
.empty-cart p{color:#aaa;font-size:0.85rem;margin-bottom:24px;}

.cart-item{
    display:flex;align-items:center;gap:16px;
    padding:16px 0;border-bottom:1px solid #f5f5f5;
    transition:background 0.2s;
}
.cart-item:last-child{border-bottom:none;}
.item-num{
    width:30px;height:30px;border-radius:50%;
    background:#f5f5f5;display:flex;align-items:center;
    justify-content:center;font-size:0.78rem;
    font-weight:700;color:#999;flex-shrink:0;
}
.item-info{flex:1;}
.item-name{font-size:0.95rem;font-weight:700;color:#1a1a2e;margin-bottom:2px;}
.item-cat{font-size:0.75rem;color:#bbb;}
.item-price{
    font-size:1rem;font-weight:800;color:#e74c3c;
    min-width:70px;text-align:right;
}
.remove-btn{
    background:none;border:none;cursor:pointer;
    color:#ddd;font-size:1.1rem;transition:color 0.2s;
    padding:4px;
}
.remove-btn:hover{color:#e74c3c;}

/* TOTAL SECTION */
.total-section{
    background:#fafafa;
    border-radius:16px;
    padding:20px 24px;
    margin-top:8px;
}
.total-row{
    display:flex;justify-content:space-between;
    align-items:center;padding:8px 0;
    font-size:0.85rem;color:#888;
}
.total-row.main{
    border-top:2px dashed #eee;margin-top:8px;padding-top:14px;
    font-size:1.1rem;font-weight:800;color:#1a1a2e;
}
.total-row.main span:last-child{color:#e74c3c;font-size:1.3rem;}
.free-badge{
    background:#e8f5e9;color:#27ae60;
    font-size:0.72rem;font-weight:700;
    padding:3px 10px;border-radius:10px;
}

/* BUTTONS */
.cart-actions{
    padding:0 32px 28px;
    display:flex;gap:12px;flex-direction:column;
}
.checkout-btn{
    display:flex;align-items:center;justify-content:center;gap:8px;
    background:linear-gradient(135deg,#e74c3c,#c0392b);
    color:#fff;text-decoration:none;
    padding:16px;border-radius:14px;
    font-size:1rem;font-weight:700;
    transition:all 0.25s;
    box-shadow:0 6px 20px rgba(231,76,60,0.35);
}
.checkout-btn:hover{transform:translateY(-2px);box-shadow:0 10px 28px rgba(231,76,60,0.45);}
.menu-btn{
    display:flex;align-items:center;justify-content:center;gap:8px;
    background:#f5f5f5;color:#555;text-decoration:none;
    padding:13px;border-radius:14px;
    font-size:0.88rem;font-weight:600;
    transition:all 0.2s;
}
.menu-btn:hover{background:#eee;}

/* PROMO */
.promo-bar{
    background:linear-gradient(90deg,#fff8e1,#fff3cd);
    border:1px solid #ffe082;
    border-radius:12px;padding:12px 18px;
    display:flex;align-items:center;gap:10px;
    margin:0 32px 20px;font-size:0.8rem;color:#856404;font-weight:600;
}

@media(max-width:500px){
    .cart-header,.cart-body,.cart-actions{padding-left:20px;padding-right:20px;}
    .promo-bar{margin-left:20px;margin-right:20px;}
}
</style>
</head>
<body>

<!-- NAV -->
<div class="navbar">
    <div class="logo">M<span>.</span>B Restaurant</div>
    <a href="menu.jsp" class="back-btn">� Back to Menu</a>
</div>

<!-- CART CARD -->
<div class="cart-card">

    <!-- HEADER -->
    <div class="cart-header">
        <div>
            <h2>My Cart</h2>
            <p>Hello <%= username %>! Review your order below.</p>
        </div>
        <div class="cart-count"><%= cart.size() %> item<%= cart.size()!=1?"s":"" %></div>
    </div>

    <!-- BODY -->
    <div class="cart-body">
<%
double total = 0;
if(cart.isEmpty()) {
%>
        <div class="empty-cart">
            <div class="empty-icon"></div>
            <h3>Your cart is empty!</h3>
            <p>Looks like you haven't added anything yet.<br>Go back and explore our delicious menu!</p>
            <a href="menu.jsp" style="display:inline-block;background:#e74c3c;color:#fff;text-decoration:none;padding:12px 28px;border-radius:10px;font-weight:700;">Browse Menu</a>
        </div>
<% } else {
    int num = 1;
    for(Map<String,String> item : cart) {
        double p = Double.parseDouble(item.get("price"));
        total += p;
%>
        <div class="cart-item">
            <div class="item-num"><%= num++ %></div>
            <div class="item-info">
                <div class="item-name"><%= item.get("name") %></div>
                <div class="item-cat">Food Item</div>
            </div>
            <div style="display:flex;align-items:center;gap:12px;">
    <div class="item-price">&#8377;<%= (int)p %></div>
    <a href="RemoveCartServlet?index=<%= num-2 %>"
       style="color:#e74c3c;text-decoration:none;font-size:1.1rem;
              font-weight:700;background:#fff0f0;border:1px solid #fdd;
              width:28px;height:28px;border-radius:50%;display:flex;
              align-items:center;justify-content:center;"
       onclick="return confirm('Remove this item?')">&#10005;</a>
</div>
           
        
<% } %>

        <!-- TOTAL -->
        <div class="total-section">
            <div class="total-row"><span>Subtotal</span><span>&#8377;<%= (int)total %></span></div>
            <div class="total-row"><span>Delivery Charge</span>
                <% if(total >= 299) { %><span class="free-badge">FREE</span><% } else { %><span>&#8377;30</span><% } %>
            </div>
            <div class="total-row"><span>Taxes &amp; Fees</span><span>&#8377;<%= (int)(total*0.05) %></span></div>
            <div class="total-row main">
                <span>Total</span>
                <span>&#8377;<%= total>=299 ? (int)(total + total*0.05) : (int)(total + 30 + total*0.05) %></span>
            </div>
        </div>
<% } %>
    </div>

    <% if(!cart.isEmpty()) { %>
    <!-- PROMO -->
    <div class="promo-bar">
        <span>&#127881;</span>
        <% if(total >= 299) { %>
            You got FREE delivery! You saved &#8377;30
        <% } else { %>
            Add &#8377;<%= (int)(299 - total) %> more for FREE delivery!
        <% } %>
    </div>
    <% } %>

    <!-- ACTIONS -->
    <div class="cart-actions">
        <% if(!cart.isEmpty()) { %>
        <a href="checkout.jsp?total=<%= total>=299 ? (int)(total + total*0.05) : (int)(total + 30 + total*0.05) %>" class="checkout-btn">
            Proceed to Checkout
        </a>
        <% } %>
        <a href="menu.jsp" class="menu-btn">Back to Menu</a>
    </div>

</div>

</body>
</html>