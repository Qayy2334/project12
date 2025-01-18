package com.shop.controller;

import com.shop.dao.ProductDAO;
import com.shop.model.Product;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/admin/ProductController")
public class ProductController extends HttpServlet {
    private ProductDAO productDAO = new ProductDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("add".equals(action)) {
            addProduct(request, response);
        } else if ("delete".equals(action)) {
            deleteProduct(request, response);
        }
    }

    /**
     * 添加商品
     */
    private void addProduct(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        request.setCharacterEncoding("UTF-8");

        String name = request.getParameter("name");
        String priceStr = request.getParameter("price");
        String stockStr = request.getParameter("stock");
        String description = request.getParameter("description");
        String category = request.getParameter("category");  // 获取类别

        // 打印调试信息
        System.out.println("商品类别：" + category);

        if (name == null || priceStr == null || stockStr == null || category == null ||
                name.isEmpty() || priceStr.isEmpty() || stockStr.isEmpty() || category.isEmpty()) {
            request.setAttribute("error", "所有字段都不能为空！");
            request.getRequestDispatcher("/admin/manage_products.jsp").forward(request, response);
            return;
        }

        try {
            double price = Double.parseDouble(priceStr);
            int stock = Integer.parseInt(stockStr);

            Product product = new Product();
            product.setName(name);
            product.setPrice(price);
            product.setStock(stock);
            product.setDescription(description);
            product.setCategory(category);  // 保存类别

            boolean success = productDAO.addProduct(product);

            if (success) {
                request.setAttribute("success", "商品添加成功！");
            } else {
                request.setAttribute("error", "商品添加失败！");
            }

            request.getRequestDispatcher("/admin/manage_products.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            request.setAttribute("error", "价格或库存格式错误！");
            request.getRequestDispatcher("/admin/manage_products.jsp").forward(request, response);
        }
    }


    /**
     * 删除商品
     */
    private void deleteProduct(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        String idStr = request.getParameter("id");

        if (idStr == null || idStr.isEmpty()) {
            System.out.println("删除失败：商品ID为空");
            response.sendRedirect(request.getContextPath() + "/admin/manage_products.jsp?error=商品ID不能为空");
            return;
        }

        try {
            int id = Integer.parseInt(idStr);
            boolean success = productDAO.deleteProduct(id);

            if (success) {
                System.out.println("商品 ID [" + id + "] 删除成功");
                // ✅ 删除成功后跳转回商品管理页面
                response.sendRedirect(request.getContextPath() + "/admin/manage_products.jsp?success=商品删除成功");
            } else {
                System.out.println("商品 ID [" + id + "] 删除失败");
                // ✅ 删除失败也跳回商品管理页面
                response.sendRedirect(request.getContextPath() + "/admin/manage_products.jsp?error=商品删除失败");
            }
        } catch (NumberFormatException e) {
            System.out.println("商品 ID 格式错误");
            response.sendRedirect(request.getContextPath() + "/admin/manage_products.jsp?error=商品ID格式错误");
        }
    }

}
