package com.foodapp;

import java.io.IOException;
import java.util.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/RemoveCartServlet")
public class RemoveCartServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        List<Map<String, String>> cart =
            (List<Map<String, String>>) session.getAttribute("cart");

        if (cart != null) {
            try {
                int index = Integer.parseInt(
                    request.getParameter("index"));
                if (index >= 0 && index < cart.size()) {
                    cart.remove(index);
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        response.sendRedirect("cart.jsp");
    }
}