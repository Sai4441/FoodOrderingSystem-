<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*, java.util.*" %>
<%
String username = (String) session.getAttribute("username");
int userid = (int) session.getAttribute("userid");
if (username == null) {
    response.sendRedirect("login.jsp");
    return;
}
List<Map<String, String>> cart = 
    (List<Map<String, String>>) session.getAttribute("cart");
if (cart == null || cart.isEmpty()) {
    response.sendRedirect("menu.jsp");
    return;
}
double total = 0;
for (Map<String, String> item : cart) {
    total += Double.parseDouble(item.get("price"));
}
Connection con = com.foodapp.DBConnection.getConnection();
String orderSql = "INSERT INTO orders (user_id, total) VALUES (?, ?)";
PreparedStatement ps = con.prepareStatement(orderSql, Statement.RETURN_GENERATED_KEYS);
ps.setInt(1, userid);
ps.setDouble(2, total);
ps.executeUpdate();
ResultSet keys = ps.getGeneratedKeys();
int orderId = 0;
if (keys.next()) orderId = keys.getInt(1);
for (Map<String, String> item : cart) {
    String itemSql = "INSERT INTO order_items (order_id, food_id, quantity) VALUES (?, ?, 1)";
    PreparedStatement ps2 = con.prepareStatement(itemSql);
    ps2.setInt(1, orderId);
    ps2.setInt(2, Integer.parseInt(item.get("id")));
    ps2.executeUpdate();
}
session.removeAttribute("cart");
con.close();
%>
<html>
<head>
<title>Order Success</title>
<link rel="stylesheet" href="style.css">
</head>
<body>
<div class="container" style="text-align:center;">
<h2>🍕 Food Ordering System</h2>
<h1 style="color:green;">🎉 Order Placed!</h1>
<p>Thank you, <b><%= username %></b>!</p>
<p>Total Paid: <b>₹<%= total %></b></p>
<p>Order ID: <b>#<%= orderId %></b></p>
<br>
<a href="menu.jsp" class="btn">Order More Food 🍕</a>
</div>
</body>
</html>