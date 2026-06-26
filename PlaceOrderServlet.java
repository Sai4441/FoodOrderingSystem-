package com.foodapp;

import java.io.IOException;
import java.sql.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/PlaceOrderServlet")
public class PlaceOrderServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Object userIdObj = session.getAttribute("userId");
        if (userIdObj == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        int userId = (Integer) userIdObj;
        String address = request.getParameter("delivery_address");
        String city    = request.getParameter("city");
        String pincode = request.getParameter("pincode");
        String phone   = request.getParameter("phone");
        String total   = request.getParameter("total");

        try {
            Connection con = DBConnection.getConnection();

            String sql = "INSERT INTO orders " +
                "(user_id, total, delivery_address, city, pincode, phone, status) " +
                "VALUES (?, ?, ?, ?, ?, ?, 'Pending')";

            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, userId);
            ps.setDouble(2, Double.parseDouble(total));
            ps.setString(3, address);
            ps.setString(4, city);
            ps.setString(5, pincode);
            ps.setString(6, phone);
            ps.executeUpdate();
            ps.close();
            con.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        response.sendRedirect("orderconfirm.jsp");
    }
}