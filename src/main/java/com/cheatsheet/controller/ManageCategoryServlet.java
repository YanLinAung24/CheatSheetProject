package com.cheatsheet.controller;

import java.io.IOException;
import java.sql.Connection;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cheatsheet.config.DBConnect;
import com.cheatsheet.model.Category;
import com.cheatsheet.model.User;
import com.cheatsheet.repository.CategoryRepository;

@WebServlet("/manage-categories")
public class ManageCategoryServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // 🌟 View ပြသခြင်းနှင့် Edit Form ဆွဲထုတ်ခြင်း (GET)
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("userObj");
        if (user == null) { response.sendRedirect("login.jsp"); return; }

        Connection conn = DBConnect.getConnection();
        CategoryRepository catRepo = new CategoryRepository(conn);

        // Edit လုပ်ဖို့ ID ပါလာခဲ့ရင် သက်ဆိုင်ရာ data ကို ရှာပြီး Form ထဲ ပို့ပေးမယ်
        String editIdParam = request.getParameter("editId");
        if (editIdParam != null) {
            int editId = Integer.parseInt(editIdParam);
            Category editCategory = catRepo.getCategoryById(editId);
            request.setAttribute("editCategory", editCategory);
        }

        // စာရင်းအမြဲပြနိုင်ရန် Category List ကို ဆွဲထုတ်ခိုင်းမယ်
        List<Category> categoryList = catRepo.getAllCategory();
        request.setAttribute("categoryList", categoryList);

        request.getRequestDispatcher("manage-categories.jsp").forward(request, response);
    }

    // 🌟 Add နှင့် Update လုပ်ဆောင်ချက်များကို လက်ခံခြင်း (POST)
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        Connection conn = DBConnect.getConnection();
        CategoryRepository catRepo = new CategoryRepository(conn);

        String catIdParam = request.getParameter("categoryId");
        String catName = request.getParameter("categoryName");

        if (catIdParam == null || catIdParam.isEmpty()) {
            // ➕ Category ID မပါလာရင် အသစ်ဆောက်မယ် (Create)
            catRepo.addCategory(catName);
        } else {
            // 📝 Category ID ပါလာရင် နာမည်အဟောင်းကို ပြင်မယ် (Update)
            int id = Integer.parseInt(catIdParam);
            catRepo.updateCategory(id, catName);
        }

        // အလုပ်လုပ်ပြီးရင် မူလ စာမျက်နှာဆီ Refresh ပြန်ရိုက်ပေးမယ်
        response.sendRedirect("manage-categories");
    }
}