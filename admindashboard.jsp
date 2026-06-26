<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
String adminname = (String) session.getAttribute("adminname");
if (adminname == null) {
    response.sendRedirect("adminlogin.jsp");
    return;
}
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Admin Dashboard - M.B Restaurant</title>
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700;800&display=swap" rel="stylesheet">
<style>
*,*::before,*::after{margin:0;padding:0;box-sizing:border-box;}
body{font-family:'Poppins',sans-serif;background:#f0f2f5;}

/* NAVBAR */
.navbar{
    background:linear-gradient(135deg,#1a1a2e,#16213e);
    padding:0 30px;height:65px;
    display:flex;align-items:center;justify-content:space-between;
    position:sticky;top:0;z-index:100;
    box-shadow:0 2px 15px rgba(0,0,0,0.3);
}
.navbar h1{color:#fff;font-size:1.1rem;font-weight:700;}
.navbar h1 span{color:#e74c3c;}
.nav-right{display:flex;align-items:center;gap:12px;}
.nav-right span{color:rgba(255,255,255,0.7);font-size:0.85rem;}
.nav-right a{
    background:#e74c3c;color:#fff;
    padding:8px 18px;border-radius:8px;
    text-decoration:none;font-weight:600;font-size:0.82rem;
    transition:background 0.2s;
}
.nav-right a:hover{background:#c0392b;}

/* STATS */
.stats{
    display:grid;grid-template-columns:repeat(4,1fr);
    gap:20px;padding:28px 30px 0;
}
.stat-card{
    background:#fff;padding:24px;border-radius:16px;
    text-align:center;box-shadow:0 4px 15px rgba(0,0,0,0.07);
    transition:transform 0.2s;
}
.stat-card:hover{transform:translateY(-3px);}
.stat-icon{font-size:2.2rem;margin-bottom:8px;}
.stat-number{font-size:2rem;font-weight:800;color:#e74c3c;}
.stat-label{color:#aaa;font-size:0.78rem;font-weight:600;margin-top:3px;text-transform:uppercase;letter-spacing:0.5px;}

/* SECTION */
.section{
    margin:24px 30px;background:#fff;
    border-radius:16px;padding:24px;
    box-shadow:0 4px 15px rgba(0,0,0,0.07);
}
.section-head{
    display:flex;align-items:center;justify-content:space-between;
    margin-bottom:20px;padding-bottom:14px;
    border-bottom:2px solid #f0f0f0;
}
.section-head h2{font-size:1.1rem;font-weight:700;color:#1a1a2e;}
.section-head .count{
    background:#f0f0f0;color:#666;
    padding:4px 12px;border-radius:20px;
    font-size:0.78rem;font-weight:600;
}

/* TABLE */
table{width:100%;border-collapse:collapse;}
th{
    background:linear-gradient(135deg,#1a1a2e,#16213e);
    color:#fff;padding:12px 14px;
    text-align:left;font-size:0.82rem;font-weight:600;
}
th:first-child{border-radius:8px 0 0 8px;}
th:last-child{border-radius:0 8px 8px 0;}
td{padding:12px 14px;border-bottom:1px solid #f5f5f5;font-size:0.85rem;color:#444;}
tr:last-child td{border-bottom:none;}
tr:hover td{background:#fafafa;}

/* STATUS BADGES */
.badge{
    padding:4px 12px;border-radius:20px;
    font-size:0.72rem;font-weight:700;display:inline-block;
}
.badge-Pending{background:#fff3cd;color:#856404;}
.badge-Confirmed{background:#cfe2ff;color:#084298;}
.badge-Preparing{background:#fff0d9;color:#854d0e;}
.badge-OutforDelivery{background:#f3e8ff;color:#6b21a8;}
.badge-Delivered{background:#d1fae5;color:#065f46;}

/* STATUS UPDATE FORM */
.status-form{display:flex;align-items:center;gap:8px;}
.status-select{
    padding:6px 10px;border:1.5px solid #eee;
    border-radius:8px;font-size:0.78rem;
    font-family:'Poppins',sans-serif;
    outline:none;cursor:pointer;
    background:#fafafa;color:#333;
}
.status-select:focus{border-color:#e74c3c;}
.update-btn{
    background:#e74c3c;color:#fff;border:none;
    padding:6px 14px;border-radius:8px;
    font-size:0.75rem;font-weight:700;
    cursor:pointer;font-family:'Poppins',sans-serif;
    transition:background 0.2s;white-space:nowrap;
}
.update-btn:hover{background:#c0392b;}

/* ADD FOOD FORM */
.add-form{
    display:grid;grid-template-columns:repeat(2,1fr);
    gap:14px;margin-top:16px;
}
.add-form input,.add-form select{
    padding:11px 14px;border:2px solid #eee;
    border-radius:10px;font-size:0.88rem;
    font-family:'Poppins',sans-serif;outline:none;
    transition:border 0.2s;background:#fafafa;
}
.add-form input:focus,.add-form select:focus{border-color:#e74c3c;background:#fff;}
.btn-add{
    background:linear-gradient(135deg,#e74c3c,#c0392b);
    color:#fff;padding:12px 24px;border:none;
    border-radius:10px;font-size:0.9rem;
    cursor:pointer;font-weight:700;
    grid-column:span 2;
    font-family:'Poppins',sans-serif;
    transition:opacity 0.2s;
}
.btn-add:hover{opacity:0.9;}

/* DELETE BTN */
.btn-delete{
    background:#fee2e2;color:#dc2626;
    padding:5px 12px;border-radius:6px;
    text-decoration:none;font-size:0.75rem;font-weight:700;
    transition:all 0.2s;
}
.btn-delete:hover{background:#dc2626;color:#fff;}

/* DELIVERY INFO */
.delivery-cell{font-size:0.75rem;color:#888;max-width:160px;overflow:hidden;text-overflow:ellipsis;white-space:nowrap;}

/* TOAST */
.toast{
    position:fixed;top:80px;right:24px;z-index:999;
    background:#1a1a2e;color:#fff;
    padding:12px 24px;border-radius:10px;
    font-size:0.85rem;font-weight:600;
    box-shadow:0 8px 24px rgba(0,0,0,0.2);
    display:none;
}
.toast.show{display:block;animation:fadeIn 0.3s;}
@keyframes fadeIn{from{opacity:0;transform:translateY(-10px);}to{opacity:1;transform:translateY(0);}}

@media(max-width:900px){
    .stats{grid-template-columns:repeat(2,1fr);}
    .section{margin:16px;}
    .add-form{grid-template-columns:1fr;}
    .btn-add{grid-column:span 1;}
}
</style>
</head>
<body>

<!-- TOAST -->
<div class="toast" id="toast">Status updated successfully!</div>

<!-- NAVBAR -->
<nav class="navbar">
    <h1>Admin Dashboard 鈥� <span>M.B Restaurant</span></h1>
    <div class="nav-right">
        <span>Welcome, <%= adminname %>!</span>
        <a href="adminlogin.jsp">Logout</a>
    </div>
</nav>

<%
Connection con = com.foodapp.DBConnection.getConnection();
Statement st = con.createStatement();

ResultSet rsU = st.executeQuery("SELECT COUNT(*) FROM users");
rsU.next(); int totalUsers = rsU.getInt(1);

ResultSet rsO = st.executeQuery("SELECT COUNT(*) FROM orders");
rsO.next(); int totalOrders = rsO.getInt(1);

ResultSet rsF = st.executeQuery("SELECT COUNT(*) FROM food_items");
rsF.next(); int totalFood = rsF.getInt(1);

ResultSet rsR = st.executeQuery("SELECT SUM(total) FROM orders");
rsR.next(); double totalRevenue = rsR.getDouble(1);

ResultSet rsPend = st.executeQuery("SELECT COUNT(*) FROM orders WHERE status='Pending'");
rsPend.next(); int pendingOrders = rsPend.getInt(1);
%>

<!-- STATS -->
<div class="stats">
    <div class="stat-card">
        <div class="stat-icon">馃懃</div>
        <div class="stat-number"><%= totalUsers %></div>
        <div class="stat-label">Total Users</div>
    </div>
    <div class="stat-card">
        <div class="stat-icon">馃搵</div>
        <div class="stat-number"><%= totalOrders %></div>
        <div class="stat-label">Total Orders</div>
    </div>
    <div class="stat-card">
        <div class="stat-icon">馃嵔锔�</div>
        <div class="stat-number"><%= totalFood %></div>
        <div class="stat-label">Food Items</div>
    </div>
    <div class="stat-card">
        <div class="stat-icon">馃挵</div>
        <div class="stat-number">&#8377;<%= (int)totalRevenue %></div>
        <div class="stat-label">Total Revenue</div>
    </div>
</div>

<!-- ORDERS TABLE -->
<div class="section">
    <div class="section-head">
        <h2>All Orders</h2>
        <span class="count"><%= pendingOrders %> Pending</span>
    </div>
    <table>
        <tr>
            <th>Order ID</th>
            <th>Customer</th>
            <th>Phone</th>
            <th>Address</th>
            <th>Total</th>
            <th>Date</th>
            <th>Status</th>
            <th>Update Status</th>
        </tr>
        <%
        ResultSet rsOrd = st.executeQuery(
            "SELECT o.id, u.name, o.total, o.order_date, o.status, " +
            "o.delivery_address, o.city, o.phone " +
            "FROM orders o JOIN users u ON o.user_id = u.id " +
            "ORDER BY o.id DESC");
        while(rsOrd.next()) {
            String orderStatus = rsOrd.getString("status");
            if(orderStatus == null) orderStatus = "Pending";
            String badgeClass = "badge-" + orderStatus.replace(" ","");
            String addr = rsOrd.getString("delivery_address");
            String city = rsOrd.getString("city");
            String phone = rsOrd.getString("phone");
            if(addr == null) addr = "-";
            if(city == null) city = "";
            if(phone == null) phone = "-";
        %>
        <tr>
            <td><strong>#<%= rsOrd.getInt("id") %></strong></td>
            <td><%= rsOrd.getString("name") %></td>
            <td><%= phone %></td>
            <td class="delivery-cell" title="<%= addr %><%= !city.isEmpty()?", "+city:"" %>">
                <%= addr %><%= !city.isEmpty()?", "+city:"" %>
            </td>
            <td><strong>&#8377;<%= (int)rsOrd.getDouble("total") %></strong></td>
            <td style="font-size:0.75rem;color:#888;"><%= rsOrd.getString("order_date") != null ? rsOrd.getString("order_date").toString().substring(0,16) : "" %></td>
            <td><span class="badge <%= badgeClass %>"><%= orderStatus %></span></td>
            <td>
                <form action="UpdateOrderServlet" method="post" class="status-form">
                    <input type="hidden" name="orderId" value="<%= rsOrd.getInt("id") %>">
                    <select name="status" class="status-select">
                        <option value="Pending"           <%= orderStatus.equals("Pending")?"selected":"" %>>Pending</option>
                        <option value="Confirmed"         <%= orderStatus.equals("Confirmed")?"selected":"" %>>Confirmed</option>
                        <option value="Preparing"         <%= orderStatus.equals("Preparing")?"selected":"" %>>Preparing</option>
                        <option value="Out for Delivery"  <%= orderStatus.equals("Out for Delivery")?"selected":"" %>>Out for Delivery</option>
                        <option value="Delivered"         <%= orderStatus.equals("Delivered")?"selected":"" %>>Delivered</option>
                    </select>
                    <button type="submit" class="update-btn">Update</button>
                </form>
            </td>
        </tr>
        <% } %>
    </table>
</div>

<!-- ADD FOOD -->
<div class="section">
    <div class="section-head">
        <h2>Add New Food Item</h2>
    </div>
    <form action="AddFoodServlet" method="post">
        <div class="add-form">
            <input type="text" name="name" placeholder="Food Name" required>
            <input type="number" name="price" placeholder="Price (Rs)" required>
            <select name="category">
                <option value="">Select Category</option>
                <option value="Biryani">Biryani</option>
                <option value="Dosa">Dosa</option>
                <option value="Tiffin">Tiffin</option>
                <option value="Rice">Rice</option>
                <option value="Drinks">Drinks</option>
                <option value="Sweets">Sweets</option>
                <option value="Uttapam">Uttapam</option>
            </select>
            <input type="text" name="description" placeholder="Description">
            <button type="submit" class="btn-add">Add Food Item</button>
        </div>
    </form>
</div>

<!-- FOOD ITEMS -->
<div class="section">
    <div class="section-head">
        <h2>All Food Items</h2>
        <span class="count"><%= totalFood %> items</span>
    </div>
    <table>
        <tr><th>ID</th><th>Name</th><th>Price</th><th>Category</th><th>Action</th></tr>
        <%
        ResultSet rsFoodList = st.executeQuery("SELECT * FROM food_items ORDER BY category");
        while(rsFoodList.next()) {
        %>
        <tr>
            <td><%= rsFoodList.getInt("id") %></td>
            <td><strong><%= rsFoodList.getString("name") %></strong></td>
            <td>&#8377;<%= (int)rsFoodList.getDouble("price") %></td>
            <td><%= rsFoodList.getString("category") %></td>
            <td>
                <a class="btn-delete"
                   href="DeleteFoodServlet?id=<%= rsFoodList.getInt("id") %>"
                   onclick="return confirm('Delete this item?')">Delete</a>
            </td>
        </tr>
        <% } %>
    </table>
</div>

<!-- USERS -->
<div class="section">
    <div class="section-head">
        <h2>All Users</h2>
        <span class="count"><%= totalUsers %> users</span>
    </div>
    <table>
        <tr><th>ID</th><th>Name</th><th>Email</th></tr>
        <%
        ResultSet rsUserList = st.executeQuery("SELECT * FROM users ORDER BY id DESC");
        while(rsUserList.next()) {
        %>
        <tr>
            <td><%= rsUserList.getInt("id") %></td>
            <td><strong><%= rsUserList.getString("name") %></strong></td>
            <td><%= rsUserList.getString("email") %></td>
        </tr>
        <% } con.close(); %>
    </table>
</div>

<script>
// Show toast if redirected after update
if(window.location.search.includes('updated=true')) {
    var t = document.getElementById('toast');
    t.classList.add('show');
    setTimeout(function(){ t.classList.remove('show'); }, 3000);
}
</script>

</body>
</html>