package com.foodapp;

import java.io.*;
import java.sql.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;

public class AddFoodServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
                          throws ServletException, IOException {

        String name = request.getParameter("name");
        String price = request.getParameter("price");
        String category = request.getParameter("category");
        String description = request.getParameter("description");

        try {
            Connection con = DBConnection.getConnection();
            String sql = "INSERT INTO food_items (name, price, category, description) VALUES (?, ?, ?, ?)";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, name);
            ps.setDouble(2, Double.parseDouble(price));
            ps.setString(3, category);
            ps.setString(4, description);
            ps.executeUpdate();
            con.close();
            response.sendRedirect("admindashboard.jsp");
        } catch (Exception e) {
            response.getWriter().println("Error: " + e.getMessage());
        }
    }
}