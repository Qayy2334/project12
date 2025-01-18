package com.shop.controller;

import com.shop.dao.CartDAO;
import com.shop.model.CartItem;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/CartController")
public class CartController extends HttpServlet {
    private CartDAO cartDAO = new CartDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("add".equals(action)) {
            addToCart(request, response);
        } else if ("remove".equals(action)) {
            removeFromCart(request, response);
        }
    }

    /**
     * 添加商品到购物车
     */
    private void addToCart(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("userId") == null) {
            return;  // 未登录，直接返回
        }

        int userId = (Integer) session.getAttribute("userId");
        int productId = Integer.parseInt(request.getParameter("productId"));

        CartItem item = new CartItem();
        item.setUserId(userId);
        item.setProductId(productId);
        item.setQuantity(1);

        cartDAO.addToCart(item);
        // ✅ 不返回任何内容
    }


    /**
     * 删除购物车商品
     */
    private void removeFromCart(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        String cartItemIdStr = request.getParameter("cartItemId");

        if (cartItemIdStr == null || cartItemIdStr.isEmpty()) {
            return;  // ❌ 没有传递商品ID，直接返回
        }

        int cartItemId = Integer.parseInt(cartItemIdStr);

        // ✅ 调用DAO删除商品
        cartDAO.removeFromCart(cartItemId);
        // ✅ 删除后不返回任何内容，不跳转页面
    }
}
